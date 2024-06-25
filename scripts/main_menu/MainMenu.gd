class_name MainMenu
extends Scene

func _init():
	var sid := SceneManager.SceneID
	sceneTransitions = [
		sid.ENDING, sid.HELP, sid.OPTIONS, sid.CREDITS,
		sid.BATHROOM, sid.FRONT_YARD, sid.BEDROOM, sid.KITCHEN
	]
	defaultStartingMessage = (
		"Welcome to the epic survival adventure: Don't Burn Your Breakfast! " +
		"If this is your first time playing, it's recommended that start by typing \"help\" and " +
		"pressing enter to get an idea of how the text commands work."
	)

func _ready():
	super()
