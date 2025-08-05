class_name CreditsParser
extends InputParser

@export var credits: Credits

enum ActionID {
	INSPECT, THANK,

	MAIN_MENU, ENDINGS, POOP, QUIT, AFFIRM, DENY
}

enum SubjectID {
	SELF, BEN, MH_FAMILY, SHIRLEY, CELLAR_DOOR_GAMES, WINDOWS_XP, FONT_CREATORS, GODOT, QUAKER_MAN
}

enum ModifierID {
	
}


func initParsableActions():
	addParsableAction(ActionID.ENDINGS,
			["endings", "view endings", "achievements", "view achievements", "help", "hints", "hint"])
	addParsableAction(ActionID.INSPECT, ["inspect", "look at", "look in", "look", "read", "view"])
	addParsableAction(ActionID.THANK, ["thanks", "thank", "acknowledge", "appreciate", "give credit to"])
	addParsableAction(ActionID.QUIT, ["quit game", "quit the game", "quit", "exit game", "exit the game"])
	addParsableAction(ActionID.MAIN_MENU,
			["main menu", "menu", "main", "go to main menu", "go back to main menu", "return to main menu",
			"exit credits", "exit", "go back", "back"])
	addParsableAction(ActionID.POOP, ["poop", "crap", "shit your pants", "shit"])
	addParsableAction(ActionID.AFFIRM, ["affirmative", "yes please", "yes", "yup", "y"])
	addParsableAction(ActionID.DENY, ["negative", "nope", "no thank you", "no", "n"])


func initParsableSubjects():
	addParsableSubject(SubjectID.SELF, ["self", "me", "player"],
			[ActionID.INSPECT, ActionID.THANK])
	addParsableSubject(SubjectID.BEN, ["ben morledge-hampton", "benjamin", "ben", "dr. morledge-hampton", "dr. morledge", "bean", "dr. bean"],
			[ActionID.INSPECT, ActionID.THANK])
	addParsableSubject(SubjectID.MH_FAMILY,
			["amazing morledge-hampton family", "morledge-hampton family", "morledge-hamptons", "morledge-hampton",
			 "abigail morledge-hampton", "abigail", "abbie morledge-hampton", "abbie",
			 "nicholas morledge-hampton", "nicholas", "nick morledge-hampton", "nick",
			 "charles morledge-hampton", "charles", "charlie morledge-hampton", "charlie",
			 "sara morledge-hampton", "sara",
			 "diane morledge-hampton", "diane", "mrs. morledge-hampton",
			 "scott morledge-hampton", "scott", "dr. mr. morledge-hampton"],
			[ActionID.INSPECT, ActionID.THANK])
	addParsableSubject(SubjectID.SHIRLEY, ["shirley shirley", "shirley", "nanny"],
			[ActionID.INSPECT, ActionID.THANK])
	addParsableSubject(SubjectID.CELLAR_DOOR_GAMES,
			["cellar door games", "cellar door", "cellar",
			 "teddy and kenny lee", "teddy and kenny", "teddy lee", "teddy", "kenny lee", "kenny", "lees"],
			[ActionID.INSPECT, ActionID.THANK])
	addParsableSubject(SubjectID.WINDOWS_XP,
			["windows xp", "windows", "xp", "microsoft windows", "stan lepard", "bill brown", "nathan grigg",
			 "richard parker", "richard", "ricardo", "darwin", "poppy corn", "poppy", "popcorn", "poppie"],
			[ActionID.INSPECT, ActionID.THANK])
	addParsableSubject(SubjectID.FONT_CREATORS,
			["font creators", "font creator", "codeman38 and ggbot", "codeman38", "ggbot"],
			[ActionID.INSPECT, ActionID.THANK])
	addParsableSubject(SubjectID.GODOT,
			["godot engine", "godot"],
			[ActionID.INSPECT, ActionID.THANK])
	addParsableSubject(SubjectID.QUAKER_MAN,
			["man", "guy", "corner", "top right corner", "top-right corner", "quaker man", "quaker mascot", "quaker"],
			[ActionID.INSPECT, ActionID.THANK])
	


func initParsableModifiers():
	pass


func initParseSubs():
	addParseSub("&", "and")
	addParseSub("dr", "dr.")
	addParseSubs(["m-h", "mh"], "morledge-hampton")


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
				SubjectID.SELF:
					return (
						"Thank you for playing my game!"
					)
				SubjectID.BEN:
					return (
						"That's me! I made this!"
					)
				SubjectID.MH_FAMILY:
					return(
						"My family is the best and has always been so supportive of me on my journey to design silly " +
						"little games like this one!\n" +
						"More specifically, Nick and Charlie were a big help with testing Don't Burn Your Breakfast in its " +
						"early stages, and Mom and Dad (Diane and Scott) provided me with a great audio clip of a butane " +
						"torch to give the oven in the kitchen a little more oomph!"
					)
				SubjectID.SHIRLEY:
					return (
						"My grandma, Shirley, is one of the greatest artists I know! She shared so much wisdom with me, and " +
						"always had kind things to say about my work, even though I know I have a long way to go."
					)
				SubjectID.CELLAR_DOOR_GAMES:
					return (
						"These guys have made lots of amazing games that are an inspiration to me, but there's one in " +
						"particular that this game is modeled after. Can you figure out which one?"
					)
				SubjectID.WINDOWS_XP:
					return (
						"Windows XP has such a characteristic feel to it, and I used a few assets from the operating system to " +
						"help bring the computer cleaning minigame to life. The visuals were adapted from Windows fonts, icons, " +
						"and UI themes, and the sound effects were made from different alerts and audio from the original Windows " +
						"XP sound library. The music tracks were also adapted from Windows XP pieces: Velkommen by Stan Lepard, " +
						"Tour Intro by Bill Brown, and Flourish by Nathan Grigg. Hopefully this is all considered fair use. " +
						"I just love the idea of recreating recognizable operating systems in absurd scenarios :)\n" +
						"Oh! And the cat pictures star Richard Parker, Poppy, and Darwin. Don't forget to thank them!"
					)
				SubjectID.FONT_CREATORS:
					return (
						"Codeman38 created the kongtext font (which you're looking at right now), and ggbot created the E1234 " +
						"font used in the kitchen timer. Thanks guys!"
					)
				SubjectID.GODOT:
					return (
						"This engine has been a joy to work with! You can find its license at godotengine.org/license. " +
						"Hooray for open source software!"
					)
				SubjectID.QUAKER_MAN:
					return (
						"The Quaker mascot is filled with gratitude."
					)


		ActionID.THANK:
			if subjectID == -1:
				return requestAdditionalSubjectContext("Who")
			else:
				AudioManager.playSound(AudioManager.applause, true)
				if subjectAlias in [
					"richard parker", "richard", "ricardo", "darwin", "poppy corn", "poppy", "popcorn", "poppie"
				]:
					return "Thanks " + subjectAlias.capitalize() + "! <3 UwU"
				else:
					return "Thanks " + subjectAlias.capitalize() + "! <3 <3"


		ActionID.POOP:
			return (
				"Nice try, but this isn't that game."
			)

		ActionID.MAIN_MENU:
			# if parseEventsSinceLastConfirmation <= 1 and confirmingActionID == ActionID.MAIN_MENU:
				SceneManager.transitionToScene(SceneManager.SceneID.MAIN_MENU)
				return ""
			# else:
			# 	parseEventsSinceLastConfirmation = 0
			# 	confirmingActionID = ActionID.MAIN_MENU
			# 	return "Are you sure you want to return to the main menu?"

		ActionID.ENDINGS:
			SceneManager.openEndings(credits)
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
						return ""
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