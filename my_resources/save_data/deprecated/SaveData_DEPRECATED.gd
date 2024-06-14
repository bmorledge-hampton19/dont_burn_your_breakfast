class_name SaveDataDEPRECATED
extends Node

# NOTE: If saving/loading ever becomes a bottleneck, create a SaveDataManager singleton which uses
#		multithreading to manage save data in the background, similar to ResourceLoader.load_threaded_get

func _getSaveFileBasename() -> String:
	push_error("Unimplemented function.")
	return ""

func _getSaveFilePath(malformed = false) -> String:
	var saveFilePath := _getSaveFileBasename()
	if malformed: saveFilePath += ".malsave"
	else: saveFilePath += ".save"
	return saveFilePath


func _getSaveDict() -> Dictionary:
	push_error("Unimplemented function.")
	return({})

func saveInstance():
	var saveFile = FileAccess.open(_getSaveFilePath(), FileAccess.WRITE)
	saveFile.store_string(JSON.stringify(_getSaveDict(), '\t'))


func _parseSaveDict(saveDict: Dictionary):
	push_error("Unimplemented function.")
	return saveDict

func loadInstance():
	var saveFile = FileAccess.open(_getSaveFilePath(), FileAccess.READ)
	if saveFile == null:
		print(_getSaveFilePath(), " not found. Using default values.")
		return

	var saveDict = JSON.parse_string(saveFile.get_as_text())
	if saveDict == null:
		print(_getSaveFilePath(), " malformed. Backing up and reverting to default values.")
		FileAccess.open(_getSaveFilePath(true), FileAccess.WRITE).store_string(saveFile.get_as_text())
		return
	_parseSaveDict(saveDict)
