extends Node

# NOTE: If scene initiailization takes longer than a frame, even with asynchronous loading through the ResourceLoader,
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

	],
	SceneID.KITCHEN : [

	]
}

const customEndingNames := {
	EndingID.FLAME_THROWING_THE_GAME: "Flame-Throwing the Game",
	EndingID.OCCAMS_MATCHSTICK:"Occam's Matchstick",
	EndingID.PARBOARD_AND_STORT:"Parboard and Stort",
	EndingID.CAUTION_FLOOR_IS_SLIPPERY_WHEN_WET:"Caution! Floor is Slippery When Wet",
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
var openComputerScene
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
	openComputerScene = preloadedEndingsScene.instantiate()
	pausedScene.add_sibling(openComputerScene)
	openComputerScene.initFromExistingTerminal(openingScene.terminal)
	get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_CANVAS_ITEMS

func closeComputerCleaning():
	openComputerScene.inputParser.disconnectTerminal()
	pausedScene.resume()
	openComputerScene.queue_free()
	get_tree().root.content_scale_mode = Window.CONTENT_SCALE_MODE_VIEWPORT
