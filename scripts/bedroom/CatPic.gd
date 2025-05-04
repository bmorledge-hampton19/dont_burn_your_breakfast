@tool
class_name CatPic
extends NinePatchRect

const CAT_1 := preload("res://sprites/computer_cleaning/cat_pics/cat1.jpg")
const CAT_2 := preload("res://sprites/computer_cleaning/cat_pics/cat2.jpg")
const CAT_3 := preload("res://sprites/computer_cleaning/cat_pics/cat3.jpg")
const CAT_4 := preload("res://sprites/computer_cleaning/cat_pics/cat4.jpg")
const CAT_5 := preload("res://sprites/computer_cleaning/cat_pics/cat5.jpg")
const CAT_6 := preload("res://sprites/computer_cleaning/cat_pics/cat6.jpg")
const CAT_7 := preload("res://sprites/computer_cleaning/cat_pics/cat7.jpg")
const CAT_8 := preload("res://sprites/computer_cleaning/cat_pics/cat8.jpg")
const CAT_9 := preload("res://sprites/computer_cleaning/cat_pics/cat9.jpg")
const CAT_10 := preload("res://sprites/computer_cleaning/cat_pics/cat10.jpg")
const CAT_11 := preload("res://sprites/computer_cleaning/cat_pics/cat11.jpg")
const CAT_12 := preload("res://sprites/computer_cleaning/cat_pics/cat12.jpg")
const CAT_13 := preload("res://sprites/computer_cleaning/cat_pics/cat13.jpg")
const CAT_14 := preload("res://sprites/computer_cleaning/cat_pics/cat14.jpg")
const CAT_15 := preload("res://sprites/computer_cleaning/cat_pics/cat15.jpg")
const CAT_16 := preload("res://sprites/computer_cleaning/cat_pics/cat16.jpg")
const CAT_17 := preload("res://sprites/computer_cleaning/cat_pics/cat17.jpg")
const CAT_18 := preload("res://sprites/computer_cleaning/cat_pics/cat18.jpg")

const CATS := [
	CAT_1, CAT_2, CAT_3, CAT_4, CAT_5, CAT_6, CAT_7, CAT_8, CAT_9,
	CAT_10, CAT_11, CAT_12, CAT_13, CAT_14, CAT_15, CAT_16, CAT_17, CAT_18, 
]

const LASER_EYE_POSITIONS := {
	CAT_1 : [Vector2(-58, 176)],
	CAT_2 : [Vector2(-98, 6), Vector2(-68, 8)],
	CAT_3 : [Vector2(-4, 224), Vector2(-52, 226)],
	CAT_4 : [Vector2(190, 58), Vector2(152, 42)],
	CAT_5 : [Vector2(92, 2)],
	CAT_6 : [Vector2(-30, 114), Vector2(122, 108)],
	CAT_7 : [Vector2(24, 124), Vector2(60, 122)],
	CAT_8 : [Vector2(100, 14), Vector2(148, 10)],
	CAT_9 : [Vector2(10, 20), Vector2(34, 4)],
	CAT_10 : [Vector2(88, 12)],
	CAT_11 : [Vector2(-70, -4), Vector2(-42, -10)],
	CAT_12 : [Vector2(-36, 92), Vector2(32, 80)],
	CAT_13 : [Vector2(12, -2), Vector2(-20, -2)],
	CAT_14 : [Vector2(92, 8), Vector2(110, 20)],
	CAT_15 : [Vector2(-38, 0), Vector2(-16, -8)],
	CAT_16 : [Vector2(78, 112)],
	CAT_17 : [Vector2(-14, 80), Vector2(44, 62)],
	CAT_18 : [Vector2(156, -24), Vector2(182, -20)],
}

@export var catPicTextureRect: TextureRect
@export var catPicTexture: Texture2D:
	set(value):

		catPicTexture = value
		if not catPicTexture or not catPicTextureRect: return

		catPicTextureRect.texture = catPicTexture
		var preferredCatPicSize = Vector2(catPicTexture.get_size().x/2,catPicTexture.get_size().y/2)
		if preferredCatPicSize.x < 330: preferredCatPicSize *= 330.0/preferredCatPicSize.x
		size = Vector2(preferredCatPicSize.x+20, preferredCatPicSize.y+70)

		for laserEye in laserEyesControl.get_children():
			laserEye.queue_free()
		for laserEyePos in LASER_EYE_POSITIONS[catPicTexture]:
			var newLaserEye = laserEyePrefab.instantiate()
			laserEyesControl.add_child(newLaserEye)
			newLaserEye.position = laserEyePos

@export var laserEyesControl: Control
@export var laserEyePrefab: PackedScene

var angry: bool
var angryTimer: float
func resetAngryTimer():
	angry = false
	headerText.text = defaultHeaderText
	laserEyesControl.hide()
	angryTimer = randf_range(10, 20)

@export var headerText: Label
var defaultHeaderText: String
const HEADER_TEXT_OPTIONS := [
	"Cat", "Uwu", "uwu", "uwU", "Kitty", "Kitty Cat", "Meow", "Mrow", "Soft Kitty",
	"Feline", "Palico", "Kat", "Kit Kat", "Purrrr", "Salami", "Give Treato", ":3",
	"Best Cat", "Is Cat", "That Cat", "Cat; No Hat", "My Cat", "taC", "(^_^)"
]
func resetHeaderText():
	defaultHeaderText = HEADER_TEXT_OPTIONS.pick_random()
	headerText.text = defaultHeaderText


# Called when the node enters the scene tree for the first time.
func _ready():
	resetAngryTimer()
	resetHeaderText()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if angryTimer <= 0:
		angry = true
		headerText.text = "HISSSS"
		laserEyesControl.show()
	else: angryTimer -= delta
