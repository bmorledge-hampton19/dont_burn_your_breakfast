class_name FrontYard
extends Scene

@export var playerControl: Control
@export var playersGasoline: Sprite2D
@export var playersRightShoeTied: Sprite2D
@export var playersLeftShoeTied: Sprite2D
@export var playersRightShoeUntied: Sprite2D
@export var playersLeftShoeUntied: Sprite2D
@export var playersShoesTiedTogether: Sprite2D

@export var rightShoeControl: Control
@export var rightShoeTied: Sprite2D
@export var rightShoeUntied: Sprite2D

@export var leftShoeControl: Control
@export var leftShoeTied: Sprite2D
@export var leftShoeUntied: Sprite2D

@export var mowerControl: Control
@export var mowerWithCap: Sprite2D
@export var mowerWithoutCap: Sprite2D
@export var mowerRunning: Sprite2D

@export var gasoline: Sprite2D

@export var mownGrass: Sprite2D
@export var unmownGrass: Sprite2D

@export var openedBedroomDoor: Sprite2D

enum SpritePos {
	BATHROOM_DOOR, IN_FRONT_OF_SHELF, ON_SHELF,
	STEP_1, STEP_2, STEP_3, STEP_4, STEP_5, BEDROOM_DOOR
}

var playerSpritePositions := {
	SpritePos.BATHROOM_DOOR : Vector2(448,150), SpritePos.IN_FRONT_OF_SHELF : Vector2(534,170),
	SpritePos.STEP_1 : Vector2(284,150), SpritePos.STEP_2 : Vector2(246,132),
	SpritePos.STEP_3 : Vector2(208,114), SpritePos.STEP_4 : Vector2(170,96),
	SpritePos.STEP_5 : Vector2(132,78),
	SpritePos.BEDROOM_DOOR : Vector2(30,48),
}

var leftShoeSpritePositions := {
	SpritePos.ON_SHELF : Vector2(624,246), SpritePos.STEP_1 : Vector2(320,268),
	SpritePos.STEP_2 : Vector2(282,250), SpritePos.STEP_3 : Vector2(244,232),
	SpritePos.STEP_4 : Vector2(206,214),
}

var rightShoeSpritePositions := {
	SpritePos.ON_SHELF : Vector2(648,246), SpritePos.STEP_1 : Vector2(286,306),
	SpritePos.STEP_2 : Vector2(248,288), SpritePos.STEP_3 : Vector2(210,270),
	SpritePos.STEP_4 : Vector2(172,252),
}

var playerPos := SpritePos.BATHROOM_DOOR
var rightShoePos := SpritePos.ON_SHELF
var leftShoePos := SpritePos.ON_SHELF

var isPlayerWearingRightShoe := false
var isPlayerWearingLeftShoe := false
var isRightShoeTied := true
var isLeftShoeTied := true
var areShoesTiedTogether := false
var areShoesMismatched := false

var isStepMown := false
var isPlayerEntangled := false

var playerHasGasoline := false
var mowerHasCap := true
var mowerHasGas := false
var isMowerRunning := false
var mowerFuelRemaining := 0.0

var isBedroomDoorOpen := false


func _init():
	var sid := SceneManager.SceneID
	sceneTransitions = [sid.MAIN_MENU, sid.ENDING, sid.BEDROOM]
	defaultStartingMessage = (
		"You emerge from your bathroom and step out into your front yard. You take a moment to admire your custom lawn " +
		"before looking up at the sky and realizing that the sun is already well above the horizon. "+
		"It's even later than you thought! " +
		"Your shift could be starting any moment now, and you'll be lucky just to keep your job at this point...\n" +
		"For the briefest instant, you consider skipping breakfast but immediately perish the thought. After all, " +
		"it's the most important meal of the day! You'll just have to pick up the pace."
	)

func _ready():
	super()

func _process(delta):
	if isMowerRunning:
		mowerFuelRemaining -= delta
		if mowerFuelRemaining <= 0:
			mowerHasGas = false
			turnOffMower()


func movePlayer(newPos: SpritePos):
	if newPos == SpritePos.STEP_2: AudioManager.playSound(AudioManager.creakingStep, true)
	if (
		(newPos == SpritePos.STEP_1 and playerPos != SpritePos.STEP_2) or
		(newPos == SpritePos.STEP_3 and playerPos != SpritePos.STEP_4) or
		(newPos == SpritePos.STEP_4 and playerPos != SpritePos.STEP_5) or
		(newPos == SpritePos.STEP_5 and playerPos != SpritePos.BEDROOM_DOOR) or
		(newPos == SpritePos.BEDROOM_DOOR)
	):
		AudioManager.playSound(AudioManager.goodTextInput, true)
	playerPos = newPos
	playerControl.position = playerSpritePositions[newPos]

func moveRightShoe(newPos: SpritePos):
	rightShoePos = newPos
	rightShoeControl.position = rightShoeSpritePositions[newPos]

func moveLeftShoe(newPos: SpritePos):
	leftShoePos = newPos
	leftShoeControl.position = leftShoeSpritePositions[newPos]


func canPlayerReachRightShoe():
	if isPlayerWearingRightShoe: return true
	elif rightShoePos == playerPos: return true
	elif (
		rightShoePos == SpritePos.ON_SHELF and
		(playerPos == SpritePos.BATHROOM_DOOR or playerPos == SpritePos.IN_FRONT_OF_SHELF)
	): return true
	else: return false

func canPlayerReachLeftShoe():
	if isPlayerWearingLeftShoe: return true
	elif leftShoePos == playerPos: return true
	elif (
		leftShoePos == SpritePos.ON_SHELF and
		(playerPos == SpritePos.BATHROOM_DOOR or playerPos == SpritePos.IN_FRONT_OF_SHELF)
	): return true
	else: return false

func isPlayerOnConcrete():
	return playerPos == SpritePos.BATHROOM_DOOR or playerPos == SpritePos.IN_FRONT_OF_SHELF

func isShoeOnRightFoot():
	return (
		(isPlayerWearingRightShoe and not areShoesMismatched) or
		(isPlayerWearingLeftShoe and areShoesMismatched)
	)

func isShoeOnLeftFoot():
	return (
		(isPlayerWearingLeftShoe and not areShoesMismatched) or
		(isPlayerWearingRightShoe and areShoesMismatched)
	)


func putOnRightShoe(onRightFoot: bool):

	isPlayerWearingRightShoe = true
	rightShoeControl.hide()

	if onRightFoot:
		playersRightShoeUntied.show()
	else:
		areShoesMismatched = true
		playersLeftShoeUntied.show()

func putOnLeftShoe(onLeftFoot: bool):

	isPlayerWearingLeftShoe = true
	leftShoeControl.hide()

	if onLeftFoot:
		playersLeftShoeUntied.show()
	else:
		areShoesMismatched = true
		playersRightShoeUntied.show()

func takeOffRightShoe():

	if playerPos == SpritePos.BATHROOM_DOOR or playerPos == SpritePos.IN_FRONT_OF_SHELF: moveRightShoe(SpritePos.ON_SHELF)
	else: moveRightShoe(playerPos)
	rightShoeControl.show()
	isPlayerWearingRightShoe = false

	if areShoesMismatched:
		playersLeftShoeTied.hide()
		playersLeftShoeUntied.hide()
		if not isPlayerWearingLeftShoe: areShoesMismatched = false
	else:
		playersRightShoeTied.hide()
		playersRightShoeUntied.hide()

func takeOffLeftShoe():

	if playerPos == SpritePos.BATHROOM_DOOR or playerPos == SpritePos.IN_FRONT_OF_SHELF: moveLeftShoe(SpritePos.ON_SHELF)
	else: moveLeftShoe(playerPos)
	leftShoeControl.show()
	isPlayerWearingLeftShoe = false

	if areShoesMismatched:
		playersRightShoeTied.hide()
		playersRightShoeUntied.hide()
		if not isPlayerWearingRightShoe: areShoesMismatched = false
	else:
		playersLeftShoeTied.hide()
		playersLeftShoeUntied.hide()


func tieRightShoe():

	AudioManager.playSound(AudioManager.tyingShoe, true)
	isRightShoeTied = true

	if isPlayerWearingRightShoe:
		if areShoesMismatched:
			playersLeftShoeUntied.hide()
			playersLeftShoeTied.show()
		else:
			playersRightShoeUntied.hide()
			playersRightShoeTied.show()
	else:
		rightShoeUntied.hide()
		rightShoeTied.show()

func tieLeftShoe():

	AudioManager.playSound(AudioManager.tyingShoe, true)
	isLeftShoeTied = true

	if isPlayerWearingLeftShoe:
		if areShoesMismatched:
			playersRightShoeUntied.hide()
			playersRightShoeTied.show()
		else:
			playersLeftShoeUntied.hide()
			playersLeftShoeTied.show()
	else:
		leftShoeUntied.hide()
		leftShoeTied.show()

func tieShoesTogether():

	AudioManager.playSound(AudioManager.tyingShoe, true)
	areShoesTiedTogether = true
	isRightShoeTied = true
	isLeftShoeTied = true
	playersLeftShoeUntied.hide()
	playersRightShoeUntied.hide()
	playersShoesTiedTogether.show()

func untieRightShoe():

	isRightShoeTied = false

	if isPlayerWearingRightShoe:
		if areShoesTiedTogether:
			areShoesTiedTogether = false
			isLeftShoeTied = false
			playersShoesTiedTogether.hide()
			playersRightShoeUntied.show()
			playersLeftShoeUntied.show()
		elif areShoesMismatched:
			playersLeftShoeTied.hide()
			playersLeftShoeUntied.show()
		else:
			playersRightShoeTied.hide()
			playersRightShoeUntied.show()
	else:
		rightShoeTied.hide()
		rightShoeUntied.show()

func untieLeftShoe():

	isLeftShoeTied = false

	if isPlayerWearingLeftShoe:
		if areShoesTiedTogether:
			areShoesTiedTogether = false
			isRightShoeTied = false
			playersShoesTiedTogether.hide()
			playersRightShoeUntied.show()
			playersLeftShoeUntied.show()
		elif areShoesMismatched:
			playersRightShoeTied.hide()
			playersRightShoeUntied.show()
		else:
			playersLeftShoeTied.hide()
			playersLeftShoeUntied.show()
	else:
		leftShoeTied.hide()
		leftShoeUntied.show()


func takeGasoline():
	gasoline.hide()
	playersGasoline.show()
	movePlayer(SpritePos.IN_FRONT_OF_SHELF)
	playerHasGasoline = true

func returnGasoline():
	gasoline.show()
	playersGasoline.hide()
	movePlayer(SpritePos.IN_FRONT_OF_SHELF)
	playerHasGasoline = false


func removeCap():

	mowerWithCap.hide()
	mowerWithoutCap.show()
	mowerHasCap = false

	AudioManager.playSound(AudioManager.goodTextInput, true)

	if isStepMown: movePlayer(SpritePos.BATHROOM_DOOR)
	else: movePlayer(SpritePos.IN_FRONT_OF_SHELF)

func replaceCap():

	mowerWithCap.show()
	mowerWithoutCap.hide()
	mowerHasCap = true

	AudioManager.playSound(AudioManager.goodTextInput, true)

	if isStepMown: movePlayer(SpritePos.BATHROOM_DOOR)
	else: movePlayer(SpritePos.IN_FRONT_OF_SHELF)

func refuelMower():
	AudioManager.playSound(AudioManager.fillingMower, true)
	movePlayer(SpritePos.IN_FRONT_OF_SHELF)
	mowerHasGas = true

func startMower():
	AudioManager.playSound(AudioManager.startingMower, true).finished.connect(AudioManager.playMowerLoop)
	isMowerRunning = true
	mowerFuelRemaining = 20.0
	mowerWithCap.hide()
	mowerRunning.show()

func turnOffMower():
	AudioManager.stopMowerLoop()
	isMowerRunning = false
	mowerWithCap.show()
	mowerRunning.hide()


func mowStep():
	AudioManager.playSound(AudioManager.mowingGrass, true, "OtherSounds", 1.5)
	mowerControl.position = Vector2(340, 242)

	unmownGrass.hide()
	mownGrass.show()
	isStepMown = true


func entanglePlayer():

	isPlayerEntangled = true


func openBedroomDoor():
	AudioManager.fadeOutMusic()
	AudioManager.playSound(AudioManager.openingDoor, true)
	openedBedroomDoor.show()
	isBedroomDoorOpen = true

func closeBedroomDoor():
	AudioManager.playSound(AudioManager.closingDoor, true)
	openedBedroomDoor.hide()
	isBedroomDoorOpen = false