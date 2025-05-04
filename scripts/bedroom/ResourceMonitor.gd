class_name ResourceMonitor
extends NinePatchRect

const RAM_PIP_COLOR = Color8(49,210,52)
const CPU_PIP_COLOR = Color8(212,204,0)
const HEAT_PIP_COLOR = Color8(211,0,0)

@export var progressPipPrefab: PackedScene
@export var ramProgressBarContainer: HBoxContainer
@export var cpuProgressBarContainer: HBoxContainer
@export var heatProgressBarContainer: HBoxContainer

var targetRamUsage: float
var targetCpuUsage: float
var targetHeat: float

var ramUsage: float
var cpuUsage: float
var heat: float

var progressBarColors: Dictionary

func _ready():
	progressBarColors[ramProgressBarContainer] = RAM_PIP_COLOR
	progressBarColors[cpuProgressBarContainer] = CPU_PIP_COLOR
	progressBarColors[heatProgressBarContainer] = HEAT_PIP_COLOR


func manual_process(delta: float):
	
	ramUsage = clampf(lerp(ramUsage, targetRamUsage, delta/5),0.0,1.0)
	cpuUsage = clampf(lerp(cpuUsage, targetCpuUsage, delta/5),0.0,1.0)
	heat = clampf(lerp(heat, targetHeat, delta/5),0.0,1.0)

	updateProgressBarContainer(ramProgressBarContainer, clampi(int(ramUsage*25),1,24))
	updateProgressBarContainer(cpuProgressBarContainer, clampi(int(cpuUsage*25),1,24))
	updateProgressBarContainer(heatProgressBarContainer, clampi(int(heat*25),1,24))


func updateProgressBarContainer(progressBarContainer: HBoxContainer, targetPips: int):
	var currentPips := progressBarContainer.get_child_count()
	while currentPips < targetPips:
		var newPip: ColorRect = progressPipPrefab.instantiate()
		newPip.color = progressBarColors[progressBarContainer]
		progressBarContainer.add_child(newPip)
		currentPips = progressBarContainer.get_child_count()
	while currentPips > targetPips:
		progressBarContainer.get_child(-1).queue_free()
		progressBarContainer.remove_child(progressBarContainer.get_child(-1))
		currentPips = progressBarContainer.get_child_count()