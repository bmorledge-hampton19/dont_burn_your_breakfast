class_name Help
extends Scene

@export var pages: Array[VBoxContainer]
var currentPage = 1
@export var peepingQuaker: TextureRect

func _init():
	var sid := SceneManager.SceneID
	sceneTransitions = [sid.MAIN_MENU]
	defaultStartingMessage = (
		"Welcome to the tutorial! Here, you'll learn everything you need to know to become a champion of breakfasts!"
	)

func _ready():
	super()

func _getCurrentPage():
	return pages[currentPage-1]

func goToNextPage():
	_getCurrentPage().hide()
	if currentPage == 5: peepingQuaker.hide()
	currentPage += 1
	assert(currentPage != 8, "Can't proceed to next page. Already at final page.")
	_getCurrentPage().show()
	if currentPage == 5: peepingQuaker.show()
	if currentPage != 6: AudioManager.playSound(AudioManager.goodTextInput, true)

func goToPreviousPage():
	_getCurrentPage().hide()
	if currentPage == 5: peepingQuaker.hide()
	currentPage -= 1
	assert(currentPage != 0, "Can't return to previous page. Already at first page.")
	_getCurrentPage().show()
	if currentPage == 5: peepingQuaker.show()
