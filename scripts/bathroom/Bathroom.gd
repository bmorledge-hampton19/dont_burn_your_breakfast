class_name Bathroom
extends Scene

@export var playerControl: Control
@export var player: Sprite2D
@export var toothpastedPlayer: Sprite2D
@export var playersToothpaste: Sprite2D
@export var playersToothbrush: Sprite2D

@export var playerInTub: Sprite2D
@export var lubedPlayerInTub: Sprite2D
@export var spilledShampoo: Sprite2D
@export var openedCabinet: Sprite2D
@export var toothpaste: Sprite2D
@export var openedTopDrawer: Sprite2D
@export var openedMiddleDrawer: Sprite2D
@export var openedBottomDrawer: Sprite2D
@export var toothbrush: Sprite2D
@export var openedToiletSeat: Sprite2D
@export var keyInLock: Sprite2D
@export var openedDoor: Sprite2D

# NOTE TO SELF: Use properties next time which automatically change sprite position and visibility.
enum PlayerPosition {
	IN_TUB, ON_MAT, IN_FRONT_OF_CABINET,
	IN_FRONT_OF_TOILET, IN_FRONT_OF_DOOR,
}
var playerPosition := PlayerPosition.IN_TUB
var playerControlPositions := {
	PlayerPosition.IN_TUB : null,
	PlayerPosition.ON_MAT : Vector2(156, 232),
	PlayerPosition.IN_FRONT_OF_CABINET : Vector2(444, 246),
	PlayerPosition.IN_FRONT_OF_TOILET : Vector2(532, 246),
	PlayerPosition.IN_FRONT_OF_DOOR : Vector2(250, 160),
}

var isPlayerLubed := false
var isShampooSpilled := false

var isCabinetOpen := false
var playerHasToothpaste := false

var isTopDrawerOpen := false
var isMiddleDrawerOpen := false
var isBottomDrawerOpen := false
var playerHasToothbrush := false

var remainingToothpaste := 5
var isToiletSeatOpened := false
var isToothbrushRinsed := true
var isToothbrushToothpasted := false
var isToiletToothpasted := false
var isPlayerToothpasted := false
var aimingToothpasteAway := false
var isKeyInLock := false
var isDoorUnlocked := false
var isDoorOpen := false

func _init():
	var sid := SceneManager.SceneID
	sceneTransitions = [sid.MAIN_MENU, sid.ENDING, sid.FRONT_YARD]
	defaultStartingMessage = (
		"You awaken from a deep slumber and blink groggily as you begin to take in your surroundings. " +
		"Slowly, your eyes adjust to the harsh, white lighting and the features of your own bathroom shift into focus. " +
		"You try to move around but quickly realize that you're almost completely submerged in a bathtub full of cereal.\n" +
		"How did you end up here? Last night's party is a bit of a blur... You can recall downing your sixth bowl of Cinnamon " +
		"Toast Crunch to raucous applause, but your memory stops abruptly afterwards. It seems safe to assume that things " +
		"only got crazier from there. Apparently your tolerance for sugary breakfast cereal isn't what it used to be...\n" +
		"You're not sure what time it is, but you vaguely remember that you have to go in to work today, and you certainly " +
		"can't arrive in this state... You desperately need a good breakfast!"
	)


# Called when the node enters the scene tree for the first time.
func _ready():

	super()

	player.hide()
	toothpastedPlayer.hide()
	playersToothbrush.hide()
	playersToothpaste.hide()

	lubedPlayerInTub.hide()
	spilledShampoo.hide()
	openedCabinet.hide()
	toothpaste.hide()
	openedTopDrawer.hide()
	openedMiddleDrawer.hide()
	openedBottomDrawer.hide()
	toothbrush.hide()
	openedToiletSeat.hide()
	keyInLock.hide()
	openedDoor.hide()


func movePlayer(newPlayerPosition: PlayerPosition):
	playerPosition = newPlayerPosition
	playerControl.position = playerControlPositions[playerPosition]


func lubeUp():
	playerInTub.hide()
	lubedPlayerInTub.show()
	isPlayerLubed = true

func spillShampoo():
	spilledShampoo.show()
	isShampooSpilled = true

func exitTub():
	movePlayer(PlayerPosition.ON_MAT)
	player.show()
	lubedPlayerInTub.hide()
	isPlayerLubed = false


func openCabinet():
	movePlayer(PlayerPosition.IN_FRONT_OF_CABINET)
	openedCabinet.show()
	if not playerHasToothpaste: toothpaste.show()
	isCabinetOpen = true

func closeCabinet():
	movePlayer(PlayerPosition.IN_FRONT_OF_CABINET)
	openedCabinet.hide()
	toothpaste.hide()
	isCabinetOpen = false

func isPlayerBlockedByCabinet() -> bool:
	return (
		(playerPosition == PlayerPosition.IN_FRONT_OF_CABINET or playerPosition == PlayerPosition.IN_FRONT_OF_TOILET)
		and isCabinetOpen
	)

func takeToothpaste():
	movePlayer(PlayerPosition.IN_FRONT_OF_TOILET)
	toothpaste.hide()
	playersToothpaste.show()
	playerHasToothpaste = true

func returnToothpaste():
	movePlayer(PlayerPosition.IN_FRONT_OF_TOILET)
	toothpaste.show()
	playersToothpaste.hide()
	playerHasToothpaste = false


func openTopDrawer():
	movePlayer(PlayerPosition.IN_FRONT_OF_TOILET)
	openedTopDrawer.show()
	isTopDrawerOpen = true

func closeTopDrawer():
	movePlayer(PlayerPosition.IN_FRONT_OF_TOILET)
	openedTopDrawer.hide()
	isTopDrawerOpen = false

func openMiddleDrawer():
	movePlayer(PlayerPosition.IN_FRONT_OF_TOILET)
	openedMiddleDrawer.show()
	if not playerHasToothbrush: toothbrush.show()
	isMiddleDrawerOpen = true

func closeMiddleDrawer():
	movePlayer(PlayerPosition.IN_FRONT_OF_TOILET)
	openedMiddleDrawer.hide()
	toothbrush.hide()
	isMiddleDrawerOpen = false

func openBottomDrawer():
	movePlayer(PlayerPosition.IN_FRONT_OF_TOILET)
	openedBottomDrawer.show()
	isBottomDrawerOpen = true

func closeBottomDrawer():
	movePlayer(PlayerPosition.IN_FRONT_OF_TOILET)
	openedBottomDrawer.hide()
	isBottomDrawerOpen = false

func takeToothbrush():
	movePlayer(PlayerPosition.IN_FRONT_OF_TOILET)
	toothbrush.hide()
	playersToothbrush.show()
	playerHasToothbrush = true

func returnToothbrush():
	movePlayer(PlayerPosition.IN_FRONT_OF_TOILET)
	toothbrush.show()
	playersToothbrush.hide()
	playerHasToothbrush = false


func openToiletSeat():
	movePlayer(PlayerPosition.IN_FRONT_OF_TOILET)
	openedToiletSeat.show()
	isToiletSeatOpened = true

func closeToiletSeat():
	movePlayer(PlayerPosition.IN_FRONT_OF_TOILET)
	openedToiletSeat.hide()
	isToiletSeatOpened = false

func applyToothpasteToToothbrush():
	remainingToothpaste -= 1
	isToothbrushRinsed = false
	isToothbrushToothpasted = true

func rinseToothbrush():
	movePlayer(PlayerPosition.IN_FRONT_OF_TOILET)
	isToothbrushRinsed = true
	isToiletToothpasted = true

func flushToilet():
	movePlayer(PlayerPosition.IN_FRONT_OF_TOILET)
	isToiletToothpasted = false

func brushTeeth():
	player.hide()
	toothpastedPlayer.show()
	isPlayerToothpasted = true
	isToothbrushToothpasted = false

func spitToothpaste(spittingInToilet := false):
	player.show()
	toothpastedPlayer.hide()
	isPlayerToothpasted = false
	if spittingInToilet:
		isToiletToothpasted = true
		movePlayer(PlayerPosition.IN_FRONT_OF_TOILET)
	else:
		movePlayer(PlayerPosition.IN_FRONT_OF_CABINET)

func aimToothpasteAway():
	aimingToothpasteAway = true

func lookDownBarrelOfToothpaste():
	aimingToothpasteAway = false

func ejectKey():
	isKeyInLock = true
	keyInLock.show()

func unlockDoor():
	movePlayer(PlayerPosition.IN_FRONT_OF_DOOR)
	isDoorUnlocked = true

func lockDoor():
	movePlayer(PlayerPosition.IN_FRONT_OF_DOOR)
	isDoorUnlocked = false

func openDoor():
	movePlayer(PlayerPosition.IN_FRONT_OF_DOOR)
	isDoorOpen = true
	openedDoor.show()

func closeDoor():
	movePlayer(PlayerPosition.IN_FRONT_OF_DOOR)
	isDoorOpen = false
	openedDoor.hide()