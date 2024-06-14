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
		var maybeFontSize = config.get_value("terminal", "fontSize")
		if maybeFontSize != null: _fontSize = maybeFontSize
		var maybeFontSpeed = config.get_value("terminal", "fontSpeed")
		if maybeFontSpeed != null: _fontSpeed = maybeFontSpeed
		var maybeDisplayMode = config.get_value("display", "mode")
		if maybeDisplayMode != null: _displayMode = maybeDisplayMode
	else:
		print(filePath, " not found. Using default values.")


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
