extends ColorRect

@export var terminalLines: Array[Label]
@export var inputText: InputText

var timeSinceLastUpdate: float
var nextUpdateThreshold: float
var preparingPause: bool = false

var currentMessage: String
var remainingMessage: String

var currentMessageChunk: String
var currentMessageChunkIndex: int

var lineCharacterMax := 30
var fastUpdateThreshold = 0.02
var slowUpdateThreshold = 0.2

# Called when the node enters the scene tree for the first time.
func _ready():
	inputText.sendInput.connect(parseInput)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if currentMessageChunk: timeSinceLastUpdate += delta
	if timeSinceLastUpdate > nextUpdateThreshold:
		timeSinceLastUpdate = 0
		nextUpdateThreshold = fastUpdateThreshold
		if currentMessageChunkIndex == 0: scrollTerminalLines()
		var currentChar := currentMessageChunk[currentMessageChunkIndex]
		terminalLines[3].text += currentMessageChunk[currentMessageChunkIndex]
		currentMessageChunkIndex += 1
		if currentChar in [',', '.', '!', '?', ':']: preparingPause = true
		if preparingPause and (currentChar == ' ' or currentMessageChunkIndex == currentMessageChunk.length()):
				nextUpdateThreshold = slowUpdateThreshold
				preparingPause = false
		if currentMessageChunkIndex == currentMessageChunk.length(): getNextMessageChunk()


func getNextMessageChunk():

	print("Getting next message chunk from \"", remainingMessage, "\"...")

	currentMessageChunkIndex = 0

	if not remainingMessage:
		currentMessageChunk = ""

	elif remainingMessage.length() <= lineCharacterMax:
		currentMessageChunk = remainingMessage
		remainingMessage = ""
	
	else:
		var acceptableSpaceIndex: int
		var nextSpaceIndex := remainingMessage.find(' ')
		while nextSpaceIndex <= lineCharacterMax and nextSpaceIndex != -1:
			acceptableSpaceIndex = nextSpaceIndex
			nextSpaceIndex = remainingMessage.find(' ', nextSpaceIndex+1)
		
		currentMessageChunk = remainingMessage.substr(0, acceptableSpaceIndex)
		remainingMessage = remainingMessage.substr(acceptableSpaceIndex+1)


func scrollTerminalLines():
	for i in range(3):
		terminalLines[i].text = terminalLines[i+1].text
	terminalLines[3].text = ""

func parseInput(input: String):

	if currentMessageChunk: fastTrackCurrentMessage()
	scrollTerminalLines()
	terminalLines[3].text = "> " + input
	# Actually parse input here.
	# Display new message here.
	# The following is a placeholder
	initMessage("You entered the following text: " + input)


func initMessage(message: String):
	currentMessage = message
	remainingMessage = message
	getNextMessageChunk()



func fastTrackCurrentMessage():
	terminalLines[3].text = currentMessageChunk
	while remainingMessage:
		getNextMessageChunk()
		scrollTerminalLines()
		terminalLines[3].text = currentMessageChunk
