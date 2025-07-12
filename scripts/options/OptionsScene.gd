class_name OptionsScene
extends Scene

@export var smallFontSizeSpoon: Sprite2D
@export var mediumFontSizeSpoon: Sprite2D
@export var largeFontSizeSpoon: Sprite2D
@export var painfullySmallFontSizeSpoon: Sprite2D
@export var painfullyLargeFontSizeSpoon: Sprite2D
var fontSizeSpoons: Dictionary

@export var slowFontSpeedSpoon: Sprite2D
@export var mediumFontSpeedSpoon: Sprite2D
@export var fastFontSpeedSpoon: Sprite2D
var fontSpeedSpoons: Dictionary

@export var windowedSpoon: Sprite2D
@export var fullscreenSpoon: Sprite2D
var displayFormatSpoons: Dictionary

@export var musicVolumeSpoon: Sprite2D
@export var musicVolumePercentLabel: Label

@export var otherSoundVolumeSpoon: Sprite2D
@export var otherSoundVolumePercentLabel: Label

@export var painfullySmallFontSizeLabel: Label
@export var painfullyLargeFontSizeLabel: Label
var painfulOptionsRevealed := false


func _init():
	var sid := SceneManager.SceneID
	sceneTransitions = [sid.MAIN_MENU]
	defaultStartingMessage = (
		"Welcome to the options menu! You can change options using the following syntax: " +
		"set [option_type] to [choice]\n" +
		"For example: \"Set font size to large\" is a valid command."
	)

func _ready():
	super()

	fontSizeSpoons = {
		Options.FontSize.SMALL : smallFontSizeSpoon,
		Options.FontSize.MEDIUM : mediumFontSizeSpoon,
		Options.FontSize.LARGE : largeFontSizeSpoon,
		Options.FontSize.PAINFULLY_SMALL : painfullySmallFontSizeSpoon,
		Options.FontSize.PAINFULLY_LARGE : painfullyLargeFontSizeSpoon,
	}
	for fontSizeSpoon in fontSizeSpoons.values(): fontSizeSpoon.hide()
	fontSizeSpoons[Options.fontSize].show()

	if EndingsManager.areAllEndingsUnlocked(): revealPainfulOptions()

	fontSpeedSpoons = {
		Options.FontSpeed.SLOW : slowFontSpeedSpoon,
		Options.FontSpeed.MEDIUM : mediumFontSpeedSpoon,
		Options.FontSpeed.FAST : fastFontSpeedSpoon,
	}
	for fontSpeedSpoon in fontSpeedSpoons.values(): fontSpeedSpoon.hide()
	fontSpeedSpoons[Options.fontSpeed].show()

	displayFormatSpoons = {
		Options.DisplayMode.WINDOWED : windowedSpoon,
		Options.DisplayMode.FULL_SCREEN : fullscreenSpoon,
	}
	for displayFormatSpoon in displayFormatSpoons.values(): displayFormatSpoon.hide()
	displayFormatSpoons[Options.displayMode].show()

	musicVolumeSpoon.position.x = 101 + (243-101)*Options.musicVolume/100
	musicVolumePercentLabel.text = str(Options.musicVolume) + '%'

	otherSoundVolumeSpoon.position.x = 101 + (243-101)*Options.otherSoundVolume/100
	otherSoundVolumePercentLabel.text = str(Options.otherSoundVolume) + '%'


func setFontSize(newFontSize: Options.FontSize):
	fontSizeSpoons[Options.fontSize].hide()
	Options.fontSize = newFontSize
	fontSizeSpoons[Options.fontSize].show()
	resetTerminal()

func revealPainfulOptions():
	painfullySmallFontSizeLabel.text = "Painfully Small"
	painfullyLargeFontSizeLabel.text = "Painfully Large"
	painfulOptionsRevealed = true

func setFontSpeed(newFontSpeed: Options.FontSpeed):
	fontSpeedSpoons[Options.fontSpeed].hide()
	Options.fontSpeed = newFontSpeed
	fontSpeedSpoons[Options.fontSpeed].show()
	terminal.setFontSpeed()

func setDisplayFormat(newDisplayFormat: Options.DisplayMode):
	displayFormatSpoons[Options.displayMode].hide()
	Options.displayMode = newDisplayFormat
	displayFormatSpoons[Options.displayMode].show()

func setMusicVolume(newPercent: int):
	musicVolumeSpoon.position.x = 101 + (243-101)*newPercent/100
	musicVolumePercentLabel.text = str(newPercent) + '%'
	Options.musicVolume = newPercent

func setOtherSoundVolume(newPercent: int):
	otherSoundVolumeSpoon.position.x = 101 + (243-101)*newPercent/100
	otherSoundVolumePercentLabel.text = str(newPercent) + '%'
	Options.otherSoundVolume = newPercent