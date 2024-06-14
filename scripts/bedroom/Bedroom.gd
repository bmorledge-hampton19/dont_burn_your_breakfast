class_name Bedroom
extends Scene


func _init():
	var sid := SceneManager.SceneID
	sceneTransitions = [sid.MAIN_MENU, sid.ENDING, sid.KITCHEN]
	defaultStartingMessage = (
		""
	)

func _ready():
	super()