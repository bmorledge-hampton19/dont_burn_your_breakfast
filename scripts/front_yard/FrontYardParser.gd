class_name FrontYardParser
extends InputParser

@export var frontYard: FrontYard

enum {AMBIGUOUS, RIGHT, LEFT, PLURAL}

enum ActionID {
	INSPECT, USE,
	TURN_ON, TURN_OFF, TURN, MOVE_TO, ASCEND, DESCEND, STEP_GENTLY, OPEN, CLOSE, ENTER,
	TAKE, EAT, REMOVE, REPLACE, PUT,
	WEAR, TIE, UNTIE, 
	REFUEL, POUR, MOW,
	FIRE, LIGHT, 
	MAIN_MENU, ENDINGS, POOP, QUIT, AFFIRM, DENY,
}

enum SubjectID {
	SELF, BATHROOM, BEDROOM, AMBIGUOUS_DOOR, HOUSE, CONCRETE, SHELF,
	STEP_1, STEP_2, STEP_3, STEP_4, STEP_5, AMBIGUOUS_STEP, NEXT_STEP, PREVIOUS_STEP,
	GAS, MOWER, GAS_CAP,
	SHOES, AMBIGUOUS_SHOE, RIGHT_SHOE, LEFT_SHOE, SHOE_ON_RIGHT_FOOT, SHOE_ON_LEFT_FOOT,
	FLAMETHROWER, CEREAL, BIRDFEEDER, FAUCET, LAWN, WEEDS, STUMP, WINDOW,
}

enum ModifierID {
	GENTLY, ON_GROUND, IN_MOWER, ON_MOWER, ON_FUEL_TANK, WITH_GAS,
	ON_RIGHT_FOOT, ON_LEFT_FOOT, ON_AMBIGUOUS_FOOT, ON_BOTH_FEET,
	ON_STEP, ON_FIRST_STEP,
	ON, OFF, BACK, AWAY
}


func initParsableActions():
	addParsableAction(ActionID.ENDINGS,
			["endings", "view endings", "achievements", "view achievements", "help", "hints", "hint"])
	addParsableAction(ActionID.MAIN_MENU,
			["main menu", "menu", "main", "go to the main menu","go to main menu", "go back to the main menu",
			"go back to main menu", "return to the main menu", "return to main menu"])
	addParsableAction(ActionID.INSPECT, ["inspect", "look at", "look in", "look", "read", "view"])
	addParsableAction(ActionID.USE, ["use"])
	addParsableAction(ActionID.TURN_ON, ["turn on", "start", "activate"])
	addParsableAction(ActionID.TURN_OFF, ["turn off", "stop", "deactivate"])
	addParsableAction(ActionID.TURN, ["turn"])
	addParsableAction(ActionID.OPEN, ["open"])
	addParsableAction(ActionID.CLOSE, ["close", "shut"])
	addParsableAction(ActionID.ENTER, ["enter", "go inside", "go in", "walk inside", "walk in"])
	addParsableAction(ActionID.REMOVE, ["remove", "take off", "unscrew", "pull off"])
	addParsableAction(ActionID.TAKE, ["take", "get", "obtain", "hold", "pick up", "grab"])
	addParsableAction(ActionID.EAT, ["eat"])
	addParsableAction(ActionID.REPLACE,
			["place", "replace", "return", "put back", "put down", "put away", "set down", "screw on", "screw"])
	addParsableAction(ActionID.WEAR, ["wear", "slip on", "put on"])
	addParsableAction(ActionID.TIE, ["tie up", "tie", "lace up", "lace"])
	addParsableAction(ActionID.UNTIE, ["untie"])
	addParsableAction(ActionID.REFUEL, ["fuel up", "fuel", "refuel", "fill up", "fill"])
	addParsableAction(ActionID.POUR, ["pour out", "pour"])
	addParsableAction(ActionID.MOW, ["mow", "cut", "trim"])
	addParsableAction(ActionID.FIRE, ["fire", "shoot"])
	addParsableAction(ActionID.LIGHT, ["light", "strike", "burn"])
	addParsableAction(ActionID.PUT, ["put"])
	addParsableAction(ActionID.STEP_GENTLY,
			["step gently on", "step gently up to", "step gently",
			"gently step on", "gently step up to", "gently step",
			"move gently to", "move gently",
			"gently move to", "gently move",
			"go gently to", "gently go to",
			"walk gently on", "gently walk on", "walk gently to", "gently walk to",
			"tiptoe on", "tiptoe to", "tiptoe"])
	addParsableAction(ActionID.DESCEND,
			["descend to", "descend on", "descend", "go down to", "go down on", "go down",
			"climb down to", "climb down on", "climb down", "step down to", "step down", "step off"])
	addParsableAction(ActionID.ASCEND,
			["ascend to", "ascend on", "ascend", "go up to", "go up on", "go up",
			"climb up to", "climb up on", "climb up", "climb", "step up to", "step up"])
	addParsableAction(ActionID.MOVE_TO,
			["move to", "move on", "move", "walk to", "walk on", "walk up", "walk down", "walk", "go to", "go on", "go",
			"step to", "step on", "step"])
	addParsableAction(ActionID.POOP, ["poop", "crap", "shit your pants", "shit"])
	addParsableAction(ActionID.QUIT, ["quit game", "quit the game", "quit", "exit game", "exit the game", "exit"])
	addParsableAction(ActionID.AFFIRM, ["affirmative", "yes please", "yes", "yup", "y"])
	addParsableAction(ActionID.DENY, ["negative", "nope", "no thank you", "no", "n"])


func initParsableSubjects():
	addParsableSubject(SubjectID.SELF, ["self", "yourself", "me", "myself", "you"],
			[ActionID.INSPECT])
	addParsableSubject(SubjectID.BATHROOM, ["bathroom door", "bathroom", "brown door", "lower door", "downstairs door"],
			[ActionID.INSPECT, ActionID.OPEN, ActionID.MOVE_TO, ActionID.STEP_GENTLY, ActionID.ENTER, ActionID.DESCEND])
	addParsableSubject(SubjectID.BEDROOM,
			["bedroom door", "bedroom", "blue door", "upper door", "upstairs door",
			"top of steps", "last step", "top step", "step 6", "step six", "sixth step", "landing", ],
			[ActionID.INSPECT, ActionID.OPEN, ActionID.MOVE_TO, ActionID.STEP_GENTLY, ActionID.ENTER, ActionID.ASCEND])
	addParsableSubject(SubjectID.AMBIGUOUS_DOOR, ["door"],
			[ActionID.INSPECT, ActionID.OPEN, ActionID.MOVE_TO, ActionID.STEP_GENTLY,ActionID.ENTER,
			ActionID.DESCEND, ActionID.ASCEND])
	addParsableSubject(SubjectID.HOUSE, ["house"],
			[ActionID.INSPECT, ActionID.ENTER])
	addParsableSubject(SubjectID.CONCRETE, ["concrete pad", "concrete patio", "concrete", "pad", "patio", "ground"],
			[ActionID.INSPECT, ActionID.MOVE_TO, ActionID.STEP_GENTLY, ActionID.DESCEND])
	addParsableSubject(SubjectID.SHELF, ["shelf", "supply shelf", "tool shelf", "wooden shelf", "shelves"],
			[ActionID.INSPECT, ActionID.MOVE_TO, ActionID.STEP_GENTLY, ActionID.DESCEND])
	addParsableSubject(SubjectID.STEP_1,
			["step 1", "step one", "first step", "1st step", "grass step", "grassy step",
			"grass on step", "grass lawn", "grass", "step lawn", "lawn on step"],
			[ActionID.INSPECT, ActionID.MOVE_TO, ActionID.STEP_GENTLY, ActionID.MOW, ActionID.ASCEND, ActionID.DESCEND])
	addParsableSubject(SubjectID.STEP_2,
			["step 2", "step two", "second step", "2nd step", "rotten step", "rotten wood", "damaged step", "damaged wood"],
			[ActionID.INSPECT, ActionID.MOVE_TO, ActionID.STEP_GENTLY, ActionID.ASCEND, ActionID.DESCEND])
	addParsableSubject(SubjectID.STEP_3, ["step 3", "step three", "third step", "3rd step"],
			[ActionID.INSPECT, ActionID.MOVE_TO, ActionID.STEP_GENTLY, ActionID.ASCEND, ActionID.DESCEND])
	addParsableSubject(SubjectID.STEP_4, ["step 4", "step four", "fourth step", "4th step"],
			[ActionID.INSPECT, ActionID.MOVE_TO, ActionID.STEP_GENTLY, ActionID.ASCEND, ActionID.DESCEND])
	addParsableSubject(SubjectID.STEP_5, ["step 5", "step five", "fifth step", "5th step"],
			[ActionID.INSPECT, ActionID.MOVE_TO, ActionID.STEP_GENTLY, ActionID.ASCEND, ActionID.DESCEND])
	addParsableSubject(SubjectID.AMBIGUOUS_STEP, ["steps", "step", "wood"],
			[ActionID.INSPECT, ActionID.MOVE_TO, ActionID.STEP_GENTLY, ActionID.MOW, ActionID.ASCEND, ActionID.DESCEND])
	addParsableSubject(SubjectID.NEXT_STEP, ["next step"],
			[ActionID.INSPECT, ActionID.MOVE_TO, ActionID.STEP_GENTLY, ActionID.ASCEND])
	addParsableSubject(SubjectID.PREVIOUS_STEP, ["previous step"],
			[ActionID.INSPECT, ActionID.MOVE_TO, ActionID.STEP_GENTLY, ActionID.DESCEND])
	addParsableSubject(SubjectID.MOWER, ["mower", "lawn mower", "engine", "fuel tank", "gas tank", "tank"],
			[ActionID.INSPECT, ActionID.USE, ActionID.REFUEL, ActionID.TURN_ON, ActionID.TURN_OFF, ActionID.TURN,
			ActionID.PUT, ActionID.MOVE_TO, ActionID.OPEN, ActionID.CLOSE])
	addParsableSubject(SubjectID.GAS_CAP, ["gas cap", "cap", "gas lid", "lid"],
			[ActionID.INSPECT, ActionID.USE, ActionID.REMOVE, ActionID.REPLACE, ActionID.TAKE, ActionID.PUT,
			 ActionID.OPEN, ActionID.CLOSE])
	addParsableSubject(SubjectID.GAS, ["gasoline", "gas can", "gas", "fuel"],
			[ActionID.INSPECT, ActionID.USE, ActionID.TAKE, ActionID.REPLACE, ActionID.POUR, ActionID.PUT])
	addParsableSubject(SubjectID.SHOES, ["shoes", "pair of shoes", "both shoes", "sneakers", "pair of sneakers", "both sneakers"],
			[ActionID.INSPECT, ActionID.USE, ActionID.TAKE,
			ActionID.WEAR, ActionID.PUT, ActionID.TIE, ActionID.UNTIE, ActionID.REMOVE])
	addParsableSubject(SubjectID.RIGHT_SHOE, ["right shoe", "r shoe", "right sneaker", "r sneaker"],
			[ActionID.INSPECT, ActionID.USE, ActionID.TAKE,
			ActionID.WEAR, ActionID.PUT, ActionID.TIE, ActionID.UNTIE, ActionID.REMOVE])
	addParsableSubject(SubjectID.LEFT_SHOE, ["left shoe", "l shoe", "left sneaker", "l sneaker"],
			[ActionID.INSPECT, ActionID.USE, ActionID.TAKE,
			ActionID.WEAR, ActionID.PUT, ActionID.TIE, ActionID.UNTIE, ActionID.REMOVE])
	addParsableSubject(SubjectID.SHOE_ON_RIGHT_FOOT, ["shoe on right foot", "shoe on r foot", "sneaker on right foot"],
			[ActionID.INSPECT, ActionID.USE, ActionID.TIE, ActionID.UNTIE, ActionID.REMOVE, ActionID.TAKE])
	addParsableSubject(SubjectID.SHOE_ON_LEFT_FOOT, ["shoe on left foot", "shoe on l foot", "sneaker on left foot"],
			[ActionID.INSPECT, ActionID.USE, ActionID.TIE, ActionID.UNTIE, ActionID.REMOVE, ActionID.TAKE])
	addParsableSubject(SubjectID.AMBIGUOUS_SHOE, ["shoe", "sneaker"],
			[ActionID.INSPECT, ActionID.USE, ActionID.TAKE,
			ActionID.WEAR, ActionID.PUT, ActionID.TIE, ActionID.UNTIE, ActionID.REMOVE])
	addParsableSubject(SubjectID.FLAMETHROWER, ["flamethrower", "flame thrower", "gun"],
			[ActionID.INSPECT, ActionID.USE, ActionID.FIRE, ActionID.TAKE])
	addParsableSubject(SubjectID.CEREAL, ["boxes of cereal", "boxes", "box", "cereal", "top shelf", "cocoa puffs"],
			[ActionID.INSPECT, ActionID.TAKE, ActionID.EAT])
	addParsableSubject(SubjectID.BIRDFEEDER, ["bird feeder", "birdfeeder", "feeder"],
			[ActionID.INSPECT])
	addParsableSubject(SubjectID.FAUCET, ["faucet", "spigot"],
			[ActionID.INSPECT, ActionID.TURN_ON, ActionID.TURN_OFF, ActionID.TURN])
	addParsableSubject(SubjectID.LAWN,
			["lawn of matchsticks", "lawn of matches", "lawn",
			"matches", "matchsticks", "match sticks", "matchstick lawn", "match",
			"yard", "front yard",],
			[ActionID.INSPECT, ActionID.MOW, ActionID.MOVE_TO, ActionID.STEP_GENTLY, ActionID.LIGHT])
	addParsableSubject(SubjectID.WEEDS, ["weeds", "weed", "the bane of my homeowner existence"],
			[ActionID.INSPECT, ActionID.MOW])
	addParsableSubject(SubjectID.STUMP, ["stump", "tree stump"],
			[ActionID.INSPECT])
	addParsableSubject(SubjectID.WINDOW, ["windows", "window", "curtains", "curtain"],
			[ActionID.INSPECT])


func initParsableModifiers():
	addParsableModifier(ModifierID.GENTLY, ["gently"],
			[ActionID.MOVE_TO, ActionID.ASCEND, ActionID.DESCEND])
	addParsableModifier(ModifierID.ON_GROUND,
			["on ground", "on concrete", "on patio", "on pad"],
			[ActionID.PUT, ActionID.POUR])
	addParsableModifier(ModifierID.IN_MOWER,
			["in mower", "in lawn mower",
			"in tank", "in fuel tank", "in gas tank"],
			[ActionID.PUT, ActionID.POUR])
	addParsableModifier(ModifierID.ON_MOWER,
			["on mower", "on lawn mower"],
			[ActionID.PUT, ActionID.POUR])
	addParsableModifier(ModifierID.ON_FUEL_TANK,
			["on tank", "on fuel tank", "on gas tank"],
			[ActionID.PUT, ActionID.POUR])
	addParsableModifier(ModifierID.WITH_GAS, ["with gasoline", "with gas", "with fuel"], [ActionID.REFUEL])
	addParsableModifier(ModifierID.ON_RIGHT_FOOT,
			["on right foot", "on r foot", "on right", "on r"],
			[ActionID.PUT, ActionID.WEAR])
	addParsableModifier(ModifierID.ON_LEFT_FOOT,
			["on left foot", "on l foot", "on left", "on l"],
			[ActionID.PUT, ActionID.WEAR])
	addParsableModifier(ModifierID.ON_AMBIGUOUS_FOOT, ["on foot"],
			[ActionID.INSPECT, ActionID.PUT, ActionID.WEAR])
	addParsableModifier(ModifierID.ON_BOTH_FEET, ["on feet", "on both feet"],
			[ActionID.INSPECT, ActionID.PUT, ActionID.WEAR])
	addParsableModifier(ModifierID.ON_FIRST_STEP,
			["on first step", "on 1st step", "on step 1", "on step lawn", "on grassy step", "on grass",
			"to first step", "to 1st step", "to step 1", "to step lawn", "to grassy step", "to grass"],
			[ActionID.PUT, ActionID.MOVE_TO])
	addParsableModifier(ModifierID.ON_STEP, ["on step", "to step"],
			[ActionID.PUT, ActionID.MOVE_TO])
	addParsableModifier(ModifierID.ON, ["on"],
			[ActionID.PUT, ActionID.REPLACE, ActionID.TURN])
	addParsableModifier(ModifierID.OFF, ["off"],
			[ActionID.TAKE, ActionID.TURN])
	addParsableModifier(ModifierID.BACK, ["back on", "back"],
			[ActionID.PUT, ActionID.REPLACE])
	addParsableModifier(ModifierID.AWAY, ["away"],
			[ActionID.PUT])


func initParseSubs():
	addParseSub("stair", "step")
	addParseSub("stairs", "steps")
	addParseSub("into", "in")
	addParseSub("onto", "on")
	addParseSubs(["carefully", "lightly", "gingerly", "softly"], "gently")


func parseItems() -> String:

	parseEventsSinceLastConfirmation += 1

	if subjectID == SubjectID.NEXT_STEP: subjectID = getNextStep()
	if subjectID == SubjectID.PREVIOUS_STEP: subjectID = getPreviousStep()

	match actionID:

		ActionID.INSPECT:
			match subjectID:

				-1:
					if actionAlias == "look":
						return requestAdditionalSubjectContext("Where", [], [], ["at "])
					else:
						return requestAdditionalSubjectContext()

				SubjectID.SELF:
					return "Now that you're out of the bathroom, you're one step closer to your delicious breakfast!"

				SubjectID.BATHROOM:
					return (
						"When you had this house built, you weren't so sure about having the bathroom open directly " +
						"into the front yard, but it's proven to be quite useful.\nFor example, on windy days, you can " +
						"blow dry your hair just by opening the door, and after eating out at the local burrito buffet, " +
						"you can go to the bathroom with the door open without stinking up the whole house!"
					)

				SubjectID.BEDROOM:
					return (
						"The door at the top of the stairs leads directly to your bedroom. It's really useful when " +
						"you get home from a long day at work and want to go straight to bed."
					)

				SubjectID.AMBIGUOUS_DOOR:
					return requestAdditionalContextCustom(
						"Which door would you like to " + actionAlias + "?",
						REQUEST_SUBJECT, [], [" door"]
					)

				SubjectID.HOUSE:
					return (
						"This is your house! It's truly one of a kind."
					)

				SubjectID.CONCRETE:
					return (
						"This concrete gets extra slick when you track water onto it after a bath. " +
						"It makes for an exciting adventure trying to get up to your bedroom without suffering a concussion!"
					)

				SubjectID.STEP_1:
					if frontYard.isStepMown:
						return (
							"The grass on the first step is now neatly trimmed. That should keep the HOA off your back " +
							"for a bit."
						)
					else:
						return (
							"The first step is covered in a small, untidy lawn."
						)

				SubjectID.STEP_2:
					return (
						"Lately, this step has been looking more and more decrepit. You wonder if it has to do with " +
						"termite season starting up again..."
					)

				SubjectID.STEP_3:
					return (
						"This step looks plain enough, but you think you can hear a faint scuttling sound coming from within..."
					)

				SubjectID.STEP_4:
					return (
						"This step is perfectly safe. Trust."
					)

				SubjectID.STEP_5:
					return (
						"This step looks plain enough, but you think you can hear a faint scuttling sound coming from within..."
					)

				SubjectID.AMBIGUOUS_STEP:
					return requestAdditionalContextCustom(
						"Which step would you like to " + actionAlias + "?",
						REQUEST_SUBJECT, ["step "], [" step"]
					)

				SubjectID.SHELF:
					return (
						"This supply shelf is great for storing stuff and things!"
					)

				SubjectID.GAS:
					return (
						"You just filled this gas can up last week, so it should have plenty of fuel inside."
					)

				SubjectID.MOWER:
					return (
						"You bought this mower from a sports car dealership which advertised it as having the " +
						"fastest fuel intake on the market. It can mow your step in record time!\nIt " +
						"always seems to be running out of gas though..."
					)

				SubjectID.GAS_CAP:
					return (
						"Sometimes your mower runs so fast that the gas cap starts to unscrew itself. Cool!"
					)

				SubjectID.SHOES, SubjectID.AMBIGUOUS_SHOE, SubjectID.RIGHT_SHOE, SubjectID.LEFT_SHOE, \
				SubjectID.SHOE_ON_LEFT_FOOT, SubjectID.SHOE_ON_RIGHT_FOOT:
					return (
						"You got these limited edition \"Air Kellogs\" by purchasing 100 boxes of Frosted Flakes."
					)

				SubjectID.FLAMETHROWER:
					return (
						"This flamethrower is perfect for chasing away any squirrels that try to eat out of your bird " +
						"feeder."
					)

				SubjectID.CEREAL:
					return (
						"You use these boxes of Cocoa Puffs to fill up the bird feeder. The birds go cuckoo for them!"
					)

				SubjectID.BIRDFEEDER:
					return (
						"The bird feeder is chock full of cereal, just what a growing bird needs!"
					)

				SubjectID.FAUCET:
					return (
						"Since you don't need to water your lawn, you planted some grass below the faucet so that " +
						"it would still feel important."
					)

				SubjectID.LAWN:
					return (
						"Instead of wasting thousands of dollars on a high-maintenance grass lawn, you opted for " +
						"an eco-friendly array of strike-anywhere matches.\nYour HOA, the fire department, and your mom " +
						"don't approve, but you're pretty sure they're in the pocket of Big Grass anyway, so you just " +
						"ignore them."
					)


				SubjectID.WEEDS:
					return (
						"These weeds are the bane of your existence. How they manage to grow in a lawn of matchsticks " +
						"is beyond you."
					)

				SubjectID.STUMP:
					return (
						"You used to have a large cottonwood tree here, but you had it cut down so that the matches below " +
						"it would get enough sunlight."
					)

				SubjectID.WINDOW:
					return (
						"If the curtains weren't closed, you'd be able to see into your bedroom from this window."
					)


		ActionID.USE:
			if subjectID == SubjectID.FLAMETHROWER:
				return useFlamethrower()
			else:
				return requestSpecificAction()


		ActionID.TURN_ON:
			
			if subjectID == -1: return requestAdditionalSubjectContext()
			elif subjectID == SubjectID.MOWER: return attemptStartMower()
			elif subjectID == SubjectID.FAUCET: return (
				"The grass looks perfectly healthy right now. Turning on the faucet would just be wasteful."
			)


		ActionID.TURN_OFF:

			if subjectID == -1: return requestAdditionalSubjectContext()
			elif subjectID == SubjectID.MOWER:
				if frontYard.isMowerRunning:
					return (
						"You're actually not sure how to turn off the mower. It's okay though; it'll run out of " +
						"gas eventually and turn itself off."
					)
				else:
					return "The mower isn't on right now."
			elif subjectID == SubjectID.FAUCET: return "The faucet isn't on right now."


		ActionID.TURN:

			if subjectID == -1: return requestAdditionalSubjectContext()

			if modifierID == -1: return requestAdditionalContextCustom(
				"Would you like to turn the " + subjectAlias + " on or off?",
				REQUEST_MODIFIER
			)
			elif modifierID == ModifierID.ON:
				actionID = ActionID.TURN_ON
				modifierID = -1
				return parseItems()
			elif modifierID == ModifierID.OFF:
				actionID = ActionID.TURN_OFF
				modifierID = -1
				return parseItems()


		ActionID.MOVE_TO, ActionID.STEP_GENTLY:
			
			match subjectID:

				-1:
					return requestAdditionalSubjectContext("Where", [], [], ["on ", "to "])

				SubjectID.LAWN:
					SceneManager.transitionToScene(
						SceneManager.SceneID.ENDING,
						"The steps leading up to your bedroom seem a bit too complicated, and you decide it would " +
						"be easier to walk over the lawn instead.\nHowever, after taking a few steps over the " +
						"matchsticks, you feel a growing heat at your back. Turning around, you see that your footsteps " +
						"had ignited a few stray matches which eagerly shared their newfound warmth with their " +
						"neighbors.\n" +
						"It's not long before the entire lawn is up in flames, and the fire begins to spread elsewhere...",
						SceneManager.EndingID.OCCAMS_MATCHSTICK
					)
					return ""

				SubjectID.BATHROOM:
					return attemptMovePlayer(FrontYard.SpritePos.BATHROOM_DOOR)

				SubjectID.BEDROOM:
					return attemptMovePlayer(FrontYard.SpritePos.BEDROOM_DOOR)

				SubjectID.AMBIGUOUS_DOOR:
					return requestAdditionalContextCustom(
						"Which door would you like to " + actionAlias + "?",
						REQUEST_SUBJECT, [], [" door"]
					)

				SubjectID.CONCRETE:
					return attemptMovePlayer(FrontYard.SpritePos.BATHROOM_DOOR)

				SubjectID.SHELF:
					return attemptMovePlayer(FrontYard.SpritePos.IN_FRONT_OF_SHELF)

				SubjectID.STEP_1:
					return attemptMovePlayer(FrontYard.SpritePos.STEP_1)

				SubjectID.STEP_2:
					if modifierID == ModifierID.GENTLY or actionID == ActionID.STEP_GENTLY:
						return attemptMovePlayer(FrontYard.SpritePos.STEP_2, true)
					else:
						return attemptMovePlayer(FrontYard.SpritePos.STEP_2, false)

				SubjectID.STEP_3:
					return attemptMovePlayer(FrontYard.SpritePos.STEP_3)

				SubjectID.STEP_4:
					return attemptMovePlayer(FrontYard.SpritePos.STEP_4)

				SubjectID.STEP_5:
					return attemptMovePlayer(FrontYard.SpritePos.STEP_5)

				SubjectID.AMBIGUOUS_STEP:
					return requestAdditionalContextCustom(
						"Which step would you like to " + actionAlias + "?",
						REQUEST_SUBJECT, ["step "], [" step"]
					)

				SubjectID.MOWER:
					if modifierID == ModifierID.ON_FIRST_STEP or modifierID == ModifierID.ON_STEP:
						return attemptMowGrass(false)
					else:
						var mowerPosition: int
						if frontYard.isStepMown: mowerPosition = frontYard.SpritePos.BATHROOM_DOOR
						else: mowerPosition = frontYard.SpritePos.IN_FRONT_OF_SHELF
						return attemptMovePlayer(mowerPosition)


		ActionID.ASCEND:

			if subjectID == -1 or subjectID == SubjectID.AMBIGUOUS_STEP:

				match frontYard.playerPos:
					
					frontYard.SpritePos.BATHROOM_DOOR, frontYard.SpritePos.IN_FRONT_OF_SHELF:
						return attemptMovePlayer(FrontYard.SpritePos.STEP_1)

					frontYard.SpritePos.STEP_1:
						if modifierID == ModifierID.GENTLY:
							return attemptMovePlayer(FrontYard.SpritePos.STEP_2, true)
						else:
							return attemptMovePlayer(FrontYard.SpritePos.STEP_2, false)

					frontYard.SpritePos.STEP_2:
						return attemptMovePlayer(FrontYard.SpritePos.STEP_3)

					frontYard.SpritePos.STEP_3:
						return attemptMovePlayer(FrontYard.SpritePos.STEP_4)

					frontYard.SpritePos.STEP_4:
						return attemptMovePlayer(FrontYard.SpritePos.STEP_5)

					frontYard.SpritePos.STEP_5:
						return attemptMovePlayer(FrontYard.SpritePos.BEDROOM_DOOR)

					frontYard.SpritePos.BEDROOM_DOOR:
						return "You're already at the top of the stairs."

			else:
				actionID = ActionID.MOVE_TO
				return parseItems()


		ActionID.DESCEND:

			if subjectID == -1 or subjectID == SubjectID.AMBIGUOUS_STEP:

				match frontYard.playerPos:
					
					frontYard.SpritePos.BATHROOM_DOOR, frontYard.SpritePos.IN_FRONT_OF_SHELF:
						return "You're already at the bottom of the stairs."

					frontYard.SpritePos.STEP_1:
						return attemptMovePlayer(FrontYard.SpritePos.BATHROOM_DOOR)

					frontYard.SpritePos.STEP_2:
						return attemptMovePlayer(FrontYard.SpritePos.STEP_1)

					frontYard.SpritePos.STEP_3:
						if modifierID == ModifierID.GENTLY:
							return attemptMovePlayer(FrontYard.SpritePos.STEP_2, true)
						else:
							return attemptMovePlayer(FrontYard.SpritePos.STEP_2, false)

					frontYard.SpritePos.STEP_4:
						return attemptMovePlayer(FrontYard.SpritePos.STEP_3)

					frontYard.SpritePos.STEP_5:
						return attemptMovePlayer(FrontYard.SpritePos.STEP_4)

					frontYard.SpritePos.BEDROOM_DOOR:
						return attemptMovePlayer(FrontYard.SpritePos.STEP_5)

			else:
				actionID = ActionID.MOVE_TO
				return parseItems()


		ActionID.OPEN, ActionID.ENTER:
			
			var playerPos := frontYard.playerPos

			if subjectID == -1:
				return requestAdditionalSubjectContext()

			elif subjectID == SubjectID.AMBIGUOUS_DOOR:
				return requestAdditionalContextCustom(
					"Which door would you like to " + actionAlias + "?",
					REQUEST_SUBJECT, [], [" door"]
				)
			
			elif subjectID == SubjectID.BATHROOM:
				if frontYard.isPlayerOnConcrete():
					return "You just got out of the bathroom. You need to keep moving forward to get your breakfast!"
				else:
					return "You can't reach the bathroom door from your current position."
			
			elif subjectID == SubjectID.BEDROOM:
				if frontYard.playerPos == frontYard.SpritePos.BEDROOM_DOOR:
					SceneManager.transitionToScene(SceneManager.SceneID.BEDROOM)
					return ""
				else:
					return "You can't reach the bedroom door from your current position."
			
			elif subjectID == SubjectID.HOUSE:
				if frontYard.playerPos == frontYard.SpritePos.BEDROOM_DOOR:
					SceneManager.transitionToScene(SceneManager.SceneID.BEDROOM)
					return ""
				else:
					return (
						"You'll need to enter your house from the upper door to get to your bedroom, but " +
						"you can't reach it from your current position."
					)
			
			elif actionID == ActionID.OPEN and subjectID in [SubjectID.MOWER, SubjectID.GAS_CAP]:
				if frontYard.isPlayerOnConcrete():

					var mowerPosition: int
					if frontYard.isStepMown: mowerPosition = frontYard.SpritePos.BATHROOM_DOOR
					else: mowerPosition = frontYard.SpritePos.IN_FRONT_OF_SHELF

					if checkForFall(mowerPosition):
						return ""
					else:
						frontYard.movePlayer(mowerPosition)
						if frontYard.mowerHasCap:
							if frontYard.isMowerRunning: return removeCapOnRunningMower()
							frontYard.removeCap()
							return "You unscrew the gas cap from the fuel tank and place it on the mower."
						else:
							return "You've already removed the gas cap from the fuel tank."
				else:
					return "You can't reach the " + subjectAlias + " from your current location."


		ActionID.CLOSE:

			if subjectID == -1:
				return requestAdditionalSubjectContext()

			elif subjectID == SubjectID.AMBIGUOUS_DOOR:
				return requestAdditionalContextCustom(
					"Which door would you like to " + actionAlias + "?",
					REQUEST_SUBJECT, [], [" door"]
				)
			
			elif subjectID == SubjectID.BATHROOM or subjectID == SubjectID.BEDROOM:
				return "That door is already closed."

			elif subjectID == SubjectID.MOWER or subjectID == SubjectID.GAS_CAP:
				if frontYard.isPlayerOnConcrete():

					var mowerPosition: int
					if frontYard.isStepMown: mowerPosition = frontYard.SpritePos.BATHROOM_DOOR
					else: mowerPosition = frontYard.SpritePos.IN_FRONT_OF_SHELF

					if checkForFall(mowerPosition):
						return ""
					else:
						frontYard.movePlayer(mowerPosition)
						if frontYard.mowerHasCap:
							return "The gas cap is already firmly screwed on."
						else:
							frontYard.replaceCap()
							return (
								"You pick up the gas cap and screw it back onto the opening " +
								"of the fuel tank."
							)
				else:
					return "You can't reach the " + subjectAlias + " from your current location."



		ActionID.TAKE:
			
			if modifierID == ModifierID.OFF:
				actionID = ActionID.REMOVE
				modifierID = -1
				return parseItems()

			match subjectID:

				-1:
					return requestAdditionalSubjectContext()
				
				SubjectID.GAS_CAP:
					if frontYard.isPlayerOnConcrete():

						var mowerPosition: int
						if frontYard.isStepMown: mowerPosition = frontYard.SpritePos.BATHROOM_DOOR
						else: mowerPosition = frontYard.SpritePos.IN_FRONT_OF_SHELF

						if checkForFall(mowerPosition):
							return ""
						else:
							frontYard.movePlayer(mowerPosition)
							if frontYard.mowerHasCap:
								if frontYard.isMowerRunning: return removeCapOnRunningMower()
								frontYard.removeCap()
								return "You unscrew the gas cap from the fuel tank and place it on the mower."
							else:
								frontYard.replaceCap()
								return (
									"You pick up the gas cap and decide it's probably best to seal up the fuel tank for " +
									"now. You place it back on the tank's opening and screw it on tightly."
								)
					else:
						return "You can't reach the gas cap from your current location."

				SubjectID.GAS:
					if frontYard.playerHasGasoline:
						return "You're already holding the gasoline."
					elif frontYard.isPlayerOnConcrete():
						if checkForFall(frontYard.SpritePos.IN_FRONT_OF_SHELF):
							return ""
						else:
							frontYard.movePlayer(frontYard.SpritePos.IN_FRONT_OF_SHELF)
							frontYard.takeGasoline()
							return "You pick up the gasoline."
					else:
						return "You can't reach the gasoline from your current location."
						

				SubjectID.FLAMETHROWER:
					if frontYard.isPlayerOnConcrete():
						if checkForFall(frontYard.SpritePos.IN_FRONT_OF_SHELF):
							return ""
						else:
							frontYard.movePlayer(frontYard.SpritePos.IN_FRONT_OF_SHELF)
							return useFlamethrower()
					else:
						return "You can't reach the flamethrower from your current location."

				SubjectID.CEREAL:
					return (
						"These Cocoa Puffs would make for a good breakfast, but you don't have any milk. " +
						"It's best if you leave them for the birds."
					)

				SubjectID.SHOES, SubjectID.RIGHT_SHOE, SubjectID.LEFT_SHOE, SubjectID.AMBIGUOUS_SHOE,\
				SubjectID.SHOE_ON_RIGHT_FOOT, SubjectID.SHOE_ON_LEFT_FOOT:
					return "You don't see a need to carry your shoes anywhere when you can just put them on instead."


		ActionID.EAT:
			match subjectID:

				-1:
					return requestAdditionalSubjectContext()

				SubjectID.CEREAL:
					return (
						"These Cocoa Puffs would make for a good breakfast, but you don't have any milk. " +
						"It's best if you leave them for the birds."
					)


		ActionID.REMOVE:
			
			match subjectID:

				-1:
					return requestAdditionalSubjectContext()
			
				SubjectID.GAS_CAP:
					if frontYard.isPlayerOnConcrete():

						var mowerPosition: int
						if frontYard.isStepMown: mowerPosition = frontYard.SpritePos.BATHROOM_DOOR
						else: mowerPosition = frontYard.SpritePos.IN_FRONT_OF_SHELF

						if checkForFall(mowerPosition):
							return ""
						else:
							frontYard.movePlayer(mowerPosition)
							if frontYard.mowerHasCap:
								if frontYard.isMowerRunning: return removeCapOnRunningMower()
								frontYard.removeCap()
								return "You unscrew the gas cap from the fuel tank and place it on the mower."
							else:
								return "You've already removed the gas cap from the fuel tank."
					else:
						return "You can't reach the gas cap from your current location."

				SubjectID.SHOES:
					return attemptRemoveShoe(PLURAL)
				
				SubjectID.RIGHT_SHOE:
					return attemptRemoveShoe(RIGHT)

				SubjectID.LEFT_SHOE:
					return attemptRemoveShoe(LEFT)

				SubjectID.SHOE_ON_RIGHT_FOOT:
					if frontYard.isShoeOnRightFoot():
						if frontYard.areShoesMismatched:
							return attemptRemoveShoe(LEFT)
						else:
							return attemptRemoveShoe(RIGHT)
					else:
						return "You're not wearing a shoe on that foot right now."

				SubjectID.SHOE_ON_LEFT_FOOT:
					if frontYard.isShoeOnLeftFoot():
						if frontYard.areShoesMismatched:
							return attemptRemoveShoe(RIGHT)
						else:
							return attemptRemoveShoe(LEFT)
					else:
						return "You're not wearing a shoe on that foot right now."

				SubjectID.AMBIGUOUS_SHOE:
					return attemptRemoveShoe(AMBIGUOUS)


		ActionID.REPLACE:

			match subjectID:

				-1:
					return requestAdditionalSubjectContext()
			
				SubjectID.GAS_CAP:
					if frontYard.isPlayerOnConcrete():

						var mowerPosition: int
						if frontYard.isStepMown: mowerPosition = frontYard.SpritePos.BATHROOM_DOOR
						else: mowerPosition = frontYard.SpritePos.IN_FRONT_OF_SHELF

						if checkForFall(mowerPosition):
							return ""
						else:
							frontYard.movePlayer(mowerPosition)
							if frontYard.mowerHasCap:
								return "The gas cap is already firmly screwed on."
							else:
								frontYard.replaceCap()
								return (
									"You pick up the gas cap and screw it back onto the opening " +
									"of the fuel tank."
								)
					else:
						return "You can't reach the gas cap from your current location."

				SubjectID.GAS:
					if not frontYard.playerHasGasoline:
						return "You're not holding the gasoline."
					elif frontYard.isPlayerOnConcrete():
						if checkForFall(frontYard.SpritePos.IN_FRONT_OF_SHELF):
							return ""
						else:
							frontYard.movePlayer(frontYard.SpritePos.IN_FRONT_OF_SHELF)
							frontYard.returnGasoline()
							return "You put the gasoline back on the shelf."
					else:
						return "You can't reach the shelf from here."


		ActionID.PUT:

			match subjectID:

				-1: return requestAdditionalSubjectContext()

				SubjectID.MOWER:
					match modifierID:
						-1: return requestAdditionalModifierContext("How", "", ["on "])
						ModifierID.ON:
							return requestAdditionalModifierContext("What", "", ["on "])
						ModifierID.ON_GROUND:
							return "The mower's already on the ground, silly!"
						ModifierID.ON_STEP, ModifierID.ON_FIRST_STEP:
							return attemptMowGrass(false)
							

				SubjectID.GAS_CAP:
					match modifierID:
						-1: return requestAdditionalModifierContext("How", "", ["on "])
						ModifierID.ON:
							return requestAdditionalModifierContext("What", "", ["on "])
						ModifierID.ON_MOWER, ModifierID.ON_FUEL_TANK, ModifierID.BACK:
							if frontYard.isPlayerOnConcrete():

								var mowerPosition: int
								if frontYard.isStepMown: mowerPosition = frontYard.SpritePos.BATHROOM_DOOR
								else: mowerPosition = frontYard.SpritePos.IN_FRONT_OF_SHELF

								if checkForFall(mowerPosition):
									return ""
								else:
									frontYard.movePlayer(mowerPosition)
									if frontYard.mowerHasCap:
										if modifierID == ModifierID.ON_FUEL_TANK or modifierID == ModifierID.BACK:
											return "The gas cap is already firmly screwed on."
										else:
											if frontYard.isMowerRunning: return removeCapOnRunningMower()
											frontYard.removeCap()
											return "You unscrew the gas cap and place it on the mower."
									else:
										if modifierID == ModifierID.ON_FUEL_TANK or modifierID == ModifierID.BACK:
											frontYard.replaceCap()
											return (
												"You pick up the gas cap and screw it back onto the opening " +
												"of the fuel tank."
											)
										else:
											return "The gas cap is already resting on the mower."
							else:
								return "You can't reach the gas cap from your current location."

				SubjectID.GAS:
					match modifierID:
						-1: return requestAdditionalModifierContext("How", "", ["on "])
						ModifierID.ON:
							return requestAdditionalModifierContext("What", "", ["on "])
						ModifierID.ON_GROUND:
							return attemptFuelMower(false, true)
						ModifierID.ON_MOWER, ModifierID.ON_FUEL_TANK:
							return attemptFuelMower(true)
						ModifierID.IN_MOWER:
							return attemptFuelMower(false)
						ModifierID.BACK, ModifierID.AWAY:
							if not frontYard.playerHasGasoline:
								return "You're not holding the gasoline."
							elif frontYard.isPlayerOnConcrete():
								if checkForFall(frontYard.SpritePos.IN_FRONT_OF_SHELF):
									return ""
								else:
									frontYard.movePlayer(frontYard.SpritePos.IN_FRONT_OF_SHELF)
									frontYard.returnGasoline()
									return "You put the gasoline back on the shelf."
							else:
								return "You can't reach the shelf from here."

				SubjectID.SHOES:
					match modifierID:
						-1: return requestAdditionalModifierContext("How", "", ["on "])
						ModifierID.ON, ModifierID.ON_BOTH_FEET:
							return attemptPutOnShoe(PLURAL, AMBIGUOUS)
						ModifierID.BACK, ModifierID.AWAY:
							if frontYard.isPlayerOnConcrete() or (
								not frontYard.isPlayerWearingRightShoe and not frontYard.isPlayerWearingLeftShoe
							): return attemptRemoveShoe(PLURAL)
							else: return "You can't put your shoes back on the shelf from where you're currently standing."

				SubjectID.RIGHT_SHOE:
					match modifierID:
						-1: return requestAdditionalModifierContext("How", "", ["on "])
						ModifierID.ON, ModifierID.ON_AMBIGUOUS_FOOT:
							return attemptPutOnShoe(RIGHT, AMBIGUOUS)
						ModifierID.ON_RIGHT_FOOT:
							return attemptPutOnShoe(RIGHT, RIGHT)
						ModifierID.ON_LEFT_FOOT:
							return attemptPutOnShoe(RIGHT, LEFT)
						ModifierID.BACK, ModifierID.AWAY:
							if frontYard.isPlayerOnConcrete() or (
								not frontYard.isPlayerWearingRightShoe and not frontYard.isPlayerWearingLeftShoe
							): return attemptRemoveShoe(RIGHT)
							else: return "You can't put that shoe back on the shelf from where you're currently standing."

				SubjectID.LEFT_SHOE:
					match modifierID:
						-1: return requestAdditionalModifierContext("How", "", ["on "])
						ModifierID.ON, ModifierID.ON_AMBIGUOUS_FOOT:
							return attemptPutOnShoe(LEFT, AMBIGUOUS)
						ModifierID.ON_RIGHT_FOOT:
							return attemptPutOnShoe(LEFT, RIGHT)
						ModifierID.ON_LEFT_FOOT:
							return attemptPutOnShoe(LEFT, LEFT)
						ModifierID.BACK, ModifierID.AWAY:
							if frontYard.isPlayerOnConcrete() or (
								not frontYard.isPlayerWearingRightShoe and not frontYard.isPlayerWearingLeftShoe
							): return attemptRemoveShoe(LEFT)
							else: return "You can't put that shoe back on the shelf from where you're currently standing."

				SubjectID.AMBIGUOUS_SHOE:
					match modifierID:
						-1: return requestAdditionalModifierContext("How", "", ["on "])
						ModifierID.BACK, ModifierID.AWAY:
							if frontYard.isPlayerOnConcrete() or (
								not frontYard.isPlayerWearingRightShoe and not frontYard.isPlayerWearingLeftShoe
							): return attemptRemoveShoe(AMBIGUOUS)
							else: return "You can't put your shoe back on the shelf from where you're currently standing."
						ModifierID.ON, ModifierID.ON_AMBIGUOUS_FOOT, ModifierID.ON_RIGHT_FOOT, ModifierID.ON_LEFT_FOOT:
							return attemptPutOnShoe(AMBIGUOUS, AMBIGUOUS)


		ActionID.WEAR:
			match subjectID:

				-1: return requestAdditionalSubjectContext()

				SubjectID.SHOES:
					match modifierID:
						ModifierID.ON, ModifierID.ON_BOTH_FEET, -1:
							return attemptPutOnShoe(PLURAL, AMBIGUOUS)

				SubjectID.RIGHT_SHOE:
					match modifierID:
						ModifierID.ON, ModifierID.ON_AMBIGUOUS_FOOT, -1:
							return attemptPutOnShoe(RIGHT, AMBIGUOUS)
						ModifierID.ON_RIGHT_FOOT:
							return attemptPutOnShoe(RIGHT, RIGHT)
						ModifierID.ON_LEFT_FOOT:
							return attemptPutOnShoe(RIGHT, LEFT)

				SubjectID.LEFT_SHOE:
					match modifierID:
						ModifierID.ON, ModifierID.ON_AMBIGUOUS_FOOT, -1:
							return attemptPutOnShoe(LEFT, AMBIGUOUS)
						ModifierID.ON_RIGHT_FOOT:
							return attemptPutOnShoe(LEFT, RIGHT)
						ModifierID.ON_LEFT_FOOT:
							return attemptPutOnShoe(LEFT, LEFT)

				SubjectID.AMBIGUOUS_SHOE:
					return attemptPutOnShoe(AMBIGUOUS, AMBIGUOUS)


		ActionID.TIE:

			match subjectID:

				-1: return requestAdditionalSubjectContext()

				SubjectID.SHOES:
					return attemptTieShoe(PLURAL)
				
				SubjectID.RIGHT_SHOE:
					return attemptTieShoe(RIGHT)

				SubjectID.LEFT_SHOE:
					return attemptTieShoe(LEFT)

				SubjectID.SHOE_ON_RIGHT_FOOT:
					if frontYard.isShoeOnRightFoot():
						if frontYard.areShoesMismatched:
							return attemptTieShoe(LEFT)
						else:
							return attemptTieShoe(RIGHT)
					else:
						return "You're not wearing a shoe on that foot right now."

				SubjectID.SHOE_ON_LEFT_FOOT:
					if frontYard.isShoeOnLeftFoot():
						if frontYard.areShoesMismatched:
							return attemptTieShoe(RIGHT)
						else:
							return attemptTieShoe(LEFT)
					else:
						return "You're not wearing a shoe on that foot right now."

				SubjectID.AMBIGUOUS_SHOE:
					return attemptTieShoe(AMBIGUOUS)


		ActionID.UNTIE:
			match subjectID:

				-1: return requestAdditionalSubjectContext()

				SubjectID.SHOES:
					return attemptUntieShoe(PLURAL)
				
				SubjectID.RIGHT_SHOE:
					return attemptUntieShoe(RIGHT)

				SubjectID.LEFT_SHOE:
					return attemptUntieShoe(LEFT)

				SubjectID.SHOE_ON_RIGHT_FOOT:
					if frontYard.isShoeOnRightFoot():
						if frontYard.areShoesMismatched:
							return attemptUntieShoe(LEFT)
						else:
							return attemptUntieShoe(RIGHT)
					else:
						return "You're not wearing a shoe on that foot right now."

				SubjectID.SHOE_ON_LEFT_FOOT:
					if frontYard.isShoeOnLeftFoot():
						if frontYard.areShoesMismatched:
							return attemptUntieShoe(RIGHT)
						else:
							return attemptUntieShoe(LEFT)
					else:
						return "You're not wearing a shoe on that foot right now."

				SubjectID.AMBIGUOUS_SHOE:
					return attemptUntieShoe(AMBIGUOUS)


		ActionID.REFUEL:
			match subjectID:
				-1: return requestAdditionalSubjectContext()
				SubjectID.MOWER: return attemptFuelMower(false)


		ActionID.POUR:
			match subjectID:
				-1:
					if frontYard.playerHasGasoline:
						return attemptFuelMower(true)
					else:
						return "You're not holding anything you can pour out right now."
				
				SubjectID.GAS:
					match modifierID:
						ModifierID.ON:
							return requestAdditionalModifierContext("What", "", ["on "])
						ModifierID.ON_GROUND:
							return attemptFuelMower(false, true)
						ModifierID.ON_MOWER, ModifierID.ON_FUEL_TANK, -1:
							return attemptFuelMower(true)
						ModifierID.IN_MOWER:
							return attemptFuelMower(false)


		ActionID.MOW:
			match subjectID:

				-1: return requestAdditionalSubjectContext()

				SubjectID.STEP_1, SubjectID.AMBIGUOUS_STEP:
					return attemptMowGrass(false)
				SubjectID.LAWN when subjectAlias.to_lower() == "lawn":
					return attemptMowGrass(true)
				SubjectID.LAWN when subjectAlias.to_lower() != "lawn":
					return attemptMowGrass(false, true)
				SubjectID.WEEDS:
					return attemptMowGrass(false, true, true)


		ActionID.FIRE:
			return useFlamethrower()


		ActionID.LIGHT:
			if subjectID == -1:
				return requestAdditionalSubjectContext()
			else:
				SceneManager.transitionToScene(
					SceneManager.SceneID.ENDING,
					"It's been a while since you laid down your matchstick lawn, and you decide you should make sure " +
					"it's still functional.\nYou scrape one of the nearby matches against the concrete pad and find " +
					"out very quickly that it does indeed still work. Soon after, you can easily deduce that the " +
					"rest of the matches still work too.",
					SceneManager.EndingID.OCCAMS_MATCHSTICK
				)
				return ""


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
			SceneManager.openEndings(frontYard)
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


func useFlamethrower():
	SceneManager.transitionToScene(
		SceneManager.SceneID.ENDING,
		"It's been a while since you've fired up your trusty flamethrower, and you just can't help taking it down from " +
		"the shelf to see if it still works.\n" +
		"As you pull the weapon from its resting place, it slips comfortably into your grasp, and before you " +
		"know what's happening, the action hero lying dormant in your heart roars to life. Imaginary aliens and ethereal " +
		"monsters are no match for the might of your flamethrower as you whirl around in frenzied circles, blasting " +
		"your surroundings with endless streams of fire.\nIn your heart, you are victorious, but in reality " +
		"you have only succeeded in filling the air with smoke, ash, and an endless stream of witty one-liners.",
		SceneManager.EndingID.FLAME_THROWING_THE_GAME
	)
	return ""


func attemptMovePlayer(movingTo: FrontYard.SpritePos, gently := false) -> String:
	
	var movingFrom := frontYard.playerPos
	var SpritePos := frontYard.SpritePos
	var TOO_MANY_STEPS := (
		"There are too many steps between you and your destination. You'll need to take them one at a time."
	)

	if movingTo == movingFrom:
		return "You're already there, so there's no need to " + reconstructCommand() + "."
	
	match movingTo:

		FrontYard.SpritePos.BATHROOM_DOOR:
			if movingFrom != SpritePos.STEP_1 and movingFrom != SpritePos.IN_FRONT_OF_SHELF:
				return TOO_MANY_STEPS
			else:
				if checkForFall(movingTo):
					return ""
				else:
					frontYard.movePlayer(movingTo)
					return "You walk over to the bathroom door."
		
		FrontYard.SpritePos.IN_FRONT_OF_SHELF:
			if movingFrom != SpritePos.STEP_1 and movingFrom != SpritePos.BATHROOM_DOOR:
				return TOO_MANY_STEPS
			else:
				if checkForFall(movingTo):
					return ""
				else:
					frontYard.movePlayer(movingTo)
					return "You walk over to the supply shelf."
		
		FrontYard.SpritePos.STEP_1:
			if (movingFrom != SpritePos.STEP_2 and
				movingFrom != SpritePos.BATHROOM_DOOR and
				movingFrom != SpritePos.IN_FRONT_OF_SHELF):
				return TOO_MANY_STEPS
			else:
				if checkForFall(movingTo):
					return ""
				elif frontYard.playerHasGasoline:
					return (
						"You're a bit out of shape, and you're worried that carrying the gas can as you " +
						"climb the steps will throw you off balance. You should probably put it back on the shelf first."
					)
				else:
					frontYard.movePlayer(movingTo)
					if not frontYard.isStepMown and (frontYard.isPlayerWearingRightShoe or frontYard.isPlayerWearingLeftShoe):
						frontYard.entanglePlayer()
						return (
							"As you move to occupy the first step alongside the overgrown grass, its unruly blades tangle " +
							"and ensnare the laces on your shoes. It seems it has no intention of letting go..."
						)
					elif frontYard.isStepMown:
						return (
							"You step confidently onto the newly trimmed mini-lawn and take a moment to appreciate " +
							"the scent of freshly cut grass."
						)
					else:
						return (
							"You step barefoot into the unkempt grass. It's itchy and uncomfortable."
						)
		
		FrontYard.SpritePos.STEP_2:
			if movingFrom != SpritePos.STEP_1 and movingFrom != SpritePos.STEP_3:
				return TOO_MANY_STEPS
			else:
				if checkForFall(movingTo):
					return ""
				else:
					frontYard.movePlayer(movingTo)
					if not gently:
						SceneManager.transitionToScene(
							SceneManager.SceneID.ENDING,
							"You move onto the second step with an air of misplaced confidence as the wood buckles beneath " +
							"you and your foot crashes into the rotten wood below. It seems that the termites living " +
							"in this step had done more damage than you realized...\nStraining yourself, you wrench your foot " +
							"out of its " +
							"wooden prison, but in doing so, send yourself tumbling backwards into the matchstick lawn.\n" +
							"If the termites' home wasn't already destroyed by your boisterous foot, the spreading flames " +
							"will certainly do the trick.",
							SceneManager.EndingID.HOMEWRECKER
						)
						return ""
					if movingFrom == SpritePos.STEP_1:
						return (
							"You gently step up onto the damaged wood. It feels much less than secure, " +
							"but seems to be holding for now."
						)
					elif movingFrom == SpritePos.STEP_3:
						return "You return to the second step, taking care not to damage it further."
		
		FrontYard.SpritePos.STEP_3:
			if movingFrom != SpritePos.STEP_2 and movingFrom != SpritePos.STEP_4:
				return TOO_MANY_STEPS
			else:
				if checkForFall(movingTo):
					return ""
				else:
					frontYard.movePlayer(movingTo)
					if checkForFootFetish(): return ""
					if movingFrom == SpritePos.STEP_2:
						return (
							"You ascend to the third step with your trusty shoes. You can feel the termites " +
							"milling around below you, but they seem disinterested in you for now. Whew!"
						)
					elif movingFrom == SpritePos.STEP_4:
						return "You move back to the fourth step."
		
		FrontYard.SpritePos.STEP_4:
			if movingFrom != SpritePos.STEP_3 and movingFrom != SpritePos.STEP_5:
				return TOO_MANY_STEPS
			else:
				if checkForFall(movingTo):
					return ""
				else:
					frontYard.movePlayer(movingTo)
					if movingFrom == SpritePos.STEP_3:
						return "You climb up to the fourth step. It's oddly peaceful here..."
					elif movingFrom == SpritePos.STEP_5:
						return "You descend back to the fourth step."
		
		FrontYard.SpritePos.STEP_5:
			if movingFrom != SpritePos.STEP_4 and movingFrom != SpritePos.BEDROOM_DOOR:
				return TOO_MANY_STEPS
			else:
				if checkForFall(movingTo):
					return ""
				else:
					frontYard.movePlayer(movingTo)
					if frontYard.isPlayerWearingRightShoe or frontYard.isPlayerWearingLeftShoe:
						SceneManager.transitionToScene(
							SceneManager.SceneID.ENDING,
							"The fifth step is home to termites with a very unique taste for athletic footwear, " +
							"and your shoes are just their style! They eagerly scurry out of the step, and you watch " +
							"in dismay as they begin to dig into your " +
							"favorite pair of Air Kellogs.\nWell, if you can't have them, nobody can! " +
							"You quickly remove the shoes, toss them defiantly into the lawn, and let the resulting " +
							"fire claim them.",
							SceneManager.EndingID.SHOEFFLE
						)
						return ""
					elif movingFrom == SpritePos.BEDROOM_DOOR:
						return "You walk back down to the fifth step."
					elif movingFrom == SpritePos.STEP_4:
						return "You step gingerly onto the fifth step with bare feet... Seems safe enough!"

		
		FrontYard.SpritePos.BEDROOM_DOOR:
			if movingFrom != SpritePos.STEP_5:
				return TOO_MANY_STEPS
			else:
				if checkForFall(movingTo):
					return ""
				else:
					frontYard.movePlayer(movingTo)
					return "You approach the door leading to your bedroom."

	return unknownParse()


func attemptPutOnShoe(whichShoe: int, whichFoot: int) -> String:

	if frontYard.isPlayerWearingRightShoe and frontYard.isPlayerWearingLeftShoe:
		return "You're already wearing both your shoes."

	if whichShoe == AMBIGUOUS:
		return requestAdditionalContextCustom("Which shoe do you want to put on?", REQUEST_SUBJECT, [], [" shoe", " shoes"])

	if whichShoe == PLURAL and (frontYard.isPlayerWearingRightShoe or frontYard.isPlayerWearingLeftShoe):
		if frontYard.isPlayerWearingRightShoe:
			whichShoe = LEFT
		else:
			whichShoe = RIGHT

	if whichShoe == RIGHT:
		if not frontYard.canPlayerReachRightShoe():
			return "You can't reach that shoe from where you are right now."
		elif frontYard.isPlayerWearingRightShoe:
			return "You're already wearing your right shoe."
		elif whichFoot == PLURAL:
			return "You can't put one shoe on both feet, silly!"
		else:

			if frontYard.rightShoePos == frontYard.SpritePos.ON_SHELF:
				if checkForFall(frontYard.SpritePos.IN_FRONT_OF_SHELF): return ""
				else: frontYard.movePlayer(frontYard.SpritePos.IN_FRONT_OF_SHELF)
			
			if frontYard.isRightShoeTied:
				return "You try in vain to put on the shoe, but since it's still tied tight, your foot simply won't fit."
			elif whichFoot == AMBIGUOUS:
				if frontYard.isShoeOnLeftFoot():
					frontYard.putOnRightShoe(true)
					return "You put the shoe on your right foot."
				else:
					frontYard.putOnRightShoe(false)
					return "You put the shoe on your left foot."
			elif whichFoot == RIGHT:
				if frontYard.isShoeOnRightFoot():
					return "You're already wearing a shoe on your right foot..."
				else:
					frontYard.putOnRightShoe(true)
					return "You put the shoe on your right foot."
			elif whichFoot == LEFT:
				if frontYard.isShoeOnLeftFoot():
					return "You're already wearing a shoe on your left foot..."
				else:
					frontYard.putOnRightShoe(false)
					return "You put the shoe on your left foot."
	
	elif whichShoe == LEFT:
		if not frontYard.canPlayerReachLeftShoe():
			return "You can't reach that shoe from where you are right now."
		elif frontYard.isPlayerWearingLeftShoe:
			return "You're already wearing your left shoe."
		elif whichFoot == PLURAL:
			return "You can't put one shoe on both feet, silly!"
		else:

			if frontYard.leftShoePos == frontYard.SpritePos.ON_SHELF:
				if checkForFall(frontYard.SpritePos.IN_FRONT_OF_SHELF): return ""
				else: frontYard.movePlayer(frontYard.SpritePos.IN_FRONT_OF_SHELF)
			
			if frontYard.isLeftShoeTied:
				return "You try in vain to put on the shoe, but since it's still tied tight, your foot simply won't fit."
			elif whichFoot == AMBIGUOUS:
				if frontYard.isShoeOnRightFoot():
					frontYard.putOnLeftShoe(true)
					return "You put the shoe on your left foot."
				else:
					frontYard.putOnLeftShoe(false)
					return "You put the shoe on your right foot."
			elif whichFoot == RIGHT:
				if frontYard.isShoeOnRightFoot():
					return "You're already wearing a shoe on your right foot..."
				else:
					frontYard.putOnLeftShoe(false)
					return "You put the shoe on your right foot."
			elif whichFoot == LEFT:
				if frontYard.isShoeOnLeftFoot():
					return "You're already wearing a shoe on your left foot..."
				else:
					frontYard.putOnLeftShoe(true)
					return "You put the shoe on your left foot."

	elif whichShoe == PLURAL:
		if not frontYard.canPlayerReachRightShoe() or not frontYard.canPlayerReachLeftShoe():
			return "You can't reach both shoes right now."
		elif frontYard.isRightShoeTied or frontYard.isLeftShoeTied:
			return "Both shoes need to be untied before you can put them on."
		else:
			if frontYard.rightShoePos == frontYard.SpritePos.ON_SHELF or frontYard.leftShoePos == frontYard.SpritePos.ON_SHELF:
				if checkForFall(frontYard.SpritePos.IN_FRONT_OF_SHELF): return ""
				else: frontYard.movePlayer(frontYard.SpritePos.IN_FRONT_OF_SHELF)
			frontYard.putOnRightShoe(false)
			frontYard.putOnLeftShoe(false)
			return "You put both shoes on, but they don't feel quite right..."

	return unknownParse()

func attemptRemoveShoe(whichShoe: int) -> String:

	if not frontYard.isShoeOnLeftFoot() and not frontYard.isShoeOnRightFoot():
		return "You're not wearing any shoes right now."

	if whichShoe == AMBIGUOUS:
		if frontYard.isPlayerWearingLeftShoe and frontYard.isPlayerWearingRightShoe:
			return requestAdditionalContextCustom(
				"Which shoe would you like to " + actionAlias + "?",
				REQUEST_SUBJECT, ["shoe ", "shoe on "], [" shoe", " shoes"]
			)
		elif frontYard.isPlayerWearingRightShoe:
			whichShoe = RIGHT
		elif frontYard.isPlayerWearingLeftShoe:
			whichShoe = LEFT

	elif whichShoe == PLURAL and not (frontYard.isShoeOnLeftFoot() and frontYard.isShoeOnRightFoot()):
		if frontYard.isPlayerWearingRightShoe:
			whichShoe = RIGHT
		else:
			whichShoe = LEFT

	if whichShoe == RIGHT:
		if not frontYard.isPlayerWearingRightShoe:
			return "You're not wearing that shoe right now."
		elif frontYard.isPlayerEntangled:
			return (
				"You try to remove your shoe, but the grass has tightly cinched your laces together. " +
				"Your foot is stuck!"
			)
		elif frontYard.isRightShoeTied:
			return "You try to take off your shoe, but it's still tied tightly and your foot won't come out."
		else:
			if frontYard.playerPos == frontYard.SpritePos.BATHROOM_DOOR:
				if checkForFall(frontYard.SpritePos.IN_FRONT_OF_SHELF): return ""
				else: frontYard.movePlayer(frontYard.SpritePos.IN_FRONT_OF_SHELF)
			frontYard.takeOffRightShoe()
			if checkForFootFetish(): return ""
			if frontYard.rightShoePos == frontYard.SpritePos.ON_SHELF:
				return "You pull off your shoe and place it back on the supply shelf for safe keeping."
			else:
				return "You pull off your shoe and place it beside you."

	elif whichShoe == LEFT:
		if not frontYard.isPlayerWearingLeftShoe:
			return "You're not wearing that shoe right now."
		elif frontYard.isPlayerEntangled:
			return (
				"You try to remove your shoe, but the grass has tightly cinched your laces together. " +
				"Your foot is stuck!"
			)
		elif frontYard.isLeftShoeTied:
			return "You try to take off your shoe, but it's still tied tightly and your foot won't come out."
		else:
			if frontYard.playerPos == frontYard.SpritePos.BATHROOM_DOOR:
				if checkForFall(frontYard.SpritePos.IN_FRONT_OF_SHELF): return ""
				else: frontYard.movePlayer(frontYard.SpritePos.IN_FRONT_OF_SHELF)
			frontYard.takeOffLeftShoe()
			if checkForFootFetish(): return ""
			if frontYard.leftShoePos == frontYard.SpritePos.ON_SHELF:
				return "You pull off your shoe and place it back on the supply shelf for safe keeping."
			else:
				return "You pull off your shoe and place it beside you."

	elif whichShoe == PLURAL:
		if frontYard.isPlayerEntangled:
			return (
				"You try to remove your shoes, but the grass has tightly cinched your laces together. " +
				"Your feet are stuck!"
			)
		elif frontYard.isLeftShoeTied or frontYard.isRightShoeTied:
			return "Both your shoes need to be untied before you can take them off."
		else:
			if frontYard.playerPos == frontYard.SpritePos.BATHROOM_DOOR:
				if checkForFall(frontYard.SpritePos.IN_FRONT_OF_SHELF): return ""
				else: frontYard.movePlayer(frontYard.SpritePos.IN_FRONT_OF_SHELF)
			frontYard.takeOffRightShoe()
			frontYard.takeOffLeftShoe()
			if checkForFootFetish(): return ""
			if frontYard.leftShoePos == frontYard.SpritePos.ON_SHELF:
				return "You take off both shoes and place them back on the supply shelf for safe keeping."
			else:
				return "You take off both shoes and place them beside you."

	return unknownParse()


func attemptTieShoe(whichShoe: int) -> String:

	if whichShoe == AMBIGUOUS:
		return requestAdditionalContextCustom(
				"Which shoe would you like to " + actionAlias + "?",
				REQUEST_SUBJECT, ["shoe ", "shoe on "], [" shoe", " shoes"]
			)
	
	elif whichShoe == RIGHT:
		if not frontYard.canPlayerReachRightShoe():
			return "You can't reach that shoe from where you are right now."
		elif frontYard.isPlayerEntangled:
			return (
				"You try to pull the laces from the grass, but it's no use. They're stuck. Like, stuck stuck."
			)
		elif frontYard.isRightShoeTied:
			return "This shoe is already tied."
		
		else:
			if not frontYard.isPlayerWearingRightShoe and frontYard.rightShoePos == frontYard.SpritePos.ON_SHELF:
				if checkForFall(frontYard.SpritePos.IN_FRONT_OF_SHELF): return ""
				else: frontYard.movePlayer(frontYard.SpritePos.IN_FRONT_OF_SHELF)
			frontYard.tieRightShoe()
			return "You tie your shoe nice and tight."
	
	elif whichShoe == LEFT:
		if not frontYard.canPlayerReachLeftShoe():
			return "You can't reach that shoe from where you are right now."
		elif frontYard.isPlayerEntangled:
			return (
				"You try to pull the laces from the grass, but it's no use. They're stuck. Like, stuck stuck."
			)
		elif frontYard.isLeftShoeTied:
			return "This shoe is already tied."

		else:
			if not frontYard.isPlayerWearingLeftShoe and frontYard.leftShoePos == frontYard.SpritePos.ON_SHELF:
				if checkForFall(frontYard.SpritePos.IN_FRONT_OF_SHELF): return ""
				else: frontYard.movePlayer(frontYard.SpritePos.IN_FRONT_OF_SHELF)
			frontYard.tieLeftShoe()
			return "You tie your shoe nice and tight."

	elif whichShoe == PLURAL:
		if not frontYard.canPlayerReachRightShoe() or not frontYard.canPlayerReachLeftShoe():
			return "You can't reach both shoes right now."
		elif frontYard.isPlayerEntangled:
			return (
				"You try to pull the laces from the grass, but it's no use. They're stuck. Like, stuck stuck."
			)
		elif frontYard.isRightShoeTied and frontYard.isLeftShoeTied:
			return "Both shoes are already tied."
		
		else:
			if frontYard.isPlayerWearingRightShoe and frontYard.isPlayerWearingLeftShoe:
				frontYard.tieShoesTogether()
				return (
					"You use a complex knot that you learned in Cereal Scouts to tie your shoes together. " +
					"Now you're much less likely to misplace one!"
				)
			else:
				if (
					(not frontYard.isPlayerWearingRightShoe and frontYard.rightShoePos == frontYard.SpritePos.ON_SHELF) or
					(not frontYard.isPlayerWearingLeftShoe and frontYard.leftShoePos == frontYard.SpritePos.ON_SHELF)
				):
					if checkForFall(frontYard.SpritePos.IN_FRONT_OF_SHELF): return ""
					else: frontYard.movePlayer(frontYard.SpritePos.IN_FRONT_OF_SHELF)
				frontYard.tieRightShoe()
				frontYard.tieLeftShoe()
				return "Both of your shoes are now tied."

	return unknownParse()

func attemptUntieShoe(whichShoe: int) -> String:

	if whichShoe == AMBIGUOUS:
		return requestAdditionalContextCustom(
				"Which shoe would you like to " + actionAlias + "?",
				REQUEST_SUBJECT, ["shoe ", "shoe on "], [" shoe", " shoes"]
			)
	
	elif whichShoe == RIGHT:
		if not frontYard.canPlayerReachRightShoe():
			return "You can't reach that shoe from where you are right now."
		elif frontYard.isPlayerEntangled:
			return (
				"You try to pull the laces from the grass, but it's no use. They're stuck. Like, stuck stuck."
			)
		elif not frontYard.isRightShoeTied:
			return "This shoe is already untied."
		
		else:
			if not frontYard.isPlayerWearingRightShoe and frontYard.rightShoePos == frontYard.SpritePos.ON_SHELF:
				if checkForFall(frontYard.SpritePos.IN_FRONT_OF_SHELF): return ""
				else: frontYard.movePlayer(frontYard.SpritePos.IN_FRONT_OF_SHELF)
			frontYard.untieRightShoe()
			return "You untie your shoe so its all loosey-goosey."
	
	elif whichShoe == LEFT:
		if not frontYard.canPlayerReachLeftShoe():
			return "You can't reach that shoe from where you are right now."
		elif frontYard.isPlayerEntangled:
			return (
				"You try to pull the laces from the grass, but it's no use. They're stuck. Like, stuck stuck."
			)
		elif not frontYard.isLeftShoeTied:
			return "This shoe is already untied."

		else:
			if not frontYard.isPlayerWearingLeftShoe and frontYard.leftShoePos == frontYard.SpritePos.ON_SHELF:
				if checkForFall(frontYard.SpritePos.IN_FRONT_OF_SHELF): return ""
				else: frontYard.movePlayer(frontYard.SpritePos.IN_FRONT_OF_SHELF)
			frontYard.untieLeftShoe()
			return "You untie your shoe so its all loosey-goosey."

	elif whichShoe == PLURAL:
		if not frontYard.canPlayerReachRightShoe() or not frontYard.canPlayerReachLeftShoe():
			return "You can't reach both shoes right now."
		elif frontYard.isPlayerEntangled:
			return (
				"You try to pull the laces from the grass, but it's no use. They're stuck. Like, stuck stuck."
			)
		elif not frontYard.isRightShoeTied and not frontYard.isLeftShoeTied:
			return "Both shoes are already untied."
		
		else:
			if (
				(not frontYard.isPlayerWearingRightShoe and frontYard.rightShoePos == frontYard.SpritePos.ON_SHELF) or
				(not frontYard.isPlayerWearingLeftShoe and frontYard.leftShoePos == frontYard.SpritePos.ON_SHELF)
			):
				if checkForFall(frontYard.SpritePos.IN_FRONT_OF_SHELF): return ""
				else: frontYard.movePlayer(frontYard.SpritePos.IN_FRONT_OF_SHELF)
			frontYard.untieRightShoe()
			frontYard.untieLeftShoe()
			return "Both of your shoes are now untied."

	return unknownParse()


func removeCapOnRunningMower() -> String:

	SceneManager.transitionToScene(
		SceneManager.SceneID.ENDING,
		"The mower is already running, but you begin to wonder how much gas it has left. To satisfy your curiosity, " +
		"you carefully reach beside the sputtering engine and remove the cap on the fuel tank.\n" +
		"In mere seconds, a stray spark " +
		"finds its way into the opening where the gas cap should be, and the entire engine is set ablaze. " +
		"Flames are pouring out of every opening on the engine now, and it isn't long before they leap " +
		"hungrily onto the house beside them.",
		SceneManager.EndingID.RAPID_FUEL_CONSUMPTION
	)
	return ""


func attemptFuelMower(ambiguous: bool, intentionalDestruction := false) -> String:

	var endingMessage := ""

	if not frontYard.playerHasGasoline:
		return "You don't have the gasoline right now..."
	elif (frontYard.playerPos != frontYard.SpritePos.BATHROOM_DOOR and
		frontYard.playerPos != frontYard.SpritePos.IN_FRONT_OF_SHELF):
		return "You can't reach the mower right now."
	elif intentionalDestruction:
		endingMessage = (
			"You let the intrusive thoughts win and begin pouring gasoline all over the concrete. "
		)
	elif ambiguous:
		endingMessage = (
			"Uncertain of the best way to use the gasoline, you begin pouring it on the mower, its engine, and the " +
			"exterior of the gas tank. This only serves to splash gasoline all over the ground, so you decide to " +
			"expedite the process by pouring the gas can directly onto the concrete.\n"
		)
	elif frontYard.mowerHasGas:
		return "The mower already has plenty of gas. "
	elif frontYard.mowerHasCap:
		endingMessage = (
			"You begin to pour the gasoline in the direction of the fuel tank, but it merely dribbles off of the closed " +
			"gas cap and onto the concrete below.\nHmmm... You can't help but think there's a more efficient way to do " +
			"this...\nAha! Instead of making the gasoline splash all over the mower before reaching " +
			"the concrete, you can just pour it directly on the ground!\n"
		)
	else:
		frontYard.refuelMower()
		return "With expert precision, you pour the gasoline into the mower's fuel tank, filling it to the brim."

	if endingMessage:
		endingMessage += (
			"As you empty the contents of the gas can, you are astounded by the amount of liquid that begins to cover the " +
			"ground. Before long, the growing puddle reaches your feet, and you suddenly feel yourself losing your " +
			"footing.\n" +
			"In a panic, you reach for the lawn mower to steady yourself and end up knocking it onto its side. The metal " +
			"edge of the mower strikes the concrete and sends a single spark into the flammable liquid..."
		)
		SceneManager.transitionToScene(SceneManager.SceneID.ENDING, endingMessage,
				SceneManager.EndingID.CAUTION_FLOOR_IS_SLIPPERY_WHEN_WET)
		return ""

	return unknownParse()


func attemptStartMower() -> String:

	var mowerPosition: int
	if frontYard.isStepMown: mowerPosition = frontYard.SpritePos.BATHROOM_DOOR
	else: mowerPosition = frontYard.SpritePos.IN_FRONT_OF_SHELF

	if not frontYard.isPlayerOnConcrete():
		return "You can't reach the mower right now."

	if frontYard.isMowerRunning:
		return "The mower is already running."

	if checkForFall(mowerPosition):
		return ""
	frontYard.movePlayer(mowerPosition)
	
	if not frontYard.mowerHasGas:
		return "You try to start the mower, but nothing happens. Perhaps it's out of fuel?"

	if not frontYard.mowerHasCap:
		SceneManager.transitionToScene(
			SceneManager.SceneID.ENDING,
			"Thanks to your stellar refueling abilities, the mower jolts to life at your touch. A steady stream of " +
			"smoke and fire spews out of the exhaust pipes, perched dangerously close to the open fuel tank.\n" +
			"In mere seconds, a stray spark " +
			"finds its way into the opening where the gas cap should be, and the entire engine is set ablaze. " +
			"Flames are pouring out of every opening on the engine now, and it isn't long before they leap " +
			"hungrily onto the house beside them.",
			SceneManager.EndingID.RAPID_FUEL_CONSUMPTION
		)
		return ""

	frontYard.startMower()
	return "You start up the mower, and it lets out a low, steady rumbling noise. It must be hungry for grass!"


func attemptMowGrass(ambiguous: bool, intentionalDestruction := false, mowingWeeds := false) -> String:

	var endingMessage := ""

	if (frontYard.playerPos != frontYard.SpritePos.BATHROOM_DOOR and
		frontYard.playerPos != frontYard.SpritePos.IN_FRONT_OF_SHELF):
		return "You can't reach the mower right now."
	if not frontYard.isMowerRunning:
		return "You need to start the mower before you can " + reconstructCommand() + "."
	elif mowingWeeds:
		endingMessage = (
			"You know the matchstick lawn is meant to be low-maintenance, but you can't help but feel like " +
			"it would look a little nicer if the weeds were cut down to size.\n"
		)
	elif intentionalDestruction:
		endingMessage = (
			"You know the matchstick lawn is meant to be low-maintenance, but you can't help but feel like " +
			"it would look a little nicer if the matchsticks were a couple centimeters shorter.\n"
		)
	elif ambiguous:
		endingMessage = (
			"You know the matchstick lawn is meant to be low-maintenance, but you can't help but feel like " +
			"it would look a little nicer if the matchsticks were a couple centimeters shorter.\n"
		)
	elif frontYard.isStepMown:
		return "The lawn on the step is already nice and tidy. There's no need to mow it again."
	else:
		if checkForFall(frontYard.SpritePos.IN_FRONT_OF_SHELF): return ""
		frontYard.movePlayer(frontYard.SpritePos.IN_FRONT_OF_SHELF)
		if checkForFall(frontYard.SpritePos.BATHROOM_DOOR): return ""
		frontYard.movePlayer(frontYard.SpritePos.BATHROOM_DOOR)

		frontYard.mowStep()
		return (
			"It's a bit difficult hoisting the mower up to the grass, but with a bit of effort you " +
			"give the step its much-needed trim."
		)

	if endingMessage:
		endingMessage += (
			"Determined for your lawn to be the envy of the neighborhood, you steer the mower straight for the matchstick " +
			"minefield. The result is a spectacular display of pyrotechnics, and for a brief moment, your really do have " +
			"the most impressive lawn on the block and the hottest property on the market!"
		)
		SceneManager.transitionToScene(SceneManager.SceneID.ENDING, endingMessage,
				SceneManager.EndingID.IMPROPER_LAWN_MAINTENANCE)
		return ""
	
	return unknownParse()


func checkForFall(destination: int) -> bool:

	var endingMessage := ""

	if (
		destination == frontYard.playerPos or (
			destination == frontYard.SpritePos.ON_SHELF and
			(
				frontYard.playerPos == frontYard.SpritePos.BEDROOM_DOOR or
				frontYard.playerPos == frontYard.SpritePos.IN_FRONT_OF_SHELF
			)
		)
	):
		return false
	elif frontYard.isPlayerEntangled:
		SceneManager.transitionToScene(
			SceneManager.SceneID.ENDING,
			"You try your best to ignore the untidy grass which has ensnared you, but its grasp on your shoes is " +
			"too tight. As soon as you attempt to move off of the step, you are forcefully yanked backwards and tumble " +
			"into a lawn that is about to be 400 degrees hotter...",
			SceneManager.EndingID.LAWN_CARE_KARMA
		)
		return true
	elif (
		(frontYard.isPlayerWearingLeftShoe and not frontYard.isPlayerWearingRightShoe) or 
		(frontYard.isPlayerWearingRightShoe and not frontYard.isPlayerWearingLeftShoe)
	):
		endingMessage = (
			"As you step forward, you become acutely aware of the imbalance between your feet. Wearing only " +
			"one shoe might make for an interesting fashion statement, but you simply don't have the dexterity to " +
			"pull it off.\n"
		)
	elif (
		(frontYard.isPlayerWearingRightShoe and not frontYard.isRightShoeTied) or
		(frontYard.isPlayerWearingLeftShoe and not frontYard.isLeftShoeTied)
	):
		endingMessage = (
			"As you move forward, you accidentally step on the shoelace from your untied shoe. Your next step is cut " +
			"unexpectedly short, and you are thrown completely off balance.\n"
		)
	elif frontYard.areShoesTiedTogether:
		endingMessage = (
			"Immediately after taking a step forward you begin to realize why people tie their shoes individually. It " +
			"is nigh impossible to take a full step without one foot catching on the other.\n"
		)
	elif frontYard.areShoesMismatched:
		SceneManager.transitionToScene(
			SceneManager.SceneID.ENDING,
			"Distinguishing left from right has never been your forte, but you could have sworn that you had worked " +
			"out a system for telling them apart. Your brain still feels warm from the effort of trying to put the " +
			"right shoes on the right feet, " +
			"but something clearly went wrong, since you can't seem to take a step forward without feeling like " +
			"you're walking a mile in an alcoholic's shoes.\nYou try to power through, but it's no use. One careless step " +
			"quickly sends you flying into the matchstick lawn.",
			SceneManager.EndingID.PARBOARD_AND_STORT
		)
		return true 

	if endingMessage:
		endingMessage += (
			"You try in vain to catch yourself as you fall directly into your lawn, which eagerly bursts into flames."
		)
		SceneManager.transitionToScene(SceneManager.SceneID.ENDING, endingMessage,
				SceneManager.EndingID.SHOE_SKILL_ISSUE)
		return true
	else:
		return false


func checkForFootFetish():
	if not frontYard.playerPos == frontYard.SpritePos.STEP_3: return
	elif not frontYard.isPlayerWearingRightShoe and not frontYard.isPlayerWearingLeftShoe:
		SceneManager.transitionToScene(
			SceneManager.SceneID.ENDING,
			"Your bare feet settle onto step #3, and you can immediately feel it humming with activity. " +
			"The flesh-eating termites that call this step home have picked up the pungent scent of your " +
			"feet and waste no time in surfacing to enjoy the tasty meal you have presented to them.\n" +
			"Frantically, you stomp up and down to try and dissuade the termites from feasting on your " +
			"exposed skin. They remain undeterred, however, and in a panic, you leap into the matchstick " +
			"lawn.\nHopefully those termites like their steak cooked well-done.",
			SceneManager.EndingID.FEET_FEAST
		)
		return true
	elif not frontYard.isPlayerWearingRightShoe or not frontYard.isPlayerWearingLeftShoe:
		SceneManager.transitionToScene(
			SceneManager.SceneID.ENDING,
			"Your bare foot settles onto step #3, and you can immediately feel it humming with activity. " +
			"The flesh-eating termites that call this step home have picked up the pungent scent of your " +
			"feet and waste no time in surfacing to enjoy the tasty meal you have presented to them.\n" +
			"Frantically, you stomp up and down to try and dissuade the termites from feasting on your " +
			"exposed skin. They remain undeterred, however, and in a panic, you leap into the matchstick " +
			"lawn.\nHopefully those termites like their steak cooked well-done.",
			SceneManager.EndingID.FEET_FEAST
		)
		return true
	else:
		return false

func getNextStep():

	match frontYard.playerPos:

		frontYard.SpritePos.BATHROOM_DOOR, frontYard.SpritePos.IN_FRONT_OF_SHELF:
			return SubjectID.STEP_1

		frontYard.SpritePos.STEP_1:
			return SubjectID.STEP_2

		frontYard.SpritePos.STEP_2:
			return SubjectID.STEP_3

		frontYard.SpritePos.STEP_3:
			return SubjectID.STEP_4

		frontYard.SpritePos.STEP_4:
			return SubjectID.STEP_5

		frontYard.SpritePos.STEP_5:
			return SubjectID.BEDROOM

		frontYard.SpritePos.BEDROOM_DOOR:
			return SubjectID.AMBIGUOUS_STEP

		
func getPreviousStep():

	match frontYard.playerPos:

		frontYard.SpritePos.BATHROOM_DOOR, frontYard.SpritePos.IN_FRONT_OF_SHELF:
			return SubjectID.AMBIGUOUS_STEP

		frontYard.SpritePos.STEP_1:
			return SubjectID.BATHROOM

		frontYard.SpritePos.STEP_2:
			return SubjectID.STEP_1

		frontYard.SpritePos.STEP_3:
			return SubjectID.STEP_2

		frontYard.SpritePos.STEP_4:
			return SubjectID.STEP_3

		frontYard.SpritePos.STEP_5:
			return SubjectID.STEP_4

		frontYard.SpritePos.BEDROOM_DOOR:
			return SubjectID.STEP_5