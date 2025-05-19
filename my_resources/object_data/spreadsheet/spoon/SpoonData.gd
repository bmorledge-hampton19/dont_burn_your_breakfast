class_name SpoonData
extends SpreadsheetData

@export var length: String
@export var focalPoint: String
@export var minorAxis: String
@export var majorAxis: String
@export var depth: String
@export var flexuralStrength: String
@export var personality: String

func getAttributes():
    if not attributes: attributes = {
        "Length" : length,
        "Focal Point" : focalPoint,
        "Major Axis" : majorAxis,
        "Depth" : depth,
        "Flexural Str" : flexuralStrength,
        "Personality" : personality,
    }
    return attributes
