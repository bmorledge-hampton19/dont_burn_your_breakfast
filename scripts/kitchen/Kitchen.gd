class_name Kitchen
extends Scene


func _init():
	var sid := SceneManager.SceneID
	sceneTransitions = [sid.MAIN_MENU, sid.ENDING]
	defaultStartingMessage = (
		"You've reached the end of this demo! Have you found all the endings so far?\n\n" +
		"Only one more area to go! See you soon!"
	)

func _ready():
	super()