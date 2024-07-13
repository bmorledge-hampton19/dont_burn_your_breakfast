class_name Bedroom
extends Scene


func _init():
	var sid := SceneManager.SceneID
	sceneTransitions = [sid.MAIN_MENU, sid.ENDING, sid.KITCHEN]
	defaultStartingMessage = (
		"Congratulations on reaching the end of the demo! " +
		"Have you unlocked all the endings and tried out the secret settings yet?"
	)

func _ready():
	super()