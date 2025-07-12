class_name Ending
extends Scene

@export var backgroundTextureRect: TextureRect

@export var finalEndingOverlay: Control

@export_category("Ending Text")
@export var mainMenuEndingText: Label
@export var bathroomEndingsText: Label
@export var frontYardEndingsText: Label
@export var bedroomEndingsText: Label
@export var kitchenEndingsText: Label
@export var endingEndingText: Label
var endingTextsByScene: Dictionary[SceneManager.SceneID, Label]

@export_category("Check Marks")
@export var mainMenuCheckMark: Sprite2D
@export var bathroomCheckMark: Sprite2D
@export var frontYardCheckMark: Sprite2D
@export var bedroomCheckMark: Sprite2D
@export var kitchenCheckMark: Sprite2D
@export var endingCheckMark: Sprite2D
var checkMarksByScene: Dictionary[SceneManager.SceneID, Sprite2D]

@export_category("Crown")
@export var crown: Sprite2D

const endingImagesDir := "res://sprites/endings/"
const mainEndingFilePath := endingImagesDir + "0-you_burned_your_breakfast.png"
const bonusEndingFilePath := endingImagesDir + "350-finishing_strong.png"

func _init():
	var sid := SceneManager.SceneID
	sceneTransitions = [sid.MAIN_MENU, sid.LAST_SCENE]


func _ready():
	super()

	endingTextsByScene = {
		SceneManager.SceneID.MAIN_MENU : mainMenuEndingText, SceneManager.SceneID.BATHROOM : bathroomEndingsText,
		SceneManager.SceneID.FRONT_YARD : frontYardEndingsText, SceneManager.SceneID.BEDROOM : bedroomEndingsText,
		SceneManager.SceneID.KITCHEN : kitchenEndingsText, SceneManager.SceneID.ENDING : endingEndingText,
	}

	checkMarksByScene = {
		SceneManager.SceneID.MAIN_MENU : mainMenuCheckMark, SceneManager.SceneID.BATHROOM : bathroomCheckMark,
		SceneManager.SceneID.FRONT_YARD : frontYardCheckMark, SceneManager.SceneID.BEDROOM : bedroomCheckMark,
		SceneManager.SceneID.KITCHEN : kitchenCheckMark, SceneManager.SceneID.ENDING : endingCheckMark,
	}

	backgroundTextureRect.texture = _getEndingTexture()

	if SceneManager.endingID == SceneManager.EndingID.CHAMPION_OF_BREAKFASTS:
		_showFinalEndingOverlay()


func _getEndingTexture() -> Texture2D:
	var endingID := SceneManager.endingID
	var endingName: String = SceneManager.EndingID.find_key(endingID).to_lower()
	return load(endingImagesDir + str(endingID) + "-" + endingName + ".png")

func _showFinalEndingOverlay():

	finalEndingOverlay.show()

	for sceneID in endingTextsByScene:
		var totalEndings: int = 0
		var unlockedEndings: int = 0

		for endingID in SceneManager.endingsByScene[sceneID]:
			totalEndings += 1
			if EndingsManager.isEndingUnlocked(endingID): unlockedEndings += 1
		
		endingTextsByScene[sceneID].text = "%02d" % unlockedEndings + "/" + "%02d" % totalEndings

		if totalEndings == unlockedEndings: checkMarksByScene[sceneID].show()
	
	if EndingsManager.areAllEndingsUnlocked(): crown.show()


func setMainEndingTexture():
	backgroundTextureRect.texture = preload(mainEndingFilePath)


func burnBreakfast():
	if not EndingsManager.isEndingUnlocked(SceneManager.EndingID.FINISHING_STRONG):
		EndingsManager.unlockEnding(SceneManager.EndingID.FINISHING_STRONG)
	
	SceneManager.endingID = SceneManager.EndingID.FINISHING_STRONG
	finalEndingOverlay.hide()
	backgroundTextureRect.texture = preload(bonusEndingFilePath)