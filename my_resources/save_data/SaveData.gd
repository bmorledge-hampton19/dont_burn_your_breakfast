extends Resource


func _getSaveFileBasename() -> String:
	push_error("Unimplemented function.")
	return ""


func _getSaveFilePath(malformed = false) -> String:
	var filePath := _getSaveFileBasename()
	if malformed: filePath += ".malcfg"
	else: filePath += ".cfg"
	return filePath


func saveInstance():
	ResourceSaver.save(self, _getSaveFilePath())


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