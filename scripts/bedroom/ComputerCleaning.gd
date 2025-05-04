class_name ComputerCleaning
extends Scene

const ANGRY_CAT_CPU_USAGE := 0.1
const CLOSING_CAT_CPU_USAGE := 0.2

const CLOSING_SPREADSHEET_RAM_USAGE := 0.25

const MOUSE_RAM_USAGE := 0.02

const RAM_OVERUSE_CPU_LOAD_RATE := 0.05

@export var infoWindow: ComputerCleaningInfo
@export var resourceMonitor: ResourceMonitor

var windows: Array
@export var catWindowPrefab: PackedScene
@export var spreadsheetPrefab: PackedScene

var mice: Array[Mouse]
@export var mouseCursorPrefab: PackedScene
@export var normalMousePrefab: PackedScene

var taskbarItems: Dictionary

var infoTextState: int:
	get: return infoWindow.infoTextState
var clippyAskingForSpeed: bool:
	get: return infoWindow.clippyAskingForSpeed
var clippyAwaitingCommand: bool:
	get: return infoWindow.clippyAwaitingCommand

var ramUsage: float:
	get: return resourceMonitor.ramUsage
var cpuUsage: float:
	get: return resourceMonitor.cpuUsage
var heat: float:
	get: return resourceMonitor.heat

var ramOveruseCPULoad: float

func _init():
	defaultStartingMessage = (
		""
	)

func initFromExistingTerminal(existingTerminal):
	terminal = existingTerminal
	inputParser.connectTerminal(existingTerminal, defaultStartingMessage)

func _ready():
	super()
	get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_CANVAS_ITEMS


func _process(delta):
	if infoWindow: return

	resourceMonitor.manual_process(delta)
