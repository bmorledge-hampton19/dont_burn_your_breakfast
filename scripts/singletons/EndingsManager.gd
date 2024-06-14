extends Node

var _endingsSaveData: EndingsSaveData
var _endingsData: Dictionary = {}

enum {UNLOCKING, AVOIDING}
enum {TOTAL, BOUGHT}
enum {TEXT, COST}

# Called when the node enters the scene tree for the first time.
func _ready():
	_endingsSaveData = loadData()


func getCerealCoins() -> int:
	return _endingsSaveData.cerealCoins

func _checkShortcutUnlock(endingSceneID: SceneManager.SceneID):

	if endingSceneID == SceneManager.SceneID.MAIN_MENU or endingSceneID == SceneManager.SceneID.KITCHEN: return
	var nextScene: SceneManager.SceneID

	match endingSceneID:
		SceneManager.SceneID.BATHROOM: nextScene = SceneManager.SceneID.FRONT_YARD
		SceneManager.SceneID.FRONT_YARD: nextScene = SceneManager.SceneID.BEDROOM
		SceneManager.SceneID.BEDROOM: nextScene = SceneManager.SceneID.KITCHEN

	for endingID: SceneManager.EndingID in SceneManager.endingsByScene[endingSceneID]:
		if not _getEndingSaveData(endingID).unlocked: return
	_endingsSaveData.isSceneShortcutUnlocked[nextScene] = true
	

func isSceneShortcutUnlocked(sceneID: SceneManager.SceneID) -> bool:
	return _endingsSaveData.isSceneShortcutUnlocked[sceneID]


func _getEndingSaveData(endingID: SceneManager.EndingID) -> EndingSaveData:
	if endingID not in _endingsSaveData.endings:
		_endingsSaveData.endings[endingID] = EndingSaveData.new()
	return _endingsSaveData.endings[endingID]

func _getEndingData(endingID: SceneManager.EndingID) -> EndingData:
	if endingID not in _endingsData:
		var endingName: String = SceneManager.EndingID.find_key(endingID).to_lower()
		_endingsData[endingID] = load("res://my_resources/object_data/endings/" + str(endingID) + "-" + endingName + ".tres")
	return _endingsData[endingID]


func isEndingUnlocked(endingID: SceneManager.EndingID) -> bool:
	return _getEndingSaveData(endingID).unlocked

func areAllEndingsUnlocked() -> bool:
	for endingID in SceneManager.EndingID.values():
		if endingID == SceneManager.EndingID.NONE or endingID == SceneManager.EndingID.YOU_BURNED_YOUR_BREAKFAST: continue
		if not isEndingUnlocked(endingID): return false
	return true

func unlockEnding(endingID: SceneManager.EndingID):
	var endingSaveData = _getEndingSaveData(endingID)
	var endingData = _getEndingData(endingID)
	endingSaveData.unlocked = true
	endingSaveData.boughtUnlockingHints = endingData.unlockingHints.size()
	if _endingsSaveData.isSceneBeaten[endingData.sceneID]:
		endingSaveData.boughtAvoidingHints = endingData.avoidingHints.size()
	_checkShortcutUnlock(endingData.sceneID)
	saveData()

func onSceneBeaten(sceneID: SceneManager.SceneID):
	if not _endingsSaveData.isSceneBeaten[sceneID]:
		_endingsSaveData.isSceneBeaten[sceneID] = true
		for endingID in SceneManager.endingsByScene[sceneID]:
			var endingSaveData := _getEndingSaveData(endingID)
			if endingSaveData.unlocked:
				endingSaveData.boughtAvoidingHints = _getEndingData(endingID).avoidingHints.size()
		saveData()


func haveCoinsBeenCollected(endingID: SceneManager.EndingID) -> bool:
	return _getEndingSaveData(endingID).coinsCollected

func collectCoins(endingID: SceneManager.EndingID):
	_endingsSaveData.cerealCoins += _getEndingData(endingID).coinsRewarded
	_getEndingSaveData(endingID).coinsCollected = true
	saveData()


func _getHintArray(endingID: SceneManager.EndingID, unlockingOrAvoiding, textOrCost = TEXT) -> Array:
	if unlockingOrAvoiding == UNLOCKING:
		if textOrCost == TEXT:
			return _getEndingData(endingID).unlockingHints
		elif textOrCost == COST:
			return _getEndingData(endingID).unlockingHintCosts
	elif unlockingOrAvoiding == AVOIDING:
		if textOrCost == TEXT:
			return _getEndingData(endingID).avoidingHints
		elif textOrCost == COST:
			return _getEndingData(endingID).avoidingHintCosts
	return []

func getNumberOfHints(endingID: SceneManager.EndingID, unlockingOrAvoiding, totalOrBought) -> int:
	if totalOrBought == TOTAL:
		return _getHintArray(endingID, unlockingOrAvoiding).size()
	elif totalOrBought == BOUGHT:
		if unlockingOrAvoiding == UNLOCKING: return _getEndingSaveData(endingID).boughtUnlockingHints
		elif unlockingOrAvoiding == AVOIDING: return _getEndingSaveData(endingID).boughtAvoidingHints
	return -1

func getHintCost(endingID: SceneManager.EndingID, unlockingOrAvoiding, hintIndex) -> int:
	return _getHintArray(endingID, unlockingOrAvoiding, COST)[hintIndex]

func hasHintBeenBought(endingID: SceneManager.EndingID, unlockingOrAvoiding, hintIndex) -> bool:
	return hintIndex < getNumberOfHints(endingID, unlockingOrAvoiding, BOUGHT)

func buyHint(endingID: SceneManager.EndingID, unlockingOrAvoiding) -> String:
	var endingSaveData := _getEndingSaveData(endingID)
	var hintIndex := -1
	if unlockingOrAvoiding == UNLOCKING:
		_endingsSaveData.cerealCoins -= getHintCost(endingID, UNLOCKING, endingSaveData.boughtUnlockingHints)
		hintIndex = endingSaveData.boughtUnlockingHints
		endingSaveData.boughtUnlockingHints += 1
	elif unlockingOrAvoiding == AVOIDING:
		_endingsSaveData.cerealCoins -= getHintCost(endingID, UNLOCKING, endingSaveData.boughtAvoidingHints)
		hintIndex = endingSaveData.boughtAvoidingHints
		endingSaveData.boughtAvoidingHints += 1
	saveData()
	return getHint(endingID, unlockingOrAvoiding, hintIndex)

func getHint(endingID: SceneManager.EndingID, unlockingOrAvoiding, hintIndex) -> String:
	return _getHintArray(endingID, unlockingOrAvoiding)[hintIndex]


# It would be awesome to implement these functions as part of an interface if those ever get added.
# Required override
func _getSaveFilePathBasename() -> String:
	return "user://endings_save_data"

# Don't override
func _getSaveFilePath(malformed = false) -> String:
	var saveFilePath := _getSaveFilePathBasename()
	if malformed: saveFilePath += ".maltres"
	else: saveFilePath += ".tres"
	return saveFilePath

# Optional override. Default would load as Resource.
func _typedLoader(saveFilePath) -> Resource:
	return load(saveFilePath) as EndingsSaveData

# Required override. Will usually just create a default instance of the loaded resource type
func _defaultLoader() -> Resource:
	return EndingsSaveData.new()

# If types could be passed as arguments, the above two functions could be removed.
func loadData() -> Resource:
	var data: Resource
	var saveFilePath = _getSaveFilePath()
	if FileAccess.file_exists(saveFilePath):
		data = _typedLoader(saveFilePath)
		if data == null:
			print(saveFilePath, " malformed. Backing up and reverting to default values.")
			FileAccess.open(_getSaveFilePath(true), FileAccess.WRITE).store_string(
				FileAccess.open(saveFilePath, FileAccess.READ).get_as_text()
			)
			data = _defaultLoader()
	else: data = _defaultLoader()
	return data

# Required overload. Give variable name for save data.
func saveData():
	ResourceSaver.save(_endingsSaveData, _getSaveFilePath())

# Required overload. give variable name for save data.
func resetData():
	_endingsSaveData = _defaultLoader()
	saveData()