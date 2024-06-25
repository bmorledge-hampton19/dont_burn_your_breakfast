class_name OptionsParser
extends InputParser

@export var optionsScene: OptionsScene

enum ActionID {
	INSPECT, SET, DELETE,
	MAIN_MENU, ENDINGS, POOP, QUIT, AFFIRM, DENY,
}

enum SubjectID {
	FONT_SIZE, FONT_SPEED, DISPLAY_FORMAT, QUESTION_MARKS,
}

enum ModifierID {
	SMALL, MEDIUM, LARGE, QUESTION_MARKS, PAINFULLY_SMALL, PAINFULLY_LARGE, SLOW, FAST, WINDOWED, FULLSCREEN,
}


func initParsableActions():
	addParsableAction(ActionID.ENDINGS,
			["endings", "view endings", "achievements", "view achievements", "help", "hints", "hint"])
	addParsableAction(ActionID.INSPECT, ["inspect", "look at", "look in", "look", "read", "view"])
	addParsableAction(ActionID.SET, ["set", "change", "configure"])
	addParsableAction(ActionID.DELETE, ["delete save game", "delete save data", "delete save", "delete"])
	addParsableAction(ActionID.QUIT, ["quit game", "quit the game", "quit", "exit game", "exit the game"])
	addParsableAction(ActionID.MAIN_MENU,
			["main menu", "menu", "main", "go to the main menu","go to main menu", "go back to the main menu",
			"go back to main menu", "return to the main menu", "return to main menu",
			"exit options", "exit", "go back", "back"])
	addParsableAction(ActionID.POOP, ["poop", "crap", "shit your pants", "shit"])
	addParsableAction(ActionID.AFFIRM, ["affirmative", "yes please", "yes", "yup", "y"])
	addParsableAction(ActionID.DENY, ["negative", "nope", "no thank you", "no", "n"])


func initParsableSubjects():
	addParsableSubject(SubjectID.FONT_SIZE, ["terminal font size", "font size", "size"],
			[ActionID.INSPECT, ActionID.SET])
	addParsableSubject(SubjectID.FONT_SPEED, ["terminal font speed", "font speed", "speed"],
			[ActionID.INSPECT, ActionID.SET])
	addParsableSubject(SubjectID.DISPLAY_FORMAT, ["screen display format", "screen", "display format", "display", "format"],
			[ActionID.INSPECT, ActionID.SET])
	addParsableSubject(SubjectID.QUESTION_MARKS, ["?", "question marks", "question mark", "question"],
			[ActionID.INSPECT])


func initParsableModifiers():
	addParsableModifier(ModifierID.SMALL, ["small size", "small", "to small size", "to small"],
			[ActionID.SET])
	addParsableModifier(ModifierID.MEDIUM,
			["medium size", "medium speed", "medium", "to medium size", "to medium speed", "to medium"],
			[ActionID.SET])
	addParsableModifier(ModifierID.LARGE, ["large size", "large", "to large size", "to large"],
			[ActionID.SET])
	addParsableModifier(ModifierID.PAINFULLY_LARGE,
			["painfully large size", "painfully large", "to painfully large size", "to painfully large"],
			[ActionID.SET])
	addParsableModifier(ModifierID.PAINFULLY_SMALL,
			["painfully small size", "painfully small", "to painfully small size", "to painfully small"],
			[ActionID.SET])
	addParsableModifier(ModifierID.QUESTION_MARKS,
			["?", "question marks", "question mark", "question", "to question marks", "to question mark", "to question"],
			[ActionID.SET])
	addParsableModifier(ModifierID.SLOW, ["slow speed", "slow", "to slow speed", "to slow"],
			[ActionID.SET])
	addParsableModifier(ModifierID.FAST, ["fast speed", "fast", "to fast speed", "to fast"],
			[ActionID.SET])
	addParsableModifier(ModifierID.WINDOWED, ["windowed", "window", "to windowed", "to window"],
			[ActionID.SET])
	addParsableModifier(ModifierID.FULLSCREEN, ["fullscreen", "full screen", "to fullscreen", "to full screen"],
			[ActionID.SET])
	


func parseItems() -> String:

	parseEventsSinceLastConfirmation += 1

	match actionID:

		ActionID.INSPECT:
			match subjectID:

				-1:
					if actionAlias == "look":
						return requestAdditionalSubjectContext("Where")
					else:
						return requestAdditionalSubjectContext()
				
				SubjectID.FONT_SIZE:
					return (
						"This option changes the size of the font in the terminal. Be aware that larger font sizes " +
						"will limit the maximum number of characters in a command. Rest assured, all endings can be obtained " +
						"even with the largest font size, but you may have to get more creative with your commands."
					)
				
				SubjectID.FONT_SPEED:
					return (
						"This option changes how quickly output appears in the terminal."
					)
				
				SubjectID.DISPLAY_FORMAT:
					return (
						"Use this option to switch between windowed and fullscreen mode. When in windowed mode, the window " +
						"can also be resized manually."
					)
				
				SubjectID.QUESTION_MARKS:
					if optionsScene.painfulOptionsRevealed:
						return (
							"The question marks are gone now. You're free to use the painful terminal options " +
							"if you're feeling up to it!"
						)
					else:
						return (
							"Strange... These options haven't been revealed to you yet. Legend has it that they will " +
							"only reveal themselves to someone who has unlocked all the endings in the game."
						)
				
		ActionID.SET:
			
			match subjectID:

				SubjectID.FONT_SIZE:
					match modifierID:

						ModifierID.SMALL:
							if Options.fontSize == Options.FontSize.SMALL:
								return "The font size is already set to small."
							else:
								optionsScene.setFontSize(Options.FontSize.SMALL)
								return "Setting font size to small."

						ModifierID.MEDIUM:
							if Options.fontSize == Options.FontSize.MEDIUM:
								return "The font size is already set to medium."
							else:
								optionsScene.setFontSize(Options.FontSize.MEDIUM)
								return "Setting font size to medium."

						ModifierID.LARGE:
							if Options.fontSize == Options.FontSize.LARGE:
								return "The font size is already set to large."
							else:
								optionsScene.setFontSize(Options.FontSize.LARGE)
								return "Setting font size to large."

						ModifierID.PAINFULLY_SMALL:
							if Options.fontSize == Options.FontSize.PAINFULLY_SMALL:
								return "The font size is already set to painfully small."
							else:
								optionsScene.setFontSize(Options.FontSize.PAINFULLY_SMALL)
								if optionsScene.painfulOptionsRevealed:
									return "Setting font size to painfully small. Good luck."
								else:
									optionsScene.revealPainfulOptions()
									return (
										"It looks like this isn't your first rodeo! " +
										"Setting font size to painfully small. Good luck."
									)

						ModifierID.PAINFULLY_LARGE:
							if Options.fontSize == Options.FontSize.PAINFULLY_LARGE:
								return "The font size is already set to painfully large."
							else:
								optionsScene.setFontSize(Options.FontSize.PAINFULLY_LARGE)
								if optionsScene.painfulOptionsRevealed:
									return "Setting font size to painfully large. Good luck"
								else:
									optionsScene.revealPainfulOptions()
									return (
										"It looks like this isn't your first rodeo! " +
										"Setting font size to painfully large. Good luck"
									)

						ModifierID.QUESTION_MARKS:
							if optionsScene.painfulOptionsRevealed: return "The question marks are already gone, silly!"
							else: return (
								"You can't set the font size to this right now... " +
								"Try coming back when you've obtained all the endings in the game."
							)
						
						-1:
							return requestAdditionalModifierContext("What", " to")

						
				
				SubjectID.FONT_SPEED:

					match modifierID:

						ModifierID.SLOW:
							if Options.fontSpeed == Options.FontSpeed.SLOW:
								return "The font speed is already set to slow."
							else:
								optionsScene.setFontSpeed(Options.FontSpeed.SLOW)
								return "Setting font speed to slow."
						
						ModifierID.MEDIUM:
							if Options.fontSpeed == Options.FontSpeed.MEDIUM:
								return "The font speed is already set to medium."
							else:
								optionsScene.setFontSpeed(Options.FontSpeed.MEDIUM)
								return "Setting font speed to medium."

						ModifierID.FAST:
							if Options.fontSpeed == Options.FontSpeed.FAST:
								return "The font speed is already set to fast."
							else:
								optionsScene.setFontSpeed(Options.FontSpeed.FAST)
								return "Setting font speed to fast."
						
						-1:
							return requestAdditionalModifierContext("What", " to")
				
				SubjectID.DISPLAY_FORMAT:

					match modifierID:

						ModifierID.WINDOWED:
							if Options.displayMode == Options.DisplayMode.WINDOWED:
								return "The display format is already set to windowed."
							else:
								optionsScene.setDisplayFormat(Options.DisplayMode.WINDOWED)
								return "Setting display format to windowed."

						ModifierID.FULLSCREEN:
							if Options.displayMode == Options.DisplayMode.FULL_SCREEN:
								return "The display format is already set to fullscreen."
							else:
								optionsScene.setDisplayFormat(Options.DisplayMode.FULL_SCREEN)
								return "Setting display format to fullscreen."

						-1:
							return requestAdditionalModifierContext("What", " to")


		ActionID.DELETE:
			if parseEventsSinceLastConfirmation <= 1 and confirmingActionID == ActionID.DELETE:
				EndingsManager.resetData()
				return "Your save data has been reset."
			else:
				parseEventsSinceLastConfirmation = 0
				confirmingActionID = ActionID.DELETE
				return (
					"Are you sure you want to delete your save data? This will lock all endings, hints, and shortcuts " +
					"and reset your cereal coins to 0."
				)


		ActionID.POOP:
			return (
				"Nice try, but this isn't that game."
			)

		ActionID.MAIN_MENU:
			# if parseEventsSinceLastConfirmation <= 1 and confirmingActionID == ActionID.MAIN_MENU:
				SceneManager.transitionToScene(SceneManager.SceneID.MAIN_MENU)
			# else:
			# 	parseEventsSinceLastConfirmation = 0
			# 	confirmingActionID = ActionID.MAIN_MENU
			# 	return "Are you sure you want to return to the main menu?"

		ActionID.ENDINGS:
			SceneManager.openEndings(optionsScene)
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

					ActionID.DELETE:
						EndingsManager.resetData()
						return "Your save data has been reset."
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
