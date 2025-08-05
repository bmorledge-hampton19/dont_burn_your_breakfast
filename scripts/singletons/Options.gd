extends Node

enum FontSize {PAINFULLY_SMALL, SMALL, MEDIUM, LARGE, PAINFULLY_LARGE}
var _fontSize := FontSize.MEDIUM
var fontSize: FontSize:
	get: return _fontSize
	set(value):
		_fontSize = value
		config.set_value("terminal", "fontSize", value)
		config.save(_getOptionsFilePath())

enum FontSpeed {SLOW, MEDIUM, FAST}
var _fontSpeed := FontSpeed.MEDIUM
var fontSpeed: FontSpeed:
	get: return _fontSpeed
	set(value):
		_fontSpeed = value
		config.set_value("terminal", "fontSpeed", value)
		config.save(_getOptionsFilePath())

enum DisplayMode {WINDOWED, FULL_SCREEN}
var _displayMode := DisplayMode.WINDOWED
var displayMode: DisplayMode:
	get: return _displayMode
	set(value):
		_displayMode = value
		_updateDisplay()
		config.set_value("display", "mode", value)
		config.save(_getOptionsFilePath())

const MUSIC_BASE_VOLUME := 1.0

var _musicVolume := 100
var musicVolume: int:
	get: return _musicVolume
	set(value):
		_musicVolume = value
		AudioServer.set_bus_volume_linear(1, float(_musicVolume)/100.0*MUSIC_BASE_VOLUME)
		config.set_value("volume", "music", value)
		config.save(_getOptionsFilePath())

const OTHER_SOUND_BASE_VOLUME := 1.0

var _otherSoundVolume := 100
var otherSoundVolume: int:
	get: return _otherSoundVolume
	set(value):
		_otherSoundVolume = value
		AudioServer.set_bus_volume_linear(2, float(_otherSoundVolume)/100.0*OTHER_SOUND_BASE_VOLUME)
		config.set_value("volume", "otherSound", value)
		config.save(_getOptionsFilePath())

var config := ConfigFile.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	loadOptions()
	_updateDisplay()

func loadOptions():
	var filePath := _getOptionsFilePath()
	if FileAccess.file_exists(filePath):
		var error := config.load(filePath)
		if error != OK:
			print(filePath, " malformed. Backing up and reverting to default values.")
			FileAccess.open(_getOptionsFilePath(true), FileAccess.WRITE).store_string(
				FileAccess.open(filePath, FileAccess.READ).get_as_text()
			)
			return
		fontSize = config.get_value("terminal", "fontSize", fontSize)
		fontSpeed = config.get_value("terminal", "fontSpeed", fontSpeed)
		displayMode = config.get_value("display", "mode", displayMode)
		musicVolume = config.get_value("volume", "music", musicVolume)
		otherSoundVolume = config.get_value("volume", "otherSound", otherSoundVolume)
	else:
		print(filePath, " not found. Using default values.")
		config.set_value("terminal", "fontSize", fontSize)
		config.save(_getOptionsFilePath())
		config.set_value("terminal", "fontSpeed", fontSpeed)
		config.save(_getOptionsFilePath())
		config.set_value("display", "mode", displayMode)
		config.save(_getOptionsFilePath())
		config.set_value("volume", "music", musicVolume)
		config.save(_getOptionsFilePath())
		config.set_value("volume", "otherSound", otherSoundVolume)
		config.save(_getOptionsFilePath())

func _getOptionsFilePath(malformed = false) -> String:
	var filePath := "user://options"
	if malformed: filePath += ".malcfg"
	else: filePath += ".cfg"
	return filePath

func _updateDisplay():
	if displayMode == DisplayMode.WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		var usableRect := DisplayServer.screen_get_usable_rect()
		var titleYOffset := DisplayServer.window_get_title_size("").y
		var usableSize := Vector2i(usableRect.size.x, usableRect.size.y - titleYOffset)

		var preferredXScale = usableSize.x/720
		var preferredYScale = usableSize.y/540
		var preferredSize := Vector2i(min(preferredXScale, preferredYScale) * 720, min(preferredXScale, preferredYScale) * 540)
		get_window().size = preferredSize

		var preferredPos := Vector2i(
			usableRect.position.x + (usableSize.x-preferredSize.x) / 2,
			usableRect.position.y + (usableSize.y-preferredSize.y) / 2 + titleYOffset
		)
		get_window().position = preferredPos

	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
