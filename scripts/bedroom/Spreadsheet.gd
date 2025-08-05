class_name Spreadsheet
extends NinePatchRect

enum Type {BOWL, BREAKFAST_TIME, CEREAL, CEREAL_BOX, MILK, SPOON, MIXES}
static var bowlDatas: Array[SpreadsheetData]
static var breakfastTimeDatas: Array[SpreadsheetData]
static var cerealDatas: Array[SpreadsheetData]
static var cerealBoxDatas: Array[SpreadsheetData]
static var milkDatas: Array[SpreadsheetData]
static var spoonDatas: Array[SpreadsheetData]
static var spreadsheetDatas: Dictionary[Type,Array] = {
	Type.BOWL : bowlDatas, Type.BREAKFAST_TIME : breakfastTimeDatas,
	Type.CEREAL : cerealDatas, Type.CEREAL_BOX : cerealBoxDatas,
	Type.MILK : milkDatas, Type.SPOON : spoonDatas
}
const TITLE_TEXTS: Dictionary[Type, Array] = {
	Type.BOWL : ["Bowls", "Cereal Bowls", "My Bowls", "Bowl Catalog", "Best Bowls", "Bold Bowls for Cereal"],
	Type.BREAKFAST_TIME : ["Breakfast Times", "Catalog of Breakfast Times", "Best Breakfast Times", "When to Eat Breakfast"],
	Type.CEREAL : ["Cereal", "Best cereals", "My Cereals", "The Cerealnomicon", "The Cerealopedia", "Cereal for the Ages"],
	Type.CEREAL_BOX : ["Cereal Boxes", "Cereal Packaging", "Cereal Prisons", "Catalog of Cereal Boxes"],
	Type.MILK : ["Favorite Milks", "Cereal Milks", "The Milk Menagerie", "Milk Demystified", "Hot MILKS in Your Area"],
	Type.SPOON : ["Spooning 101", "Spoons", "Cereal Spoons", "Best Spoons", "Seriously Spoons"],
	Type.MIXES : ["Cereal Mixes", "Cereal Type Matchups", "The Mixing Mandate", "MIXUM62", "Best Cereal Mixes"]
}

const SPREADSHEET_DATA_DIR = "res://my_resources/object_data/spreadsheet/"
const BOWL_DATA_DIR = SPREADSHEET_DATA_DIR + "bowl/"
const BREAKFAST_TIME_DATA_DIR = SPREADSHEET_DATA_DIR + "breakfast_time/"
const CEREAL_DATA_DIR = SPREADSHEET_DATA_DIR + "cereal/"
const CEREAL_BOX_DATA_DIR = SPREADSHEET_DATA_DIR + "cereal_box/"
const MILK_DATA_DIR = SPREADSHEET_DATA_DIR + "milk/"
const SPOON_DATA_DIR = SPREADSHEET_DATA_DIR + "spoon/"
static func _static_init():

	for fileName in ResourceLoader.list_directory(BOWL_DATA_DIR):
		if fileName.ends_with(".tres"):
			bowlDatas.append(load(BOWL_DATA_DIR+fileName))

	for fileName in ResourceLoader.list_directory(BREAKFAST_TIME_DATA_DIR):
		if fileName.ends_with(".tres"):
			breakfastTimeDatas.append(load(BREAKFAST_TIME_DATA_DIR+fileName))
	
	for fileName in ResourceLoader.list_directory(CEREAL_DATA_DIR):
		if fileName.ends_with(".tres"):
			cerealDatas.append(load(CEREAL_DATA_DIR+fileName))
	
	for fileName in ResourceLoader.list_directory(CEREAL_BOX_DATA_DIR):
		if fileName.ends_with(".tres"):
			cerealBoxDatas.append(load(CEREAL_BOX_DATA_DIR+fileName))
	
	for fileName in ResourceLoader.list_directory(MILK_DATA_DIR):
		if fileName.ends_with(".tres"):
			milkDatas.append(load(MILK_DATA_DIR+fileName))

	for fileName in ResourceLoader.list_directory(SPOON_DATA_DIR):
		if fileName.ends_with(".tres"):
			spoonDatas.append(load(SPOON_DATA_DIR+fileName))

enum {COMPLEMENTARY, AGNOSTIC, CONFLICTING}

@export var headerText: Label
@export var textContainer: GridContainer
@export var cellTextPrefab: PackedScene

var type: Type

# Called when the node enters the scene tree for the first time.
func _ready():

	if OS.is_debug_build(): _testCereals()

	type = Type.values().pick_random()

	headerText.text = TITLE_TEXTS[type].pick_random()

	textContainer.add_child(cellTextPrefab.instantiate())

	if type != Type.MIXES:

		var dataArray: Array[SpreadsheetData] = spreadsheetDatas[type]
		dataArray.shuffle()

		var attributeCount := randi_range(3,5)
		textContainer.columns = attributeCount + 1

		var attributeKeys: Array[String]
		attributeKeys = dataArray[0].attributes.keys()
		attributeKeys.shuffle()
		attributeKeys = attributeKeys.slice(0, attributeCount)

		for key in attributeKeys:
			var nameCellText = cellTextPrefab.instantiate()
			nameCellText.text = key
			textContainer.add_child(nameCellText)

		for data in dataArray.slice(0,randi_range(4,7)):
			var nameCellText = cellTextPrefab.instantiate()
			nameCellText.text = data.name
			textContainer.add_child(nameCellText)

			for key in attributeKeys:
				var attributeCellText = cellTextPrefab.instantiate()
				attributeCellText.text = data.attributes[key]
				textContainer.add_child(attributeCellText)
	
	else:

		var dataArray: Array[SpreadsheetData] = spreadsheetDatas[Type.CEREAL]
		dataArray.shuffle()

		var columnCereals: Array[CerealData]
		columnCereals.assign(dataArray.slice(0,randi_range(3,5)))
		textContainer.columns = len(columnCereals) + 1

		for cereal in columnCereals:
			var nameCellText = cellTextPrefab.instantiate()
			nameCellText.text = cereal.name
			textContainer.add_child(nameCellText)

		var rowCereals: Array[CerealData]
		rowCereals.assign(dataArray.slice(6,6+randi_range(4,7)))

		for rowCereal in rowCereals:
			var nameCellText = cellTextPrefab.instantiate()
			nameCellText.text = rowCereal.name
			textContainer.add_child(nameCellText)

			for columnCereal in columnCereals:

				# Important exception!
				if (
					(rowCereal.name == "Life" and columnCereal.name == "Cnm Tst Crnch") or
					(rowCereal.name == "Cnm Tst Crnch" and columnCereal.name == "Life")
				):
					var exceptionCellText = cellTextPrefab.instantiate()
					exceptionCellText.text = "+++"
					textContainer.add_child(exceptionCellText)
					continue


				var sugarCompatibility
				var shapeCompatibility

				if rowCereal.geometry == "Irregular" and columnCereal.geometry == "Irregular":
					shapeCompatibility = AGNOSTIC
				elif rowCereal.geometry == columnCereal.geometry:
					shapeCompatibility = COMPLEMENTARY
				elif (
					rowCereal.geometry == "Irregular" or columnCereal.geometry == "Irregular" or
					(rowCereal.geometry == "Flake" and columnCereal.geometry == "Mini-flake") or
					(rowCereal.geometry == "Mini-flake" and columnCereal.geometry == "Flake") or
					(rowCereal.geometry == "Square" and columnCereal.geometry == "Ravioli") or
					(rowCereal.geometry == "Ravioli" and columnCereal.geometry == "Square")
				):
					shapeCompatibility = AGNOSTIC
				else:
					shapeCompatibility = CONFLICTING
				
				if (
					(rowCereal.sugarClass == "Sugary" and columnCereal.sugarClass != "Non-sugar") or
					(columnCereal.sugarClass == "Sugary" and rowCereal.sugarClass != "Non-sugar")
				):
					sugarCompatibility = CONFLICTING
				elif(
					(rowCereal.sugarClass == "Sugary" and columnCereal.sugarClass == "Non-sugar") or
					(columnCereal.sugarClass == "Sugary" and rowCereal.sugarClass == "Non-sugar")
				):
					sugarCompatibility = COMPLEMENTARY
				else:
					sugarCompatibility = AGNOSTIC


				var overallCompatibility: String

				if sugarCompatibility == AGNOSTIC:
					if shapeCompatibility == AGNOSTIC:
						overallCompatibility = "+/−"
					elif shapeCompatibility == COMPLEMENTARY:
						overallCompatibility = "+"
					elif shapeCompatibility == CONFLICTING:
						overallCompatibility = "−"
				elif sugarCompatibility == COMPLEMENTARY:
					if shapeCompatibility == AGNOSTIC:
						overallCompatibility = "++"
					elif shapeCompatibility == COMPLEMENTARY:
						overallCompatibility = "+++"
					elif shapeCompatibility == CONFLICTING:
						overallCompatibility = "+"
				elif sugarCompatibility == CONFLICTING:
					if shapeCompatibility == AGNOSTIC:
						overallCompatibility = "−−"
					elif shapeCompatibility == COMPLEMENTARY:
						overallCompatibility = "−"
					elif shapeCompatibility == CONFLICTING:
						overallCompatibility = "−−−"

				var compatibilityCellText = cellTextPrefab.instantiate()
				compatibilityCellText.text = overallCompatibility
				textContainer.add_child(compatibilityCellText)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _testCereals():
	for cerealData in spreadsheetDatas[Type.CEREAL]:
		if cerealData.attributes["Sugar Class"] not in [
			"Sugary", "Non-sugar", "Medium"
		]: print("Unexpected sugar class: ", cerealData.attributes["Sugar Class"], " in ", cerealData.name)
		if cerealData.attributes["Geometry"] not in [
			"Irregular", "Torus", "Ravioli", "Flake", "Mini-flake", "Square", "Spherical"
		]: print("Unexpected geometry: ", cerealData.attributes["Geometry"], " in ", cerealData.name)
