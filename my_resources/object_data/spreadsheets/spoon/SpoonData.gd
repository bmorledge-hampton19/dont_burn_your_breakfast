class_name SpoonData
extends Resource

@export var name: String
@export var size: String
@export var length: String
@export var focalPoint: String
@export var minorAxis: String
@export var majorAxis: String
@export var depth: String
@export var flexuralStrength: String
var attributes: Array:
    get:
        if not attributes: attributes = [name, size, length, focalPoint, majorAxis, depth, flexuralStrength]
        return attributes
