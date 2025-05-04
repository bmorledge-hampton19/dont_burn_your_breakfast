class_name Clothing
extends TextureRect

const BED_ORIGIN := Vector2(0,0)
const BED_GRID_DIM := 10

const AMBIGUOUS = -1
enum {SOCK, UNDERWEAR, PANTS, SHIRT, BRA}
enum {WHITE, RED, GREEN, YELLOW, BLACK, PINK}
enum {PLAIN, STRIPED, SPOTTED}

const CLOTHING_GRID_SIZE := {
	SOCK : {
		false : Vector2(1,2),
		true : Vector2(1,2)
	},
	UNDERWEAR : {
		false : Vector2(2,1),
		true : Vector2(2,1)
	},
	PANTS : {
		false : Vector2(2,3),
		true : Vector2(2,1)
	},
	SHIRT : {
		false : Vector2(2,2),
		true : Vector2(2,1)
	},
	BRA : {
		false : Vector2(2,2),
		true : Vector2(0,0)
	}
}

var color: int
var pattern: int
var type: int
var bedRotation: float
var gridSize: Vector2
var gridPos: Vector2
var depth: int
var buriedDepth: int:
	get:
		var p_buriedDepth = 0
		for overlappingDepth in overlappingClothes:
			if overlappingDepth <= depth: continue
			if overlappingClothes[depth]: p_buriedDepth += 1
		return p_buriedDepth
var overlappingClothes := {0:0, 1:0, 2:0}
var isAccessible: bool:
	get:
		if depth == 0: return true
		for checkingDepth in range(0,depth):
			if overlappingClothes[checkingDepth]: return false
		return true

var folded: bool
var putAway: bool


func setTexture():

	var textureOrigin: Vector2
	match type:
		SOCK:
			if folded: textureOrigin = Vector2(64,0)
			else: textureOrigin = Vector2(0,0)
			textureOrigin.x += color*CLOTHING_GRID_SIZE[type][folded].x*BED_GRID_DIM
			textureOrigin.y += pattern*CLOTHING_GRID_SIZE[type][folded].y*BED_GRID_DIM
		UNDERWEAR:
			if folded: textureOrigin = Vector2(64,64)
			else: textureOrigin = Vector2(0,64)
			textureOrigin.x += pattern*CLOTHING_GRID_SIZE[type][folded].x*BED_GRID_DIM
			textureOrigin.y += color*CLOTHING_GRID_SIZE[type][folded].y*BED_GRID_DIM
		PANTS:
			if folded:
				textureOrigin = Vector2(112,128)
				textureOrigin.x += pattern*CLOTHING_GRID_SIZE[type][folded].x*BED_GRID_DIM
				textureOrigin.y += color*CLOTHING_GRID_SIZE[type][folded].y*BED_GRID_DIM
			else:
				textureOrigin = Vector2(0,128)
				textureOrigin.x += color*CLOTHING_GRID_SIZE[type][folded].x*BED_GRID_DIM
				textureOrigin.y += pattern*CLOTHING_GRID_SIZE[type][folded].y*BED_GRID_DIM
		SHIRT:
			if folded:
				textureOrigin = Vector2(112,224)
				textureOrigin.x += pattern*CLOTHING_GRID_SIZE[type][folded].x*BED_GRID_DIM
				textureOrigin.y += color*CLOTHING_GRID_SIZE[type][folded].y*BED_GRID_DIM
			else:
				textureOrigin = Vector2(0,224)
				textureOrigin.x += color*CLOTHING_GRID_SIZE[type][folded].x*BED_GRID_DIM
				textureOrigin.y += pattern*CLOTHING_GRID_SIZE[type][folded].y*BED_GRID_DIM
		BRA:
			textureOrigin = Vector2(128,64)

	(texture as AtlasTexture).region = Rect2(textureOrigin, CLOTHING_GRID_SIZE[type][folded]*BED_GRID_DIM)
	size = CLOTHING_GRID_SIZE[type][folded]*BED_GRID_DIM*2

func setBedPosition():
	position = BED_ORIGIN + gridPos*BED_GRID_DIM
	if bedRotation == PI/2:
		position.x += BED_GRID_DIM*CLOTHING_GRID_SIZE[type][false].y*2
	if bedRotation == PI:
		position.x += BED_GRID_DIM*CLOTHING_GRID_SIZE[type][false].x*2
		position.y += BED_GRID_DIM*CLOTHING_GRID_SIZE[type][false].y*2
	if bedRotation == 3*PI/2:
		position.y += BED_GRID_DIM*CLOTHING_GRID_SIZE[type][false].x*2
	rotation = bedRotation

func updateBuriedDepth():
	material.set_shader_parameter("buriedDepth", buriedDepth)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func init(p_type: int, p_color: int, p_pattern: int, p_rotation: float, p_depth: int):
	type = p_type
	color = p_color
	pattern = p_pattern

	gridSize = CLOTHING_GRID_SIZE[type][false]
	bedRotation = p_rotation
	if bedRotation == PI/2 or bedRotation == 3*PI/2:
		var temp = gridSize.x
		gridSize.x = gridSize.y
		gridSize.y = temp
	setTexture()

	depth = p_depth


func shuffleGridPos():
	@warning_ignore("narrowing_conversion")
	gridPos = Vector2(randi_range(0,8-gridSize.x), randi_range(0,4-gridSize.y))


func fold():
	folded = true
	setTexture()