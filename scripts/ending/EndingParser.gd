class_name EndingParser
extends InputParser

@export var endingScene: Ending

var firstParse = true
const endingMessage = (
	"Oh no! You burned your breakfast...\n\n" +
	"Would you like to [retry] the current level or return to the [main menu]?"
)

enum ActionID {
	POOP, QUIT, MAIN_MENU, RETRY, AFFIRM, DENY
}

enum SubjectID {

}

enum ModifierID {
	
}


func initParsableActions():
	addParsableAction(ActionID.RETRY, ["retry level", "retry the current level", "retry", "replay level"])
	addParsableAction(ActionID.MAIN_MENU,
			["main menu", "menu", "go to the main menu","go to main menu", "go back to the main menu", "go back to main menu",
			"return to the main menu", "return to main menu"])
	addParsableAction(ActionID.POOP, ["poop", "crap", "shit your pants", "shit"])
	addParsableAction(ActionID.QUIT, ["quit game", "quit the game", "quit", "exit game", "exit the game"])
	addParsableAction(ActionID.AFFIRM, ["affirmative", "yes please", "yes", "yup", "y"])
	addParsableAction(ActionID.DENY, ["negative", "nope", "no thank you", "no", "n"])


func initParsableSubjects():
	pass


func initParsableModifiers():
	pass


func receiveInputFromTerminal(input: String):
	if firstParse:
		if input.to_lower() == "replay" or input.to_lower() == "replay message":
			terminal.initMessage(
				lastMessage +
				"\n(Ok, fine. I guess *technically* you have to input any command EXCEPT \"replay\" or \"replay message\" " +
				"to continue.)"
				)
		elif input.to_lower() in ["retry level", "retry the current level", "retry", "replay level"]:
			SceneManager.transitionToScene(SceneManager.SceneID.LAST_SCENE)
		else:
			firstParse = false
			endingScene.setMainEndingTexture()
			lastMessage = endingMessage
			terminal.initMessage(endingMessage)
	else: super(input)


func parseItems(actionID: int, subjectID: int, modifierID: int) -> String:

	previousActionID = actionID
	previousSubjectID = subjectID
	previousModifierID = modifierID

	parseEventsSinceLastConfirmation += 1

	match actionID:

		ActionID.RETRY:
			SceneManager.transitionToScene(SceneManager.SceneID.LAST_SCENE)
	
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
