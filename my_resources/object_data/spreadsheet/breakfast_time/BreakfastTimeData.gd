class_name BreakfastTimeData
extends SpreadsheetData

@export var time: String
@export var alertness: String
@export var hunger: String
@export var rarity: String
@export var notes: String
@export var idealCereal: String

func getAttributes():
    if not attributes: attributes = {
        "Time" : time,
        "Alertness" : alertness,
        "Hunger" : hunger,
        "Rarity" : rarity,
        "Notes" : notes,
        "Ideal Cereal" : idealCereal
    }
    return attributes