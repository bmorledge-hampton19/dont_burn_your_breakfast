class_name Bedroom
extends Scene

@export var clothingPrefab: PackedScene

# Player nodes
@export_group("Player")
@export var playerControl: Control
@export var playerSprite: Sprite2D

@export var handForeground: Sprite2D
@export var playerClothesControl: Control

@export var playerMachete: Sprite2D
@export var playerFireExtinguisher: Sprite2D
@export var playerSmokeyHat: Sprite2D

@export var playerPepperFlakes: Sprite2D
@export var playerFlintFlakes: Sprite2D
@export var playerBreadCrumbs: Sprite2D
@export var playerCharcoalPowder: Sprite2D

# Bed nodes
@export_group("Bed")
@export var bedGridControls: Array[Control]
@export var lessMessyBed: Sprite2D
@export var almostMadeBed: Sprite2D
@export var madeBed: Sprite2D

# Dresser nodes
@export_group("Dresser")
@export var topLeftDrawerControl: Control
@export var topLeftDrawerClothesControl: Control

@export var topRightDrawerControl: Control
@export var topRightDrawerClothesControl: Control

@export var middleDrawerControl: Control
@export var middleDrawerClothesControl: Control

@export var bottomDrawerControl: Control
@export var bottomDrawerClothesControl: Control

# Smokey nodes
@export_group("Smokey")
@export var smokeyBra: Sprite2D
@export var smokeyMessyBeard: Sprite2D
@export var smokeyShavingCream: Sprite2D
@export var smokeyMessyHair: Sprite2D
@export var smokeyHat: Sprite2D

@export var rackedAxe: Sprite2D
@export var rackedMachete: Sprite2D
@export var rackedFireExtinguisher: Sprite2D
@export var rackedHat: Sprite2D

# Zoomba nodes
@export_group("Zoomba")
@export var zoomba: Sprite2D

@export var tablePepperFlakes: Sprite2D
@export var tableFlintFlakes: Sprite2D
@export var tableBreadCrumbs: Sprite2D
@export var tableCharcoalPowder: Sprite2D

@export var scatteredPepperFlakes: Sprite2D
@export var scatteredFlintFlakes: Sprite2D
@export var scatteredBreadCrumbs: Sprite2D
@export var scatteredCharcoalPowder: Sprite2D

# Gaming station nodes
@export_group("Gaming Station")
@export var clutteredScreen: Sprite2D

enum PlayerPos {
	FRONT_YARD_DOOR, KITCHEN_DOOR,
	COMPUTER_DESK, LEGO_TABLE,
	BED_LEFT_SIDE, BED_RIGHT_SIDE, DRESSER,
	SMOKEY_TOOLS, SMOKEY,
	ZOOMBA, ZOOMBA_FOOD_TABLE, SCATTERING_FOOD
}
const PLAYER_SPRITE_POSITIONS := {
	PlayerPos.FRONT_YARD_DOOR : Vector2(32,80), PlayerPos.KITCHEN_DOOR : Vector2(614,100),
	PlayerPos.COMPUTER_DESK : Vector2(168,70), PlayerPos.LEGO_TABLE : Vector2(54, 236),
	PlayerPos.BED_LEFT_SIDE : Vector2(210,138), PlayerPos.BED_RIGHT_SIDE : Vector2(446,138), PlayerPos.DRESSER : Vector2(244,244),
	PlayerPos.SMOKEY_TOOLS : Vector2(444,30), PlayerPos.SMOKEY : Vector2(526,28),
	PlayerPos.ZOOMBA : Vector2(638,152), PlayerPos.ZOOMBA_FOOD_TABLE : Vector2(500,240), PlayerPos.SCATTERING_FOOD : Vector2(470, 138),
}
var playerPos: PlayerPos

enum {RELAXED, ARMS_IN, ARMS_VERY_IN, HOLDING_AXE}
func setPlayerTexture(texture: int):
	match texture:
		RELAXED: playerSprite.region_rect.position.x = 0
		ARMS_IN: playerSprite.region_rect.position.x = 128
		ARMS_VERY_IN: playerSprite.region_rect.position.x = 160
		HOLDING_AXE: playerSprite.region_rect.position.x = 192

enum PlayerHeldItem {
	NONE, AXE, MACHETE, FIRE_EXTINGUISHER,
	PEPPER_FLAKES, FLINT_FLAKES, BREAD_CRUMBS, CHARCOAL_POWDER,
	CLOTHING,
}
var playerHeldItem: PlayerHeldItem
var heldClothing: Clothing
var heldSecondSock: Clothing
var isPlayerWearingHat: bool

var clothesByDepth := {0 : [], 1 : [], 2 : []} # 0 is highest; 2 is lowest
var accessibleClothing: Array[Clothing]:
	get():
		accessibleClothing.clear()
		for depth in clothesByDepth:
			for clothing in clothesByDepth[depth]:
				if clothing.isAccessible: accessibleClothing.append(clothing)
		return accessibleClothing
var isBedClear: bool:
	get:
		for depth in clothesByDepth:
			if clothesByDepth[depth]: return false
		return true

func isValidClothesPlacement(clothing: Clothing):
	for otherClothing in clothesByDepth[clothing.depth]:
		if otherClothing == clothing: continue
		if doesClothingIntersect(clothing, otherClothing): return false
	return true

func doesClothingIntersect(clothing1: Clothing, clothing2: Clothing):
	return Rect2(clothing1.gridPos,clothing1.gridSize).intersects(Rect2(clothing2.gridPos,clothing2.gridSize))

func addClothingToBed(clothing: Clothing):
	for depth in range(3):
		for otherClothing in clothesByDepth[depth]:
			if doesClothingIntersect(clothing, otherClothing):
				clothing.overlappingClothes[depth] += 1
				otherClothing.overlappingClothes[clothing.depth] += 1
				otherClothing.updateBuriedDepth()
	clothing.updateBuriedDepth()
	if clothing.get_parent() == null: bedGridControls[clothing.depth].add_child(clothing)
	else: clothing.reparent(bedGridControls[clothing.depth])
	clothing.rotation = clothing.bedRotation
	clothing.setBedPosition()
	clothesByDepth[clothing.depth].append(clothing)

func removeClothingFromBed(clothing: Clothing):
	clothesByDepth[clothing.depth].erase(clothing)
	for depth in range(3):
		for otherClothing in clothesByDepth[depth]:
			if doesClothingIntersect(clothing, otherClothing):
				otherClothing.overlappingClothes[clothing.depth] -= 1
				otherClothing.updateBuriedDepth()
		clothing.overlappingClothes[depth] = 0
	clothing.updateBuriedDepth()

enum SearchResult {NONEXISTANT, BURIED, AMBIGUOUS, FOUND}
var clothingSearchResult: SearchResult
var foundSecondSock: Clothing
func findClothing(type, color, pattern) -> Clothing:
	clothingSearchResult = SearchResult.NONEXISTANT
	foundSecondSock = null
	var foundClothing: Clothing
	for depth in range(3):
		for clothing in clothesByDepth[depth]:

			if type == Clothing.AMBIGUOUS or type == clothing.type: pass
			else: continue
			if color == Clothing.AMBIGUOUS or color == clothing.color: pass
			else: continue
			if pattern == Clothing.AMBIGUOUS or pattern == clothing.pattern: pass
			else: continue

			if clothing.isAccessible and clothingSearchResult != SearchResult.AMBIGUOUS:
				if clothingSearchResult == SearchResult.FOUND:
					@warning_ignore("unassigned_variable")
					if type == Clothing.SOCK and foundClothing.color == clothing.color and foundClothing.pattern == clothing.pattern:
						assert(not foundSecondSock, "Looks like we found three matching socks!?")
						foundSecondSock = clothing
					else:
						clothingSearchResult = SearchResult.AMBIGUOUS
						foundSecondSock = null
						return null
				else:
					clothingSearchResult = SearchResult.FOUND
					foundClothing = clothing
			elif clothingSearchResult == SearchResult.NONEXISTANT:
				clothingSearchResult = SearchResult.BURIED
			
	return foundClothing

enum {MESSY, LESS_MESSY, ALMOST_MADE, MADE}
var bedState: int

# func getClothingString(type, color, pattern):
# 	var clothingString: String
# 	match color:
# 		-1: clothingString += ""
# 		Clothing.WHITE: clothingString += "white "
# 		Clothing.RED: clothingString += "red "
# 		Clothing.GREEN: clothingString += "green "
# 		Clothing.YELLOW: clothingString += "yellow "
# 		Clothing.BLACK: clothingString += "black "
# 		Clothing.PINK: clothingString += "pink "

var clothesInTopLeftDrawer: int
var clothesInTopRightDrawer: int
var clothesInMiddleDrawer: int
var clothesInBottomDrawer: int
func _addClothesToDresser(clothing: Clothing):
	match clothing.type:
		Clothing.SOCK:
			if clothing.get_parent() == null: topLeftDrawerClothesControl.add_child(clothing)
			else: clothing.reparent(topLeftDrawerClothesControl)
			clothing.position = Vector2(10*(clothesInTopLeftDrawer%3), -6-2*(clothesInTopLeftDrawer/3))
			clothesInTopLeftDrawer += 1
		Clothing.UNDERWEAR:
			if clothing.get_parent() == null: topRightDrawerClothesControl.add_child(clothing)
			else: clothing.reparent(topRightDrawerClothesControl)
			clothing.position = Vector2(-2 + 10*(clothesInTopRightDrawer%3), 2-2*(clothesInTopRightDrawer/3))
			clothesInTopRightDrawer += 1
		Clothing.PANTS:
			if clothing.get_parent() == null: middleDrawerClothesControl.add_child(clothing)
			else: clothing.reparent(middleDrawerClothesControl)
			clothing.position = Vector2(28*(clothesInMiddleDrawer%3), 2-2*(clothesInMiddleDrawer/3))
			clothesInMiddleDrawer += 1
		Clothing.SHIRT:
			if clothing.get_parent() == null: bottomDrawerClothesControl.add_child(clothing)
			else: clothing.reparent(bottomDrawerClothesControl)
			clothing.position = Vector2(-2 + 30*(clothesInBottomDrawer%3), 2-2*(clothesInBottomDrawer/3))
			clothesInBottomDrawer += 1

var dresserPatience := 6


var isSmokeysHairCut: bool
var isSmokeysBeardShavingCreamed: bool
var isSmokeysBeardTrimmed: bool
var isSmokeyWearingHat: bool
var isSmokeyWearingBra: bool
var isSmokeyComplete: bool:
	get(): return isSmokeysHairCut and isSmokeysBeardTrimmed and isSmokeyWearingHat and isSmokeyWearingBra


enum Scattered {AMBIGUOUS = -1, PEPPER_FLAKES, FLINT_FLAKES, BREAD_CRUMBS, CHARCOAL_POWDER,}
var scatteredOnFloor: Array[Scattered]
var roombaSatisfied: bool


var isComputerCleaned: bool

func _init():
	var sid := SceneManager.SceneID
	sceneTransitions = [sid.MAIN_MENU, sid.ENDING, sid.KITCHEN]
	defaultStartingMessage = (
		"You step inside, leaving the perilous outdoors behind. As you get your bearings, the musty odor of your bedroom " +
		"hits you like an old, familiar friend. It looks like this part of the house was left relatively untouched " +
		"by the party, but there's no denying that you've been neglecting some basic housekeeping for some time... " +
		"You really should head to the kitchen to prepare your breakfast, but it just wouldn't feel right leaving " +
		"your room in such a state. You resolve to get things cleaned up before moving on."
	)

func _ready():
	super()
	initClothes()

func initClothes():
	var clothingTypes := [Clothing.PANTS, Clothing.SHIRT, Clothing.SOCK, Clothing.UNDERWEAR]
	var inclusionArray := [true, true, true, false]
	var duplicateInclusionArray := [true, false, false, false]
	var colors := [Clothing.WHITE, Clothing.RED, Clothing.YELLOW, Clothing.GREEN, Clothing.BLACK]
	var colorsByClothingType: Dictionary
	var patterns := [Clothing.PLAIN, Clothing.STRIPED, Clothing.SPOTTED]
	var rotations := [0, PI/2, PI, 3*PI/2]
	var braDepth := randi_range(0,2)
	for clothingType in clothingTypes:
		colorsByClothingType[clothingType] = colors.duplicate()
		colorsByClothingType[clothingType].shuffle()

	for depth in range(3):
		inclusionArray.shuffle(); duplicateInclusionArray.shuffle();
		for i in range(4):

			if not inclusionArray[i]: continue

			patterns.shuffle(); rotations.shuffle()

			if braDepth == depth and not duplicateInclusionArray[i]:
				braDepth = -1
				var bra: Clothing = clothingPrefab.instantiate()
				bra.init(Clothing.BRA, Clothing.PINK, patterns[0], rotations[0], depth)
				bra.shuffleGridPos()
				while not isValidClothesPlacement(bra): bra.shuffleGridPos()
				addClothingToBed(bra)

			else:
				var newClothing: Clothing = clothingPrefab.instantiate()
				newClothing.init(clothingTypes[i], colorsByClothingType[clothingTypes[i]][depth], patterns[0], rotations[0], depth)
				newClothing.shuffleGridPos()
				while not isValidClothesPlacement(newClothing): newClothing.shuffleGridPos()
				addClothingToBed(newClothing)
				if duplicateInclusionArray[i]:
					newClothing = clothingPrefab.instantiate()
					newClothing.init(clothingTypes[i], colorsByClothingType[clothingTypes[i]][depth], patterns[1], rotations[1], depth)
					newClothing.shuffleGridPos()
					while not isValidClothesPlacement(newClothing): newClothing.shuffleGridPos()
					addClothingToBed(newClothing)

	for type in range(4):
		var newClothing = clothingPrefab.instantiate()
		newClothing.init(type, colorsByClothingType[type][-1], patterns.pick_random(), 0, 0)
		_addClothesToDresser(newClothing)


func movePlayer(newPos: PlayerPos):
	playerPos = newPos
	playerControl.position = PLAYER_SPRITE_POSITIONS[newPos]


func pickUpClothing(clothing: Clothing):
	removeClothingFromBed(clothing)
	clothing.reparent(playerClothesControl)
	clothing.rotation = 0
	playerHeldItem = PlayerHeldItem.CLOTHING
	if clothing.gridPos.x > 3: movePlayer(PlayerPos.BED_RIGHT_SIDE)
	else: movePlayer(PlayerPos.BED_LEFT_SIDE)
	match clothing.type:
		Clothing.SOCK:
			if heldClothing == null:
				heldClothing = clothing
				clothing.position = Vector2(-2, 64)
			else:
				heldSecondSock = clothing
				clothing.position = Vector2(46, 64)
		Clothing.UNDERWEAR:
			heldClothing = clothing
			setPlayerTexture(ARMS_VERY_IN)
			clothing.position = Vector2(14, 62)
		Clothing.PANTS:
			heldClothing = clothing
			clothing.position = Vector2(-12, 70)
			handForeground.show()
		Clothing.SHIRT:
			heldClothing = clothing
			clothing.position = Vector2(-10, 70)
			handForeground.show()
		Clothing.BRA:
			heldClothing = clothing
			setPlayerTexture(ARMS_VERY_IN)
			clothing.position = Vector2(10, 56)


func replaceHeldClothing(replaceBothSocks: bool):
	if heldSecondSock != null:
		addClothingToBed(heldSecondSock)
		if heldSecondSock.gridPos.x > 3: movePlayer(PlayerPos.BED_RIGHT_SIDE)
		else: movePlayer(PlayerPos.BED_LEFT_SIDE)
		heldSecondSock = null
		if replaceBothSocks:
			addClothingToBed(heldClothing)
			heldClothing = null
			playerHeldItem = PlayerHeldItem.NONE
	else:
		addClothingToBed(heldClothing)
		if heldClothing.gridPos.x > 3: movePlayer(PlayerPos.BED_RIGHT_SIDE)
		else: movePlayer(PlayerPos.BED_LEFT_SIDE)
		heldClothing = null
		playerHeldItem = PlayerHeldItem.NONE
		setPlayerTexture(RELAXED)
		handForeground.hide()
			

func foldClothing():
	heldClothing.fold()
	match heldClothing.type:
		Clothing.SOCK:
			heldSecondSock.queue_free()
			heldSecondSock = null
		Clothing.UNDERWEAR:
			setPlayerTexture(RELAXED)
			handForeground.show()
			heldClothing.position = Vector2(-6,74)
		Clothing.PANTS:
			setPlayerTexture(ARMS_VERY_IN)
			handForeground.hide()
			heldClothing.position = Vector2(12,56)
		Clothing.SHIRT:
			setPlayerTexture(ARMS_VERY_IN)
			handForeground.hide()
			heldClothing.position = Vector2(12,56)


func putAwayClothing(clothing: Clothing):
	movePlayer(PlayerPos.DRESSER)
	_addClothesToDresser(clothing)
	heldClothing = null
	playerHeldItem = PlayerHeldItem.NONE
	handForeground.hide()
	setPlayerTexture(RELAXED)


func toggleTopLeftDrawer():
	movePlayer(PlayerPos.DRESSER)
	topLeftDrawerControl.visible = not topLeftDrawerControl.visible

func toggleTopRightDrawer():
	movePlayer(PlayerPos.DRESSER)
	topRightDrawerControl.visible = not topRightDrawerControl.visible

func toggleMiddleDrawer():
	movePlayer(PlayerPos.DRESSER)
	middleDrawerControl.visible = not middleDrawerControl.visible

func toggleBottomDrawer():
	movePlayer(PlayerPos.DRESSER)
	bottomDrawerControl.visible = not bottomDrawerControl.visible

func angerDresser():
	movePlayer(PlayerPos.DRESSER)
	dresserPatience -= 1


func tidyUpPillows():
	movePlayer(PlayerPos.BED_RIGHT_SIDE)
	lessMessyBed.show()
	bedState = LESS_MESSY

func pullUpSheet():
	movePlayer(PlayerPos.BED_LEFT_SIDE)
	lessMessyBed.hide()
	almostMadeBed.show()
	bedState = ALMOST_MADE

func pullUpComforter():
	movePlayer(PlayerPos.BED_LEFT_SIDE)
	almostMadeBed.hide()
	madeBed.show()
	bedState = MADE


func putBraOnSmokey():
	heldClothing.queue_free()
	heldClothing = null
	playerHeldItem = PlayerHeldItem.NONE
	setPlayerTexture(RELAXED)
	movePlayer(PlayerPos.SMOKEY)
	smokeyBra.show()
	isSmokeyWearingBra = true


func pickUpAxe():
	movePlayer(PlayerPos.SMOKEY_TOOLS)
	rackedAxe.hide()
	setPlayerTexture(HOLDING_AXE)
	playerHeldItem = PlayerHeldItem.AXE

func replaceAxe():
	movePlayer(PlayerPos.SMOKEY_TOOLS)
	rackedAxe.show()
	setPlayerTexture(RELAXED) # Rel"axe"d, lol.
	playerHeldItem = PlayerHeldItem.NONE

func giveSmokeyAHaircut():
	movePlayer(PlayerPos.SMOKEY)
	smokeyMessyHair.hide()
	isSmokeysHairCut = true


func pickUpFireExtinguisher():
	movePlayer(PlayerPos.SMOKEY_TOOLS)
	rackedFireExtinguisher.hide()
	playerFireExtinguisher.show()
	playerHeldItem = PlayerHeldItem.FIRE_EXTINGUISHER

func replaceFireExtinguisher():
	movePlayer(PlayerPos.SMOKEY_TOOLS)
	rackedFireExtinguisher.show()
	playerFireExtinguisher.hide()
	playerHeldItem = PlayerHeldItem.NONE

func applyShavingCreamToSmokey():
	movePlayer(PlayerPos.SMOKEY)
	smokeyShavingCream.show()
	isSmokeysBeardShavingCreamed = true

func pickUpMachete():
	movePlayer(PlayerPos.SMOKEY_TOOLS)
	rackedMachete.hide()
	playerMachete.show()
	playerHeldItem = PlayerHeldItem.MACHETE

func replaceMachete():
	movePlayer(PlayerPos.SMOKEY_TOOLS)
	rackedMachete.show()
	playerMachete.hide()
	playerHeldItem = PlayerHeldItem.NONE

func trimSmokeysBeard():
	movePlayer(PlayerPos.SMOKEY)
	smokeyShavingCream.hide()
	smokeyMessyBeard.hide()
	isSmokeysBeardTrimmed = true


func pickUpHat():
	movePlayer(PlayerPos.SMOKEY_TOOLS)
	rackedHat.hide()
	playerSmokeyHat.show()
	isPlayerWearingHat = true

func replaceHat():
	movePlayer(PlayerPos.SMOKEY_TOOLS)
	rackedHat.show()
	playerSmokeyHat.hide()
	isPlayerWearingHat = false

func putHatOnSmokey():
	movePlayer(PlayerPos.SMOKEY)
	playerSmokeyHat.hide()
	isPlayerWearingHat = false
	smokeyHat.show()
	isSmokeyWearingHat = true


func pickUpPepperFlakes():
	movePlayer(PlayerPos.ZOOMBA_FOOD_TABLE)
	setPlayerTexture(ARMS_IN)
	tablePepperFlakes.hide()
	playerPepperFlakes.show()
	playerHeldItem = PlayerHeldItem.PEPPER_FLAKES

func replacePepperFlakes():
	movePlayer(PlayerPos.ZOOMBA_FOOD_TABLE)
	setPlayerTexture(RELAXED)
	tablePepperFlakes.show()
	playerPepperFlakes.hide()
	playerHeldItem = PlayerHeldItem.NONE

func pickUpFlintFlakes():
	movePlayer(PlayerPos.ZOOMBA_FOOD_TABLE)
	setPlayerTexture(ARMS_IN)
	tableFlintFlakes.hide()
	playerFlintFlakes.show()
	playerHeldItem = PlayerHeldItem.FLINT_FLAKES

func replaceFlintFlakes():
	movePlayer(PlayerPos.ZOOMBA_FOOD_TABLE)
	setPlayerTexture(RELAXED)
	tableFlintFlakes.show()
	playerFlintFlakes.hide()
	playerHeldItem = PlayerHeldItem.NONE

func pickUpBreadCrumbs():
	movePlayer(PlayerPos.ZOOMBA_FOOD_TABLE)
	setPlayerTexture(ARMS_IN)
	tableBreadCrumbs.hide()
	playerBreadCrumbs.show()
	playerHeldItem = PlayerHeldItem.BREAD_CRUMBS

func replaceBreadCrumbs():
	movePlayer(PlayerPos.ZOOMBA_FOOD_TABLE)
	setPlayerTexture(RELAXED)
	tableBreadCrumbs.show()
	playerBreadCrumbs.hide()
	playerHeldItem = PlayerHeldItem.NONE

func pickUpCharcoalPowder():
	movePlayer(PlayerPos.ZOOMBA_FOOD_TABLE)
	setPlayerTexture(ARMS_IN)
	tableCharcoalPowder.hide()
	playerCharcoalPowder.show()
	playerHeldItem = PlayerHeldItem.CHARCOAL_POWDER

func replaceCharcoalPowder():
	movePlayer(PlayerPos.ZOOMBA_FOOD_TABLE)
	setPlayerTexture(RELAXED)
	tableCharcoalPowder.show()
	playerCharcoalPowder.hide()
	playerHeldItem = PlayerHeldItem.NONE


func scatterZoombaFood(scattered: Scattered):
	match scattered:
		Scattered.PEPPER_FLAKES: scatteredPepperFlakes.show()
		Scattered.FLINT_FLAKES: scatteredFlintFlakes.show()
		Scattered.BREAD_CRUMBS: scatteredBreadCrumbs.show()
		Scattered.CHARCOAL_POWDER: scatteredCharcoalPowder.show()
	scatteredOnFloor.append(scattered)

func feedZoomba():
	zoomba.position = Vector2(563,244)
	scatteredPepperFlakes.hide()
	scatteredFlintFlakes.hide()
	scatteredBreadCrumbs.hide()
	scatteredCharcoalPowder.hide()
	roombaSatisfied = true


func accessComputer():
	movePlayer(PlayerPos.COMPUTER_DESK)
	SceneManager.openComputerCleaning(self)

func cleanComputer():
	clutteredScreen.hide()
	isComputerCleaned = true


func openKitchenDoor():
	SceneManager.transitionToScene(SceneManager.SceneID.KITCHEN)