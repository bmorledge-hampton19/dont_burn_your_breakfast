class_name Terminal
extends ColorRect

@export var terminalLines: Array[Label]
@export var inputText: InputText
@export var lineCount = 4
@export var lineCharacterMax := 30

signal sendInputForParsing(input: String)

var timeSinceLastUpdate: float
var nextUpdateThreshold: float
var preparingPause: bool = false

var currentMessage: String
var remainingMessage: String

var currentMessageChunk: String
var currentMessageChunkIndex: int

var fastUpdateThreshold = 0.05
var slowUpdateThreshold = 0.4
var newlineUpdateThreshold = 2


func setFontSpeed():
	match Options.fontSpeed:

		Options.FontSpeed.SLOW:
			fastUpdateThreshold = 0.1
			slowUpdateThreshold = 0.8
			newlineUpdateThreshold = 4
		
		Options.FontSpeed.MEDIUM:
			fastUpdateThreshold = 0.05
			slowUpdateThreshold = 0.4
			newlineUpdateThreshold = 2
		
		Options.FontSpeed.FAST:
			fastUpdateThreshold = 0.025
			slowUpdateThreshold = 0.2
			newlineUpdateThreshold = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	inputText.sendInput.connect(receiveInput)
	setFontSpeed()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if currentMessageChunk: timeSinceLastUpdate += delta
	if timeSinceLastUpdate > nextUpdateThreshold:
		timeSinceLastUpdate = 0
		nextUpdateThreshold = fastUpdateThreshold
		if currentMessageChunkIndex == 0: scrollTerminalLines()
		var currentChar := currentMessageChunk[currentMessageChunkIndex]
		if currentChar == '\n':
			nextUpdateThreshold = newlineUpdateThreshold
			preparingPause = false
		else:
			terminalLines[lineCount-1].text += currentMessageChunk[currentMessageChunkIndex]
		currentMessageChunkIndex += 1

		if currentChar in [',', '.', '!', '?', ':', ';']: preparingPause = true
		if preparingPause and (currentChar == ' ' or currentMessageChunkIndex == currentMessageChunk.length()):
				nextUpdateThreshold = slowUpdateThreshold
				preparingPause = false

		if currentMessageChunkIndex == currentMessageChunk.length(): getNextMessageChunk()


func getNextMessageChunk():

	currentMessageChunkIndex = 0
	var nextNewlineIndex = remainingMessage.find('\n')

	if not remainingMessage:
		currentMessageChunk = ""

	elif nextNewlineIndex != -1 and nextNewlineIndex <= lineCharacterMax:
		currentMessageChunk = remainingMessage.substr(0, nextNewlineIndex+1)
		remainingMessage = remainingMessage.substr(nextNewlineIndex+1)

	elif remainingMessage.length() <= lineCharacterMax:
		currentMessageChunk = remainingMessage
		remainingMessage = ""
	
	else:
		var acceptableSpaceIndex := lineCharacterMax
		var overflowOffset := 0
		var nextSpaceIndex := remainingMessage.find(' ')
		while nextSpaceIndex <= lineCharacterMax and nextSpaceIndex != -1:
			acceptableSpaceIndex = nextSpaceIndex
			overflowOffset = 1
			nextSpaceIndex = remainingMessage.find(' ', nextSpaceIndex+1)
		
		currentMessageChunk = remainingMessage.substr(0, acceptableSpaceIndex)
		remainingMessage = remainingMessage.substr(acceptableSpaceIndex+overflowOffset)


func scrollTerminalLines():
	for i in range(lineCount-1):
		terminalLines[i].text = terminalLines[i+1].text
	terminalLines[lineCount-1].text = ""

func receiveInput(input: String):
	if currentMessageChunk: fastTrackCurrentMessage()
	scrollTerminalLines()
	terminalLines[lineCount-1].text = "> " + input
	sendInputForParsing.emit(input)


func initMessage(message: String):
	currentMessage = message
	remainingMessage = message
	timeSinceLastUpdate = 0
	nextUpdateThreshold = fastUpdateThreshold
	getNextMessageChunk()


func fastTrackCurrentMessage():
	if currentMessageChunkIndex == 0: scrollTerminalLines()
	terminalLines[lineCount-1].text = currentMessageChunk
	while remainingMessage:
		getNextMessageChunk()
		scrollTerminalLines()
		terminalLines[lineCount-1].text = currentMessageChunk
	currentMessageChunk = ""
