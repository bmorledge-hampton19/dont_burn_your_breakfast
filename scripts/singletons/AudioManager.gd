extends Node2D

@export var musicPlayer: AudioStreamPlayer2D
@export var soundEffectsNode: Node2D
@export var textInputPlayer: AudioStreamPlayer2D
@export var mowerPlayer: AudioStreamPlayer2D
@export var computerCleaningMusicPlayer: AudioStreamPlayer2D
@export var clippyPlayer: AudioStreamPlayer2D
@export var fanPlayer: AudioStreamPlayer2D
@export var ovenPlayer: AudioStreamPlayer2D

@export var oneShotAudioPrefab: PackedScene

# Terminal
@export_group("Terminal")
@export var keystrokes: Array[AudioStream]
@export var reversedKeystrokes: Array[AudioStream]
@export var defaultTextInput: AudioStream
@export var badTextInput: AudioStream
@export var goodTextInput: AudioStream


# Splash Screen
@export_group("Splash Screen")
@export var drBeanSpillingMilk: AudioStream
@export var drBeanPouringMilkInCereal: AudioStream
@export var drBeanEatingCereal: AudioStream


# Main Menu
@export_group("Main Menu")

@export_subgroup("Music")
@export var mainMenuOpeningFanfare: AudioStream
@export var mainMenuLongMusic: Array[AudioStream] # Also plays in options, credits, and endings.
@export var mainMenuShortMusic: Array[AudioStream] # Also plays in options, credits, and endings.

@export_subgroup("Sound Effects")

@export var startGame: AudioStream


# Options
@export_group("Options")
@export var changeMusicVolume: AudioStream


# Credits
@export_group("Credits")
@export var applause: AudioStream

# Tutorial
@export_group("Tutorial")
@export var quakerWhisper: AudioStream
@export var oatMunch: AudioStream


# Endings
@export_group("Endings") # Music for endings adapts from opening scene
@export var collectCerealCoins: AudioStream
@export var collectLotsOfCerealCoins: AudioStream
@export var buyHint: AudioStream


# Ending
@export_group("Ending")

@export_subgroup("Music")
@export var endingOpeningFanfareOminous: AudioStream
@export var endingOpeningFanfareVictorious: AudioStream
@export var ominousEndingMusic: Array[AudioStream]
@export var victoriousEndingMusic: Array[AudioStream]

@export_subgroup("Sound Effects")
@export var youBurnedYourBreakfast: AudioStream


# Bathroom
@export_group("Bathroom")

@export_subgroup("Music")
@export var bathroomOpeningFanfare: AudioStream
@export var bathroomLongMusic: Array[AudioStream]
@export var bathroomShortMusic: Array[AudioStream]

@export_subgroup("Sound Effects")
@export var squirtingShampoo: AudioStream
@export var shiftingCereal: AudioStream
@export var openingVanity: AudioStream
@export var closingVanity: AudioStream
@export var openingBathroomDrawer: AudioStream
@export var closingBathroomDrawer: AudioStream
@export var brushingTeeth: AudioStream
@export var spittingToothpaste: AudioStream
@export var rinsingToothbrush: AudioStream
@export var openingToilet: AudioStream
@export var closingToilet: AudioStream
@export var flushingToilet: AudioStream
@export var ejectingKey: AudioStream
@export var unlockingDoorWithKey: AudioStream


# Front Yard
@export_group("Front Yard")

@export_subgroup("Music")
@export var frontYardOpeningFanfare: AudioStream
@export var frontYardLongMusic: Array[AudioStream]
@export var frontYardShortMusic: Array[AudioStream]

@export_subgroup("Sound Effects")
@export var fillingMower: AudioStream
@export var startingMower: AudioStream
@export var runningMowerLoop: AudioStream
@export var mowingGrass: AudioStream
@export var tyingShoe: AudioStream
@export var creakingStep: AudioStream


# Bedroom
@export_group("Bedroom")

@export_subgroup("Music")
@export var bedroomOpeningFanfare: AudioStream
@export var bedroomLongMusic: Array[AudioStream]
@export var bedroomShortMusic: Array[AudioStream]

@export_subgroup("Sound Effects")
@export var movingPillows: AudioStream
@export var movingSheet: AudioStream
@export var movingComforter: AudioStream # Maybe?
@export var openingBedroomDrawer: AudioStream
@export var closingBedroomDrawer: AudioStream
@export var dresserError: AudioStream # Made orally?
@export var shakingFlakes: AudioStream
@export var shakingBoxes: AudioStream
@export var tappingBowl: AudioStream
@export var feedingZoomba: AudioStream
@export var sprayingSmokey: AudioStream
@export var cuttingSmokeyBeard: AudioStream
@export var cuttingSmokeyHair: AudioStream


# Computer Cleaning 
@export_group("Computer") # Uses same music as bedroom.

@export_subgroup("Music")
@export var clippyIntroMusicIntro: AudioStream
@export var clippyIntroMusicLoop: AudioStream
@export var computerCleaningMusicIntro: AudioStream
@export var computerCleaningMusicLoop: AudioStream

@export_subgroup("Sound Effects")
@export var startingComputer: AudioStream
@export var clippyTalking: Array[AudioStream] # XP Ringin and XP Ringout
@export var clippyLoggingOn: AudioStream
@export var clippyLoggingOff: AudioStream
@export var tada: AudioStream # On presentation start and computer cleaned
@export var spawningMouse: AudioStream # Balloon
@export var activatingCheese: AudioStream # Shutdown
@export var explodingMouse: AudioStream # Critical Stop
@export var eatingMouse: AudioStream # XP Recycle
@export var angryCat: AudioStream # Error
@export var closingWindow: Array[AudioStream] # Anything else that has a "closing" feel to it.
@export var fanLoop: AudioStream # Actual fan noise


# Kitchen
@export_group("Kitchen")

@export_subgroup("Music")
@export var kitchenOpeningFanfare: AudioStream
@export var kitchenLongMusic: Array[AudioStream]
@export var kitchenShortMusic: Array[AudioStream]

@export_subgroup("Sound Effects")
@export var openingKitchenCupboard: AudioStream
@export var closingKitchenCupboard: AudioStream
@export var openingKitchenDrawer: AudioStream
@export var closingKitchenDrawer: AudioStream
@export var openingMicrowave: AudioStream
@export var closingMicrowave: AudioStream
@export var openingFridge: AudioStream
@export var closingFridge: AudioStream
@export var openingOven: AudioStream
@export var closingOven: AudioStream
@export var runningMicrowave: AudioStream
@export var talkingDemon: AudioStream
@export var muffledTalkingDemon: AudioStream
@export var demonEating: AudioStream
@export var crackingEgg: AudioStream
@export var fryingEgg: AudioStream
@export var startingOvenOrStove: AudioStream
@export var ovenOrStoveLoop: AudioStream
@export var washingAndDryingBowl: AudioStream
@export var pressFridgeButton: Array[AudioStream]
@export var unlockFridge: AudioStream
@export var unlockMilk: AudioStream
@export var lockMilk: AudioStream
@export var pouringMilkInEmptyBowl: AudioStream
@export var pouringCerealInEmptyBowl: AudioStream
@export var addingMilkToCereal: AudioStream
@export var addingCerealToMilk: AudioStream
@export var flippingLarry: AudioStream


# Global
@export_group("Global")

@export var minorSceneTransitionIn: AudioStream
@export var minorSceneTransitionOut: AudioStream
@export var openingDoor: AudioStream
@export var closingDoor: AudioStream


var musicScene := SceneManager.SceneID.UNINITIALIZED
var playingFanfare: bool
var victory: bool
var timeUntilNextMusic: float
var consecutiveShortMusics: int
var musicFadeTween: Tween
var computerCleaningMusicFadeTween: Tween

enum {LONG, SHORT}
var lastMusicType: int
var lastLongMusic: AudioStream
var lastShortMusic: AudioStream

var waitingActions: Dictionary[Callable, float]

var earlyRemoveOvenNoiseCalls: int

func _process(delta):

	var readyActions: Array[Callable]
	for waitingAction in waitingActions:
		waitingActions[waitingAction] -= delta
		if waitingActions[waitingAction] <= 0:
			readyActions.append(waitingAction)
	for readyAction in readyActions:
		readyAction.call()
		waitingActions.erase(readyAction)

	if musicScene == SceneManager.SceneID.UNINITIALIZED or musicPlayer.playing: return

	timeUntilNextMusic -= delta
	if timeUntilNextMusic <= 0:

		var timeForLongMusic: bool = randf() < 0.2*consecutiveShortMusics - 0.4

		match musicScene:

			SceneManager.SceneID.MAIN_MENU:
				if timeForLongMusic:
					musicPlayer.stream = _getNextMusic(mainMenuLongMusic, LONG)
					musicPlayer.play()
					consecutiveShortMusics = 0
				else:
					musicPlayer.stream = _getNextMusic(mainMenuShortMusic, SHORT)
					musicPlayer.play()
					consecutiveShortMusics += 1

			SceneManager.SceneID.ENDING:
				if victory:
					musicPlayer.stream = _getNextMusic(victoriousEndingMusic, SHORT)
					musicPlayer.play()
					consecutiveShortMusics += 1
				else:
					musicPlayer.stream = _getNextMusic(ominousEndingMusic, SHORT)
					musicPlayer.play()
					consecutiveShortMusics += 1

			SceneManager.SceneID.BATHROOM:
				if timeForLongMusic:
					musicPlayer.stream = _getNextMusic(bathroomLongMusic, LONG)
					musicPlayer.play()
					consecutiveShortMusics = 0
				else:
					musicPlayer.stream = _getNextMusic(bathroomShortMusic, SHORT)
					musicPlayer.play()
					consecutiveShortMusics += 1

			SceneManager.SceneID.FRONT_YARD:
				if timeForLongMusic:
					musicPlayer.stream = _getNextMusic(frontYardLongMusic, LONG)
					musicPlayer.play()
					consecutiveShortMusics = 0
				else:
					musicPlayer.stream = _getNextMusic(frontYardShortMusic, SHORT)
					musicPlayer.play()
					consecutiveShortMusics += 1

			SceneManager.SceneID.BEDROOM:
				if timeForLongMusic:
					musicPlayer.stream = _getNextMusic(bedroomLongMusic, LONG)
					musicPlayer.play()
					consecutiveShortMusics = 0
				else:
					musicPlayer.stream = _getNextMusic(bedroomShortMusic, SHORT)
					musicPlayer.play()
					consecutiveShortMusics += 1

			SceneManager.SceneID.KITCHEN:
				if timeForLongMusic:
					musicPlayer.stream = _getNextMusic(kitchenLongMusic, LONG)
					musicPlayer.play()
					consecutiveShortMusics = 0
				else:
					musicPlayer.stream = _getNextMusic(kitchenShortMusic, SHORT)
					musicPlayer.play()
					consecutiveShortMusics += 1


func queueAction(action: Callable, delay: float):
	waitingActions[action] = delay


func playSound(stream: AudioStream, overrideTextInputSound := false, busName: String = "OtherSounds", volume_linear: float = 1) -> OneShotAudio:
	var oneShotAudio: OneShotAudio = oneShotAudioPrefab.instantiate()
	soundEffectsNode.add_child(oneShotAudio)
	oneShotAudio.init(stream, busName, volume_linear)

	if overrideTextInputSound: textInputPlayer.stop()
	return oneShotAudio

func playTextInputSound():
	textInputPlayer.play()

func playMowerLoop():
	mowerPlayer.play()

func playClippySound():
	clippyPlayer.stream = clippyTalking.pick_random()
	clippyPlayer.play()

func playFan():
	fanPlayer.play()

func addOvenNoise():

	if earlyRemoveOvenNoiseCalls > 0:
		earlyRemoveOvenNoiseCalls -= 1
		return

	if not ovenPlayer.playing:
		ovenPlayer.volume_linear = 1
		ovenPlayer.play()
	else:
		ovenPlayer.volume_linear = 1.5

func removeOvenNoise():
	if not ovenPlayer.playing:
		earlyRemoveOvenNoiseCalls += 1
	elif ovenPlayer.volume_linear > 1.4:
		ovenPlayer.volume_linear = 1
	else:
		ovenPlayer.stop()

func clearSounds():
	for soundEffect in soundEffectsNode.get_children():
		soundEffect.queue_free()
	textInputPlayer.stop()
	mowerPlayer.stop()
	clippyPlayer.stop()
	fanPlayer.stop()
	ovenPlayer.stop()
	earlyRemoveOvenNoiseCalls = 0


func startNewMusic(scene: SceneManager.SceneID, p_victory := false, skipFanfare := false):
	musicScene = scene
	playingFanfare = true
	victory = p_victory
	consecutiveShortMusics = 0
	if musicFadeTween and musicFadeTween.is_valid(): musicFadeTween.kill()
	musicPlayer.volume_linear = 1

	match musicScene:

		SceneManager.SceneID.MAIN_MENU:
			musicPlayer.stream = mainMenuOpeningFanfare
			musicPlayer.play()

		SceneManager.SceneID.ENDING:
			if victory:
				musicPlayer.stream = endingOpeningFanfareVictorious
				musicPlayer.play()
			else:
				musicPlayer.stream = endingOpeningFanfareOminous
				musicPlayer.play()

		SceneManager.SceneID.BATHROOM:
			musicPlayer.stream = bathroomOpeningFanfare
			musicPlayer.play()

		SceneManager.SceneID.FRONT_YARD:
			musicPlayer.stream = frontYardOpeningFanfare
			musicPlayer.play()

		SceneManager.SceneID.BEDROOM:
			if skipFanfare:
				musicPlayer.stream = bedroomShortMusic.pick_random()
				consecutiveShortMusics += 1
				playingFanfare = false
			else:
				musicPlayer.stream = bedroomOpeningFanfare
			musicPlayer.play()

		SceneManager.SceneID.KITCHEN:
			musicPlayer.stream = kitchenOpeningFanfare
			musicPlayer.play()
		
		_:
			print("Umm... This scene doesn't have music directly associated with it: " + str(musicScene))

func _onMusicStreamFinished():
	if playingFanfare:
		playingFanfare = false
		timeUntilNextMusic = randf_range(3.0, 5.0)
	elif lastMusicType == LONG:
		timeUntilNextMusic = randf_range(5.0, 10.0)
	elif lastMusicType == SHORT:
		timeUntilNextMusic = randf_range(1.5, 3.0)

func _getNextMusic(choices: Array[AudioStream], longOrShort: int) -> AudioStream:

	var avoid: AudioStream = lastLongMusic if longOrShort == LONG else lastShortMusic
	var choice: AudioStream = choices.pick_random()
	while choice == avoid: choice = choices.pick_random()

	if longOrShort == LONG:
		lastLongMusic = choice
	elif longOrShort == SHORT:
		lastShortMusic = choice
	lastMusicType = longOrShort

	return choice

func stopMusic():
	musicPlayer.stop()
	musicScene = SceneManager.SceneID.UNINITIALIZED

func fadeOutMusic(duration := 2.0):
	if musicFadeTween and musicFadeTween.is_valid(): musicFadeTween.kill()
	musicFadeTween = create_tween()
	musicFadeTween.tween_property(musicPlayer, "volume_linear", 0, duration)
	musicFadeTween.tween_callback(stopMusic)


func startClippyMusic():
	computerCleaningMusicPlayer.stream = clippyIntroMusicIntro
	if computerCleaningMusicPlayer.finished.is_connected(_startComputerCleaningLoop):
		computerCleaningMusicPlayer.finished.disconnect(_startComputerCleaningLoop)
	computerCleaningMusicPlayer.finished.connect(_startClippyMusicLoop, ConnectFlags.CONNECT_ONE_SHOT)

func _startClippyMusicLoop():
	computerCleaningMusicPlayer.stream = clippyIntroMusicLoop
	computerCleaningMusicPlayer.play()

func startComputerCleaningMusic():
	if computerCleaningMusicPlayer.finished.is_connected(_startClippyMusicLoop):
		computerCleaningMusicPlayer.finished.disconnect(_startClippyMusicLoop)
	computerCleaningMusicPlayer.stream = computerCleaningMusicIntro
	computerCleaningMusicPlayer.finished.connect(_startComputerCleaningLoop, ConnectFlags.CONNECT_ONE_SHOT)

func _startComputerCleaningLoop():
	computerCleaningMusicPlayer.stream = computerCleaningMusicLoop
	computerCleaningMusicPlayer.play()

func fadeOutComputerCleaningMusic(duration := 2.0):
	if computerCleaningMusicFadeTween and computerCleaningMusicFadeTween.is_valid(): computerCleaningMusicFadeTween.kill()
	computerCleaningMusicFadeTween = create_tween()
	computerCleaningMusicFadeTween.tween_property(computerCleaningMusicPlayer, "volume_linear", 0, duration)
	computerCleaningMusicFadeTween.tween_callback(func(): computerCleaningMusicPlayer.stop())
