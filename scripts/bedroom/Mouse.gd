class_name Mouse
extends Control

@export var textureRect: TextureRect
@export var explosionAnimation: AnimatedSprite2D
@export var jitterNoise: FastNoiseLite

var velocity: Vector2
var minX: float
var minY: float
var maxX: float
var maxY: float

var reproductionTimer: float
signal onReproduction()

var jittering: bool
var jitterTime: float
var jitterPos: Vector2
var positionAnchor: Vector2
var jitterOffset: Vector2
var jitterStrength: float = 1
var jitterSpeed: float = 4

var exploding: bool
signal onExplosion()

var edible: bool:
	get: return not jittering and not exploding


# Called when the node enters the scene tree for the first time.
func _ready():
	if randf() < 0.9:
		velocity = Vector2(0,randf_range(50,100))
	else:
		velocity = Vector2(0,randf_range(200,400))
	velocity = velocity.rotated(randf()*PI*2)

	maxX = 720-size.x
	maxY = 380-size.y

	reproductionTimer = randf_range(15,25)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):

	if exploding: return


	if jittering:

		jitterPos += delta*jitterSpeed*Vector2.ONE
		jitterOffset = Vector2(
			jitterNoise.get_noise_2d(0, jitterPos.x)*jitterStrength,
			jitterNoise.get_noise_2d(100, jitterPos.y)*jitterStrength
		)

		position = positionAnchor + jitterOffset

		jitterTime -= delta
		if jitterTime <= 0:
			jittering = false
			exploding = true
			onExplosion.emit()
			textureRect.hide()
			explosionAnimation.play()
			explosionAnimation.animation_finished.connect(queue_free)
		
		return

	var distanceThisFrame := velocity*delta

	var horizontalWallDistanceRatio: float
	var verticalWallDistanceRatio: float

	while distanceThisFrame.length() > 0:

		if distanceThisFrame.x < 0:
			horizontalWallDistanceRatio = (minX-position.x)/distanceThisFrame.x
		elif distanceThisFrame.x > 0:
			horizontalWallDistanceRatio = (maxX-position.x)/distanceThisFrame.x
		
		if distanceThisFrame.y < 0:
			verticalWallDistanceRatio = (minY-position.y)/distanceThisFrame.y
		elif distanceThisFrame.y > 0:
			verticalWallDistanceRatio = (maxY-position.y)/distanceThisFrame.y

		if horizontalWallDistanceRatio < 1 and horizontalWallDistanceRatio < verticalWallDistanceRatio:
			position += distanceThisFrame*horizontalWallDistanceRatio
			distanceThisFrame *= (1-horizontalWallDistanceRatio)
			distanceThisFrame.x *= -1
			velocity.x *= -1
		elif verticalWallDistanceRatio < 1:
			position += distanceThisFrame*verticalWallDistanceRatio
			distanceThisFrame *= (1-verticalWallDistanceRatio)
			distanceThisFrame.y *= -1
			velocity.y *= -1
		else:
			position += distanceThisFrame
			distanceThisFrame = Vector2.ZERO
	
	reproductionTimer -= delta
	if reproductionTimer <= 0:
		onReproduction.emit()
		reproductionTimer = randf_range(10,20)

func exposeToAntimatter():
	positionAnchor = position
	jittering = true
	jitterTime = randf_range(3,5)
	jitterPos = Vector2(randf()*50, randf()*50)