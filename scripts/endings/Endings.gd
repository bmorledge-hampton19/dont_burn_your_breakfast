class_name Endings
extends Scene

@export var background: TextureRect
@export var grayFilter: ColorRect
@export var lockedEnding: ColorRect

@export var shortcutText: Label
@export var lockedSprite: Sprite2D
@export var unlockedSprite: Sprite2D

@export var titleText: Label

@export var cerealCoinCounter: Label

@export var endingsGrid: GridContainer
@export var endingPreviewScene: PackedScene

@export var prevText: Label
@export var nextText: Label

var currentLevel := SceneManager.SceneID.MAIN_MENU

var visualCerealCoinNumber: int
var timeSinceLastCerealCoinUpdate: float = 0

var currentLevelEndingPreviews: Array[EndingPreview] = []

var viewingEnding = false
var viewingEndingID: int

var confirmingHintType: int
var confirmingHintCost: int


func _init():
	var sid := SceneManager.SceneID
	sceneTransitions = [sid.MAIN_MENU]
	defaultStartingMessage = (
		"Behold: Your greatest failures! (so far)\n" +
		"Here you can view any endings you've unlocked and buy hints to help you figure out " +
		"how to unlock more or avoid the ones you've already discovered. " +
		"To get started, use the command \"view ending\" followed by the number of the ending you wish to view. " +
		"You can also use the commands \"next\" and \"previous\" to view the endings for other levels you've visited."
	)

func _ready():
	super()
	visualCerealCoinNumber = EndingsManager.getCerealCoins()
	cerealCoinCounter.text = str(visualCerealCoinNumber)
	changeLevel(SceneManager.SceneID.MAIN_MENU)


func _process(delta):
	timeSinceLastCerealCoinUpdate += delta
	if timeSinceLastCerealCoinUpdate > 0.5:

		if visualCerealCoinNumber > EndingsManager.getCerealCoins():
			timeSinceLastCerealCoinUpdate = 0
			visualCerealCoinNumber -= 1
			cerealCoinCounter.text = str(visualCerealCoinNumber)
			cerealCoinCounter.add_theme_color_override("font_color", Color.DARK_RED)
		elif visualCerealCoinNumber < EndingsManager.getCerealCoins():
			timeSinceLastCerealCoinUpdate = 0
			visualCerealCoinNumber += 1
			cerealCoinCounter.text = str(visualCerealCoinNumber)
			cerealCoinCounter.add_theme_color_override("font_color", Color.ROYAL_BLUE)
		else: cerealCoinCounter.add_theme_color_override("font_color", Color.WHITE)


func changeLevel(sceneID: SceneManager.SceneID):

	currentLevel = sceneID

	background.texture = load("res://sprites/backgrounds/" + SceneManager.SceneID.find_key(sceneID).to_lower() + ".png")

	if currentLevel == SceneManager.SceneID.MAIN_MENU: hideShortcut()
	else: showShortcut()

	titleText.text = SceneManager.SceneID.keys()[sceneID].capitalize()

	for endingPreview in currentLevelEndingPreviews: endingPreview.queue_free()
	currentLevelEndingPreviews.clear()
	for endingID: SceneManager.EndingID in SceneManager.endingsByScene[currentLevel]:
		currentLevelEndingPreviews.append(endingPreviewScene.instantiate())
		currentLevelEndingPreviews[-1].initEnding(endingID, currentLevelEndingPreviews.size())
		endingsGrid.add_child(currentLevelEndingPreviews[-1])
	
	if sceneID == SceneManager.SceneID.MAIN_MENU: prevText.hide()
	else: prevText.show()

	if sceneID == SceneManager.SceneID.BATHROOM: nextText.hide()
	else: nextText.show()


func hideShortcut():
	shortcutText.hide()
	lockedSprite.hide()
	unlockedSprite.hide()

func showShortcut():
	shortcutText.show()
	if EndingsManager.isSceneShortcutUnlocked(currentLevel): unlockedSprite.show()
	else: lockedSprite.show()

func collectCoins() -> int:
	var coinsBeforeCollection := EndingsManager.getCerealCoins()
	for endingPreview in currentLevelEndingPreviews:
		if (EndingsManager.isEndingUnlocked(endingPreview.endingID) and
			not EndingsManager.haveCoinsBeenCollected(endingPreview.endingID)):
			endingPreview.collectCoins()
	return EndingsManager.getCerealCoins() - coinsBeforeCollection


func viewEnding(endingPreviewIndex):
	viewingEnding = true
	grayFilter.hide()
	hideShortcut()
	titleText.hide()
	endingsGrid.hide()
	prevText.hide()
	nextText.hide()

	viewingEndingID = currentLevelEndingPreviews[endingPreviewIndex].endingID
	if EndingsManager.isEndingUnlocked(viewingEndingID):
		if not EndingsManager.haveCoinsBeenCollected(viewingEndingID):
			currentLevelEndingPreviews[endingPreviewIndex].collectCoins()
		var endingName: String = SceneManager.EndingID.find_key(viewingEndingID).to_lower()
		background.texture = load("res://sprites/endings/" + str(viewingEndingID) + "-" + endingName + ".png")
	else: lockedEnding.show()

func returnFromEnding():

	viewingEnding = false
	grayFilter.show()
	lockedEnding.hide()
	if currentLevel != SceneManager.SceneID.MAIN_MENU: showShortcut()
	titleText.show()
	endingsGrid.show()
	if currentLevel == SceneManager.SceneID.MAIN_MENU: prevText.hide()
	else: prevText.show()
	if currentLevel == SceneManager.SceneID.BATHROOM: nextText.hide()
	else: nextText.show()

	background.texture = load("res://sprites/backgrounds/" + SceneManager.SceneID.find_key(currentLevel).to_lower() + ".png")

