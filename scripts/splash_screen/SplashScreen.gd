class_name SplashScreen
extends Scene

func _init():
	var sid := SceneManager.SceneID
	sceneTransitions = [sid.MAIN_MENU]
	defaultStartingMessage = (
		""
	)

func _ready():
	super()