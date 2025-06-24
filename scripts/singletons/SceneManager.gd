extends Node

# NOTE: If scene initialization takes longer than a frame, even with asynchronous loading through the ResourceLoader,
#		consider adding loaded components to the active scene in a hidden and deactivated state. (The deactivated state
#		will have to be coded manually somewhat, but the process_mode parameter should help). This will allow for full,
#		custom initialization prior to use, similar to the multi-scene setup I used in Unity.

enum SceneID {
	UNINITIALIZED, LAST_SCENE, MAIN_MENU, HELP, ACHIEVEMENTS, OPTIONS, ENDING,
	BATHROOM, FRONT_YARD, BEDROOM, KITCHEN,
	CREDITS, SPLASH_SCREEN, COMPUTER_CLEANING
}

enum EndingID {
	NONE = 0, YOU_BURNED_YOUR_BREAKFAST = 1, FALSE_START = 5, FIRST_BLOOD = 10, SECOND_BLOOD = 15, BATH_BOMB = 20,
	SLIPPERY_SURPRISE = 30, IRRESPONSIBLE_BRUSHING = 40, FLAMMABLE_FLUSH = 45, SPICY_SPITTOON = 50, MUZZLE_DISCIPLINE = 60,
	HEAD_OVER_HEELS_FOR_CEREAL = 65, FLAME_THROWING_THE_GAME = 70, OCCAMS_MATCHSTICK = 80, HOMEWRECKER = 90,
	FEET_FEAST = 100, SHOE_SKILL_ISSUE = 110, PARBOARD_AND_STORT = 120, LAWN_CARE_KARMA = 130,
	CAUTION_FLOOR_IS_SLIPPERY_WHEN_WET = 140, RAPID_FUEL_CONSUMPTION = 150, IMPROPER_LAWN_MAINTENANCE = 160, SHOEFFLE = 170,
	ERRORS_SHOULD_NEVER_PASS_SILENTLY = 180, TWO_IN_ONE_SET_BED_AND_BLAZE = 190, WHY_IS_THERE_COOLANT_ALL_OVER_MY_FLOOR = 200,
	ITS_NOT_A_BUG_ITS_A_FEATURE = 205, VACUUMING_ON_AN_EMPTY_STOMACH = 210, HAS_MINECRAFT_TAUGHT_YOU_NOTHING = 220,
	HEARTBURN = 230, GUTBOMB = 240, HIGH_FIRE_BER_DIET = 250, FIRED_AND_FIRED = 260, MICROWAVE_MAYHEM = 270,
	TNTASTY = 280, KITCHENCINERATOR = 290, REFRIGERATOR_TERMINATOR = 300, BEWARE_OF_BURNOUT = 305, ONE_STAR_REVIEW = 310,
	EGGSISTENTIAL_CRISIS = 315, DRY_FIRE = 320, CRYING_OVER_SPILLED_MILK = 325, EVAPORATED_MILK = 330,
	CHAMPION_OF_BREAKFASTS = 340,
}

const endingsByScene := {
	SceneID.MAIN_MENU : [
		EndingID.FALSE_START,
	],
	SceneID.BATHROOM : [
		EndingID.FIRST_BLOOD, EndingID.SECOND_BLOOD, EndingID.BATH_BOMB, EndingID.SLIPPERY_SURPRISE,
		EndingID.IRRESPONSIBLE_BRUSHING, EndingID.FLAMMABLE_FLUSH, EndingID.SPICY_SPITTOON, EndingID.MUZZLE_DISCIPLINE,
		EndingID.HEAD_OVER_HEELS_FOR_CEREAL,
	],
	SceneID.FRONT_YARD : [
		EndingID.FLAME_THROWING_THE_GAME, EndingID.OCCAMS_MATCHSTICK, EndingID.HOMEWRECKER, EndingID.FEET_FEAST,
		EndingID.SHOE_SKILL_ISSUE, EndingID.PARBOARD_AND_STORT, EndingID.LAWN_CARE_KARMA,
		EndingID.CAUTION_FLOOR_IS_SLIPPERY_WHEN_WET, EndingID.RAPID_FUEL_CONSUMPTION, EndingID.IMPROPER_LAWN_MAINTENANCE,
		EndingID.SHOEFFLE
	],
	SceneID.BEDROOM : [
		EndingID.ERRORS_SHOULD_NEVER_PASS_SILENTLY, EndingID.TWO_IN_ONE_SET_BED_AND_BLAZE, EndingID.WHY_IS_THERE_COOLANT_ALL_OVER_MY_FLOOR,
		EndingID.ITS_NOT_A_BUG_ITS_A_FEATURE, EndingID.VACUUMING_ON_AN_EMPTY_STOMACH, EndingID.HAS_MINECRAFT_TAUGHT_YOU_NOTHING,
		EndingID.HEARTBURN, EndingID.GUTBOMB, EndingID.HIGH_FIRE_BER_DIET,
	],
	SceneID.KITCHEN : [
		EndingID.FIRED_AND_FIRED, EndingID.MICROWAVE_MAYHEM, EndingID.TNTASTY, EndingID.KITCHENCINERATOR, EndingID.REFRIGERATOR_TERMINATOR,
		EndingID.BEWARE_OF_BURNOUT, EndingID.ONE_STAR_REVIEW, EndingID.EGGSISTENTIAL_CRISIS, EndingID.DRY_FIRE,
		EndingID.CRYING_OVER_SPILLED_MILK, EndingID.EVAPORATED_MILK, EndingID.CHAMPION_OF_BREAKFASTS,
	]
}

const customEndingNames := {
	EndingID.FLAME_THROWING_THE_GAME:"Flame-Throwing the Game",
	EndingID.OCCAMS_MATCHSTICK:"Occam's Matchstick",
	EndingID.PARBOARD_AND_STORT:"Parboard and Stort",
	EndingID.CAUTION_FLOOR_IS_SLIPPERY_WHEN_WET:"Caution! Floor is Slippery When Wet",
	EndingID.TWO_IN_ONE_SET_BED_AND_BLAZE:"2-in-1 Set: Bed and Blaze",
	EndingID.WHY_IS_THERE_COOLANT_ALL_OVER_MY_FLOOR:"Why is There Coolant All Over My Floor?",
	EndingID.ITS_NOT_A_BUG_ITS_A_FEATURE:"It's Not a Bug. It's a Feature.",
	EndingID.VACUUMING_ON_AN_EMPTY_STOMACH:"Vacuuming on an Empty Stomach",
	EndingID.HAS_MINECRAFT_TAUGHT_YOU_NOTHING:"Has Minecraft Taught You Nothing?",
	EndingID.HIGH_FIRE_BER_DIET:"High Fire-ber Diet",
	EndingID.FIRED_AND_FIRED:"Fired and Fired",
	EndingID.TNTASTY:"TNTasty!",
	EndingID.BEWARE_OF_BURNOUT:"Beware of Burnout",
	EndingID.ONE_STAR_REVIEW:"1-star Review",
	EndingID.CHAMPION_OF_BREAKFASTS:"Champion of Breakfasts",
}

func getEndingName(p_endingID: EndingID) -> String:
	if p_endingID in customEndingNames: return customEndingNames[p_endingID]
	else: return SceneManager.EndingID.find_key(p_endingID).capitalize()

const mainScenesPath := "res://scenes/main_scenes/"

var currentScene := SceneID.UNINITIALIZED
var lastScene := SceneID.UNINITIALIZED
var preloadedScenes: Array[SceneID] ### Would be nice to swap this out for a set if it ever gets implemented.

var preloadedEndingsScene: PackedScene
var openEndingsScene: Endings
var preloadedComputerScene: PackedScene
var openComputerScene: ComputerCleaning
var pausedScene: Scene

var customStartingMessage := ""
var endingID := EndingID.NONE


func _ready():
	var sceneName := get_tree().current_scene.name.to_upper()
	if sceneName == "OPTIONS_SCENE": currentScene = SceneID.OPTIONS
	else: currentScene = SceneID[sceneName]
	preloadedEndingsScene = load(_getScenePath(SceneID.ACHIEVEMENTS))
	preloadedComputerScene = load(_getScenePath(SceneID.COMPUTER_CLEANING))
	# print("Starting scene: " + str(currentScene))
	# var root = get_tree().root
	# currentScene = root.get_child(root.get_child_count() - 1) # May be unnecessary?


func _getScenePath(sceneID: SceneID):
	return mainScenesPath + SceneID.keys()[sceneID].to_lower() + ".tscn"

func preloadScenes(sceneIDsToPreload: Array[SceneID]):

	for i in range(sceneIDsToPreload.size()):
		if sceneIDsToPreload[i] == SceneID.LAST_SCENE: sceneIDsToPreload[i] = lastScene
		if sceneIDsToPreload[i] == SceneID.ACHIEVEMENTS:
			print("Preloading achievements is deprecated. Simply call \"SceneManager.openEndings()\" instead.")

	if currentScene in sceneIDsToPreload:
		push_error(
			"Current scene should not be preloaded. You can still transition to the current scene by " +
			"calling the transitionToScene function on the current scene, which will invoke get_tree().reload_current_scene()"
		)

	var validSceneIDs: Array[SceneID] = []
	for sceneID in preloadedScenes:
		if sceneID not in sceneIDsToPreload:
			pass
			### Cancel the preloaded scene when this gets added to the ResourceLoader API
			# print("Unloading scene " + str(sceneID))
		else:
			validSceneIDs.append(sceneID)
			# print("Maintaining load for scene " + str(sceneID))
	preloadedScenes = validSceneIDs

	for sceneID in sceneIDsToPreload:
		if sceneID == SceneID.UNINITIALIZED: continue
		if sceneID not in preloadedScenes:
			ResourceLoader.load_threaded_request(_getScenePath(sceneID))
			preloadedScenes.append(sceneID)
			# print("Preloading scene " + str(sceneID))
	
	# print("Currently preloaded scenes: " + str(preloadedScenes))


func transitionToScene(sceneID: SceneID, p_customStartingMessage = "", p_endingID := EndingID.NONE):

	if sceneID == SceneID.LAST_SCENE:
		sceneID = lastScene

	if is_instance_valid(openEndingsScene): openEndingsScene.queue_free()
	if is_instance_valid(openComputerScene): openComputerScene.queue_free()

	assert(sceneID in preloadedScenes or sceneID == currentScene,
			"Attempting to transition to non-preloaded scene: " + str(sceneID))

	customStartingMessage = p_customStartingMessage

	assert(p_endingID == EndingID.NONE or sceneID == SceneID.ENDING,
			"Ending ID supplied, but we are not switching to the ending scene...")
	endingID = p_endingID
	if endingID != EndingID.NONE and not EndingsManager.isEndingUnlocked(endingID): EndingsManager.unlockEnding(endingID)

	if customStartingMessage and endingID != EndingID.NONE:
		customStartingMessage += "\n(Input any command to continue.)"

	if sceneID == currentScene:
		get_tree().reload_current_scene()
	else:
		lastScene = currentScene
		currentScene = sceneID
		# print("Transitioning to " + _getScenePath(sceneID))
		var newSceneResource := ResourceLoader.load_threaded_get(_getScenePath(sceneID))
		get_tree().change_scene_to_packed(newSceneResource)

		# currentScene.free()
		# currentScene = newScene.instantiate()
		# get_tree().root.add_child(currentScene)
	
func openEndings(openingScene: Scene):
	openingScene.pause()
	pausedScene = openingScene
	openEndingsScene = preloadedEndingsScene.instantiate()
	pausedScene.add_sibling(openEndingsScene)
	openEndingsScene.initFromExistingTerminal(openingScene.terminal)
	if currentScene in endingsByScene:
		openEndingsScene.changeLevel(currentScene)

func closeEndings():
	openEndingsScene.inputParser.disconnectTerminal()
	pausedScene.resume()
	openEndingsScene.queue_free()

func openComputerCleaning(openingScene: Scene):
	openingScene.pause()
	pausedScene = openingScene
	openComputerScene = preloadedComputerScene.instantiate()
	pausedScene.add_sibling(openComputerScene)
	openComputerScene.initFromExistingTerminal(openingScene.terminal)
	get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_CANVAS_ITEMS

func closeComputerCleaning():
	openComputerScene.inputParser.disconnectTerminal()
	pausedScene.resume()
	(pausedScene as Bedroom).cleanComputer()
	openComputerScene.queue_free()
	get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_VIEWPORT
