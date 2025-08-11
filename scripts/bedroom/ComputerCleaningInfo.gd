class_name ComputerCleaningInfo
extends NinePatchRect

@export var clippy: TextureRect
@export var speechBubble: Panel
@export var speechBubbleText: Label
@export var infoBoxText: MarginContainer

enum {PAUSED, SLOW_SCROLL, FAST_SCROLL}
var infoTextState := PAUSED

const CLIPPY_TEXT_DELAY = 0.03
var clippyAskingForSpeed: bool
var clippyAwaitingCommand: bool
var clippyTextTween: Tween

var clippyTalking: bool
var timeUntilNextClippySound: float

signal finished()

func _ready():
	clippy.scale = Vector2.ZERO
	speechBubble.scale = Vector2.ZERO
	speechBubbleText.visible_characters = 0
	infoBoxText.position.y = 500
	summonClippy()

func _process(delta):

	if clippyTalking:
		timeUntilNextClippySound -= delta
		if timeUntilNextClippySound <= 0:
			AudioManager.playClippySound()
			timeUntilNextClippySound = randf_range(0.1,0.2)

	if infoTextState == SLOW_SCROLL:
		infoBoxText.position.y -= 5 * delta
	elif infoTextState == FAST_SCROLL:
		infoBoxText.position.y -= 300 * delta
	
	if infoBoxText.position.y < -infoBoxText.size.y:
		infoBoxText.position.y = -infoBoxText.size.y
		infoTextState = PAUSED
		displayClippyOutro()


func summonClippy():
	var tween = create_tween()
	tween.tween_interval(5)
	tween.tween_callback(
		func(): AudioManager.playSound(AudioManager.clippyLoggingOn).finished.connect(
			AudioManager.startClippyMusic
		)
	)
	tween.tween_property(clippy, "scale", Vector2.ONE, 2).set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)
	tween.tween_property(speechBubble, "scale", Vector2.ONE, 1).set_trans(Tween.TRANS_CUBIC)
	tween.tween_interval(1)
	tween.tween_callback(displayFirstClippyMessage)

func startClippyTalking():
	clippyTalking = true
	timeUntilNextClippySound = 0

func stopClippyTalking():
	clippyTalking = false
	AudioManager.clippyPlayer.stop()

func displayFirstClippyMessage():
	speechBubbleText.text = (
		"Hey! It looks like you're trying to clean up this mess of a desktop!\n        \n" +
		"I guess you're not as lazy as you look!"
	)
	speechBubbleText.visible_ratio = 0
	clippyTextTween = create_tween()
	clippyTextTween.tween_callback(startClippyTalking)
	clippyTextTween.tween_property(speechBubbleText, "visible_ratio", 1, len(speechBubbleText.text)*CLIPPY_TEXT_DELAY)
	clippyTextTween.tween_callback(stopClippyTalking)
	clippyTextTween.tween_interval(3)
	clippyTextTween.tween_callback(displaySecondClippyMessage)

func displaySecondClippyMessage():
	speechBubbleText.text = (
		"But... Yikes! Things are in pretty bad shape...\n        \n" +
		"Let's be real. You're gonna need some help, and I know just the guy!            \n" +
		"(Spoiler alert: It's me!)"
	)
	speechBubbleText.visible_ratio = 0
	clippyTextTween = create_tween()
	clippyTextTween.tween_callback(startClippyTalking)
	clippyTextTween.tween_property(speechBubbleText, "visible_ratio", 1, len(speechBubbleText.text)*CLIPPY_TEXT_DELAY)
	clippyTextTween.tween_callback(stopClippyTalking)
	clippyTextTween.tween_interval(3)
	clippyTextTween.tween_callback(displayThirdClippyMessage)


func displayThirdClippyMessage():
	speechBubbleText.text = (
		"Well, it's your lucky day! Here comes your salvation: " +
		"A compelling- nay! RIVETING presentation from yours truly! Feast your eyes!" +
		"<-----------"
	)
	speechBubbleText.visible_ratio = 0
	clippyTextTween = create_tween()
	clippyTextTween.tween_callback(startClippyTalking)
	clippyTextTween.tween_property(speechBubbleText, "visible_ratio", 1, len(speechBubbleText.text)*CLIPPY_TEXT_DELAY)
	clippyTextTween.tween_callback(stopClippyTalking)
	clippyTextTween.tween_callback(beginSlowInfoScroll)

func playPresentationNoise():
	AudioManager.playSound(AudioManager.tada)

func beginSlowInfoScroll():
	infoTextState = SLOW_SCROLL
	infoBoxText.size.y = 0
	get_tree().create_timer(4).timeout.connect(playPresentationNoise)
	get_tree().create_timer(10).timeout.connect(displayClippyAskForSpeedPreamble)

func displayClippyAskForSpeedPreamble():
	speechBubbleText.text = (
		"Hmmmmmm...\n" +
		"It's a bit slower than I expected... I figured this would be easier on your silky smooth brain, " +
		"but if you'd like, I can speed things up for you."
	)
	speechBubbleText.visible_ratio = 0
	clippyTextTween = create_tween()
	clippyTextTween.tween_callback(startClippyTalking)
	clippyTextTween.tween_property(speechBubbleText, "visible_ratio", 1, len(speechBubbleText.text)*CLIPPY_TEXT_DELAY)
	clippyTextTween.tween_callback(stopClippyTalking)
	clippyTextTween.tween_interval(3)
	clippyTextTween.tween_callback(displayClippyAskForSpeed)

func displayClippyAskForSpeed():
	speechBubbleText.text = (
		"What do you say? Would you like me to speed up the presentation?\n\n" +
		"          -Yes         -No"
	)
	speechBubbleText.visible_ratio = 0
	clippyAskingForSpeed = true
	clippyTextTween = create_tween()
	clippyTextTween.tween_callback(startClippyTalking)
	clippyTextTween.tween_property(speechBubbleText, "visible_ratio", 1, len(speechBubbleText.text)*CLIPPY_TEXT_DELAY)
	clippyTextTween.tween_callback(stopClippyTalking)

func displayClippyAskForAssurance():
	speechBubbleText.text = (
		"Oh? Have you changed your mind? Would you like me to speed up the presentation?\n\n" +
		"          -Yes         -No"
	)
	speechBubbleText.visible_ratio = 0
	clippyAskingForSpeed = true
	clippyAwaitingCommand = false
	if clippyTextTween: clippyTextTween.kill()
	clippyTextTween = create_tween()
	clippyTextTween.tween_callback(startClippyTalking)
	clippyTextTween.tween_property(speechBubbleText, "visible_ratio", 1, len(speechBubbleText.text)*CLIPPY_TEXT_DELAY)
	clippyTextTween.tween_callback(stopClippyTalking)

func displayClippyConfirmSpeed():
	speechBubbleText.text = (
		"Great choice!\nHere we goooooooo!"
	)
	speechBubbleText.visible_ratio = 0
	clippyAskingForSpeed = false
	if clippyTextTween: clippyTextTween.kill()
	clippyTextTween = create_tween()
	clippyTextTween.tween_callback(startClippyTalking)
	clippyTextTween.tween_property(speechBubbleText, "visible_ratio", 1, len(speechBubbleText.text)*CLIPPY_TEXT_DELAY)
	clippyTextTween.tween_callback(stopClippyTalking)
	clippyTextTween.tween_callback(func(): infoTextState = FAST_SCROLL)

func displayClippyDenySpeed():
	speechBubbleText.text = (
		"Yeah, that's fair. This speed seems about right for you."
	)
	speechBubbleText.visible_ratio = 0
	clippyAskingForSpeed = false
	clippyAwaitingCommand = true
	if clippyTextTween: clippyTextTween.kill()
	clippyTextTween = create_tween()
	clippyTextTween.tween_callback(startClippyTalking)
	clippyTextTween.tween_property(speechBubbleText, "visible_ratio", 1, len(speechBubbleText.text)*CLIPPY_TEXT_DELAY)
	clippyTextTween.tween_callback(stopClippyTalking)

func displayClippyOutro():
	speechBubbleText.text = (
		"I hope you got all that!\n        \nBest of luck!"
	)
	speechBubbleText.visible_ratio = 0
	clippyAskingForSpeed = false
	clippyAwaitingCommand = false
	if clippyTextTween: clippyTextTween.kill()
	clippyTextTween = create_tween()
	clippyTextTween.tween_callback(startClippyTalking)
	clippyTextTween.tween_property(speechBubbleText, "visible_ratio", 1, len(speechBubbleText.text)*CLIPPY_TEXT_DELAY)
	clippyTextTween.tween_callback(stopClippyTalking)
	clippyTextTween.tween_interval(1)
	clippyTextTween.tween_callback(AudioManager.fadeOutComputerCleaningMusic)
	clippyTextTween.tween_interval(2)
	clippyTextTween.tween_callback(finish)

func finish():
	stopClippyTalking()
	AudioManager.computerCleaningMusicPlayer.stop()
	AudioManager.playSound(AudioManager.clippyLoggingOff, true).finished.connect(
		AudioManager.startComputerCleaningMusic
	)
	finished.emit()
	queue_free()
