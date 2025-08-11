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
var fractionalCerealCoinNumber: float

var currentLevelEndingPreviews: Array[EndingPreview] = []

var viewingEnding = false
var viewingEndingID: int

var confirmingHintType: int
var confirmingHintCost: int


func _init():
	defaultStartingMessage = (
		"Behold: Your greatest failures! (so far)\n" +
		"Here you can view any endings you've unlocked and buy hints to help you figure out " +
		"how to unlock more or avoid the ones you've already discovered. " +
		"To get started, use the command \"view ending\" followed by the number of the ending you wish to view. " +
		"You can also use the commands \"next\" and \"previous\" to view the endings for other levels you've visited."
	)

func _ready():
	fractionalCerealCoinNumber = EndingsManager.getCerealCoins()
	cerealCoinCounter.text = str(visualCerealCoinNumber)
	changeLevel(SceneManager.SceneID.MAIN_MENU)


func initFromExistingTerminal(existingTerminal):
	terminal = existingTerminal
	inputParser.connectTerminal(existingTerminal)

func _process(delta):
	

	if visualCerealCoinNumber > EndingsManager.getCerealCoins():
		cerealCoinCounter.add_theme_color_override("font_color", Color.DARK_RED)
		fractionalCerealCoinNumber = lerp(fractionalCerealCoinNumber, EndingsManager.getCerealCoins()*0.95, delta*1.5)
		if fractionalCerealCoinNumber < EndingsManager.getCerealCoins(): fractionalCerealCoinNumber = EndingsManager.getCerealCoins()
		visualCerealCoinNumber = ceili(fractionalCerealCoinNumber)
	elif visualCerealCoinNumber < EndingsManager.getCerealCoins():
		cerealCoinCounter.add_theme_color_override("font_color", Color.ROYAL_BLUE)
		fractionalCerealCoinNumber = lerp(fractionalCerealCoinNumber, EndingsManager.getCerealCoins()*1.1, delta*1.5)
		if fractionalCerealCoinNumber > EndingsManager.getCerealCoins(): fractionalCerealCoinNumber = EndingsManager.getCerealCoins()
		visualCerealCoinNumber = floori(fractionalCerealCoinNumber)
	else:
		cerealCoinCounter.add_theme_color_override("font_color", Color.WHITE)

	cerealCoinCounter.text = str(visualCerealCoinNumber)


func getBackgroundTexture() -> Texture2D:

	var customBackgroundPath: String = (
		"res://sprites/backgrounds/previews/" + SceneManager.SceneID.find_key(currentLevel).to_lower() + "_preview.png"
	)

	if FileAccess.file_exists(customBackgroundPath): return load(customBackgroundPath)
	else: return load("res://sprites/backgrounds/" + SceneManager.SceneID.find_key(currentLevel).to_lower() + ".png")


func changeLevel(sceneID: SceneManager.SceneID):

	currentLevel = sceneID

	background.texture = getBackgroundTexture()

	if currentLevel == SceneManager.SceneID.MAIN_MENU or currentLevel == SceneManager.SceneID.ENDING: hideShortcut()
	else: showShortcut()

	if currentLevel == SceneManager.SceneID.ENDING: titleText.text = "Bonus!!"
	else: titleText.text = SceneManager.SceneID.keys()[sceneID].capitalize()

	for endingPreview in currentLevelEndingPreviews: endingPreview.queue_free()
	currentLevelEndingPreviews.clear()
	for endingID: SceneManager.EndingID in SceneManager.endingsByScene[currentLevel]:
		currentLevelEndingPreviews.append(endingPreviewScene.instantiate())
		currentLevelEndingPreviews[-1].initEnding(endingID, currentLevelEndingPreviews.size())
		endingsGrid.add_child(currentLevelEndingPreviews[-1])
	
	if sceneID == SceneManager.SceneID.MAIN_MENU: prevText.hide()
	else: prevText.show()

	if sceneID == SceneManager.SceneID.ENDING: nextText.hide()
	else: nextText.show()


func hideShortcut():
	shortcutText.hide()
	lockedSprite.hide()
	unlockedSprite.hide()

func showShortcut():
	shortcutText.show()
	if EndingsManager.isSceneShortcutUnlocked(currentLevel):
		unlockedSprite.show()
		lockedSprite.hide()
	else:
		unlockedSprite.hide()
		lockedSprite.show()

func collectCoins() -> int:
	var coinsBeforeCollection := EndingsManager.getCerealCoins()
	for endingPreview in currentLevelEndingPreviews:
		var wereCoinsCollected: bool
		if (EndingsManager.isEndingUnlocked(endingPreview.endingID) and
			not EndingsManager.haveCoinsBeenCollected(endingPreview.endingID)):
			endingPreview.collectCoins()
			wereCoinsCollected = true
		if wereCoinsCollected and EndingsManager.areAllCoinsCollected(): EndingsManager.maximizeCerealCoins()
	return EndingsManager.getCerealCoins() - coinsBeforeCollection


func viewEnding(endingPreviewIndex):
	viewingEnding = true
	grayFilter.hide()
	hideShortcut()
	titleText.hide()
	endingsGrid.hide()
	prevText.hide()
	nextText.hide()

	cerealCoinCounter.add_theme_constant_override("outline_size", 8)

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
	if currentLevel != SceneManager.SceneID.MAIN_MENU and currentLevel != SceneManager.SceneID.ENDING: showShortcut()
	titleText.show()
	endingsGrid.show()
	if currentLevel == SceneManager.SceneID.MAIN_MENU: prevText.hide()
	else: prevText.show()
	if currentLevel == SceneManager.SceneID.ENDING: nextText.hide()
	else: nextText.show()

	cerealCoinCounter.add_theme_constant_override("outline_size", 0)

	background.texture = getBackgroundTexture()

