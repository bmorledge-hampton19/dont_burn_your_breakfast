class_name SplashScreenParser
extends InputParser

@export var splashScreen: SplashScreen

enum ActionID {
	INSPECT,
	POUR, EAT, POKE, PUT, SKIP,
	MAIN_MENU, ENDINGS, POOP, QUIT, AFFIRM, DENY
}

enum SubjectID {
	DR_BEAN, LEAVES, LAB_COAT, NUCLEOSOME, DNA, SYMBOLS,
	MILK, CEREAL_BOWL
}

enum ModifierID {
	ON_FLOOR, IN_BOWL
}


func initParsableActions():
	addParsableAction(ActionID.INSPECT, ["inspect", "look at", "look in", "look", "read", "view"])

	addParsableAction(ActionID.POUR, ["pour", "spill"])
	addParsableAction(ActionID.EAT, ["eat", "enjoy", "consume", "drink", "devour"])
	addParsableAction(ActionID.POKE, ["poke", "touch", "caress", "pet", "click on", "click",])
	addParsableAction(ActionID.PUT, ["put"])

	addParsableAction(ActionID.SKIP, ["skip scene", "skip splash screen", "skip intro", "skip dr. bean", "skip"])
	addParsableAction(ActionID.MAIN_MENU,
		["main menu", "menu", "main", "go to main menu", "go back to main menu", "return to main menu"])
	addParsableAction(ActionID.QUIT, ["quit game", "quit", "exit game"])
	addParsableAction(ActionID.AFFIRM, ["affirmative", "yes please", "yes", "yup", "y"])
	addParsableAction(ActionID.DENY, ["negative", "nope", "no thank you", "no", "n"])


func initParsableSubjects():
	addParsableSubject(SubjectID.DR_BEAN, ["dr. bean", "dr.", "logo", "bean", "ben", "scientist", "researcher", "doctor bean", "doctor", "self"],
		[ActionID.INSPECT, ActionID.POKE, ActionID.EAT])
	addParsableSubject(SubjectID.LEAVES, ["leaves", "hair", "leaf"],
		[ActionID.INSPECT])
	addParsableSubject(SubjectID.LAB_COAT, ["lab coat", "coat", "jacket"],
		[ActionID.INSPECT])
	addParsableSubject(SubjectID.NUCLEOSOME, ["nucleosome", "histones", "histone octamer", "histone", "chromatin"],
		[ActionID.INSPECT])
	addParsableSubject(SubjectID.DNA, ["dna", "deoxyribonucleic acids", "deoxyribonucleic acid", "helix", "double helix"],
		[ActionID.INSPECT])
	addParsableSubject(SubjectID.SYMBOLS, ["symbols", "molecules", "symbol", "molecule"],
		[ActionID.INSPECT])
	addParsableSubject(SubjectID.MILK, ["milk jug", "jug of milk", "gallon of milk", "milk carton", "milk", "cow juice"],
		[ActionID.INSPECT, ActionID.POUR, ActionID.EAT, ActionID.PUT])
	addParsableSubject(SubjectID.CEREAL_BOWL, ["bowl of cereal", "cereal bowl", "cereal", "bowl", "breakfast"],
		[ActionID.INSPECT, ActionID.POKE, ActionID.EAT])


func initParsableModifiers():
	addParsableModifier(ModifierID.ON_FLOOR, ["on floor", "on ground", "down on floor", "down on ground"],
		[ActionID.POUR, ActionID.PUT])
	addParsableModifier(ModifierID.IN_BOWL, ["in bowl of cereal", "in bowl", "in cereal bowl", "in cereal", "in breakfast"],
		[ActionID.INSPECT, ActionID.POUR, ActionID.PUT])


func initParseSubs():
	addParseSub("into", "in")
	addParseSub("onto", "on")
	addParseSub("dr", "dr.")


func parseItems() -> String:

	parseEventsSinceLastConfirmation += 1

	splashScreen.resetFadeOutTime()

	match actionID:

		ActionID.INSPECT:
			match subjectID:

				-1:
					if actionAlias == "look":
						return requestAdditionalSubjectContext("Where", [], [], ["at "])
					else:
						return requestAdditionalSubjectContext()
				
				SubjectID.DR_BEAN:
					match splashScreen.beanState:
						SplashScreen.BeanState.IDLE:
							return "Dr. Bean is hungry for breakfast!"
						SplashScreen.BeanState.SPILLING:
							return "Dr. Bean is in distress! Why did you do this!?"
						SplashScreen.BeanState.PREPARED:
							return "Dr. Bean is staring hungrily at the cereal. It's ready to eat!"
						SplashScreen.BeanState.EATING:
							return "Dr. Bean is furiously consuming his breakfast."

				SubjectID.LEAVES:
					return "Dr. Bean's leaves are thinning at a younger age than he expected... That's that Y chromosome for ya!"

				SubjectID.LAB_COAT:
					return "Dr. Bean's lab coat has seen better days. It really needs to be washed... Or autoclaved."

				SubjectID.NUCLEOSOME:
					return "A nucleosome! This baby can bind 146 bp of DNA. Impressive!"

				SubjectID.DNA:
					return "The blueprint of life! It's beautiful."

				SubjectID.SYMBOLS:
					return (
						"A nucleosome is embroidered on the right side of Dr. Bean's lab coat, and the left side sports some pretty snazzy DNA."
					)

				SubjectID.MILK:
					match splashScreen.beanState:
						SplashScreen.BeanState.IDLE, SplashScreen.BeanState.SPILLING:
							return "Wow! That's a full gallon of freshly squeezed cow juice!"
						SplashScreen.BeanState.PREPARED, SplashScreen.BeanState.EATING:
							return "There is a bit less milk now."

				SubjectID.CEREAL_BOWL:
					match splashScreen.beanState:
						SplashScreen.BeanState.IDLE, SplashScreen.BeanState.SPILLING:
							return "The bowl is full of dry cereal."
						SplashScreen.BeanState.PREPARED:
							return "The bowl is full of cereal and milk. It's ready to eat!"
						SplashScreen.BeanState.EATING:
							return "The bowl of cereal is rapidly emptying."


		ActionID.POUR, ActionID.PUT:
			match subjectID:

				-1:
					return requestAdditionalSubjectContext()
				
				SubjectID.MILK:
					
					if modifierID == -1 and actionID == ActionID.PUT:
						return requestAdditionalContextCustom(
							"What would you like to " + reconstructCommand() + " in/on?",
							REQUEST_MODIFIER, ["in ", "on "]
						)
					
					elif modifierID == -1 or modifierID == ModifierID.ON_FLOOR:
						match splashScreen.beanState:
							SplashScreen.BeanState.IDLE, SplashScreen.BeanState.PREPARED:
								splashScreen.spillMilk()
								return "Dr. Bean begins pouring the milk on the floor. This is what you wanted, right?"
							SplashScreen.BeanState.SPILLING:
								return "Affirmative."
							SplashScreen.BeanState.EATING:
								return "Dr. Bean is a bit preoccupied at the moment..."

					elif modifierID == ModifierID.IN_BOWL:
						match splashScreen.beanState:
							SplashScreen.BeanState.IDLE:
								splashScreen.pourMilkInCereal()
								return (
									"Dr. Bean carefully pours the milk into the bowl cereal. Perfect!"
								)
							SplashScreen.BeanState.SPILLING:
								return "It's a bit late for that..."
							SplashScreen.BeanState.PREPARED, SplashScreen.BeanState.EATING:
								return "Already done!"


		ActionID.EAT:

			match subjectID:

				-1:
					return requestAdditionalSubjectContext()

				SubjectID.DR_BEAN:
					return "NO"
				
				SubjectID.CEREAL_BOWL:
					match splashScreen.beanState:
						SplashScreen.BeanState.IDLE, SplashScreen.BeanState.SPILLING:
							return "There's no milk in the cereal bowl, and Dr. Bean refuses to eat it dry."
						SplashScreen.BeanState.PREPARED:
							splashScreen.eatCereal()
							return "Dr. Bean begins eating the cereal at an alarming pace. Well, at least he looks happy about it!"
						SplashScreen.BeanState.EATING:
							return "Dr. Bean is already eating the cereal."
				
				SubjectID.MILK:
					match splashScreen.beanState:
						SplashScreen.BeanState.IDLE:
							return "This gallon of milk is too full for Dr. Bean to drink from directly."
						SplashScreen.BeanState.SPILLING:
							return "It's a bit late for that..."
						SplashScreen.BeanState.PREPARED:
							splashScreen.eatCereal()
							return "Dr. Bean begins eating the cereal at an alarming pace. Well, at least he looks happy about it!"
						SplashScreen.BeanState.EATING:
							return "Dr. Bean is a bit preoccupied at the moment..."


		ActionID.POKE:

			match subjectID:

				-1:
					return requestAdditionalSubjectContext()
				
				SubjectID.DR_BEAN:
					return "You'd need to at least take him out to dinner first."


		ActionID.POOP:
			return (
				"Nice try, but this isn't that game."
			)

		ActionID.MAIN_MENU, ActionID.SKIP:
			splashScreen.transitionToMainMenu()
			return ""

		ActionID.ENDINGS:
			return "Be patient! You can look at the endings once the game starts."

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
