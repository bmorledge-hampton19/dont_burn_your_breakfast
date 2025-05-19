class_name CerealData
extends SpreadsheetData

@export var servingSize: String
@export var sugar: String
@export var sugarClass: String
@export var fiber: String
@export var protein: String
@export var geometry: String
@export var company: String
@export var mascot: String


func getAttributes():
    if not attributes: attributes = {
        "Serving Size" : servingSize,
        "Sugar" : sugar,
        "Sugar Class" : sugarClass,
        "Fiber" : fiber,
        "Protein" : protein,
        "Geometry" : geometry,
        "Company" : company,
        "Mascot" : mascot,
    }
    return attributes