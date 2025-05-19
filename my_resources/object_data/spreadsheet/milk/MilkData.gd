class_name MilkData
extends SpreadsheetData

@export var caloriesPerServing: String
@export var color: String
@export var absorbance: String
@export var viscosity: String
@export var specificGravity: String
@export var meltingPoint: String
@export var costPerGallon: String

func getAttributes():
    if not attributes: attributes = {
        "Cal/Serving" : caloriesPerServing,
        "Color" : color,
        "Abs (208nm)" : absorbance,
        "Visc. (10 °C)" : viscosity,
        "Spec Gravity" : specificGravity,
        "Melting Point" : meltingPoint,
        "Cost/Gallon" : costPerGallon

    }
    return attributes