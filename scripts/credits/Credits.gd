class_name Credits
extends Scene

func _init():
	var sid := SceneManager.SceneID
	sceneTransitions = [sid.MAIN_MENU]
	defaultStartingMessage = (
		"These are the people that made this game possible! Make sure to inspect and thank them."
	)

func _ready():
	super()