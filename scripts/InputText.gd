class_name InputText
extends Label

@export var caretContainer: Container

signal sendInput(input: String)

var caretPosition := 0
var caretIncrement := 24

var previousInputs: Array[String]
var currentInputs: Array[String] = [""]
var currentInputsIndex := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _unhandled_key_input(event: InputEvent):

	var keyEvent := event as InputEventKey

	if keyEvent and keyEvent.pressed:
	
		var keyAsChar := char(keyEvent.unicode)
	
		if keyEvent.keycode == KEY_BACKSPACE:
			attemptRemoveCharacter()

		elif keyEvent.keycode == KEY_ENTER and text.strip_edges() != "":
			sendInput.emit(text.strip_edges())
			updateStoredInputs()
			text = ""
			caretPosition = 0

		elif keyEvent.keycode == KEY_LEFT and caretPosition > 0:
			caretPosition -= 1

		elif keyEvent.keycode == KEY_RIGHT and caretPosition < text.length():
			caretPosition += 1

		elif keyEvent.keycode == KEY_UP and currentInputsIndex > 0:
			currentInputs[currentInputsIndex] = text
			currentInputsIndex -= 1
			text = currentInputs[currentInputsIndex]
			caretPosition = text.length()

		elif keyEvent.keycode == KEY_DOWN and currentInputsIndex < previousInputs.size():
			currentInputs[currentInputsIndex] = text
			currentInputsIndex += 1
			text = currentInputs[currentInputsIndex]
			caretPosition = text.length()

		elif keyAsChar: attemptAddCharacter(keyAsChar)

		repositionCaret()


func repositionCaret():
	caretContainer.position.x = (caretPosition+2)*caretIncrement

func updateStoredInputs():
	if previousInputs.size() == 10: previousInputs.pop_front()
	previousInputs.append(text.strip_edges())
	currentInputs = previousInputs.duplicate()
	currentInputs.append("")
	currentInputsIndex = currentInputs.size()-1


func attemptRemoveCharacter():
	if caretPosition > 0:
		caretPosition -= 1
		text = text.erase(caretPosition)


func attemptAddCharacter(newChar: String):
	if text.length() < 27:
		text = text.insert(caretPosition, newChar)
		caretPosition += 1
	print(text)
