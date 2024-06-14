class_name FrontYardParser
extends InputParser

@export var frontYard: FrontYard

enum ActionID {
	INSPECT,

	MAIN_MENU, POOP, QUIT, AFFIRM, DENY
}

enum SubjectID {
	SELF,
}

enum ModifierID {
	
}


func initParsableActions():
	addParsableAction(ActionID.INSPECT, ["inspect", "look at", "look in", "look", "read", "view"])
	addParsableAction(ActionID.MAIN_MENU,
			["main menu", "menu", "go to the main menu","go to main menu", "go back to the main menu", "go back to main menu",
			"return to the main menu", "return to main menu"])
	addParsableAction(ActionID.POOP, ["poop", "crap", "shit your pants", "shit"])
	addParsableAction(ActionID.QUIT, ["quit game", "quit the game", "quit", "exit game", "exit the game"])
	addParsableAction(ActionID.AFFIRM, ["affirmative", "yes please", "yes", "yup", "y"])
	addParsableAction(ActionID.DENY, ["negative", "nope", "no thank you", "no", "n"])


func initParsableSubjects():
	addParsableSubject(SubjectID.SELF, ["self", "yourself", "me", "you"],
			[ActionID.INSPECT])


func initParsableModifiers():
	pass


func parseItems(actionID: int, subjectID: int, modifierID: int) -> String:

	previousActionID = actionID
	previousSubjectID = subjectID
	previousModifierID = modifierID

	parseEventsSinceLastConfirmation += 1

	match actionID:

		ActionID.INSPECT:
			match subjectID:

				-1:
					if actionAlias == "look":
						return requestAdditionalSubjectContext("Where")
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

		ActionID.QUIT:
			if parseEventsSinceLastConfirmation <= 1 and confirmingActionID == ActionID.QUIT:
				get_tree().quit()
			else:
				parseEventsSinceLastConfirmation = 0
				confirmingActionID = ActionID.QUIT
				return requestConfirmation()
	
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