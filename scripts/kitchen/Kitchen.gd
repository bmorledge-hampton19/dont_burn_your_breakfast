class_name Kitchen
extends Scene


func _init():
	var sid := SceneManager.SceneID
	sceneTransitions = [sid.MAIN_MENU, sid.ENDING]
	defaultStartingMessage = (
		""
	)

func _ready():
	super()