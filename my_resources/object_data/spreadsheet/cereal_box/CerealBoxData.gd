class_name CerealBoxData
extends SpreadsheetData

@export var width: String
@export var height: String
@export var depth: String
@export var volume: String
@export var servings: String
@export var saleFrequency: String

func getAttributes():
    if not attributes: attributes = {
        "Width" : width,
        "Height" : height,
        "Depth" : depth,
        "volume" : volume,
        "Servings" : servings,
        "Sale Freq" : saleFrequency,
    }
    return attributes