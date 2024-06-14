class_name EndingPreview
extends Node

@export var preview: TextureRect
@export var obfuscator: ColorRect
@export var endingNumber: Label
@export var cerealCoin: Sprite2D

var endingID: SceneManager.EndingID

func initEnding(p_endingID: SceneManager.EndingID, numberInScene: int):
	endingID = p_endingID
	var endingName: String = SceneManager.EndingID.find_key(endingID).to_lower()
	preview.texture = load("res://sprites/endings/minis/" + str(endingID) + "-" + endingName + "_mini.png")
	endingNumber.text = str(numberInScene)
	if EndingsManager.isEndingUnlocked(endingID): obfuscator.hide()
	if EndingsManager.haveCoinsBeenCollected(endingID): cerealCoin.hide()

func collectCoins():
	cerealCoin.hide()
	EndingsManager.collectCoins(endingID)
	cerealCoin.hide()