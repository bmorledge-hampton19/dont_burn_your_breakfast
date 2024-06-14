class_name Ending
extends Scene

@export var backgroundTextureRect: TextureRect

const endingImagesDir := "res://sprites/endings/"
const mainEndingFilePath := endingImagesDir + "0-you_burned_your_breakfast.png"

func _init():
	var sid := SceneManager.SceneID
	sceneTransitions = [sid.MAIN_MENU, sid.LAST_SCENE]


func _ready():
	super()
	backgroundTextureRect.texture = _getEndingTexture()


func _getEndingTexture() -> Texture2D:
	var endingID := SceneManager.endingID
	var endingName: String = SceneManager.EndingID.find_key(endingID).to_lower()
	return load(endingImagesDir + str(endingID) + "-" + endingName + ".png")

func setMainEndingTexture():
	backgroundTextureRect.texture = preload(mainEndingFilePath)