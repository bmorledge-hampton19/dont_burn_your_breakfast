class_name ComputerCleaning extends Scene

const ANGRY_CAT_CPU_USAGE := 0.1
const CLOSING_CAT_CPU_USAGE := 0.2
const CLOSING_CAT_DECAY_RATE := 0.015

const CLOSING_SPREADSHEET_RAM_USAGE := 0.15
const CLOSING_SPREADSHEET_DECAY_RATE := 0.015

const MOUSE_RAM_USAGE := 0.02

const RAM_OVERUSE_CPU_LOAD_RATE := 0.1
const FREE_RAM_CPU_DECAY_RATE := 0.2
const CPU_OVERUSE_HEAT_RATE := 0.05

@export var infoWindow: ComputerCleaningInfo
@export var resourceMonitor: ResourceMonitor
@export var heatVFX: ColorRect

@export var massiveMouseMama: Control
var massiveMouseMamaRect: Rect2
@export var antimatterCheese: Control
var antimatterCheeseRect: Rect2

@export var clutterControl: Control
@export var catPicPrefab: PackedScene
var catPics: Array[CatPic]
var catPicsBeingClosed: Array[float]
@export var spreadsheetPrefab: PackedScene
var spreadsheets: Array[Spreadsheet]
var spreadsheetsBeingClosed: Array[float]

@export var taskbarControl: Control
@export var taskbarItemPrefab: PackedScene
var taskbarItems: Dictionary[Variant, TaskbarItem]
var lastAddedTaskbarItem: TaskbarItem

@export var miceControl: Control
@export var mouseCursorPrefab: PackedScene
@export var normalMousePrefab: PackedScene
var mice: Array[Mouse]

@export var cows: Cows
@export var farewellClippy: FarewellClippy

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

var ramOveruseCpuLoad: float

var finished: bool


func _init():
	defaultStartingMessage = (
		""
	)

func initFromExistingTerminal(existingTerminal):
	terminal = existingTerminal
	inputParser.connectTerminal(existingTerminal)

func addTaskbarItem(window):

	var newTaskbarItem: TaskbarItem = taskbarItemPrefab.instantiate()
	taskbarControl.add_child(newTaskbarItem)

	if window is ComputerCleaningInfo:
		newTaskbarItem.init(TaskbarItem.IconType.INFO, "How to Computer", lastAddedTaskbarItem)
	elif window is ResourceMonitor:
		newTaskbarItem.init(TaskbarItem.IconType.RESOURCE_MONITOR, "Resource Monitor", lastAddedTaskbarItem)
	elif window is CatPic:
		newTaskbarItem.init(TaskbarItem.IconType.CAT_PIC, (window as CatPic).headerText.text, lastAddedTaskbarItem)
	elif window is Spreadsheet:
		newTaskbarItem.init(TaskbarItem.IconType.SPREADSHEET, (window as Spreadsheet).headerText.text, lastAddedTaskbarItem)
	else:
		print("Uh-oh!! I can't make a taskbar item from that!")
		breakpoint

	taskbarItems[window] = newTaskbarItem
	lastAddedTaskbarItem = newTaskbarItem

func removeTaskbarItem(window):
	taskbarItems[window].destroy()
	taskbarItems.erase(window)


func _ready():
	get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_CANVAS_ITEMS

	addTaskbarItem(infoWindow)
	infoWindow.finished.connect(func(): removeTaskbarItem(infoWindow); infoWindow = null; startClutter())
	addTaskbarItem(resourceMonitor)

	massiveMouseMamaRect = Rect2(massiveMouseMama.position, massiveMouseMama.size)
	antimatterCheeseRect = Rect2(antimatterCheese.position, antimatterCheese.size)

	for i in range(randi_range(30, 35)):
		if randi()%2:
			var newCatPic: CatPic = catPicPrefab.instantiate()
			clutterControl.add_child(newCatPic)
			setRandomWindowPos(newCatPic)
			newCatPic.onAngry.connect(increaseCatCpuLoad)
			newCatPic.onCalm.connect(decreaseCatCpuLoad)
			catPics.append(newCatPic)
			addTaskbarItem(newCatPic)

		else:
			var newSpreadsheet: Spreadsheet = spreadsheetPrefab.instantiate()
			clutterControl.add_child(newSpreadsheet)
			setRandomWindowPos(newSpreadsheet)
			spreadsheets.append(newSpreadsheet)
			addTaskbarItem(newSpreadsheet)

func startClutter():
	spawnMice(randi_range(4,6))


func _process(delta: float):
	if infoWindow: return

	if not finished and not catPics and not spreadsheets and resourceMonitor.allTargetsBelowOne:
		finished = true
		activateAntimatterCheese()
		cows.dance()
		farewellClippy.summonClippy()
		resourceMonitor.hide()
		if resourceMonitor in taskbarItems: removeTaskbarItem(resourceMonitor)
		
	elif heat >= 1:
		SceneManager.transitionToScene(
			SceneManager.SceneID.ENDING,
			"You're still desperately trying to corral the chaos that is your computer desktop when things take a turn for the worse. " +
			"The screen begins to stutter and flicker ominously, and before too long the monitor is almost entirely unresponsive. " +
			"With a growing sense of dread, you look over at your PC's tower and find smoke billowing out of the exhaust ports. " +
			"You consider forcing a shutdown but worry that you might not have saved all your spreadsheets and cat pictures. " +
			"It's probably best to just wait until it starts responding again...",
			SceneManager.EndingID.WHY_IS_THERE_COOLANT_ALL_OVER_MY_FLOOR
		)


	for catPic in catPics:

		catPic.manualProcess(delta)

		if catPic.angryTimer <= 0:

			var edibleMouse: Mouse
			for mouse in mice:
				if mouse.edible:
					edibleMouse = mouse
					break

			if edibleMouse:
				catPic.feed(edibleMouse.position+edibleMouse.size/2)
				mice.erase(edibleMouse)
				edibleMouse.exposeToHungryCat()


	var closedCatPicDecay := CLOSING_CAT_DECAY_RATE*delta
	for i in range(len(catPicsBeingClosed)-1,-1,-1):
		if catPicsBeingClosed[i] > closedCatPicDecay:
			catPicsBeingClosed[i] -= closedCatPicDecay
			resourceMonitor.targetCpuUsage -= closedCatPicDecay
		else:
			resourceMonitor.targetCpuUsage -= catPicsBeingClosed[i]
			catPicsBeingClosed.pop_at(i)
		closedCatPicDecay *= 0.5

	var closedSpreadsheetDecay := CLOSING_SPREADSHEET_DECAY_RATE*delta
	for i in range(len(spreadsheetsBeingClosed)-1,-1,-1):
		if spreadsheetsBeingClosed[i] > closedSpreadsheetDecay:
			spreadsheetsBeingClosed[i] -= closedSpreadsheetDecay
			resourceMonitor.targetRamUsage -= closedSpreadsheetDecay
		else:
			resourceMonitor.targetRamUsage -= spreadsheetsBeingClosed[i]
			spreadsheetsBeingClosed.pop_at(i)
		closedSpreadsheetDecay *= 0.5


	if ramUsage >= 1:
		ramOveruseCpuLoad += RAM_OVERUSE_CPU_LOAD_RATE*delta*resourceMonitor.targetRamUsage
		resourceMonitor.targetCpuUsage += RAM_OVERUSE_CPU_LOAD_RATE*delta*resourceMonitor.targetRamUsage
	elif ramOveruseCpuLoad > 0:
		var freeRamCpuDecay := FREE_RAM_CPU_DECAY_RATE*delta
		if ramOveruseCpuLoad > freeRamCpuDecay:
			ramOveruseCpuLoad -= freeRamCpuDecay
			resourceMonitor.targetCpuUsage -= freeRamCpuDecay
		else:
			resourceMonitor.targetCpuUsage -= ramOveruseCpuLoad
			ramOveruseCpuLoad = 0

	if cpuUsage >= 1:
		resourceMonitor.targetHeat += CPU_OVERUSE_HEAT_RATE*delta*resourceMonitor.targetCpuUsage
	elif resourceMonitor.targetHeat > 0:
		resourceMonitor.targetHeat -= 0.1*(1-cpuUsage)*delta

	resourceMonitor.manual_process(delta)
	heatVFX.modulate.a = resourceMonitor.heat

	for window in taskbarItems:
		taskbarItems[window].manualProcess(delta)


func setRandomWindowPos(window: Control):
	var maxX = 720-window.size.x*window.scale.x
	var maxY = 380-window.size.y*window.scale.y
	var windowRect: Rect2

	# Alternatively, set the X position first, then determine range of possible Y positions.
	while true:
		window.position = Vector2(randi_range(0,maxX),randi_range(0,maxY))
		windowRect = Rect2(window.position, window.size*window.scale)
		if (
			not windowRect.intersects(massiveMouseMamaRect) and
			not windowRect.intersects(antimatterCheeseRect) and
			not (window.position.x > resourceMonitor.position.x and window.position.y > resourceMonitor.position.y)
		):
			break


func increaseCatCpuLoad():
	resourceMonitor.targetCpuUsage += ANGRY_CAT_CPU_USAGE

func decreaseCatCpuLoad():
	resourceMonitor.targetCpuUsage -= ANGRY_CAT_CPU_USAGE


func spawnMice(count: int):
	for i in range(count):
		if len(mice) >= 50: return
		var newMouse: Mouse
		if randi_range(0,4): newMouse = mouseCursorPrefab.instantiate()
		else: newMouse = normalMousePrefab.instantiate()
		miceControl.add_child(newMouse)
		mice.append(newMouse)
		newMouse.position = Vector2(randf_range(0, newMouse.maxX), randf_range(0, newMouse.maxY))
		newMouse.onReproduction.connect(func(): spawnMice(1))
		newMouse.onDestroy.connect(decreaseMouseRamLoad)
		increaseMouseRamLoad()

func increaseMouseRamLoad():
	resourceMonitor.targetRamUsage += MOUSE_RAM_USAGE

func decreaseMouseRamLoad():
	resourceMonitor.targetRamUsage -= MOUSE_RAM_USAGE


func attemptCloseCatPic():
	var closingCatPic: CatPic
	for i in range(len(catPics)-1,-1,-1):
		if catPics[i].angry:
			continue
		else:
			closingCatPic = catPics.pop_at(i)
			break

	if not closingCatPic: return false

	resourceMonitor.targetCpuUsage += CLOSING_CAT_CPU_USAGE
	catPicsBeingClosed.append(CLOSING_CAT_CPU_USAGE)
	removeTaskbarItem(closingCatPic)
	closingCatPic.queue_free()
	return true

func attemptCloseSpreadsheet():

	if not spreadsheets: return false

	var closingSpreadsheet: Spreadsheet = spreadsheets.pop_back()

	resourceMonitor.targetRamUsage += CLOSING_SPREADSHEET_RAM_USAGE
	spreadsheetsBeingClosed.append(CLOSING_SPREADSHEET_RAM_USAGE)
	removeTaskbarItem(closingSpreadsheet)
	closingSpreadsheet.queue_free()
	return true

func activateAntimatterCheese():
	for mouse in mice:
		mouse.exposeToAntimatter()
	mice.clear()
