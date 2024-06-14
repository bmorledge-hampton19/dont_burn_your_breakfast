class_name EndingData
extends Resource

@export var endingID: SceneManager.EndingID
@export var sceneID: SceneManager.SceneID

@export var coinsRewarded := 2

@export_multiline var unlockingHints: Array[String]
@export var unlockingHintCosts: Array[int]

@export_multiline var avoidingHints: Array[String]
@export var avoidingHintCosts: Array[int]
