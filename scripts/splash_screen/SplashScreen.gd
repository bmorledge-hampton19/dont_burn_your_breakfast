class_name SplashScreen
extends Scene

@export var drBeanSprite: Sprite2D

@export var spillingMilkSprite: Texture2D
@export var preparedCerealSprite: Texture2D
@export var eatingCerealSprite: Texture2D

@export var noise: FastNoiseLite

var drBeanAnchor: Vector2

enum BeanState {IDLE, SPILLING, PREPARED, EATING}
var beanState: BeanState


var fadeInDelay: float = 1.0
var fadingIn: bool
var fadeInDuration: float = 2.0

var timeUntilFadeOut := 10.0
var fadingOut: bool
var fadeOutDuration: float = 2.0
var finalFadeOutTimer: float

var jittering: bool
var noisePos: float
var jitterSpeed: float = 5

func _init():
	var sid := SceneManager.SceneID
	sceneTransitions = [sid.MAIN_MENU]
	defaultStartingMessage = (
		"A game by Dr. Bean\n               \n(You can input \"skip\" to proceed.)"
	)

func _ready():

	super()

	drBeanSprite.modulate.a = 0
	beanState = BeanState.IDLE
	drBeanAnchor = drBeanSprite.position


func _process(delta):

	processFades(delta)

	if jittering: processJitter(delta)

func resetFadeOutTime(newTime := 10.0):
	fadingIn = false
	fadingOut = false
	drBeanSprite.modulate.a = 1.0
	timeUntilFadeOut = newTime
	finalFadeOutTimer = 0


func processFades(delta):
	if fadeInDelay > 0:
		fadeInDelay -= delta
		if fadeInDelay <= 0:
			fadingIn = true
	
	if fadingIn:
		drBeanSprite.modulate.a += delta/fadeInDuration
		if drBeanSprite.modulate.a >= 1:
			drBeanSprite.modulate.a = 1
			fadingIn = false
	
	if timeUntilFadeOut > 0 and drBeanSprite.modulate.a == 1:
		timeUntilFadeOut -= delta
		if timeUntilFadeOut <= 0: fadingOut = true
	
	if fadingOut:
		drBeanSprite.modulate.a -= delta/fadeOutDuration
		if drBeanSprite.modulate.a <= 0:
			drBeanSprite.modulate.a = 0
			finalFadeOutTimer += delta
			if finalFadeOutTimer >= 0.5: transitionToMainMenu()


func processJitter(delta):
	noisePos += delta*jitterSpeed
	drBeanSprite.position = Vector2(
		round(noise.get_noise_2d(0, noisePos)*2.4)*2,
		round(noise.get_noise_2d(100, noisePos)*2.4)*2
	) + drBeanAnchor


func spillMilk():
	resetFadeOutTime(5.0)
	beanState = BeanState.SPILLING
	drBeanSprite.texture = spillingMilkSprite
	jittering = true


func pourMilkInCereal():
	beanState = BeanState.PREPARED
	drBeanSprite.texture = preparedCerealSprite


func eatCereal():
	resetFadeOutTime(5.0)
	beanState = BeanState.SPILLING
	drBeanSprite.texture = eatingCerealSprite
	jittering = true


func transitionToMainMenu():
	SceneManager.transitionToScene(SceneManager.SceneID.MAIN_MENU)