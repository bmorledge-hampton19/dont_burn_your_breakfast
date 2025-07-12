extends Node2D

@export var musicPlayer: AudioStreamPlayer2D
@export var soundEffectsNode: Node2D
@export var textInputPlayer: AudioStreamPlayer2D

@export var oneShotAudioPrefab: PackedScene

# Terminal
@export_group("Terminal")
@export var keystrokes: Array[AudioStream]
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
@export var otherMainMenuButtons: AudioStream


# Options
@export_group("Options")
@export var changeOption: AudioStream
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
@export var buyHint: AudioStream

# Ending
@export_group("Ending")

@export_subgroup("Music")
@export var endingOpeningFanfareOminous: AudioStream
@export var endingOpeningFanfareVictorious: AudioStream
@export var ominousEndingMusic: Array[AudioStream]
@export var victoriousEndingMusic: Array[AudioStream]

@export_subgroup("Sound Effects")
@export var youBurnedYourBreakfast: Array[AudioStream]

# Bathroom
@export_group("Bathroom")

@export_subgroup("Music")
@export var bathroomOpeningFanfare: AudioStream
@export var bathroomLongMusic: Array[AudioStream]
@export var bathroomShortMusic: Array[AudioStream]

@export_subgroup("Sound Effects")
@export var shampooSquirt: AudioStream
@export var cerealShifting: AudioStream



# Front Yard
@export_group("Front Yard")

@export_subgroup("Music")
@export var frontYardOpeningFanfare: AudioStream
@export var frontYardLongMusic: Array[AudioStream]
@export var frontYardShortMusic: Array[AudioStream]

@export_subgroup("Sound Effects")


# Bedroom
@export_group("Bedroom")

@export_subgroup("Music")
@export var bedroomOpeningFanfare: AudioStream
@export var bedroomLongMusic: Array[AudioStream]
@export var bedroomShortMusic: Array[AudioStream]

@export_subgroup("Sound Effects")


# Kitchen
@export_group("Kitchen")

@export_subgroup("Music")
@export var kitchenOpeningFanfare: AudioStream
@export var kitchenLongMusic: Array[AudioStream]
@export var kitchenShortMusic: Array[AudioStream]

@export_subgroup("Sound Effects")


# Misc.
@export_group("Misc")

@export var doorOpenAndClose: AudioStream


var musicScene := SceneManager.SceneID.UNINITIALIZED
var playingFanfare: bool
var victory: bool
var timeUntilNextMusic: float
var consecutiveShortMusics: int

enum {LONG, SHORT}
var lastMusicType: int
var lastLongMusic: AudioStream
var lastShortMusic: AudioStream


func _process(delta):

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


func playSound(stream: AudioStream, busName: String = "OtherSounds", volume_db: float = 0):
	var oneShotAudio = oneShotAudioPrefab.instantiate()
	add_child(oneShotAudio)
	oneShotAudio.init(stream, busName, volume_db)

func clearSounds():
	for soundEffect in soundEffectsNode.get_children():
		soundEffect.queue_free()

func overrideTextInputSound(replacementSound: AudioStream = null):
	textInputPlayer.stop()
	if replacementSound != null:
		playSound(replacementSound)


func startNewMusic(scene: SceneManager.SceneID, p_victory := false):
	musicScene = scene
	playingFanfare = true
	victory = p_victory
	consecutiveShortMusics = 0

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
