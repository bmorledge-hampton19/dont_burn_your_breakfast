class_name MainMenuParser
extends InputParser

@export var mainMenu: MainMenu

enum ActionID {
	INSPECT, SELECT,
	PLAY, TAKE_SHORTCUT, ENDINGS, HELP, OPTIONS, CREDITS,
	MAIN_MENU, POOP, QUIT, AFFIRM, DENY,
}

enum SubjectID {
	PLAY_BUTTON, HELP_BUTTON, OPTIONS_BUTTON, CREDITS_BUTTON, AMBIGUOUS_BUTTON, 
	QUAKER_MAN, MILK, CEREAL, GASOLINE, MATCH, TITLE
}

enum ModifierID {
	BATHROOM, FRONT_YARD, BEDROOM, KITCHEN,
}


func initParsableActions():
	addParsableAction(ActionID.ENDINGS,
			["endings", "view endings", "achievements", "view achievements", "hints", "hint"])
	addParsableAction(ActionID.INSPECT, ["inspect", "look at", "look in", "look", "read", "view"])
	addParsableAction(ActionID.MAIN_MENU,
			["main menu", "menu", "main", "go to the main menu","go to main menu", "go back to the main menu",
			"go back to main menu", "return to the main menu", "return to main menu"])
	addParsableAction(ActionID.SELECT, ["select", "click", "choose", "go to"])
	addParsableAction(ActionID.PLAY, ["play game", "play", "start", "begin"])
	addParsableAction(ActionID.TAKE_SHORTCUT, ["take shortcut", "use shortcut", "shortcut"])
	addParsableAction(ActionID.HELP, ["help me", "help", "get help", "--help", "-h"])
	addParsableAction(ActionID.OPTIONS, ["options", "settings"])
	addParsableAction(ActionID.CREDITS, ["credits", "acknowledgements"])
	addParsableAction(ActionID.POOP, ["poop", "crap", "shit your pants", "shit"])
	addParsableAction(ActionID.QUIT, ["quit game", "quit the game", "quit", "exit game", "exit the game", "exit"])
	addParsableAction(ActionID.AFFIRM, ["affirmative", "yes please", "yes", "yup", "y"])
	addParsableAction(ActionID.DENY, ["negative", "nope", "no thank you", "no", "n"])


func initParsableSubjects():
	addParsableSubject(SubjectID.PLAY_BUTTON, ["play button", "play", "top left button"],
			[ActionID.INSPECT, ActionID.SELECT])
	addParsableSubject(SubjectID.HELP_BUTTON, ["help button", "help", "top right button"],
			[ActionID.INSPECT, ActionID.SELECT])
	addParsableSubject(SubjectID.OPTIONS_BUTTON, ["options button", "settings button", "settings", "bottom left button"],
			[ActionID.INSPECT, ActionID.SELECT])
	addParsableSubject(SubjectID.CREDITS_BUTTON, ["credits button", "credits", "bottom right button"],
			[ActionID.INSPECT, ActionID.SELECT])
	addParsableSubject(SubjectID.AMBIGUOUS_BUTTON, ["buttons", "button"],
			[ActionID.INSPECT, ActionID.SELECT])
	addParsableSubject(SubjectID.QUAKER_MAN, ["man", "quaker man", "quaker mascot", "quaker"],
			[ActionID.INSPECT])
	addParsableSubject(SubjectID.MILK, ["milk pitcher", "milk", "pitcher"],
			[ActionID.INSPECT])
	addParsableSubject(SubjectID.CEREAL,
			["cereal boxes", "cereal box", "cereal bowl", "bowl of cereal", "cereal", "boxes", "box", "bowl"],
			[ActionID.INSPECT])
	addParsableSubject(SubjectID.GASOLINE, ["gasoline", "gas", "can of gasoline", "can"],
			[ActionID.INSPECT])
	addParsableSubject(SubjectID.MATCH, ["matchstick", "match", "lit match", "burning match", "flaming match"],
			[ActionID.INSPECT])
	addParsableSubject(SubjectID.TITLE, ["title", "don't burn your breakfast", "burn", "fire", "flames", "flame", "words"],
			[ActionID.INSPECT])
	


func initParsableModifiers():
	addParsableModifier(ModifierID.BATHROOM, ["bathroom", "at bathroom", "from bathroom", "on bathroom", "to bathroom"],
			[ActionID.PLAY, ActionID.SELECT, ActionID.TAKE_SHORTCUT])
	addParsableModifier(ModifierID.FRONT_YARD,
			[
				"yard", "at yard", "on yard", "from yard", "to yard",
				"front yard", "at front yard", "on front yard", "from front yard", "to front yard",
				"outside", "at outside", "on outside", "from outside", "to outside"
			],
			[ActionID.PLAY, ActionID.SELECT, ActionID.TAKE_SHORTCUT])
	addParsableModifier(ModifierID.BEDROOM, ["bedroom", "at bedroom", "on bedroom", "from bedroom", "to bedroom"],
			[ActionID.PLAY, ActionID.SELECT, ActionID.TAKE_SHORTCUT])
	addParsableModifier(ModifierID.KITCHEN, ["kitchen", "at kitchen", "on kitchen", "from kitchen", "to kitchen"],
			[ActionID.PLAY, ActionID.SELECT, ActionID.TAKE_SHORTCUT])


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
			
				SubjectID.PLAY_BUTTON:
					return (
						"This button can be used to start the game. Once enough endings have been unlocked, " +
						"you will also be able to start the game from specific levels."
					)
				
				SubjectID.CREDITS_BUTTON:
					return (
						"This button will let you view all the wonderful people who helped make this game."
					)
				
				SubjectID.HELP_BUTTON:
					return (
						"This button will give you a rundown on how the basic mechanics of the game work."
					)
				
				SubjectID.OPTIONS_BUTTON:
					return (
						"This button will let you modify basic settings for the game."
					)
				
				SubjectID.AMBIGUOUS_BUTTON:
					return requestAdditionalContextCustom("What button would you like to know more about?", REQUEST_SUBJECT)
				
				SubjectID.QUAKER_MAN:
					return (
						"This sneaky lil' guy just can't help peeping at some delicious cereal!"
					)
				
				SubjectID.MILK:
					return (
						"Milk is an important part of the cereal experience! Cereal without milk is like " +
						"a man without his fingernails! Think about it."
					)
				
				SubjectID.CEREAL:
					return (
						"The cereal cascading behind the title and into the bowl is truly remarkable. It's natural " +
						"beauty reminds you of Niagra Falls or perhaps the Mona Lisa."
					)
				
				SubjectID.GASOLINE:
					return (
						"If motorcycles ate cereal for breakfast, this is probably what they would use for milk."
					)
				
				SubjectID.MATCH:
					return (
						"Disaster is imminent..."
					)
				
				SubjectID.TITLE:
					SceneManager.transitionToScene(
						SceneManager.SceneID.ENDING,
						"Looking closely at the game's title, you notice that the word \"burn\" is already aflame. " +
						"Suddenly, as if spurred on by your awareness, the fire begins to spread, and it isn't long before " +
						"the entire title screen is up in flames. It's almost impressive how quickly you've managed to " +
						"lose the game...",
						SceneManager.EndingID.FALSE_START
					)


		ActionID.SELECT:
			
			match subjectID:

				SubjectID.PLAY_BUTTON:
					return attemptStartGame(modifierID)
				SubjectID.CREDITS_BUTTON:
					SceneManager.transitionToScene(SceneManager.SceneID.CREDITS)
				SubjectID.HELP_BUTTON:
					SceneManager.transitionToScene(SceneManager.SceneID.HELP)
				SubjectID.OPTIONS_BUTTON:
					SceneManager.transitionToScene(SceneManager.SceneID.OPTIONS)
				SubjectID.AMBIGUOUS_BUTTON:
					return requestAdditionalContextCustom("Which button would you like to select?", REQUEST_SUBJECT)


		ActionID.PLAY, ActionID.TAKE_SHORTCUT:
			return attemptStartGame(modifierID)

		ActionID.HELP:
			SceneManager.transitionToScene(SceneManager.SceneID.HELP)

		ActionID.OPTIONS:
			SceneManager.transitionToScene(SceneManager.SceneID.OPTIONS)

		ActionID.CREDITS:
			SceneManager.transitionToScene(SceneManager.SceneID.CREDITS)


		ActionID.POOP:
			return (
				"Nice try, but this isn't that game."
			)

		ActionID.ENDINGS:
			SceneManager.openEndings(mainMenu)
			return SceneManager.openEndingsScene.defaultStartingMessage

		ActionID.MAIN_MENU:
			return "You're already at the main menu."

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


func attemptStartGame(startGameModifierID: ModifierID):

	match startGameModifierID:
		-1, ModifierID.BATHROOM:
			SceneManager.transitionToScene(SceneManager.SceneID.BATHROOM)
		ModifierID.FRONT_YARD:
			if EndingsManager.isSceneShortcutUnlocked(SceneManager.SceneID.FRONT_YARD):
				SceneManager.transitionToScene(SceneManager.SceneID.FRONT_YARD)
		ModifierID.BEDROOM:
			if EndingsManager.isSceneShortcutUnlocked(SceneManager.SceneID.BEDROOM):
				SceneManager.transitionToScene(SceneManager.SceneID.BEDROOM)
		ModifierID.KITCHEN:
			if EndingsManager.isSceneShortcutUnlocked(SceneManager.SceneID.KITCHEN):
				SceneManager.transitionToScene(SceneManager.SceneID.KITCHEN)
		
	return (
		"You haven't unlocked the ability to skip to this level yet. For more information, " +
		"inspect the shortcut in the Endings screen."
	)