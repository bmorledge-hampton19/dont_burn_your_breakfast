class_name TaskbarItem extends TextureRect

const TASKBAR_WIDTH = 160.0

enum IconType {INFO, RESOURCE_MONITOR, CAT_PIC, SPREADHSEET}

const INFO_ICON = preload("res://sprites/computer_cleaning/info_icon.png")
const INFO_ICON_SIZE = Vector2(40, 40)
const INFO_ICON_POS = Vector2(-4.545, -7.545)

const RESOURCE_MONITOR_ICON = preload("res://sprites/computer_cleaning/my_computer.png")
const RESOURCE_MONITOR_ICON_SIZE = Vector2(24, 24)
const RESOURCE_MONITOR_ICON_POS = Vector2(3.424, -1.485)

const CAT_PIC_ICON = preload("res://sprites/computer_cleaning/polite_cat.png")
const CAT_PIC_ICON_SIZE = Vector2(22, 22)
const CAT_PIC_ICON_POS = Vector2(3.03, 1.545)

const SPREADSHEET_ICON = preload("res://sprites/computer_cleaning/old_excel_logo.png")
const SPREADSHEET_ICON_SIZE = Vector2(18, 18)
const SPREADSHEET_ICON_POS = Vector2(4.545, 3.061)

@export var icon: TextureRect
@export var label: Label

var leftNeighbor: TaskbarItem
var rightNeighbor: TaskbarItem

func _ready():
	pass

func init(iconType: IconType, text: String, p_leftNeighbor: TaskbarItem = null):
	match iconType:
		IconType.INFO:
			icon.texture = INFO_ICON
			icon.size = INFO_ICON_SIZE
			icon.position = INFO_ICON_POS

		IconType.RESOURCE_MONITOR:
			icon.texture = RESOURCE_MONITOR_ICON
			icon.size = RESOURCE_MONITOR_ICON_SIZE
			icon.position = RESOURCE_MONITOR_ICON_POS

		IconType.CAT_PIC:
			icon.texture = CAT_PIC_ICON
			icon.size = CAT_PIC_ICON_SIZE
			icon.position = CAT_PIC_ICON_POS

		IconType.SPREADHSEET:
			icon.texture = SPREADSHEET_ICON
			icon.size = SPREADSHEET_ICON_SIZE
			icon.position = SPREADSHEET_ICON_POS

	label.text = text

	if p_leftNeighbor:
		leftNeighbor = p_leftNeighbor
		leftNeighbor.rightNeighbor = self
		position.x = leftNeighbor.position.x + TASKBAR_WIDTH

func manualProcess(delta: float):

	var leftBoundary: float
	if leftNeighbor: leftBoundary = leftNeighbor.position.x + TASKBAR_WIDTH

	if position.x > leftBoundary:
		var distanceToMove = lerp(0.0, position.x - leftBoundary + 10.0, delta*5.0)
		if position.x - distanceToMove < leftBoundary: distanceToMove = position.x - leftBoundary
		propogateMovement(distanceToMove)

func propogateMovement(distance: float):
	position.x -= distance
	if rightNeighbor: rightNeighbor.propogateMovement(distance)

func destroy():
	if leftNeighbor: leftNeighbor.rightNeighbor = rightNeighbor
	if rightNeighbor: rightNeighbor.leftNeighbor = leftNeighbor
	queue_free()
