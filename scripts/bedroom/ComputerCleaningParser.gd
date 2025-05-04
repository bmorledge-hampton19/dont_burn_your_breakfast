class_name ComputerCleaningParser
extends InputParser

@export var scene: Scene

enum ActionID {
	INSPECT,
	SPEED_UP, SLOW_DOWN, SKIP, CLOSE, OPEN, EXECUTE, FEED,
	MAIN_MENU, ENDINGS, POOP, QUIT, AFFIRM, DENY,
	EXIT_COMPUTER, END,
}

enum SubjectID {
	SELF,
	DESKTOP,
	AMBIGUOUS_WINDOW,
	INFO_WINDOW, CLIPPY,
	RESOURCE_MONITOR, CPU, RAM, HEAT,
	CAT_WINDOW,
	EXCEL_WINDOW,
	MASSIVE_MOUSE_MAMA, MASSIVE_MOUSE, MOUSE_MAMA, MOUSE, MAMA, ANTIMATTER_CHEESE,
	BACKGROUND, TIME, END_BUTTON
}

enum ModifierID {
	
}


func initParsableActions():
	addParsableAction(ActionID.ENDINGS,
			["endings", "view endings", "achievements", "view achievements", "help", "hints", "hint"])
	addParsableAction(ActionID.INSPECT, ["inspect", "look at", "look in", "look", "read", "view"])
	addParsableAction(ActionID.MAIN_MENU,
			["main menu", "menu", "main", "go to main menu", "go back to main menu", "return to main menu"])
	addParsableAction(ActionID.POOP, ["poop", "crap", "shit your pants", "shit"])
	addParsableAction(ActionID.QUIT, ["quit game", "quit", "exit game"])

	addParsableAction(ActionID.SPEED_UP, ["speed up", "go fast", "ask clippy to speed up", "ask clippy to go fast"])
	addParsableAction(ActionID.SLOW_DOWN, ["slow down", "go slow", "slow", "ask clippy to slow down", "ask clippy to go slow"])
	addParsableAction(ActionID.SKIP, ["skip clippy", "skip", "shut up clippy", "shut up"])
	addParsableAction(ActionID.CLOSE, ["close", "delete", "destroy"])
	addParsableAction(ActionID.OPEN, ["open"])
	addParsableAction(ActionID.EXECUTE, ["execute", "run", "click", "double click", "double-click"])
	addParsableAction(ActionID.FEED, ["feed", "appease", "give mouse to"])
	addParsableAction(ActionID.EXIT_COMPUTER, ["exit computer", "exit"])
	addParsableAction(ActionID.END, ["end"])

	addParsableAction(ActionID.AFFIRM, ["affirmative", "yes please", "yes", "yup", "y"])
	addParsableAction(ActionID.DENY, ["negative", "nope", "no thank you", "no", "n"])


func initParsableSubjects():
	addParsableSubject(SubjectID.SELF, ["self", "yourself", "me", "myself", "you"],
		[ActionID.INSPECT])

	addParsableSubject(SubjectID.BACKGROUND, ["background", "desktop background", "cows", "field"],
		[ActionID.INSPECT])
	addParsableSubject(SubjectID.DESKTOP, ["desktop", "computer", "screen"],
		[ActionID.INSPECT])
	
	addParsableSubject(SubjectID.AMBIGUOUS_WINDOW, ["window"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE, ActionID.SKIP])
	
	addParsableSubject(SubjectID.INFO_WINDOW, ["info window", "clippy window", "help window", "presentation"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE, ActionID.SKIP, ActionID.SPEED_UP, ActionID.SLOW_DOWN])
	addParsableSubject(SubjectID.CLIPPY, ["firefighter clippy", "clippy", "firefighter"],
		[ActionID.INSPECT, ActionID.SKIP, ActionID.SPEED_UP, ActionID.SLOW_DOWN])
	
	addParsableSubject(SubjectID.RESOURCE_MONITOR, ["resource monitor", "resource window", "resources", "resource"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE])
	addParsableSubject(SubjectID.HEAT, ["heat", "cpu heat"],
		[ActionID.INSPECT])
	addParsableSubject(SubjectID.CPU, ["cpu"],
		[ActionID.INSPECT])
	addParsableSubject(SubjectID.RAM, ["ram"],
		[ActionID.INSPECT])
	
	addParsableSubject(SubjectID.CAT_WINDOW, ["cat window", "cat"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE, ActionID.FEED])
	
	addParsableSubject(SubjectID.EXCEL_WINDOW, ["excel window", "spreadsheet window", "excel", "spreadsheet"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE])
	
	addParsableSubject(SubjectID.MASSIVE_MOUSE_MAMA, ["massive mouse mama", "massive_mouse_mama.exe", "massive_mouse_mama"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.EXECUTE])
	addParsableSubject(SubjectID.MASSIVE_MOUSE, ["massive mouse", "massive_mouse"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.EXECUTE])
	addParsableSubject(SubjectID.MOUSE_MAMA, ["mouse mama", "mouse_mama"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.EXECUTE])
	addParsableSubject(SubjectID.MOUSE, ["mouse"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.EXECUTE])
	addParsableSubject(SubjectID.MAMA, ["mama"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.EXECUTE])
	addParsableSubject(SubjectID.ANTIMATTER_CHEESE, ["antimatter cheese", "antimatter_cheese.exe", "antimatter_cheese", "cheese"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.EXECUTE])
	
	addParsableSubject(SubjectID.TIME, ["breakfast time", "time for breakfast", "time"],
		[ActionID.INSPECT])
	addParsableSubject(SubjectID.END_BUTTON, ["end button", "end"],
		[ActionID.INSPECT, ActionID.EXECUTE])


func initParsableModifiers():
	pass

func initParseSubs():
	addParseSub("go faster", "go fast")
	addParseSub("go slower", "go slow")
	addParseSub("fire fighter", "firefighter")
	addParseSub("mother", "mama")
	addParseSub("mom", "mama")

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


		ActionID.SPEED_UP:
			pass


		ActionID.SLOW_DOWN:
			pass


		ActionID.SKIP:
			pass


		ActionID.CLOSE:
			pass


		ActionID.OPEN:
			pass


		ActionID.EXECUTE:
			pass


		ActionID.FEED:
			pass


		ActionID.EXIT_COMPUTER:
			pass


		ActionID.END:
			pass


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
			SceneManager.openEndings(scene)
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