class_name FarewellClippy extends Control

const CLIPPY_TEXT_DELAY = 0.03

@export var clippy: TextureRect
@export var speechBubble: Panel
@export var speechBubbleText: Label


func _ready():
	clippy.scale = Vector2.ZERO
	speechBubble.scale = Vector2.ZERO
	speechBubbleText.visible_characters = 0

func summonClippy():
	var tween = create_tween()
	tween.tween_interval(1)
	tween.tween_property(clippy, "scale", Vector2.ONE, 2).set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)
	tween.tween_property(speechBubble, "scale", Vector2(0.5, 0.5), 1).set_trans(Tween.TRANS_CUBIC)
	tween.tween_interval(1)
	tween.tween_callback(displayFirstClippyMessage)

func displayFirstClippyMessage():
	speechBubbleText.text = (
		"Nice work! This desktop is looking mighty fine!\n        \n" +
		"And the cows are loving it!"
	)
	speechBubbleText.visible_ratio = 0
	var clippyTextTween = create_tween()
	clippyTextTween.tween_property(speechBubbleText, "visible_ratio", 1, len(speechBubbleText.text)*CLIPPY_TEXT_DELAY)
	clippyTextTween.tween_interval(10)
	clippyTextTween.tween_callback(displaySecondClippyMessage)

func displaySecondClippyMessage():
	speechBubbleText.text = (
		"Ok... You can leave now.\n\n\n" +
		"Bye."
	)
	speechBubbleText.visible_ratio = 0
	var clippyTextTween = create_tween()
	clippyTextTween.tween_property(speechBubbleText, "visible_characters", 6, 6*CLIPPY_TEXT_DELAY*10)
	clippyTextTween.tween_interval(1)
	clippyTextTween.tween_property(speechBubbleText, "visible_characters", 25, 20*CLIPPY_TEXT_DELAY)
	clippyTextTween.tween_interval(5)
	clippyTextTween.tween_property(speechBubbleText, "visible_ratio", 1, 2*CLIPPY_TEXT_DELAY)
