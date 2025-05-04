class_name BedroomParser
extends InputParser

@export var bedroom: Bedroom

enum ActionID {
	INSPECT, MOVE_TO,
	TAKE, REPLACE, USE, OPEN, CLOSE, ENTER, WEAR,
	FOLD, PUT_AWAY, PULL_UP, MAKE,
	DRESS, CUT, LATHER, 
	SCATTER, FEED, TURN_ON, TURN_OFF,
	DECLUTTER,
	PUT, TURN,
	MAIN_MENU, ENDINGS, POOP, QUIT, AFFIRM, DENY
}

enum SubjectID {
	SELF,
	YARD_DOOR, BEDROOM, KITCHEN_DOOR, AMBIGUOUS_DOOR,
	LEGO_BED, AMBIGUOUS_BED, PILLOWS, SHEET, COMFORTER, CLOTHES,
	DRESSER, TOP_LEFT_DRAWER, TOP_RIGHT_DRAWER, MIDDLE_DRAWER, BOTTOM_DRAWER, AMBIGUOUS_TOP_DRAWER, AMBIGUOUS_DRAWER, STATS,
	LEGO_TABLE, ZOOMBA_TABLE, AMBIGUOUS_TABLE,
	SMOKEY, BEARD, HAIR, AXE, MACHETE, FIRE_EXTINGUISHER, HAT,
	ZOOMBA_BED, ZOOMBA_FOOD, MAT, ZOOMBA, PEPPER_FLAKES, FLINT_FLAKES, BREAD_CRUMBS, CHARCOAL_POWDER,
	COMPUTER_DESK, GAMING_CHAIR, CABLES, COMPUTER, 
	CTC_POSTER, MILK_POSTER, AMBIGUOUS_POSTER, FLOOR,
}

enum ModifierID {
	ON_BED, IN_DRESSER, ON_SMOKEY, ON_FLOOR,
	ON, OFF, BACK, AWAY,
}


func initParsableActions():
	addParsableAction(ActionID.ENDINGS,
			["endings", "view endings", "achievements", "view achievements", "help", "hints", "hint"])
	addParsableAction(ActionID.MAIN_MENU,
			["main menu", "menu", "main", "go to main menu", "go back to main menu", "return to main menu"])

	addParsableAction(ActionID.INSPECT, ["inspect", "look at", "look in", "look", "read", "view"])
	addParsableAction(ActionID.MOVE_TO, [])

	addParsableAction(ActionID.TAKE, [])
	addParsableAction(ActionID.REPLACE, [])
	addParsableAction(ActionID.USE, [])
	addParsableAction(ActionID.OPEN, [])
	addParsableAction(ActionID.CLOSE, [])
	addParsableAction(ActionID.ENTER, [])
	addParsableAction(ActionID.WEAR, [])

	addParsableAction(ActionID.FOLD, [])
	addParsableAction(ActionID.PUT_AWAY, [])
	addParsableAction(ActionID.PULL_UP, [])
	addParsableAction(ActionID.MAKE, [])

	addParsableAction(ActionID.DRESS, [])
	addParsableAction(ActionID.CUT, [])
	addParsableAction(ActionID.LATHER, [])

	addParsableAction(ActionID.SCATTER, [])
	addParsableAction(ActionID.FEED, [])
	addParsableAction(ActionID.TURN_ON, [])
	addParsableAction(ActionID.TURN_OFF, [])

	addParsableAction(ActionID.DECLUTTER, [])

	addParsableAction(ActionID.PUT, [])
	addParsableAction(ActionID.TURN, [])

	addParsableAction(ActionID.POOP, ["poop", "crap", "shit your pants", "shit"])
	addParsableAction(ActionID.QUIT, ["quit game", "quit", "exit game"])
	addParsableAction(ActionID.AFFIRM, ["affirmative", "yes please", "yes", "yup", "y"])
	addParsableAction(ActionID.DENY, ["negative", "nope", "no thank you", "no", "n"])


func initParsableSubjects():
	addParsableSubject(SubjectID.SELF, ["self", "yourself", "me", "myself", "you"],
		[ActionID.INSPECT])
	
	addParsableSubject(SubjectID.YARD_DOOR, [],
		[])
	addParsableSubject(SubjectID.BEDROOM, [],
		[])
	addParsableSubject(SubjectID.KITCHEN_DOOR, [],
		[])
	addParsableSubject(SubjectID.KITCHEN_DOOR, [],
		[])
	
	addParsableSubject(SubjectID.LEGO_BED, [],
		[])
	addParsableSubject(SubjectID.AMBIGUOUS_BED, [],
		[])
	addParsableSubject(SubjectID.PILLOWS, [],
		[])
	addParsableSubject(SubjectID.SHEET, [],
		[])
	addParsableSubject(SubjectID.COMFORTER, ["comforter", "duvet", "coverlet", "top sheet", "blanket"],
		[])
	addParsableSubject(SubjectID.CLOTHES, [],
		[])
	
	addParsableSubject(SubjectID.DRESSER, [],
		[])
	addParsableSubject(SubjectID.TOP_LEFT_DRAWER, [],
		[])
	addParsableSubject(SubjectID.TOP_RIGHT_DRAWER, [],
		[])
	addParsableSubject(SubjectID.MIDDLE_DRAWER, [],
		[])
	addParsableSubject(SubjectID.BOTTOM_DRAWER, [],
		[])
	addParsableSubject(SubjectID.AMBIGUOUS_TOP_DRAWER, [],
		[])
	addParsableSubject(SubjectID.AMBIGUOUS_DRAWER, [],
		[])
	addParsableSubject(SubjectID.STATS, [],
		[])
	
	addParsableSubject(SubjectID.LEGO_TABLE, [],
		[])
	addParsableSubject(SubjectID.ZOOMBA_TABLE, [],
		[])
	addParsableSubject(SubjectID.AMBIGUOUS_TABLE, [],
		[])
	
	addParsableSubject(SubjectID.SMOKEY, [],
		[])
	addParsableSubject(SubjectID.BEARD, [],
		[])
	addParsableSubject(SubjectID.HAIR, [],
		[])
	addParsableSubject(SubjectID.AXE, [],
		[])
	addParsableSubject(SubjectID.MACHETE, [],
		[])
	addParsableSubject(SubjectID.FIRE_EXTINGUISHER, [],
		[])
	addParsableSubject(SubjectID.HAT, [],
		[])
	
	addParsableSubject(SubjectID.ZOOMBA_BED, [],
		[])
	addParsableSubject(SubjectID.ZOOMBA_FOOD, [],
		[])
	addParsableSubject(SubjectID.MAT, [],
		[])
	addParsableSubject(SubjectID.ZOOMBA, [],
		[])
	addParsableSubject(SubjectID.PEPPER_FLAKES, [],
		[])
	addParsableSubject(SubjectID.FLINT_FLAKES, [],
		[])
	addParsableSubject(SubjectID.BREAD_CRUMBS, [],
		[])
	addParsableSubject(SubjectID.CHARCOAL_POWDER, [],
		[])
	
	addParsableSubject(SubjectID.COMPUTER_DESK, [],
		[])
	addParsableSubject(SubjectID.GAMING_CHAIR, [],
		[])
	addParsableSubject(SubjectID.CABLES, [],
		[])
	addParsableSubject(SubjectID.COMPUTER, [],
		[])
	
	addParsableSubject(SubjectID.CTC_POSTER, [],
		[])
	addParsableSubject(SubjectID.MILK_POSTER, [],
		[])
	addParsableSubject(SubjectID.AMBIGUOUS_POSTER, [],
		[])
	addParsableSubject(SubjectID.FLOOR, [],
		[])
	


func initParsableModifiers():
	addParsableModifier(ModifierID.ON_BED, [],
		[])
	addParsableModifier(ModifierID.IN_DRESSER, [],
		[])
	addParsableModifier(ModifierID.ON_SMOKEY, [],
		[])
	addParsableModifier(ModifierID.ON_FLOOR, [],
		[])
	
	addParsableModifier(ModifierID.ON, [],
		[])
	addParsableModifier(ModifierID.OFF, [],
		[])
	addParsableModifier(ModifierID.BACK, [],
		[])
	addParsableModifier(ModifierID.AWAY, [],
		[])
	


func parseItems() -> String:

	parseEventsSinceLastConfirmation += 1

	match actionID:

		ActionID.INSPECT:
			match subjectID:

				-1:
					if actionAlias == "look":
						return requestAdditionalSubjectContext("Where", [], [], ["at "])
					else:
						return requestAdditionalSubjectContext()


		ActionID.POOP:
			return (
				"Nice try, but this isn't that game."
			)

		ActionID.MAIN_MENU:
			if parseEventsSinceLastConfirmation <= 1 and confirmingActionID == ActionID.MAIN_MENU:
				SceneManager.transitionToScene(SceneManager.SceneID.MAIN_MENU)
			else:
				parseEventsSinceLastConfirmation = 0
				confirmingActionID = ActionID.MAIN_MENU
				return "Are you sure you want to return to the main menu?"

		ActionID.ENDINGS:
			SceneManager.openEndings(bedroom)
			return SceneManager.openEndingsScene.defaultStartingMessage

		ActionID.QUIT:
			if parseEventsSinceLastConfirmation <= 1 and confirmingActionID == ActionID.QUIT:
				get_tree().quit()
			else:
				parseEventsSinceLastConfirmation = 0
				confirmingActionID = ActionID.QUIT
				return (
					requestConfirmation() + " The endings and shortcuts you've unlocked will be saved, " +
					"but any progress in the current level will be lost."
				)
	
		ActionID.AFFIRM:
			if parseEventsSinceLastConfirmation <= 1:
				match confirmingActionID:

					ActionID.MAIN_MENU:
						SceneManager.transitionToScene(SceneManager.SceneID.MAIN_MENU)
					ActionID.QUIT:
						get_tree().quit()

			else:
				return (
					"It's not clear what you want to say yes to..."
				)

		ActionID.DENY:
			if parseEventsSinceLastConfirmation <= 1:
				return (
					"Okie-dokie artichokie! If you change your mind, just ask again."
				)
			else:
				return (
					"It's not clear what you want to say no to..."
				)

	return unknownParse()