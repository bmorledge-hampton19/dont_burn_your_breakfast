class_name BowlData
extends SpreadsheetData

@export var shape: String
@export var slope: String
@export var depth: String
@export var material: String
@export var topEdge: String
@export var milkDrinkingDifficulty: String

func getAttributes():
    if not attributes: attributes = {
        "Shape" : shape,
        "Slope" : slope,
        "Depth" : depth,
        "Material" : material,
        "Rim" : topEdge,
        "Milk Drinking" : milkDrinkingDifficulty
    }
    return attributes