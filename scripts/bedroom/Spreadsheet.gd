class_name Spreadsheet
extends NinePatchRect

@export var headerText: Label
@export var textContainer: GridContainer
@export var cellTextPrefab: PackedScene

enum Type {SPOON, BOWL, CEREAL, MILK, CEREAL_BOX, BREAKFAST_TIME, MIXES}

const test = preload("res://my_resources/object_data/spreadsheets/spoon/baby_spoon.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Spreadsheets!")
	print(test.attributes)
	print(test.attributes)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
