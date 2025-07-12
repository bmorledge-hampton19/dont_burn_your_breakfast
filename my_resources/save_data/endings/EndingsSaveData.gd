class_name EndingsSaveData
extends Resource

@export var cerealCoins := 0

@export var isSceneBeaten := {
	SceneManager.SceneID.MAIN_MENU : true,
	SceneManager.SceneID.BATHROOM : false,
	SceneManager.SceneID.FRONT_YARD : false,
	SceneManager.SceneID.BEDROOM : false,
	SceneManager.SceneID.KITCHEN : false,
	SceneManager.SceneID.ENDING : true
}

@export var isSceneShortcutUnlocked := {
	SceneManager.SceneID.BATHROOM : true,
	SceneManager.SceneID.FRONT_YARD : false,
	SceneManager.SceneID.BEDROOM : false,
	SceneManager.SceneID.KITCHEN : false
}

@export var endings: Dictionary[SceneManager.EndingID, EndingSaveData]

func checkSceneBeatenDict():
	if not SceneManager.SceneID.ENDING in isSceneBeaten: isSceneBeaten[SceneManager.SceneID.ENDING] = true