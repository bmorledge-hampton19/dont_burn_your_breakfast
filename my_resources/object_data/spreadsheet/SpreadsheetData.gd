class_name SpreadsheetData
extends Resource

@export var name: String

var attributes: Dictionary[String,String]:
    get = getAttributes

func getAttributes() -> Dictionary[String,String]:
    return attributes