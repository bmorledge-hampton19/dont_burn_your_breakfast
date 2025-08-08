@tool
extends EditorScript

func get_files(path: String, ext: Variant = null) -> Array[String]:
	var dir_access = DirAccess.open(path)
	var files: Array[String] = []
	for file_name in dir_access.get_files():
		if ext == null || file_name.get_extension() == str(ext):
			files.append(path.path_join(file_name))
	for dir in dir_access.get_directories():
		files.append_array(get_files(path.path_join(dir), ext))
	return files

# Called when the script is executed (using File -> Run in Script Editor).
func _run():
	var dir := "res://audio/"
	var filePathsToReimport: Array[String]
	for filePath in get_files(dir, "import"):
			print("Editing " + filePath)
			var config := ConfigFile.new()
			config.load(filePath)
			config.set_value("params", "compress/mode", 0)
			config.save(filePath)
			filePathsToReimport.append(filePath.left(-len(".import")))
	EditorInterface.get_resource_filesystem().reimport_files(filePathsToReimport)
