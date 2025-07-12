class_name HelpParser
extends InputParser

@export var help: Help

enum ActionID {
	INSPECT,
	GO_TO, PROCEED, RETURN,
	MAIN_MENU, ENDINGS, POOP, QUIT, AFFIRM, DENY
}

enum SubjectID {
	NEXT_PAGE, PREVIOUS_PAGE, QUAKER_MAN, RULE, TERMINAL
}

enum ModifierID {
	BRAVELY, WITH_OATS
}


func initParsableActions():
	addParsableAction(ActionID.ENDINGS,
			["endings", "view endings", "achievements", "view achievements", "help", "hints", "hint"])
	addParsableAction(ActionID.INSPECT, ["inspect", "look at", "look in", "look", "read", "view"])
	addParsableAction(ActionID.QUIT, ["quit game", "quit the game", "quit", "exit game", "exit the game"])
	addParsableAction(ActionID.MAIN_MENU,
			["main menu", "menu", "main", "go to the main menu","go to main menu", "go back to the main menu",
			"go back to main menu", "return to the main menu", "return to main menu",
			"exit tutorial", "exit help", "exit", "go back", "back"])
	addParsableAction(ActionID.GO_TO, ["go to", "go on to", "move to", "move on to", "proceed to", "return to"])
	addParsableAction(ActionID.PROCEED, ["proceed", "next page", "next"])
	addParsableAction(ActionID.RETURN, ["return", "previous page", "previous", "prev", "last page", "last"])
	addParsableAction(ActionID.POOP, ["poop", "crap", "shit your pants", "shit"])
	addParsableAction(ActionID.AFFIRM, ["affirmative", "yes please", "yes", "yup", "y"])
	addParsableAction(ActionID.DENY, ["negative", "nope", "no thank you", "no", "n"])


func initParsableSubjects():
	addParsableSubject(SubjectID.NEXT_PAGE, ["next page", "next"],
			[ActionID.GO_TO])
	addParsableSubject(SubjectID.PREVIOUS_PAGE, ["previous page", "previous", "last page", "page"],
			[ActionID.GO_TO])
	addParsableSubject(SubjectID.QUAKER_MAN,
			["man", "guy", "corner", "top right corner", "top-right corner", "quaker man", "quaker mascot", "quaker"],
			[ActionID.INSPECT])
	addParsableSubject(SubjectID.RULE, ["rules", "rule", "text", "how to play", "title"],
			[ActionID.INSPECT])
	addParsableSubject(SubjectID.TERMINAL, ["terminal", "typing area", "console", "bottom of screen", "bottom", "command prompt"],
			[ActionID.INSPECT])


func initParsableModifiers():
	addParsableModifier(ModifierID.BRAVELY, ["bravely"],
			[ActionID.PROCEED, ActionID.RETURN, ActionID.GO_TO])
	addParsableModifier(ModifierID.WITH_OATS, ["with oats"],
			[ActionID.PROCEED, ActionID.RETURN, ActionID.GO_TO])


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
				SubjectID.QUAKER_MAN:
					if help.currentPage == 5:
						return (
							"It seems the Quaker mascot has come to offer you some advice. " +
							"He whispers surreptitiously into your ear: \"Don't forget about your oats. " +
							"You can never have too many oats. Try proceeding 'with oats' this time.\" ;)"
						)
					else: return wrongContextParse()
				SubjectID.RULE:
					return "These rules are very important! Are you paying attention?"
				SubjectID.TERMINAL:
					return "Using the terminal makes you feel like a cool hacker from a 90s action movie."


		ActionID.PROCEED:
			return changePage(modifierID)


		ActionID.RETURN:
			return changePage(modifierID, true)


		ActionID.GO_TO:
			match subjectID:
				-1:
					return requestAdditionalSubjectContext("Where", [], [], ["to "])
				SubjectID.NEXT_PAGE:
					return changePage(modifierID)
				SubjectID.PREVIOUS_PAGE:
					return changePage(modifierID, false)


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
			SceneManager.openEndings(help)
			return SceneManager.openEndingsScene.defaultStartingMessage

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


func changePage(pageChangeModifierID: int, goingBackwards: bool = false) -> String:

	if goingBackwards:
		if help.currentPage == 1:
			return "You're already at the first page. You can't go back anymore."
		else:
			help.goToPreviousPage()
			return "You return to the previous page."
	
	else:
		match help.currentPage:

			1:
				help.goToNextPage()
				return "You proceed to the next page."
			2:
				help.goToNextPage()
				return (
					"You proceed to the next page. Also, this message is" +
					"\nreally\nreally\nreally\nreally\nreally\nreally\n" +
					"long, and you might miss some of the important bits from the beginning if you're not paying attention."
				)
			3:
				help.goToNextPage()
				return (
					"You proceed to the next page, but this tutorial is starting to sap your courage. " +
					"You're not sure how much further you'll be able to make it..."
				)
			4:
				if pageChangeModifierID == ModifierID.BRAVELY:
					help.goToNextPage()
					return (
						"You take a deep breath and steel yourself for the next page. You can do this!"
					)
				else:
					return (
						"You try to go on to the next page but find yourself doubting whether or not you're cut out " +
						"for this... Maybe if you try to \"proceed bravely\" you'll be able to move on."
					)
			5:
				if pageChangeModifierID == ModifierID.WITH_OATS:
					help.goToNextPage()
					return (
						"Aha! Your oats! You'd almost forgotten! You reach into your back pocket and fish out a handful of " +
						"instant oats. You shovel them into your mouth and chew hungrily. Delicious! Now you're ready to " +
						"move on for sure."
					)
				else:
					return (
						"Just when you're about to move to the next page, you feel a distinct sense that you're forgetting " +
						"something... Maybe that \"man\" in the corner knows what it is?"
					)
			6:
				help.goToNextPage()
				return "Don't forget to check the endings screen for hints if you ever get stuck!"
			7:
				return "You're already at the last page. You can't proceed any further."

	return unknownParse()
			
