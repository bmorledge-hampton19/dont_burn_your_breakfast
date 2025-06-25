class_name Kitchen
extends Scene

const NONE := -1

@export_group("Cupboards and Drawers")

@export var topLeftCupboard: Control
var isTopLeftCupboardOpen: bool
@export var coloredCerealBoxes: Array[Sprite2D]
const SHORT_BOX_RECT = Rect2(48, 272, 17, 28)
const TALL_BOX_RECT = Rect2(79, 272, 17, 28)
const BLUE_BUTTON_COLOR = Color8(0, 19, 255)
const GREEN_BUTTON_COLOR = Color8(7, 187, 39)
const RED_BUTTON_COLOR = Color8(219, 36, 36)
const YELLOW_BUTTON_COLOR = Color8(205, 202, 41)
var cerealBoxColors: Array[Color] = [BLUE_BUTTON_COLOR, GREEN_BUTTON_COLOR, RED_BUTTON_COLOR, YELLOW_BUTTON_COLOR]

@export var bottomLeftCupboard: Control
var isBottomLeftCupboardOpen: bool
@export var cerealBoxNumberSprites: Array[Sprite2D]
const CEREAL_BOX_NUMBER_RECTS: Dictionary[int,Rect2] = {
	1 : Rect2(48, 224, 3, 7), 2 : Rect2(64, 224, 3, 7),
	3 : Rect2(48, 240, 3, 7), 4 : Rect2(64, 240, 3, 7)
}
var cerealBoxNumbers: Array[int] = [1,2,3,4]

@export var bottomDrawer: Sprite2D
var isBottomDrawerOpen: bool
@export var middleDrawer: Sprite2D
var isMiddleDrawerOpen: bool
@export var topDrawer: Sprite2D
var isTopDrawerOpen: bool

@export var middleLeftCupboard: Control
var isMiddleLeftCupboardOpen: bool
@export var hungryDemon: Sprite2D
@export var satisfiedDemon: Sprite2D
var isDemonSatisfied: bool

@export var middleRightCupboard: Control
var isMiddleRightCupboardOpen: bool
@export var cupboardFork: Sprite2D

@export var bottomRightCupboard: Sprite2D
var isBottomRightCupboardOpen: bool


@export_group("Oven")

@export var closedOvenDoor: Sprite2D
@export var openedOvenDoor: Sprite2D
var isOvenDoorOpen: bool

@export var ovenFlames: Sprite2D
var isOvenOn: bool

@export var ovenCereal: Sprite2D
var isCerealInOven: bool

@export var ovenFrozenStrategyGuide: Control
var isStrategyGuideInOven: bool
var isStrategyGuideFrozen: bool

@export var ovenThawedStrategyGuide: Sprite2D
@export var ovenDriedStrategyGuide: Sprite2D
var isStrategyGuideThawed: bool

@export var ovenBurntStrategyGuide: Sprite2D
var isStrategyGuideBurnt: bool

@export var ovenFryingPanControl: Control
enum {FRONT_LEFT, BACK_LEFT, BACK_RIGHT, FRONT_RIGHT}
const OVEN_FRYING_PAN_POSITIONS: Dictionary[int, Vector2] = {
	FRONT_LEFT : Vector2(514, 161), BACK_LEFT : Vector2(544, 147),
	BACK_RIGHT : Vector2(580, 165), FRONT_RIGHT : Vector2(550, 179)
}
var ovenFryingPanPos: int

@export var frontLeftOnDial: Sprite2D
@export var backLeftOnDial: Sprite2D
@export var backRightOnDial: Sprite2D
@export var frontRightOnDial: Sprite2D
var dials: Dictionary[int, Sprite2D] = {
	FRONT_LEFT : frontLeftOnDial, BACK_LEFT : backLeftOnDial,
	BACK_RIGHT : backRightOnDial, FRONT_RIGHT : frontRightOnDial
}
var activeBurner: int


@export_group("Frying Pan")
@export var fryingPanControl: Control
@export var leftFryingPan: Sprite2D
@export var leftActiveBurner: Sprite2D
@export var rightFryingPan: Sprite2D
@export var rightActiveBurner: Sprite2D

@export var rawEgg: Sprite2D
@export var friedEgg: Sprite2D
@export var rawScrambledEgg: Sprite2D
@export var friedScrambledEgg: Sprite2D
@export var eggAshes: Sprite2D
var isEggInPan: bool
var isEggScrambled: bool
var isEggFried: bool
var areAshesOnEgg: bool


@export_group("Fridge")
var fridgeHeat: float

@export var closedTopFridgeDoor: Sprite2D
@export var openedTopFridgeDoor: Sprite2D
var isTopFridgeDoorOpen: bool

@export var closedBottomFridgeDoor: Sprite2D
@export var openedBottomFridgeDoor: Sprite2D
var isBottomFridgeDoorOpen: bool
@export var fridgeLockLight: ColorRect
const LOCKED_LIGHT_COLOR = Color8(205, 30, 30)
const UNLOCKED_LIGHT_COLOR = Color8(57, 255, 57)
var inputtedFridgeButtons: Array[Color]
var isFridgeUnlocked: bool

@export var fridgeFrozenStrategyGuide: Control
var isStrategyGuideInFridge: bool

@export var spoons: Array[Sprite2D]
var spoonNum: int

@export var eggs: Array[Sprite2D]
var eggNum: int

@export var grapefruitJuices: Array[Sprite2D]
var grapefruitJuiceNum: int

@export var milk: Sprite2D
@export var milkLocked: Sprite2D
@export var milkUnlocked: Sprite2D
var isMilkUnlocked: bool


@export_group("Microwave")

@export var closedMicrowaveDoor: Sprite2D
@export var openedMicrowaveDoor: Sprite2D
var isMicrowaveDoorOpen: bool
var currentMilkHeat: int
var minMilkHeat: int
var maxMilkHeat: int

@export var milkVapor: Sprite2D
var isVaporInMicrowave: bool

@export var microwaveCerealBowl: Sprite2D
var isCerealBowlInMicrowave: bool


@export_group("Timer")

@export var minutes: Label
@export var seconds: Label
var timeRemaining: float

@export var larryOff: Sprite2D
var isTimeReverting: bool
var timeBeforeReversion: float
var timeSinceReversionStart: float
var hasTimeReverted: bool

@export_group("Misc")

@export var dirtyCerealBowl: Sprite2D
@export var cleanedCerealBowl: Sprite2D
@export var tableCerealBowl: Sprite2D
enum {DIRTY, CLEAN, JUST_MILK, JUST_CEREAL, UNHATCHED, HATCHED}
const BOWL_REGION_RECTS: Dictionary[int, Rect2] = {
	DIRTY : Rect2(208, 192, 11, 7), CLEAN : Rect2(224, 192, 11, 7),
	JUST_MILK : Rect2(240, 192, 11, 7), JUST_CEREAL : Rect2(208, 208, 11, 7),
	UNHATCHED : Rect2(224, 208, 11, 7), HATCHED : Rect2(240, 208, 11, 7),
}
var bowlState: int:
	set(newState):
		bowlState = newState
		cleanedCerealBowl.region_rect = CEREAL_BOX_NUMBER_RECTS[bowlState]
		tableCerealBowl.region_rect = CEREAL_BOX_NUMBER_RECTS[bowlState]
		microwaveCerealBowl.region_rect = CEREAL_BOX_NUMBER_RECTS[bowlState]
		playerCerealBowl.region_rect = CEREAL_BOX_NUMBER_RECTS[bowlState]
var isCerealBowlOnFan: bool
var isCerealBowlOnTable: bool
var bowlHasMilk: bool:
	get(): return bowlState in [JUST_MILK, UNHATCHED, HATCHED]
var bowlHasCereal: bool:
	get(): return bowlState in [JUST_CEREAL, UNHATCHED, HATCHED]

@export var tableCerealBox: Sprite2D
@export var counterCerealBox: Sprite2D
var isCerealOnTable: bool
var isCerealOnCounter: bool

@export var tableStrategyGuide: Sprite2D
@export var counterStrategyGuide: Sprite2D
@export var counterAshes: Sprite2D
var isStrategyGuideOnTable: bool
var isStrategyGuideOnCounter: bool
var areAshesOnCounter: bool

@export var floorEgg: Sprite2D
var isEggOnFloor


@export_group("Player")

@export var playerControl: Control
enum PlayerPos {
	MICROWAVE, # Or left cupboards
	FRIDGE,
	DRAWERS, # Or picking up bowl from fan
	MIDDLE_LEFT_CUPBOARD, # Or feeding demon or opening both middle cupboards
	MIDDLE_RIGHT_CUPBOARD, # Or washing bowl or flipping Larry the Light Switch
	OVEN, # Or interacting with stove top or items on counter
	RIGHT_CUPBOARD,
	TABLE,
	ZOOMBA,

}
const PLAYER_SPRITE_POSITIONS := {
	PlayerPos.MICROWAVE : Vector2(84, 142), PlayerPos.FRIDGE : Vector2(214, 132),
	PlayerPos.DRAWERS : Vector2(276, 132), PlayerPos.MIDDLE_LEFT_CUPBOARD : Vector2(380, 134),
	PlayerPos.MIDDLE_RIGHT_CUPBOARD : Vector2(320, 134), PlayerPos.OVEN : Vector2(446, 132),
	PlayerPos.RIGHT_CUPBOARD : Vector2(562, 174), PlayerPos.TABLE : Vector2(360, 242),
	PlayerPos.ZOOMBA : Vector2(106, 240)
}
var playerPos: PlayerPos
func movePlayer(newPos: PlayerPos):
	playerPos = newPos
	playerControl.position = PLAYER_SPRITE_POSITIONS[newPos]

@export var playerSprite: Sprite2D
@export var handForeground: Sprite2D
enum {RELAXED, ARMS_IN, RIGHT_ARM_IN, LEFT_ARM_IN, ARMS_VERY_IN, HOLDING_ICE}
func _setPlayerTexture(texture: int):
	match texture:
		RELAXED:
			playerSprite.region_rect.position = Vector2(0,0)
			handForeground.show()
		ARMS_IN:
			playerSprite.region_rect.position = Vector2(128,0)
			handForeground.hide()
		RIGHT_ARM_IN:
			playerSprite.region_rect.position = Vector2(128,80)
			handForeground.hide()
		LEFT_ARM_IN:
			playerSprite.region_rect.position = Vector2(160,80)
			handForeground.hide()
		ARMS_VERY_IN:
			playerSprite.region_rect.position = Vector2(160,0)
			handForeground.hide()
		HOLDING_ICE:
			playerSprite.region_rect.position = Vector2(192,80)
			handForeground.hide()

@export var playerCerealBox: Sprite2D
@export var playerMilk: Sprite2D
@export var playerThawedStrategyGuide: Sprite2D
@export var playerFork: Sprite2D
@export var playerSpoon: Sprite2D
@export var playerFryingPanControl: Control
@export var playerFrozenStrategyGuide: Control
@export var playerAshes: Sprite2D
@export var playerCerealBowl: Sprite2D
enum PlayerHeldItem {
	NONE, CEREAL_BOX, MILK, THAWED_STRATEGY_GUIDE, FORK, SPOON,
	FRYING_PAN, FROZEN_STRATEGY_GUIDE, ASHES, CEREAL_BOWL,
}
var playerHeldItem: PlayerHeldItem
func _removePlayerHeldItem():
	_setPlayerTexture(RELAXED)
	playerHeldItem = PlayerHeldItem.NONE
	playerCerealBox.hide()
	playerMilk.hide()
	playerThawedStrategyGuide.hide()
	playerFork.hide()
	playerSpoon.hide()
	fryingPanControl.reparent(ovenFryingPanControl, false)
	if ovenFryingPanPos in [FRONT_RIGHT, BACK_RIGHT]:
		leftFryingPan.hide()
		rightFryingPan.show()
	playerFrozenStrategyGuide.hide()
	playerAshes.hide()
	playerCerealBowl.hide()
func _givePlayerHeldItem(item: PlayerHeldItem):
	match item:
		PlayerHeldItem.CEREAL_BOX:
			playerCerealBox.show()
		PlayerHeldItem.MILK:
			playerMilk.show()
		PlayerHeldItem.THAWED_STRATEGY_GUIDE:
			playerThawedStrategyGuide.show()
		PlayerHeldItem.FORK:
			playerFork.show()
		PlayerHeldItem.SPOON:
			playerSpoon.show()
		PlayerHeldItem.FRYING_PAN:
			fryingPanControl.reparent(playerFryingPanControl, false)
		PlayerHeldItem.FROZEN_STRATEGY_GUIDE:
			playerFrozenStrategyGuide.show()
			_setPlayerTexture(HOLDING_ICE)
		PlayerHeldItem.ASHES:
			playerAshes.show()
			_setPlayerTexture(ARMS_VERY_IN)
		PlayerHeldItem.CEREAL_BOWL:
			playerCerealBowl.show()
			_setPlayerTexture(RIGHT_ARM_IN)
		

@export var playerEgg: Sprite2D
var isPlayerWearingEgg: bool


func _init():
	var sid := SceneManager.SceneID
	sceneTransitions = [sid.MAIN_MENU, sid.ENDING]
	defaultStartingMessage = (
		"With your chores completed and your conscience clear, you throw open the door to the kitchen and step inside. " +
		"Zoomba follows lazily behind you and begins searching for food scraps as you take a look around. Your eyes " +
		"dart over to the large timer on the back wall, filling you with a peculiar mixture of hope and dread. " +
		"There's still time for you to make your breakfast and get to work before it's too late, " +
		"but you'll have to hurry!\nQuickly! Your breakfast awaits!"
	)

func _ready():

	super()

	cerealBoxColors.shuffle()
	for i in range(4):
		coloredCerealBoxes[i].modulate = cerealBoxColors[i]
		if randi()%2: coloredCerealBoxes[i].region_rect = SHORT_BOX_RECT
		else: coloredCerealBoxes[i].region_rect = TALL_BOX_RECT

	while cerealBoxNumbers == [1,2,3,4]:
		cerealBoxNumbers.shuffle()
	for i in range(4):
		cerealBoxNumberSprites[i].region_rect = CEREAL_BOX_NUMBER_RECTS[cerealBoxNumbers[i]]


	ovenFryingPanPos = FRONT_RIGHT


	spoonNum = randi_range(2,7)
	for i in range(len(spoons)):
		if i < spoonNum: spoons[i].show()
		else: spoons[i].hide()

	eggNum = randi_range(1,6)
	for i in range(len(eggs)):
		if i < eggNum: eggs[i].show()
		else: eggs[i].hide()

	grapefruitJuiceNum = randi_range(1,4)
	for i in range(len(grapefruitJuices)):
		if i < grapefruitJuiceNum: grapefruitJuices[i].show()
		else: grapefruitJuices[i].hide()


	var idealMilkHeat = randi_range(40, 59)
	minMilkHeat = idealMilkHeat - 2
	maxMilkHeat = idealMilkHeat + 2


	timeRemaining = 360.9


func _process(delta):
	if paused: return

	if isTimeReverting:
		timeSinceReversionStart += delta
		if timeSinceReversionStart >= 5:
			isTimeReverting = false
			hasTimeReverted = true
			timeRemaining = 639
		else:
			timeRemaining = timeBeforeReversion + (639-timeBeforeReversion)*(timeSinceReversionStart/5)
	else:
		timeRemaining -= delta

	if timeRemaining < 0:
		SceneManager.transitionToScene(
			SceneManager.SceneID.ENDING,
			"You're still running around frantically when the timer ticks down to zero and alarms begin blaring throughout your house. " +
			"It's too late! Breakfast time is here, and YOU HAVE NO BREAKFAST!!\nThe next few hours pass in a blur as you rush to your job " +
			"and try your best to work on an empty stomach. It's no use though. With the gaping hole in your nutritional intake, your " +
			"performance slips into an all time low, and at the end of the day, your boss approaches you to inform you that you're being laid " +
			"off. Unfortunately for you, corporate policy mandates that all firing must be performed both figuratively and literally, so an " +
			"arsonist is dispatched to your house to burn it to the ground. It's a bit inconvenient, but hey, that's just business for ya!",
			SceneManager.EndingID.FIRED_AND_FIRED
		)

	var minutesRemaining = int(timeRemaining) / 60
	var secondsRemaining = int(timeRemaining) % 60
	if minutesRemaining > 9:
		minutesRemaining -= 1
		secondsRemaining += 60
	minutes.text = str(minutesRemaining)
	if secondsRemaining > 9: seconds.text = str(secondsRemaining)
	else: seconds.text = "0" + str(secondsRemaining)

	if isTopFridgeDoorOpen: fridgeHeat += delta
	if isBottomFridgeDoorOpen: fridgeHeat += delta
	if not isTopFridgeDoorOpen and not isBottomFridgeDoorOpen: fridgeHeat -= delta
	if fridgeHeat < 0: fridgeHeat = 0
	if fridgeHeat > 60:
		SceneManager.transitionToScene(
			SceneManager.SceneID.ENDING,
			"The whirring from your fridge's motor has been getting louder for a while, and now the steady whirring has " +
			"transitioned to a frantic, high-pitched buzzing. You don't usually leave the doors open for this long, " +
			"and it seems like the fridge is NOT happy about it. You reach out your hand to close the door, and as if on cue the " +
			"motor behind the fridge starts expelling flames at an alarming rate. With a yelp, you slam the door shut, " +
			"but bright red flames have already latched onto the wall behind the fridge and started to spread throughout the kitchen...",
			SceneManager.EndingID.BEWARE_OF_BURNOUT
		)


func openTopLeftCupboard():
	topLeftCupboard.show()
	isTopLeftCupboardOpen = true
	movePlayer(PlayerPos.MICROWAVE)
func closeTopLeftCupboard():
	topLeftCupboard.hide()
	isTopLeftCupboardOpen = false
	movePlayer(PlayerPos.MICROWAVE)

func openBottomLeftCupboard():
	bottomLeftCupboard.show()
	isBottomLeftCupboardOpen = true
	movePlayer(PlayerPos.MICROWAVE)
func closeBottomLeftCupboard():
	bottomLeftCupboard.hide()
	isBottomLeftCupboardOpen = false
	movePlayer(PlayerPos.MICROWAVE)

func openBottomDrawer():
	bottomDrawer.show()
	isBottomDrawerOpen = true
	movePlayer(PlayerPos.DRAWERS)
func closeBottomDrawer():
	bottomDrawer.hide()
	isBottomDrawerOpen = false
	movePlayer(PlayerPos.DRAWERS)

func openMiddleDrawer():
	middleDrawer.show()
	isMiddleDrawerOpen = true
	movePlayer(PlayerPos.DRAWERS)
func closeMiddleDrawer():
	middleDrawer.hide()
	isMiddleDrawerOpen = false
	movePlayer(PlayerPos.DRAWERS)

func openTopDrawer():
	topDrawer.show()
	isTopDrawerOpen = true
	movePlayer(PlayerPos.DRAWERS)
func closeTopDrawer():
	topDrawer.hide()
	isTopDrawerOpen = false
	movePlayer(PlayerPos.DRAWERS)

func openMiddleLeftCupboard():
	middleLeftCupboard.show()
	isMiddleLeftCupboardOpen = true
	movePlayer(PlayerPos.MIDDLE_LEFT_CUPBOARD)
func closeMiddleLeftCupboard():
	middleLeftCupboard.hide()
	isMiddleLeftCupboardOpen = false
	movePlayer(PlayerPos.MIDDLE_LEFT_CUPBOARD)

func feedDemon():
	hungryDemon.hide()
	satisfiedDemon.show()
	isDemonSatisfied = true
	fryingPanControl.hide()
	_removePlayerHeldItem()
	movePlayer(PlayerPos.MIDDLE_LEFT_CUPBOARD)
func satisfyDemon(): feedDemon() ## An alias for feedDemon.

func openMiddleRightCupboard():
	middleRightCupboard.show()
	isMiddleRightCupboardOpen = true
	movePlayer(PlayerPos.MIDDLE_RIGHT_CUPBOARD)
func closeMiddleRightCupboard():
	middleRightCupboard.hide()
	isMiddleRightCupboardOpen = false
	movePlayer(PlayerPos.MIDDLE_RIGHT_CUPBOARD)

func takeFork():
	cupboardFork.hide()
	_givePlayerHeldItem(PlayerHeldItem.FORK)
	movePlayer(PlayerPos.MIDDLE_RIGHT_CUPBOARD)
func putForkBack():
	cupboardFork.show()
	_removePlayerHeldItem()
	movePlayer(PlayerPos.MIDDLE_RIGHT_CUPBOARD)

func openBottomRightCupboard():
	bottomRightCupboard.show()
	isBottomRightCupboardOpen = true
	movePlayer(PlayerPos.RIGHT_CUPBOARD)
func closeBottomRightCupboard():
	bottomRightCupboard.hide()
	isBottomRightCupboardOpen = false
	movePlayer(PlayerPos.RIGHT_CUPBOARD)


func openOvenDoor():
	closedOvenDoor.hide()
	openedOvenDoor.show()
	isOvenDoorOpen = true
	movePlayer(PlayerPos.OVEN)
func closeOvenDoor():
	closedOvenDoor.show()
	openedOvenDoor.hide()
	isOvenDoorOpen = false
	movePlayer(PlayerPos.OVEN)

func turnOvenOn():
	ovenFlames.show()
	isOvenOn = true
	movePlayer(PlayerPos.OVEN)
func turnOvenOff():
	ovenFlames.hide()
	isOvenOn = false
	movePlayer(PlayerPos.OVEN)


func putFrozenStrategyGuideInOven():
	ovenFrozenStrategyGuide.show()
	isStrategyGuideInOven = true
	_removePlayerHeldItem()
	movePlayer(PlayerPos.OVEN)
func takeFrozenStrategyGuideFromOven():
	ovenFrozenStrategyGuide.hide()
	isStrategyGuideInOven = false
	_givePlayerHeldItem(PlayerHeldItem.FROZEN_STRATEGY_GUIDE)
	movePlayer(PlayerPos.OVEN)

func thawStrategyGuide():
	ovenFrozenStrategyGuide.hide()
	ovenThawedStrategyGuide.show()
	isStrategyGuideFrozen = false
	isStrategyGuideThawed = true
	movePlayer(PlayerPos.OVEN)

func takeThawedStrategyGuideFromOven():
	ovenThawedStrategyGuide.hide()
	ovenDriedStrategyGuide.hide()
	isStrategyGuideInOven = false
	_givePlayerHeldItem(PlayerHeldItem.THAWED_STRATEGY_GUIDE)
	movePlayer(PlayerPos.OVEN)
func putThawedStrategyGuideInOven():
	ovenDriedStrategyGuide.show()
	isStrategyGuideInOven = true
	_removePlayerHeldItem()
	movePlayer(PlayerPos.OVEN)

func burnStrategyGuide():
	ovenThawedStrategyGuide.hide()
	ovenDriedStrategyGuide.hide()
	ovenBurntStrategyGuide.show()
	isStrategyGuideThawed = false
	isStrategyGuideBurnt = true
	movePlayer(PlayerPos.OVEN)

func takeBurntStrategyGuideFromOven():
	ovenBurntStrategyGuide.hide()
	isStrategyGuideInOven = false
	_givePlayerHeldItem(PlayerHeldItem.ASHES)
	movePlayer(PlayerPos.OVEN)
func putBurntStrategyGuideInOven():
	ovenBurntStrategyGuide.show()
	isStrategyGuideInOven = true
	_removePlayerHeldItem()
	movePlayer(PlayerPos.OVEN)

func takeFryingPan():
	_givePlayerHeldItem(PlayerHeldItem.FRYING_PAN)
	movePlayer(PlayerPos.OVEN)
func putFryingPanBack():
	_removePlayerHeldItem()
	movePlayer(PlayerPos.OVEN)

func moveFryingPan(whichBurner: int):
	ovenFryingPanPos = whichBurner
	ovenFryingPanControl.position = OVEN_FRYING_PAN_POSITIONS[whichBurner]
	if whichBurner in [FRONT_LEFT, BACK_LEFT]:
		rightFryingPan.hide()
		leftFryingPan.show()
	else:
		leftFryingPan.hide()
		rightFryingPan.show()
	movePlayer(PlayerPos.OVEN)

func turnOnBurner(whichBurner: int):
	activeBurner = whichBurner
	dials[whichBurner].show()
	if whichBurner in [FRONT_LEFT, BACK_LEFT]: leftActiveBurner.show()
	else: rightActiveBurner.show()
	movePlayer(PlayerPos.OVEN)
func turnOffBurner():
	dials[activeBurner].hide()
	leftActiveBurner.hide()
	rightActiveBurner.hide()
	activeBurner = NONE
	movePlayer(PlayerPos.OVEN)


func addRawEggToPan():
	playerEgg.hide()
	isPlayerWearingEgg = false
	rawEgg.show()
	isEggInPan = true
	movePlayer(PlayerPos.OVEN)

func fryEgg():
	if isEggScrambled:
		rawScrambledEgg.hide()
		friedScrambledEgg.show()
	else:
		rawEgg.hide()
		friedEgg.show()
	isEggFried = true
	movePlayer(PlayerPos.OVEN)

func scrambleEgg():
	if isEggFried:
		friedEgg.hide()
		friedScrambledEgg.show()
	else:
		rawEgg.hide()
		rawScrambledEgg.show()
	isEggScrambled = true
	movePlayer(PlayerPos.OVEN)

func addAshes():
	eggAshes.show()
	areAshesOnEgg = true
	movePlayer(PlayerPos.OVEN)


func openTopFridgeDoor():
	closedTopFridgeDoor.hide()
	openedTopFridgeDoor.show()
	isTopFridgeDoorOpen = true
	movePlayer(PlayerPos.FRIDGE)
func closeTopFridgeDoor():
	closedTopFridgeDoor.show()
	openedTopFridgeDoor.hide()
	isTopFridgeDoorOpen = false
	movePlayer(PlayerPos.FRIDGE)

func pressButton(whichButton: Color):
	inputtedFridgeButtons.append(whichButton)
	movePlayer(PlayerPos.FRIDGE)
func checkFridgeLock():
	if len(inputtedFridgeButtons) != 4: return false
	for number in cerealBoxNumbers:
		if inputtedFridgeButtons[number] != cerealBoxColors[number]: return false
	fridgeLockLight.color = UNLOCKED_LIGHT_COLOR
	isFridgeUnlocked = true
	inputtedFridgeButtons.clear()
	return true

func openBottomFridgeDoor():
	closedBottomFridgeDoor.hide()
	fridgeLockLight.hide()
	openedBottomFridgeDoor.show()
	isBottomFridgeDoorOpen = true
	movePlayer(PlayerPos.FRIDGE)
func closeBottomFridgeDoor():
	closedBottomFridgeDoor.show()
	fridgeLockLight.show()
	fridgeLockLight.color = LOCKED_LIGHT_COLOR
	isFridgeUnlocked = false
	openedBottomFridgeDoor.hide()
	isBottomFridgeDoorOpen = false
	movePlayer(PlayerPos.FRIDGE)

func takeFrozenStrategyGuideFromFridge():
	fridgeFrozenStrategyGuide.hide()
	isStrategyGuideInFridge = false
	_givePlayerHeldItem(PlayerHeldItem.FROZEN_STRATEGY_GUIDE)
	movePlayer(PlayerPos.FRIDGE)
func putFrozenStrategyGuideInFridge():
	fridgeFrozenStrategyGuide.show()
	isStrategyGuideInFridge = true
	_removePlayerHeldItem()
	movePlayer(PlayerPos.FRIDGE)

func takeSpoonFromFridge():
	spoons[0].hide()
	_givePlayerHeldItem(PlayerHeldItem.SPOON)
	movePlayer(PlayerPos.FRIDGE)
func putSpoonInFridge():
	spoons[0].show()
	_removePlayerHeldItem()
	movePlayer(PlayerPos.FRIDGE)

func takeEggFromFridge():
	eggs[0].hide()
	playerEgg.show()
	isPlayerWearingEgg = true
	movePlayer(PlayerPos.FRIDGE)
func putEggInFridge():
	eggs[0].show()
	playerEgg.hide()
	isPlayerWearingEgg = false
	movePlayer(PlayerPos.FRIDGE)

func checkMilkCombo(combo: String):
	movePlayer(PlayerPos.FRIDGE)
	if len(combo) != 3: return false
	if not combo[0].is_valid_int() or int(combo[0]) != eggNum: return false
	if not combo[1].is_valid_int() or int(combo[1]) != spoonNum: return false
	if not combo[2].is_valid_int() or int(combo[2]) != grapefruitJuiceNum: return false
	milkLocked.hide()
	milkUnlocked.show()
	isMilkUnlocked = true
	return true

func lockMilk():
	movePlayer(PlayerPos.FRIDGE)
	milkLocked.show()
	milkUnlocked.hide()
	isMilkUnlocked = false

func takeMilk():
	milk.hide()
	_givePlayerHeldItem(PlayerHeldItem.MILK)
	movePlayer(PlayerPos.FRIDGE)
func putMilkBack():
	milk.show()
	_removePlayerHeldItem()
	movePlayer(PlayerPos.FRIDGE)


func openMicrowaveDoor():
	openedMicrowaveDoor.show()
	closedMicrowaveDoor.hide()
	isMicrowaveDoorOpen = true
	movePlayer(PlayerPos.MICROWAVE)
func closeMicrowaveDoor():
	openedMicrowaveDoor.hide()
	closedMicrowaveDoor.show()
	isMicrowaveDoorOpen = false
	movePlayer(PlayerPos.MICROWAVE)

func addHeatToMilk(heat: int):
	currentMilkHeat += heat
	if currentMilkHeat > maxMilkHeat:
		milkVapor.show()
		isVaporInMicrowave = true
	elif currentMilkHeat >= minMilkHeat and bowlState == UNHATCHED:
		bowlState = HATCHED
	movePlayer(PlayerPos.MICROWAVE)
	

func flipLarryTheLightSwitch():
	larryOff.hide()
	timeBeforeReversion = timeRemaining
	timeSinceReversionStart = 0
	isTimeReverting = true
	movePlayer(PlayerPos.MIDDLE_RIGHT_CUPBOARD)


func cleanCerealBowl():
	dirtyCerealBowl.hide()
	cleanedCerealBowl.show()
	bowlState = CLEAN
	movePlayer(PlayerPos.MIDDLE_RIGHT_CUPBOARD)

func isCerealBowlAccessible():
	if isCerealBowlInMicrowave and not isMicrowaveDoorOpen: return false
	else: return true

func takeCerealBowl():
	if isCerealBowlOnFan:
		cleanedCerealBowl.hide()
		isCerealBowlOnFan = false
		movePlayer(PlayerPos.MIDDLE_RIGHT_CUPBOARD)
	elif isCerealBowlOnTable:
		tableCerealBowl.hide()
		isCerealBowlOnTable = false
		movePlayer(PlayerPos.TABLE)
	elif isCerealBowlInMicrowave:
		microwaveCerealBowl.hide()
		isCerealBowlInMicrowave = false
		movePlayer(PlayerPos.MICROWAVE)
	_givePlayerHeldItem(PlayerHeldItem.CEREAL_BOWL)

func putCerealBowlOnFan():
	cleanedCerealBowl.show()
	isCerealBowlOnFan = true
	_removePlayerHeldItem()
	movePlayer(PlayerPos.MIDDLE_RIGHT_CUPBOARD)
func putCerealBowlOnTable():
	tableCerealBowl.show()
	isCerealBowlOnTable = true
	_removePlayerHeldItem()
	movePlayer(PlayerPos.TABLE)
func putCerealBowlInMicrowave():
	microwaveCerealBowl.show()
	isCerealBowlInMicrowave = true
	_removePlayerHeldItem()
	movePlayer(PlayerPos.MICROWAVE)

func isCerealAccessible():
	if isCerealInOven and not isOvenDoorOpen: return false
	else: return true

func takeCereal():
	if isCerealInOven:
		ovenCereal.hide()
		isCerealInOven = false
		movePlayer(PlayerPos.OVEN)
	elif isCerealOnCounter:
		counterCerealBox.hide()
		isCerealOnCounter = false
		movePlayer(PlayerPos.OVEN)
	elif isCerealOnTable:
		tableCerealBox.hide()
		isCerealOnTable = false
		movePlayer(PlayerPos.TABLE)
	_givePlayerHeldItem(PlayerHeldItem.CEREAL_BOX)
func putCerealInOven():
	ovenCereal.show()
	isCerealInOven = true
	_removePlayerHeldItem()
	movePlayer(PlayerPos.OVEN)
func putCerealOnCounter():
	counterCerealBox.show()
	isCerealOnCounter = true
	_removePlayerHeldItem()
	movePlayer(PlayerPos.OVEN)
func putCerealOnTable():
	tableCerealBox.show()
	isCerealOnTable = true
	_removePlayerHeldItem()
	movePlayer(PlayerPos.TABLE)

func pourMilkInBowl():
	if bowlState == CLEAN: bowlState = JUST_MILK
	elif bowlState == JUST_CEREAL: bowlState = UNHATCHED

	if isCerealBowlOnFan:
		movePlayer(PlayerPos.MIDDLE_RIGHT_CUPBOARD)
	elif isCerealBowlOnTable:
		movePlayer(PlayerPos.TABLE)

func pourCerealInBowl():
	if bowlState == CLEAN: bowlState = JUST_CEREAL
	elif bowlState == JUST_MILK:
		if currentMilkHeat > minMilkHeat: bowlState = HATCHED
		else: bowlState = UNHATCHED
	
	if isCerealBowlOnFan:
		movePlayer(PlayerPos.MIDDLE_RIGHT_CUPBOARD)
	elif isCerealBowlOnTable:
		movePlayer(PlayerPos.TABLE)


func putStrategyGuideOnCounter():
	counterStrategyGuide.show()
	isStrategyGuideOnCounter = true
	_removePlayerHeldItem()
	movePlayer(PlayerPos.OVEN)
func takeStrategyGuideFromCounter():
	counterStrategyGuide.hide()
	isStrategyGuideOnCounter = false
	_givePlayerHeldItem(PlayerHeldItem.THAWED_STRATEGY_GUIDE)
	movePlayer(PlayerPos.OVEN)

func putStrategyGuideOnTable():
	tableStrategyGuide.show()
	isStrategyGuideOnTable = true
	_removePlayerHeldItem()
	movePlayer(PlayerPos.TABLE)
func takeStrategyGuideFromTable():
	tableStrategyGuide.hide()
	isStrategyGuideOnTable = false
	_givePlayerHeldItem(PlayerHeldItem.THAWED_STRATEGY_GUIDE)
	movePlayer(PlayerPos.TABLE)

func putAshesOnCounter():
	counterAshes.show()
	areAshesOnCounter = true
	_removePlayerHeldItem()
	movePlayer(PlayerPos.OVEN)
func takeAshesFromCounter():
	counterAshes.hide()
	areAshesOnCounter = false
	_givePlayerHeldItem(PlayerHeldItem.ASHES)
	movePlayer(PlayerPos.OVEN)

func crackEggOnFloor():
	floorEgg.show()
	isEggOnFloor = true
	playerEgg.hide()
	isPlayerWearingEgg = false
	movePlayer(PlayerPos.OVEN)