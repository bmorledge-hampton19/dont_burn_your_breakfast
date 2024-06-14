extends ColorRect

var isCaretVisible := true

func toggleCarat():
	if isCaretVisible:
		isCaretVisible = false
		color = Color.TRANSPARENT
	else:
		isCaretVisible = true
		color = Color.WHITE
