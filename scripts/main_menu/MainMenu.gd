class_name MainMenu
extends Scene

@export var musicNotesControl: Control

func _init():
	var sid := SceneManager.SceneID
	sceneTransitions = [
		sid.ENDING, sid.HELP, sid.OPTIONS, sid.CREDITS,
		sid.BATHROOM, sid.FRONT_YARD, sid.BEDROOM, sid.KITCHEN
	]
	defaultStartingMessage = (
		"Welcome to the epic survival adventure: Don't Burn Your Breakfast! " +
		"If this is your first time playing, you should start by typing \"help\" and " +
		"pressing enter to get an idea of how the text commands work."
	)

func _ready():
	if EndingsManager.areAllEndingsUnlocked(): musicNotesControl.show()
	super()

func _process(_delta):
	if AudioManager.isThemeSongPlaying:
		musicNotesControl.modulate.a = 1.0
	else:
		musicNotesControl.modulate.a = 0.5


func playSong():
	AudioManager.fadeOutMusic(1.5)

	var songPlayer := AudioManager.playSound(AudioManager.themeSong, true)

	songPlayer.finished.connect(func(): AudioManager.startNewMusic(SceneManager.SceneID.MAIN_MENU, false, true))
	songPlayer.finished.connect(func(): musicNotesControl.modulate.a = 0.5)
