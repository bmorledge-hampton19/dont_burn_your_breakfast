class_name Scene
extends Node

const painfullySmallFontTerminal: PackedScene = preload("res://scenes/scene_modules/painfully_small_font_terminal.tscn")
const smallFontTerminal: PackedScene = preload("res://scenes/scene_modules/small_font_terminal.tscn")
const mediumFontTerminal: PackedScene = preload("res://scenes/scene_modules/medium_font_terminal.tscn")
const largeFontTerminal: PackedScene = preload("res://scenes/scene_modules/large_font_terminal.tscn")
const painfullyLargeFontTerminal: PackedScene = preload("res://scenes/scene_modules/painfully_large_font_terminal.tscn")

@export var inputParser: InputParser

var sceneTransitions: Array[SceneManager.SceneID]

var terminal: Terminal
var defaultStartingMessage := ""

var paused: bool


func _getTerminal() -> Terminal:

	match Options.fontSize:

		Options.FontSize.PAINFULLY_SMALL:
			return painfullySmallFontTerminal.instantiate()
		Options.FontSize.SMALL:
			return smallFontTerminal.instantiate()
		Options.FontSize.MEDIUM:
			return mediumFontTerminal.instantiate()
		Options.FontSize.LARGE:
			return largeFontTerminal.instantiate()
		Options.FontSize.PAINFULLY_LARGE:
			return painfullyLargeFontTerminal.instantiate()
		_:
			return null


func _ready():
	SceneManager.preloadScenes(sceneTransitions)
	terminal = _getTerminal()
	$VBoxContainer/PlaceholderTerminal.queue_free()
	$VBoxContainer.add_child(terminal)
	if SceneManager.customStartingMessage:
		inputParser.connectTerminal(terminal)
		terminal.initMessage(SceneManager.customStartingMessage, true)
	else:
		inputParser.connectTerminal(terminal)
		terminal.initMessage(defaultStartingMessage, true)

func pause():
	paused = true
	inputParser.disconnectTerminal()

func resume():
	paused = false
	inputParser.reconnectTerminal()

func resetTerminal():
	terminal.queue_free()
	terminal = _getTerminal()
	$VBoxContainer.add_child(terminal)
	inputParser.connectTerminal(terminal)
	#terminal.initMessage("Font size changed to " + Options.FontSize.keys()[Options.fontSize].to_lower().replace('_', ' ') + ".")
