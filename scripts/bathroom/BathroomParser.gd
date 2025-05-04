class_name BathroomParser
extends InputParser

@export var bathroom: Bathroom

# Add option to flush toilet? This could be its own ending, splashing water in the tub.
enum ActionID {
	INSPECT, USE,
	TURN_ON, SQUEEZE, SHAMPOO, ENTER, EXIT, STAND_UP, MOVE_TO, LOOK_AWAY,
	OPEN, CLOSE, TAKE, EAT, PLACE, APPLY, PUT, RINSE, BRUSH, SPIT, SWALLOW, RAISE, LOWER, FLUSH, AIM, TURN, UNLOCK, LOCK,
	POOP, QUIT, MAIN_MENU, ENDINGS, AFFIRM, DENY,
}

enum SubjectID {
	SELF, BATHROOM, WATER, FLOOR, CEREAL_BOX, CEREAL, CABINET,
	AMBIGUOUS_DRAWER, TOP_DRAWER, MIDDLE_DRAWER, BOTTOM_DRAWER,
	TOOTHPASTE_TUBE, TOOTHPASTE, TOOTHBRUSH, TEETH, TOILET, KEY,
	TUB_FAUCET_HANDLE, TUB_FAUCET, SINK_FAUCET, BATHTUB, SHAMPOO, DOOR_HANDLE, DOOR,
	SINK, SPIDER, PAINTING, PLANT, GARBAGE, MACHINE, GRAPEFRUIT, URINAL_CAKE, BATH_BOMB, MIRROR, RUG,
	OUTSIDE, GAME,
}

enum ModifierID {
	TO_SELF, ON_SELF, TO_FLOOR, ON_FLOOR, TO_TOOTHBRUSH, ON_TOOTHBRUSH, ON, BACK, UP, DOWN,
	IN_SINK, IN_TOILET, IN_GARBAGE, IN_TUB, IN_CABINET, IN_DRAWER, AWAY, AT_DOOR, AT_SELF, HARDER,
}


func initParsableActions():
	addParsableAction(ActionID.ENDINGS,
			["endings", "view endings", "achievements", "view achievements", "help", "hints", "hint"])
	addParsableAction(ActionID.LOOK_AWAY, ["look away from", "look away"])
	addParsableAction(ActionID.INSPECT, ["inspect", "look at", "look in", "look", "read", "view"])
	addParsableAction(ActionID.USE, ["use"])
	addParsableAction(ActionID.TURN_ON, ["turn on", "activate"])
	addParsableAction(ActionID.SQUEEZE, ["squeeze", "pour", "extrude", "hug", "pump", "squirt"])
	addParsableAction(ActionID.SHAMPOO, ["shampoo", "lather up", "lather", "lube up", "lube"])
	addParsableAction(ActionID.ENTER, ["enter", "go in", "get in", "get back in", "reenter", "re-enter"])
	addParsableAction(ActionID.QUIT, ["quit game", "quit the game", "quit", "exit game", "exit the game"])
	addParsableAction(ActionID.EXIT, ["exit", "leave", "get out of"])
	addParsableAction(ActionID.STAND_UP, ["stand up", "get up"])
	addParsableAction(ActionID.MAIN_MENU,
			["main menu", "menu", "main", "go to the main menu","go to main menu", "go back to the main menu",
			"go back to main menu", "return to the main menu", "return to main menu"])
	addParsableAction(ActionID.MOVE_TO, ["move to", "move", "walk to", "walk", "go to", "go"])
	addParsableAction(ActionID.OPEN, ["open"])
	addParsableAction(ActionID.CLOSE, ["close", "shut"])
	addParsableAction(ActionID.TAKE, ["take", "get", "obtain", "hold", "pick up", "grab"])
	addParsableAction(ActionID.EAT, ["eat", "taste", "consume", "monch on"])
	addParsableAction(ActionID.APPLY, ["apply", "put on"])
	addParsableAction(ActionID.PLACE, ["place", "return", "put back", "put down", "set down"])
	addParsableAction(ActionID.RINSE, ["rinse off", "rinse", "wash off", "wash"])
	addParsableAction(ActionID.BRUSH, ["brush"])
	addParsableAction(ActionID.SPIT, ["spit out","spit"])
	addParsableAction(ActionID.SWALLOW, ["swallow"])
	addParsableAction(ActionID.RAISE, ["raise", "lift up", "lift", "put up"])
	addParsableAction(ActionID.LOWER, ["lower"])
	addParsableAction(ActionID.PUT, ["put"])
	addParsableAction(ActionID.FLUSH, ["flush"])
	addParsableAction(ActionID.AIM, ["aim", "point"])
	addParsableAction(ActionID.TURN, ["turn and pull", "turn", "rotate"])
	addParsableAction(ActionID.UNLOCK, ["unlock"])
	addParsableAction(ActionID.LOCK, ["lock"])
	addParsableAction(ActionID.POOP, ["poop", "crap", "shit your pants", "shit"])
	addParsableAction(ActionID.AFFIRM, ["affirmative", "yes please", "yes", "yup", "y"])
	addParsableAction(ActionID.DENY, ["negative", "nope", "no thank you", "no", "n"])


func initParsableSubjects():
	addParsableSubject(SubjectID.SELF, ["self", "yourself", "me", "myself", "you", "body"],
			[ActionID.INSPECT, ActionID.SHAMPOO, ActionID.SQUEEZE])
	addParsableSubject(SubjectID.BATHROOM, ["bathroom", "room"],
			[ActionID.INSPECT, ActionID.EXIT, ActionID.ENTER])
	addParsableSubject(SubjectID.WATER, ["water"],
			[ActionID.INSPECT, ActionID.TURN_ON, ActionID.TURN])
	addParsableSubject(SubjectID.FLOOR, ["floor", "tile floor", "ground"],
			[ActionID.INSPECT, ActionID.SHAMPOO])
	addParsableSubject(SubjectID.CEREAL_BOX, ["box of cereal", "boxes of cereal", "boxes", "box",
			"cereal boxes", "cereal box", "nao"], [ActionID.INSPECT, ActionID.TAKE, ActionID.OPEN])
	addParsableSubject(SubjectID.CEREAL, ["cereal"],
			[ActionID.INSPECT, ActionID.TAKE, ActionID.ENTER, ActionID.EXIT, ActionID.EAT])
	addParsableSubject(SubjectID.CABINET,
			["sink cabinet", "cabinet door", "cabinet", "vanity door", "vanity", "counter door", "counter"],
			[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.TOP_DRAWER, ["top drawer", "first drawer", "1st drawer", "drawer 1"],
			[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE])
	addParsableSubject(SubjectID.MIDDLE_DRAWER, ["middle drawer", "second drawer", "2nd drawer", "drawer 2"],
			[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE])
	addParsableSubject(SubjectID.BOTTOM_DRAWER, ["bottom drawer", "third drawer", "3rd drawer", "drawer 3"],
			[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE])
	addParsableSubject(SubjectID.AMBIGUOUS_DRAWER, ["drawers", "drawer"],
			[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE])
	addParsableSubject(SubjectID.TOOTHPASTE, ["toothpaste", "tooth paste", "paste"],
			[ActionID.SPIT, ActionID.USE, ActionID.SWALLOW, ActionID.EAT, ActionID.APPLY, ActionID.PUT])
	addParsableSubject(SubjectID.TOOTHPASTE_TUBE,
			["toothpaste tube", "toothpaste", "tube of toothpaste", "tube", "tooth paste", "paste"],
			[ActionID.INSPECT, ActionID.USE, ActionID.TAKE, ActionID.PLACE, ActionID.SQUEEZE, ActionID.PUT, ActionID.AIM,
			ActionID.LOOK_AWAY])
	addParsableSubject(SubjectID.TOOTHBRUSH, ["toothbrush", "tooth brush", "brush"],
			[ActionID.INSPECT, ActionID.USE, ActionID.TAKE, ActionID.PLACE, ActionID.RINSE, ActionID.PUT])
	addParsableSubject(SubjectID.TEETH, ["teeth"],
			[ActionID.INSPECT, ActionID.BRUSH])
	addParsableSubject(SubjectID.TOILET, ["toilet bowl", "toilet seat", "toilet lid", "toilet", "seat", "lid"],
			[ActionID.INSPECT, ActionID.USE, ActionID.OPEN, ActionID.CLOSE, ActionID.FLUSH,
			ActionID.RAISE, ActionID.LOWER, ActionID.PLACE, ActionID.PUT, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.KEY, ["key"],
			[ActionID.INSPECT, ActionID.USE, ActionID.TAKE, ActionID.TURN, ActionID.AIM, ActionID.LOOK_AWAY])
	addParsableSubject(SubjectID.TUB_FAUCET_HANDLE, ["handles", "handle", "knobs", "knob", "faucet handles", "faucet handle"],
			[ActionID.INSPECT, ActionID.USE, ActionID.TURN])
	addParsableSubject(SubjectID.TUB_FAUCET, ["faucet", "tub faucet", "bathtub faucet"],
			[ActionID.INSPECT, ActionID.TURN_ON, ActionID.TURN])
	addParsableSubject(SubjectID.SINK_FAUCET, ["sink faucet"],
			[ActionID.INSPECT, ActionID.USE, ActionID.TURN_ON, ActionID.TURN])
	addParsableSubject(SubjectID.BATH_BOMB, ["bomb", "bath bomb", "powdered milk"],
			[ActionID.INSPECT, ActionID.TAKE, ActionID.EAT])
	addParsableSubject(SubjectID.RUG, ["rug", "mat", "bath mat"],
			[ActionID.INSPECT, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.BATHTUB, ["tub", "bathtub", "bath"],
			[ActionID.INSPECT, ActionID.ENTER, ActionID.EXIT, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.SHAMPOO,
			["shampoo bottle", "bottle", "shampoo", "4-in-1 shampoo", "soap", "lotion", "lubricant"],
			[ActionID.INSPECT, ActionID.USE, ActionID.SQUEEZE, ActionID.APPLY, ActionID.PUT, ActionID.SHAMPOO, ActionID.TAKE])
	addParsableSubject(SubjectID.DOOR_HANDLE, ["doorknob", "door knob", "door handle"],
			[ActionID.INSPECT, ActionID.USE, ActionID.TURN])
	addParsableSubject(SubjectID.DOOR, ["door"],
			[ActionID.INSPECT, ActionID.USE, ActionID.OPEN, ActionID.CLOSE, ActionID.UNLOCK, ActionID.LOCK, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.SINK, ["sink"],
			[ActionID.INSPECT, ActionID.USE, ActionID.TURN_ON, ActionID.TURN, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.SPIDER, ["spiderweb", "spider web", "spider", "web"],
			[ActionID.INSPECT, ActionID.TAKE, ActionID.EAT])
	addParsableSubject(SubjectID.PAINTING, ["painting", "portrait", "art", "quaker man", "quaker"],
			[ActionID.INSPECT])
	addParsableSubject(SubjectID.PLANT, ["plant", "potted plant", "pot", "sticks"],
			[ActionID.INSPECT])
	addParsableSubject(SubjectID.GARBAGE, ["garbage", "trashcan", "trash can", "trash"],
			[ActionID.INSPECT])
	addParsableSubject(SubjectID.MACHINE, ["machine", "juicer", "grapefruit juicer", "grapefruit juice", "yuck"],
			[ActionID.INSPECT, ActionID.USE, ActionID.TURN_ON, ActionID.TURN])
	addParsableSubject(SubjectID.GRAPEFRUIT, ["grapefruits", "grapefruit"],
			[ActionID.INSPECT, ActionID.EAT])
	addParsableSubject(SubjectID.URINAL_CAKE, ["urinal cakes", "urinal cake", "cakes", "cake"],
			[ActionID.INSPECT, ActionID.EAT, ActionID.TAKE])
	addParsableSubject(SubjectID.MIRROR, ["mirror", "paper", "sign"],
			[ActionID.INSPECT])
	addParsableSubject(SubjectID.OUTSIDE, ["outside", "outdoors", "front yard", "yard"],
			[ActionID.INSPECT, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.GAME, ["game"],
			[ActionID.EXIT])


func initParsableModifiers():
	addParsableModifier(ModifierID.TO_SELF, ["to self", "to yourself", "to me", "to you"],
			[ActionID.APPLY])
	addParsableModifier(ModifierID.ON_SELF, ["on self", "on yourself", "on me", "on you",
			"onto self", "onto yourself", "onto me", "onto you", "onto body", "on body"],
			[ActionID.SQUEEZE, ActionID.APPLY, ActionID.PUT, ActionID.SHAMPOO])
	addParsableModifier(ModifierID.TO_FLOOR, ["to floor", "to ground"],
			[ActionID.APPLY])
	addParsableModifier(ModifierID.ON_FLOOR, ["on floor", "on ground", "onto floor", "onto ground"],
			[ActionID.SQUEEZE, ActionID.SHAMPOO, ActionID.SPIT, ActionID.POOP, ActionID.APPLY, ActionID.PUT])
	addParsableModifier(ModifierID.TO_TOOTHBRUSH, ["to toothbrush", "to tooth brush", "to brush"],
			[ActionID.APPLY])
	addParsableModifier(ModifierID.ON_TOOTHBRUSH,
			["on toothbrush", "on tooth brush", "on brush", "onto toothbrush", "onto tooth brush", "onto brush"],
			[ActionID.SQUEEZE, ActionID.APPLY, ActionID.PUT])
	addParsableModifier(ModifierID.BACK, ["back"],
			[ActionID.APPLY, ActionID.PUT])
	addParsableModifier(ModifierID.UP, ["up"],
			[ActionID.PUT])
	addParsableModifier(ModifierID.DOWN, ["down"],
			[ActionID.PUT])
	addParsableModifier(ModifierID.IN_SINK,
			["into sink", "in sink", "using sink", "with sink", "into grapefruit juice", "in grapefruit juice"],
			[ActionID.SPIT, ActionID.RINSE, ActionID.POOP, ActionID.PLACE, ActionID.PUT])
	addParsableModifier(ModifierID.IN_TOILET,
			["into toilet bowl", "in toilet bowl", "into toilet", "in toilet", "using toilet bowl", "using toilet"],
			[ActionID.SPIT, ActionID.RINSE, ActionID.POOP, ActionID.PUT])
	addParsableModifier(ModifierID.IN_GARBAGE, ["in garbage", "into garbage",],
			[ActionID.SPIT])
	addParsableModifier(ModifierID.IN_TUB, ["into tub", "in tub", "into bathtub", "in bathtub"],
			[ActionID.SPIT, ActionID.POOP, ActionID.PLACE])
	addParsableModifier(ModifierID.IN_CABINET, ["in cabinet", "on shelf", "to cabinet", "to shelf"],
			[ActionID.PLACE])
	addParsableModifier(ModifierID.IN_DRAWER, ["in drawer", "in middle drawer", "to drawer", "to middle drawer"],
			[ActionID.PLACE])
	addParsableModifier(ModifierID.AWAY, ["away from me", "away from self", "away from yourself", "away"],
			[ActionID.AIM, ActionID.PUT])
	addParsableModifier(ModifierID.AT_DOOR,
			["at door", "on door", "onto door", "in door", "into door", "to door",
			"at lock", "in lock", "into lock", "to lock",
			"at keyhole", "at key hole", "in keyhole", "in key hole",
			"into keyhole", "into key hole", "to keyhole", "to key hole"],
			[ActionID.AIM, ActionID.SQUEEZE, ActionID.APPLY, ActionID.PUT])
	addParsableModifier(ModifierID.AT_SELF, ["at self", "at yourself", "at me", "at you"],
			[ActionID.AIM])
	addParsableModifier(ModifierID.HARDER, ["harder", "hard", "forcefully", "with force", "firmly", "tightly"],
			[ActionID.SQUEEZE])
	addParsableModifier(ModifierID.ON, ["on"],
			[ActionID.TURN, ActionID.PUT])


func parseItems() -> String:

	parseEventsSinceLastConfirmation += 1

	match actionID:

		ActionID.LOOK_AWAY:
			if not bathroom.playerHasToothpaste or bathroom.remainingToothpaste > 0:
				return wrongContextParse()
			else:
				bathroom.aimToothpasteAway()
				return (
					"The key protruding from the tube of toothpaste is indeed mesmerizing, but you manage " +
					"to tear your gaze away from it and point the loaded weapon away from you."
				)


		ActionID.INSPECT:
			match subjectID:

				-1:
					if actionAlias == "look":
						return requestAdditionalSubjectContext("Where", [], [], ["at "])
					else:
						return requestAdditionalSubjectContext()
				SubjectID.SELF:
					if bathroom.isPlayerLubed:
						return (
							"The 3-in-1 shampoo is coating your entire body. " +
							"You're feeling extra clean and extra slippery!"
						)
					elif bathroom.isPlayerToothpasted:
						return (
							"Your mouth is absolutely stuffed with toothpaste. " +
							"You wonder if this is how a tube of toothpaste feels every day..."
						)
					else:
						return (
							"You've certainly had better days... " +
							"You're in desperate need of a good breakfast."
						)
				SubjectID.BATHROOM:
					return (
						"Somehow, you remember your bathroom being a little less dirty than this... " +
						"Maybe you should starting mopping the floors occasionally."
					)
				SubjectID.TUB_FAUCET:
					return (
						"You're pretty sure that water comes out of this, but you always hope that " +
						"it might start producing Diet Mountian Dew Code Red instead. The faucet is flanked by two handles. "
					)
				SubjectID.SINK_FAUCET:
					return (
						"You wish this just produced water..."
					)
				SubjectID.WATER:
					return (
						"You stare into the toilet water... And it stares back into you."
					)
				SubjectID.BATHTUB:
					return (
						"Your bathtub is filled to the brim with cereal."
					)
				SubjectID.SHAMPOO:
					return (
						"This is your trusty 4-in shampoo. It serves as shampoo, conditioner, body wash, and an " +
						"industrial-strength lubricant. So convenient!"
					)
				SubjectID.FLOOR:
					return (
						"It's only been a few months since you last mopped the floors. It could always be worse!"
					)
				SubjectID.CEREAL_BOX:
					if bathroom.isCabinetOpen:
						return (
							"This is a brand new cereal: Sodium Oh's! They're an essential part of an explosive breakfast! " +
							"It seems like this is what was used to fill the bathtub."
						)
					else: return wrongContextParse()
				SubjectID.CEREAL:
					return (
						"The cereal in the bathtub looks like plain Cheerios, but something seems off about it... " +
						"It's very rough and has a strangely metallic scent."
					)
				SubjectID.CABINET:
					return (
						"You bought this extra long vanity for your bathroom because it was on sale. " +
						"It has a large cabinet below the sink and three drawers on the side."
					)
				SubjectID.AMBIGUOUS_DRAWER:
					return (
						"There are three drawers next to the cabinet door under your sink. " +
						"(You can inspect them individually by indicating a specific drawer.)"
					)
				SubjectID.TOP_DRAWER:
					if bathroom.isTopDrawerOpen:
						return (
							"This drawer is full of powdered-milk bath bombs. Bathing with them makes you feel like a " +
							"dairy worker who just fell into one of those big vats of freshly-squeezed cow juice."
						)
					else:
						return (
							"This drawer is closed right now."
						)
				SubjectID.MIDDLE_DRAWER:
					if bathroom.isMiddleDrawerOpen:
						if bathroom.playerHasToothbrush:
							return (
								"There's your toothbrush! Hooray for oral hygiene!"
							)
						else:
							return (
								"This drawer is empty right now."
							)
					else:
						return (
							"This drawer is closed right now."
						)
				SubjectID.BOTTOM_DRAWER:
					if bathroom.isBottomDrawerOpen:
						return (
							"Yum! This drawer if filled with Lil' Debbie's Urinal Cakes (tm). " +
							"They're a great snack when you're stuck on the toilet dropping an XL dookie."
						)
					else:
						return (
							"This drawer is closed right now."
						)
				SubjectID.TOOTHPASTE, SubjectID.TOOTHPASTE_TUBE:
					if bathroom.isCabinetOpen or bathroom.playerHasToothpaste:
						if bathroom.remainingToothpaste > 0:
							return "This is a tube of aw-key-fresh toothpaste. Every tube is guaranteed to contain a key!"
						else:
							bathroom.lookDownBarrelOfToothpaste()
							return (
								"You bring the tube of toothpaste up to eye level where you can see the tip of a key " +
								"protruding from the opening. A good squeeze should get it out of there!"
							)
					else: return wrongContextParse()
				SubjectID.TOOTHBRUSH:
					if not bathroom.isMiddleDrawerOpen and not bathroom.playerHasToothbrush:
						return wrongContextParse()
					elif bathroom.isToothbrushRinsed:
						return (
							"Your toothbrush is rinsed and ready to go!"
						)
					elif bathroom.remainingToothpaste == 5:
						return (
							"Your toothbrush is bone dry..."
						)
					else:
						return (
							"Your toothbrush is covered is spit and used toothpaste... Gross."
						)
				SubjectID.TEETH:
					return (
						"You can't see your teeth, but you're pretty sure they're still there."
					)
				SubjectID.TOILET:
					return (
						"You usually clean this toilet on World Toilet Day (November 19th), but you " +
						"forgot last time because you were too busy celebrating International Men's Day."
					)
				SubjectID.KEY:
					if bathroom.isKeyInLock:
						return (
							"The key is jammed snugly in the door's lock."
						)
					elif bathroom.remainingToothpaste == 0 and bathroom.playerHasToothpaste:
						bathroom.lookDownBarrelOfToothpaste()
						return (
							"You can see the tip of a key poking out of the tube of toothpaste! " +
							"It looks like it's pretty stuck in there though... You'll have to really put your " +
							"your back into it to get it out of there."
						)
					elif bathroom.playerHasToothpaste or bathroom.isCabinetOpen:
						return (
							"You can see a picture of a key on your toothpaste. You should inspect the toothpaste itself."
						)
					else: return wrongContextParse()
				SubjectID.DOOR:
					return (
						"You installed this beautiful door all by yourself!"
					)
				SubjectID.TUB_FAUCET_HANDLE:
					return (
						"Yup. Those turn on the bathtub faucet."
					)
				SubjectID.DOOR_HANDLE:
					return (
						"This doorknob is vegan AND gluten free!"
					)
				SubjectID.SINK:
					return (
						"You have an extra-long sink for your extra-long counter! " +
						"It seemed like too much of a hassle to install normal plumbing, " + 
						"so you just connected the sink faucet directly to the grapefruit juicer."
					)
				SubjectID.SPIDER:
					return (
						"You refuse to acknowledge the elephant in the room."
					)
				SubjectID.PAINTING:
					return (
						"This custom painting of the Quaker mascot in nude stares down at you while you bathe. " +
						"It's watchful gaze makes you feel much safer."
					)
				SubjectID.PLANT:
					if bathroom.isCabinetOpen:
						return (
							"It looks like your plant doesn't like grapefruit juice either..."
						)
					else: return wrongContextParse()
				SubjectID.GARBAGE:
					if bathroom.isCabinetOpen:
						return (
							"The garbage is filled to the brim with excess grapefruits."
						)
					else: return wrongContextParse()
				SubjectID.GRAPEFRUIT:
					return (
						"These yellow spheres are an affront to mankind."
					)
				SubjectID.BATH_BOMB:
					return "Luxurious, and nutritous!"
				SubjectID.URINAL_CAKE:
					if bathroom.isBottomDrawerOpen:
						return (
							"Yummy!"
						)
					else: return wrongContextParse()
				SubjectID.MACHINE:
					return (
						"Your aunt gifted you this grapefruit juicer for your birthday last year. " +
						"It has a special filter to remove all sugar from the juice. " +
						"She said that this would help you develop a good \"west-side pucker\". " +
						"Maybe that's why Auntie always looks like she's simultaneously constipated and having a stroke..."
					)
				SubjectID.MIRROR:
					return (
						"You decided you'd rather have self-confidence instead of a functional mirror. Go you!"
					)
				SubjectID.RUG:
					return (
						"Your bath mat is soft and absorbant."
					)
				SubjectID.OUTSIDE:
					if bathroom.isDoorOpen:
						return (
							"Through the open door, you can see your front yard. Freedom is at hand!"
						)
					else: return wrongContextParse()


		ActionID.USE:
			return requestSpecificAction()


		ActionID.TURN_ON, ActionID.TURN:
			if actionID == ActionID.TURN_ON or (actionID == ActionID.TURN and modifierID == ModifierID.ON):
				match subjectID:

					-1: return requestAdditionalSubjectContext()
					SubjectID.TUB_FAUCET, SubjectID.WATER:
						if bathroom.isPlayerBlockedByCabinet():
							transitionToTripEnding("the bathtub faucet")
						else:
							SceneManager.transitionToScene(
								SceneManager.SceneID.ENDING,
								"You reach for the faucet handle to turn the water on. This immediately proves to be a very " +
								"poor decision. As water streams into the bathtub, the cereal begins to react violently, " +
								"bursting into flames and leaping out into the rest of the bathroom. The fire spreads " +
								"quickly, and it's not long before your entire house is engulfed in flames.",
								SceneManager.EndingID.BATH_BOMB
							)

					SubjectID.SINK_FAUCET, SubjectID.SINK, SubjectID.MACHINE:
						if bathroom.playerPosition != bathroom.PlayerPosition.IN_TUB:
							return (
								"You decide you're not in the mood for grapefruit juice. " +
								"In fact, you're not really EVER in the mood for grapefruit juice."
							)
						else:
							return (
								"You can't reach that while you're still in the bathtub."
							)
			
			else:
				match subjectID:

					SubjectID.KEY:
						if bathroom.isKeyInLock:
							if bathroom.isPlayerBlockedByCabinet():
								transitionToTripEnding("the key in the door")
							if bathroom.isDoorUnlocked:
								bathroom.lockDoor()
								return (
									"You turn the key back to it's original position, locking the door again. " +
									"No one's leaving this room unless you say so!"
								)
							else:
								bathroom.unlockDoor()
								return (
									"The key makes a satisfying *click* as you turn it in the lock. It sounds like the door " +
									"has been unlocked!"
								)
						else: return wrongContextParse()
					SubjectID.TUB_FAUCET_HANDLE:
						if bathroom.isPlayerBlockedByCabinet():
							transitionToTripEnding("the bathtub faucet")
						else:
							SceneManager.transitionToScene(
								SceneManager.SceneID.ENDING,
								"You reach for the faucet handle to turn the water on. This immediately proves to be a very " +
								"poor decision. As water streams into the bathtub, the cereal begins to react violently, " +
								"bursting into flames and leaping out into the rest of the bathroom. The fire spreads " +
								"quickly, and it's not long before your entire house is engulfed in flames.",
								SceneManager.EndingID.BATH_BOMB
							)
					SubjectID.DOOR_HANDLE:
						if bathroom.isPlayerBlockedByCabinet():
							transitionToTripEnding("the door handle")
						elif bathroom.playerPosition == bathroom.PlayerPosition.IN_TUB:
							return (
								"You can't reach that while you're still in the bathtub."
							)
						else:
							bathroom.movePlayer(bathroom.PlayerPosition.IN_FRONT_OF_DOOR)
							if bathroom.isDoorUnlocked:
								bathroom.openDoor()
								return (
									"You turn the handle and pull the door wide open. Freedom is at hand!"
								)
							else:
								return (
									"You attempt to turn door handle, but it's locked from the outside. You'll need " +
									"to unlock it if you want to leave."
								)
					-1: return requestAdditionalSubjectContext()


		ActionID.SQUEEZE:
			
			match subjectID:

				SubjectID.SELF:
					if bathroom.playerPosition == bathroom.PlayerPosition.IN_TUB:
						return (
							"You really want to give yourself a hug, but you're still submerged in cereal..."
						)
					else:
						return (
							"You wrap your arms around your body and give yourself a big hug. Awwww!"
						)
				
				SubjectID.TOOTHPASTE_TUBE, -1:
					if bathroom.playerHasToothpaste and not bathroom.isKeyInLock:
						match modifierID:
							ModifierID.ON_SELF, ModifierID.ON_FLOOR, ModifierID.ON_TOOTHBRUSH, ModifierID.AT_DOOR:
								return useToothpaste(modifierID)
							ModifierID.HARDER:
								if bathroom.remainingToothpaste > 0:
									return (
										"If you do that right now, you'll spray toothpaste all over the bathroom. Gross!"
									)
								else:
									if bathroom.aimingToothpasteAway:
										bathroom.ejectKey()
										return (
											"While carefully aiming the tube of toothpaste away from you, you firmly " +
											"grasp it and squeeze with all your might. With a satisfying *pop*, the key " +
											"is ejected from the tube and flies straight into the keyhole on the door."
										)
									else:
										SceneManager.transitionToScene(
											SceneManager.SceneID.ENDING,
											"Your face screws up in concentration as you stare down the toothpaste tube " +
											"and wring it out as hard as you can. After an especially firm squeeze, the " +
											"key is released from its toothepasty shackles at high velocity... directly " +
											"into your cornea.\n" +
											"You begin flailing around your bathroom like a wounded animal, " +
											"blood and tears flying every which way. It's not long before this moisture " +
											"reaches the cereal in your bathtub, quickly adding a raging house fire to " +
											"your list of worries...",
											SceneManager.EndingID.MUZZLE_DISCIPLINE
										)
							-1:
								if bathroom.remainingToothpaste == 0:
									return (
										"You try squeezing the tube of toothpaste to eject the key at the tip, " +
										"but it's wedged in there pretty tightly. Maybe you can get it out if you " +
										"squeeze harder?"
									)
								else:
									return requestAdditionalModifierContext("What", " onto", ["onto "])

					elif not bathroom.playerHasToothpaste:
						if subjectID == -1:
							return (
								"You're not holding anything you can " + actionAlias + " right now."
							)
						else:
							return (
								"You're not holding any toothpaste right now, so you can't " + reconstructCommand() + "."
							)
					
					elif bathroom.isKeyInLock:
						return(
							"You've already gotten the key out of the tube of toothpaste, so there's no reason to " +
							"keep using it."
						)


				SubjectID.SHAMPOO:
					if bathroom.playerPosition == bathroom.PlayerPosition.IN_TUB:
						return useShampoo(modifierID)
					else:
						return (
							"Now that you're out of the tub, you don't have any use for the shampoo any more."
						)


		ActionID.APPLY:

			match subjectID:
				
				SubjectID.TOOTHPASTE:
					if bathroom.playerHasToothpaste and not bathroom.isKeyInLock:
						return useToothpaste(modifierID)

					elif not bathroom.playerHasToothpaste:
						return (
							"You're not holding any toothpaste right now, so you can't " + reconstructCommand() + "."
						)
					
					elif bathroom.isKeyInLock:
						return(
							"You've already gotten the key out of the tube of toothpaste, so there's no reason to " +
							"keep using it."
						)


				SubjectID.SHAMPOO:
					if bathroom.playerPosition == bathroom.PlayerPosition.IN_TUB:
						return useShampoo(modifierID)
					else:
						return (
							"Now that you're out of the tub, you don't have any use for the shampoo any more."
						)
				
				-1: return requestAdditionalSubjectContext()


		ActionID.SHAMPOO:

			if bathroom.playerPosition == bathroom.PlayerPosition.IN_TUB:

				match subjectID:

					SubjectID.SELF: return useShampoo(ModifierID.ON_SELF)
					SubjectID.FLOOR: return useShampoo(ModifierID.ON_FLOOR)
					SubjectID.SHAMPOO: return useShampoo(modifierID)
					-1: return requestAdditionalSubjectContext()
			
			else:
				return (
							"Now that you're out of the tub, you don't have any use for the shampoo any more."
						)


		ActionID.PUT:

			match subjectID:

				-1: return requestAdditionalSubjectContext("What")

				SubjectID.TOOTHBRUSH:

					match modifierID:
						ModifierID.BACK, ModifierID.AWAY:
							return returnItem(subjectID)
						ModifierID.IN_TOILET, ModifierID.IN_SINK:
							return attemptRinseToothbrush(modifierID)
						-1:
							return requestAdditionalModifierContext("How", "", ["in "])

				SubjectID.TOOTHPASTE:
					match modifierID:
						ModifierID.BACK, ModifierID.AWAY:
							return returnItem(subjectID)
						ModifierID.ON_SELF, ModifierID.ON_FLOOR, ModifierID.ON_TOOTHBRUSH, ModifierID.AT_DOOR:
							if bathroom.playerHasToothpaste and not bathroom.isKeyInLock:
								return useToothpaste(modifierID)

							elif not bathroom.playerHasToothpaste:
								return (
									"You're not holding any toothpaste right now, so you can't " + reconstructCommand() + "."
								)
							
							elif bathroom.isKeyInLock:
								return(
									"You've already gotten the key out of the tube of toothpaste, so there's no reason to " +
									"keep using it."
								)
						-1:
							return requestAdditionalModifierContext("How", "", ["onto "])


				SubjectID.SHAMPOO:
					match modifierID:
						ModifierID.ON_SELF, ModifierID.ON_FLOOR, ModifierID.ON, -1:
							return useShampoo(modifierID)

				SubjectID.TOILET:
					match modifierID:
						ModifierID.UP:
							if bathroom.playerPosition == bathroom.PlayerPosition.IN_TUB:
								return "You need to get out of this cereal before you can try that."
							elif bathroom.isToiletSeatOpened:
								return "The toilet seat is already up."
							else:
								bathroom.openToiletSeat()
								bathroom.movePlayer(bathroom.PlayerPosition.IN_FRONT_OF_TOILET)
								return "You raise the toilet seat."
						ModifierID.DOWN:
							if bathroom.playerPosition == bathroom.PlayerPosition.IN_TUB:
								return "You need to get out of this cereal before you can try that."
							elif not bathroom.isToiletSeatOpened:
								return "The toilet seat is already down."
							else:
								bathroom.closeToiletSeat()
								bathroom.movePlayer(bathroom.PlayerPosition.IN_FRONT_OF_TOILET)
								return "You lower the toilet seat."
						-1:
							return requestAdditionalModifierContext()


		ActionID.PLACE:

			match subjectID:

				SubjectID.TOOTHPASTE_TUBE:

					if modifierID in [-1, ModifierID.IN_CABINET]:
						return returnItem(subjectID)
					else:
						return (
							"That's not where the toothpaste goes."
						)

				SubjectID.TOOTHBRUSH:

					if modifierID in [-1, ModifierID.IN_DRAWER]:
						return returnItem(subjectID)
					else:
						return (
							"That's not where the toothbrush goes."
						)

				SubjectID.TOILET when actionAlias == "put down":

					if not bathroom.isToiletSeatOpened:
						return "The toilet seat is already down."
					else:
						bathroom.closeToiletSeat()
						bathroom.movePlayer(bathroom.PlayerPosition.IN_FRONT_OF_TOILET)
						return "You lower the toilet seat."

				-1:
					return requestAdditionalSubjectContext()


		ActionID.TAKE:
			
			match subjectID:

				SubjectID.SHAMPOO:
					if bathroom.playerInTub:
						return (
							"You try to pick up the bottle of shampoo, but it's firmly stuck in place. " +
							"You vaguely remember supergluing it to the edge of the tub so that you " +
							"wouldn't lose track of it... " +
							"You should still be able to use it from here though."
						)
					elif bathroom.isPlayerBlockedByCabinet():
						transitionToTripEnding("the shampoo")
						return (
							"You try to pick up the bottle of shampoo, but it's firmly stuck in place. " +
							"You vaguely remember supergluing it to the edge of the tub so that you " +
							"wouldn't lose track of it... " +
							"Oh well! You don't really need it now that you're out of the tub."
						)

				SubjectID.CEREAL_BOX:
					if bathroom.isCabinetOpen: return "You don't see a good reason to take these boxes of cereal with you."
					else: return wrongContextParse()
				
				SubjectID.CEREAL:
					return (
						"You'll deal with the cereal in your bathtub later. " +
						"Right now you need to focus on getting out of the bathroom."
					)
				
				SubjectID.TOOTHPASTE_TUBE:
					if bathroom.playerHasToothpaste:
						return "You are already holding the tube of toothpaste."
					elif bathroom.isCabinetOpen:
						bathroom.takeToothpaste()
						return "You pick up the tube of toothpaste."
					else:
						return wrongContextParse()
				
				SubjectID.TOOTHBRUSH:
					if bathroom.playerHasToothbrush:
						return "You are already holding the toothbrush."
					elif bathroom.isMiddleDrawerOpen:
						bathroom.takeToothbrush()
						return "You pick up your toothbrush."
					else:
						return wrongContextParse()
				
				SubjectID.KEY:
					if bathroom.isKeyInLock:
						if bathroom.isPlayerBlockedByCabinet():
							transitionToTripEnding("the key in the bathroom door")
						else:
							bathroom.movePlayer(bathroom.PlayerPosition.IN_FRONT_OF_DOOR)
							return (
								"You try to remove the key from the lock in the door, but it's wedged firmly in place."
							)
					elif not bathroom.playerHasToothpaste and bathroom.isCabinetOpen:
						bathroom.takeToothpaste()
						return (
							"You pick up the tube of toothpaste with the picture of a key on it. " +
							"Perhaps this will help you open the door? It's probably a good idea to take a closer " +
							"look at the toothpaste."
						)
					elif bathroom.playerHasToothpaste and bathroom.remainingToothpaste == 0:
						return (
							"You try to remove the key by hand, but you can't seem to get a good grip on it. " +
							"Perhaps you're better off trying to squeeze it out of the tube."
						)
					else: return wrongContextParse()
				
				SubjectID.SPIDER:
					return "NO."
				
				SubjectID.BATH_BOMB:
					return "Now's not the time for a bath. You need to focus on getting out of here!"

				-1:
					return requestAdditionalSubjectContext()


		ActionID.ENTER:
			match subjectID:

				SubjectID.BATHTUB, SubjectID.CEREAL:
					if bathroom.isPlayerBlockedByCabinet():
							transitionToTripEnding("the bathtub")
					else:
						SceneManager.transitionToScene(
							SceneManager.SceneID.ENDING,
							"For some reason, you decide that you really want to get back in bathtub full of cereal. " +
							"However, without the aid of your lubricating shampoo, the coarse cereal cuts up your skin, " +
							"causing you to bleed profusely in the tub. Your blood reacts violently with the cereal, causing " +
							"it, you, and your house to erupt into flames.",
							SceneManager.EndingID.SECOND_BLOOD
						)

				-1:
					return requestAdditionalSubjectContext()


		ActionID.EXIT:
			match subjectID:
				
				SubjectID.BATHTUB, SubjectID.CEREAL:
					return attemptExitBathtub()

				SubjectID.BATHROOM:
					if bathroom.isDoorOpen:
						EndingsManager.onSceneBeaten(SceneManager.SceneID.BATHROOM)
						SceneManager.transitionToScene(SceneManager.SceneID.FRONT_YARD)
					else: return attemptOpenDoor()

				SubjectID.GAME:
					if parseEventsSinceLastConfirmation <= 1 and confirmingActionID == ActionID.QUIT:
						get_tree().quit()
					else:
						parseEventsSinceLastConfirmation = 0
						confirmingActionID = ActionID.QUIT
						return requestConfirmation()

				-1:
					return requestAdditionalSubjectContext()


		ActionID.STAND_UP:
			return attemptExitBathtub()


		ActionID.MOVE_TO:
			
			if bathroom.playerPosition == bathroom.PlayerPosition.IN_TUB:
				return "You need to get out of the tub before you can move around."
			else:
				match subjectID:

					SubjectID.RUG:
						if bathroom.isPlayerBlockedByCabinet():
							transitionToTripEnding("the bath mat")
						else:
							bathroom.movePlayer(bathroom.PlayerPosition.ON_MAT)
							return "You move onto the bath mat."

					SubjectID.BATHTUB:
						if bathroom.isPlayerBlockedByCabinet():
							transitionToTripEnding("the bathtub")
						else:
							bathroom.movePlayer(bathroom.PlayerPosition.ON_MAT)
							return "You walk over to the bathtub."

					SubjectID.DOOR:
						if bathroom.isPlayerBlockedByCabinet():
							transitionToTripEnding("the door")
						else:
							bathroom.movePlayer(bathroom.PlayerPosition.IN_FRONT_OF_DOOR)
							return "You move to the door."
					
					SubjectID.OUTSIDE:
						if bathroom.isDoorOpen:
							if bathroom.isPlayerBlockedByCabinet():
								transitionToTripEnding("to leave the bathroom")
							else:
								EndingsManager.onSceneBeaten(SceneManager.SceneID.BATHROOM)
								SceneManager.transitionToScene(SceneManager.SceneID.FRONT_YARD)
						else:
							return "You can't go outside yet. The door is still closed."

					SubjectID.CABINET, SubjectID.SINK:
						bathroom.movePlayer(bathroom.PlayerPosition.IN_FRONT_OF_CABINET)
						return "You walk over to the " + subjectAlias + "."
					
					SubjectID.TOILET:
						bathroom.movePlayer(bathroom.PlayerPosition.IN_FRONT_OF_TOILET)
						return "You move over to the toilet."

					-1:
						return requestAdditionalSubjectContext("Where", [], [], ["on ", "to "])


		ActionID.OPEN:
			
			if bathroom.playerPosition == bathroom.PlayerPosition.IN_TUB:
				return "You need to get out of this cereal before you can try that."
			
			match subjectID:

				SubjectID.DOOR:
					return attemptOpenDoor()

				SubjectID.CEREAL_BOX:
					if bathroom.isCabinetOpen:
						return (
							"You look over at the bathtub full of cereal and decide that there's not a good reason " +
							"to open any more boxes."
						)
					else: return wrongContextParse()
				
				SubjectID.CABINET:
					if bathroom.isCabinetOpen:
						return "The cabinet door is already open."
					else:
						bathroom.openCabinet()
						bathroom.movePlayer(bathroom.PlayerPosition.IN_FRONT_OF_CABINET)
						return "You open the cabinet beneath your sink."

				SubjectID.AMBIGUOUS_DRAWER:
					return requestAdditionalContextCustom(
						"Which drawer would you like to open?", REQUEST_SUBJECT, ["drawer "], [" drawer"]
					)

				SubjectID.TOP_DRAWER:
					if bathroom.isTopDrawerOpen:
						return "The top drawer is already open."
					else:
						bathroom.openTopDrawer()
						bathroom.movePlayer(bathroom.PlayerPosition.IN_FRONT_OF_TOILET)
						return "You open the top drawer."

				SubjectID.MIDDLE_DRAWER:
					if bathroom.isMiddleDrawerOpen:
						return "The middle drawer is already open."
					else:
						bathroom.openMiddleDrawer()
						bathroom.movePlayer(bathroom.PlayerPosition.IN_FRONT_OF_TOILET)
						return "You open the middle drawer."

				SubjectID.BOTTOM_DRAWER:
					if bathroom.isBottomDrawerOpen:
						return "The bottom drawer is already open."
					else:
						bathroom.openBottomDrawer()
						bathroom.movePlayer(bathroom.PlayerPosition.IN_FRONT_OF_TOILET)
						return "You open the bottom drawer."
				
				SubjectID.TOILET:
					if bathroom.isToiletSeatOpened:
						return "The toilet seat is already up."
					else:
						bathroom.openToiletSeat()
						bathroom.movePlayer(bathroom.PlayerPosition.IN_FRONT_OF_TOILET)
						return "You raise the toilet seat."

				-1:
					return requestAdditionalSubjectContext()


		ActionID.CLOSE:

			if bathroom.playerPosition == bathroom.PlayerPosition.IN_TUB:
				return "You need to get out of this cereal before you can try that."
			
			match subjectID:
				
				SubjectID.DOOR:
					if bathroom.isDoorOpen:
						bathroom.closeDoor()
						return "You close the door again. The outside world is scary, and your bathroom is safe and cozy."
					else:
						return "The door is already closed..."

				SubjectID.CABINET:
					if not bathroom.isCabinetOpen:
						return "The cabinet door is already closed."
					else:
						bathroom.closeCabinet()
						bathroom.movePlayer(bathroom.PlayerPosition.IN_FRONT_OF_CABINET)
						return "You close the cabinet beneath your sink."

				SubjectID.AMBIGUOUS_DRAWER:
					return requestAdditionalContextCustom(
						"Which drawer would you like to close?", REQUEST_SUBJECT, ["drawer "], [" drawer"]
					)

				SubjectID.TOP_DRAWER:
					if not bathroom.isTopDrawerOpen:
						return "The top drawer is already closed."
					else:
						bathroom.closeTopDrawer()
						bathroom.movePlayer(bathroom.PlayerPosition.IN_FRONT_OF_TOILET)
						return "You close the top drawer."

				SubjectID.MIDDLE_DRAWER:
					if not bathroom.isMiddleDrawerOpen:
						return "The middle drawer is already closed."
					else:
						bathroom.closeMiddleDrawer()
						bathroom.movePlayer(bathroom.PlayerPosition.IN_FRONT_OF_TOILET)
						return "You close the middle drawer."

				SubjectID.BOTTOM_DRAWER:
					if not bathroom.isBottomDrawerOpen:
						return "The bottom drawer is already closed."
					else:
						bathroom.closeBottomDrawer()
						bathroom.movePlayer(bathroom.PlayerPosition.IN_FRONT_OF_TOILET)
						return "You close the bottom drawer."
				
				SubjectID.TOILET:
					if not bathroom.isToiletSeatOpened:
						return "The toilet seat is already down."
					else:
						bathroom.closeToiletSeat()
						bathroom.movePlayer(bathroom.PlayerPosition.IN_FRONT_OF_TOILET)
						return "You lower the toilet seat."

				-1:
					return requestAdditionalSubjectContext()


		ActionID.RAISE:
			
			if bathroom.playerPosition == bathroom.PlayerPosition.IN_TUB:
				return "You need to get out of this cereal before you can try that."

			match subjectID:

				SubjectID.TOILET:
					if bathroom.isToiletSeatOpened:
						return "The toilet seat is already up."
					else:
						bathroom.openToiletSeat()
						bathroom.movePlayer(bathroom.PlayerPosition.IN_FRONT_OF_TOILET)
						return "You raise the toilet seat."

				-1:
					return requestAdditionalSubjectContext()


		ActionID.LOWER:
			
			if bathroom.playerPosition == bathroom.PlayerPosition.IN_TUB:
				return "You need to get out of this cereal before you can try that."

			match subjectID:

				SubjectID.TOILET:
					if not bathroom.isToiletSeatOpened:
						return "The toilet seat is already down."
					else:
						bathroom.closeToiletSeat()
						bathroom.movePlayer(bathroom.PlayerPosition.IN_FRONT_OF_TOILET)
						return "You lower the toilet seat."

				-1:
					return requestAdditionalSubjectContext()


		ActionID.EAT:

			match subjectID:

				SubjectID.CEREAL:
					return (
						"You couldn't possibly eat this cereal dry! You'd need some milk for sure."
					)

				SubjectID.TOOTHPASTE:
					if bathroom.isPlayerToothpasted or bathroom.playerHasToothpaste:
						return "Ew. No."
					else: return wrongContextParse()
				
				SubjectID.GRAPEFRUIT:
					return "Grapefruit is much too gross to serve as your breakfast."

				SubjectID.BATH_BOMB:
					return "Gross! You wouldn't dream of consuming these without adding water first."

				SubjectID.URINAL_CAKE:
					if bathroom.isBottomDrawerOpen:
						return (
							"These cakes are undeniably delicious, but they're all sugar. They won't satisfy " +
							"your need for a good breakfast."
						)
					else: return wrongContextParse()
				
				SubjectID.SPIDER:
					return "What's wrong with you? N O"

				-1: return requestAdditionalSubjectContext()


		ActionID.BRUSH:
			
			match subjectID:

				SubjectID.TEETH:
					if bathroom.playerHasToothbrush and bathroom.isToothbrushToothpasted:
						if bathroom.isPlayerToothpasted:
							SceneManager.transitionToScene(
								SceneManager.SceneID.ENDING,
								"Despite the fact that your mouth is already filled with toothpaste froth, you " +
								"try to go in for another brushing. At first things seem manageable, but as your mouth " +
								"steadily reaches maximum toothpaste capacity you begin to choke and sputter. You endeavor " +
								"to continue brushing, but you can feel your vision darkening as your body attempts to " +
								"replace much-needed oxygen with toothpaste fumes. Consciousness gradually slips away from " +
								"you, and when you finally come to, you're covered in toothpaste and surroundned by ashes.",
								SceneManager.EndingID.IRRESPONSIBLE_BRUSHING
							)
						else:
							bathroom.brushTeeth()
							return (
								"You vigorously brush your teeth, filling your mouth with toothpaste."
							)
					elif bathroom.playerHasToothbrush:
						return "There's not enough toothpaste on your toothbrush..."
					else:
						return "You're not holding your toothbrush right now, so you can't " + reconstructCommand() + "."
				
				-1: return requestAdditionalSubjectContext()


		ActionID.RINSE:
			
			match subjectID:

				SubjectID.TOOTHBRUSH:

					return attemptRinseToothbrush(modifierID)

				-1: return requestAdditionalSubjectContext()


		ActionID.SPIT:
			
			if not bathroom.isPlayerToothpasted:
				return "There's nothing in your mouth to spit out right now."

			match modifierID:

				ModifierID.ON_FLOOR:
					return (
						"While your floor isn't what you would call \"clean\", spitting toothpaste on it would certainly " +
						"be a new low point that you're not ready to sink to quite yet."
					)
				
				ModifierID.IN_SINK, ModifierID.IN_GARBAGE, ModifierID.IN_TOILET:
					bathroom.spitToothpaste(modifierID == ModifierID.IN_TOILET)
					return "You spit out the toothpaste and are ready to go again!"
				
				ModifierID.IN_TUB, -1:
					SceneManager.transitionToScene(
						SceneManager.SceneID.ENDING,
						"Without any consideration for where it might end up, you spit out a large glob of toothpaste. " +
						"It arcs gracefully through the air before plummeting towards the bathtub. " +
						"The massive droplet hits the cereal like a meteorite, flaming impact and all! Whoops...",
						SceneManager.EndingID.SPICY_SPITTOON
					)


		ActionID.SWALLOW:
			
			if bathroom.isPlayerToothpasted: return "Toothpaste does not count as breakfast."
			else: return wrongContextParse()


		ActionID.FLUSH:
			
			if bathroom.playerPosition == bathroom.PlayerPosition.IN_TUB:
				return "You need to get out of the tub before you can do that."
			elif bathroom.isToiletSeatOpened:
				SceneManager.transitionToScene(
					SceneManager.SceneID.ENDING,
					"With the lid open for the world to see, you flush the toilet. It's an especially energetic flush, " +
					"swirling vigorously and spewing water droplets all over the bathroom. For a brief moment, you're very " +
					"satisfied with the \"super deluxe flush\" feature your brother encouraged you to install, but " +
					"that satisfaction quickly turns to regret as you feel a warmth on the back of your neck and turn " +
					"around to see roiling flames emanating from your bathtub.",
					SceneManager.EndingID.FLAMMABLE_FLUSH
				)
			else:
				bathroom.flushToilet()
				return "FFFLLLLRLRSRSRSSHHHSHSHSHHshshshhhhh"


		ActionID.AIM:
			
			if not bathroom.playerHasToothpaste or bathroom.remainingToothpaste > 0: return wrongContextParse()

			match modifierID:

				ModifierID.AWAY, ModifierID.AT_DOOR:
					
					bathroom.aimToothpasteAway()
					return "You carefully aim the tube of toothpaste away from you."

				ModifierID.AT_SELF:

					bathroom.lookDownBarrelOfToothpaste()
					return (
						"You like to live dangerously. You intentionally aim the barrel of the toothpaste tube " +
						"straight at your eye."
					)

				-1:
					return requestAdditionalModifierContext("What", " at", ["at "])


		ActionID.UNLOCK:
			
			if subjectID == -1: return requestAdditionalSubjectContext()

			if bathroom.isKeyInLock:
				if bathroom.isPlayerBlockedByCabinet():
					transitionToTripEnding("unlock the door")
				if bathroom.isDoorUnlocked:
					return "The door is already unlocked."
				else:
					bathroom.unlockDoor()
					return (
						"The key makes a satisfying *click* as you turn it in the lock. It sounds like the door " +
						"has been unlocked!"
					)
			else: return wrongContextParse()


		ActionID.LOCK:
			
			if subjectID == -1: return requestAdditionalSubjectContext()

			if bathroom.isKeyInLock:
				if bathroom.isPlayerBlockedByCabinet():
					transitionToTripEnding("lock the door")
				if bathroom.isDoorUnlocked:
					bathroom.lockDoor()
					return (
						"You turn the key back to it's original position, locking the door again. " +
						"No one's leaving this room unless you say so!"
					)
				else:
					return "The door is already locked."
			else: return wrongContextParse()


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
			SceneManager.openEndings(bathroom)
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

func useToothpaste(toothpasteModifierID: int) -> String:
	match toothpasteModifierID:
		ModifierID.ON_SELF, ModifierID.TO_SELF:
			return (
				"You consider applying the toothpaste directly to your body but quickly decide " +
				"there are better ways to moisturize your skin."
			)
		ModifierID.ON_FLOOR, ModifierID.TO_FLOOR:
			return (
				"While your concern for the dental hygiene of your bathroom floor is admirable, " +
				"you simply don't have enough toothpaste for all the tiles, and you don't want " +
				"to play favorites."
			)
		ModifierID.ON_TOOTHBRUSH, ModifierID.TO_TOOTHBRUSH:
			if bathroom.playerHasToothbrush:
				if bathroom.isToothbrushRinsed and not bathroom.isToothbrushToothpasted:
					if bathroom.remainingToothpaste > 0:
						bathroom.applyToothpasteToToothbrush()
						var message := "You squeeze a walnut-sized blob of toothpaste onto your toothbrush. Just right! "
						match bathroom.remainingToothpaste:

							4:
								message += (
									"The toothpaste tube feels a bit lighter now. " +
									"Keep it up, and you're sure to find the key eventually!"
								)
							3:
								message += (
									"The toothpaste tube feels even lighter. " +
									"You're making good progress!"
								)
							2:
								message += (
									"The toothpaste tube has started to deflate significantly. " +
									"You must be getting close!"
								)
							1:
								message += (
									"You're having to really strain to get toothpaste out of the tube now. " +
									"One more brushing should do the trick!"
								)
							0:
								return (
									"After putting more toothpaste onto the toothbrush, you realize " +
									"something is stuck in the opening of the tube. Looking closely, " +
									"you can see the tip of a key protruding from the toothpaste tube. " +
									"An especially forceful squeeze should be able to get it out of there."
								)
						return message
					elif not bathroom.isKeyInLock:
						return (
							"You try to squeeze more toothpaste onto your toothbrush, but something is " +
							"blocking the opening of the tube."
						)
					else:
						return (
							"Now that you've gotten the key out of the tube of toothpaste, you don't " +
							"see any reason to keep emptying it."
						)
				elif bathroom.isToothbrushToothpasted:
					return (
						"There's already quit a bit of toothpaste on your toothbrush. " +
						"You don't think it can hold anymore."
					)
				elif not bathroom.isToothbrushRinsed:
					return (
						"The toothbrush still has residue on it from your most recent brushing. " +
						"You should really rinse it off before you use it again."
					)
			else:
				return (
					"You're not holding your toothbrush right now, so you can't " + reconstructCommand() + "."
				)
		ModifierID.AT_DOOR:
			if bathroom.remainingToothpaste == 0 and not bathroom.isKeyInLock:
				if bathroom.isPlayerBlockedByCabinet():
					transitionToTripEnding("the door")
				else:
					bathroom.movePlayer(bathroom.PlayerPosition.IN_FRONT_OF_DOOR)
					bathroom.aimToothpasteAway()
					return (
						"You aim the tube of toothpaste at the door and try to force the key out. It's still stuck, " +
						"but you feel like you're getting somewhere! Maybe if you try to SQUEEZE HARDER you can get it out."
					)
			elif bathroom.remainingToothpaste > 0:
				return ("You resist the urge to splatter your door with toothpaste.")
			else:
				return ("There's nothing left in the tube to squeeze out.")
		-1:
			return requestAdditionalModifierContext("What", "onto", ["onto "])
	return unknownParse()


func useShampoo(shampooingModifierID: int) -> String:
	match shampooingModifierID:
		ModifierID.ON_SELF, ModifierID.TO_SELF:
			if bathroom.isPlayerLubed:
				return (
					"You're already covered in shampoo. There's no need to apply it again."
				)
			else:
				bathroom.lubeUp()
				return (
					"You reach for the bottle of shampoo behind you and apply a healthy amount " +
					"to your body. As the slippery shampoo percolates through the cereal and coats your " +
					"skin, the constraining effects of the rough cereal begin to lessen."
				)
		ModifierID.ON_FLOOR, ModifierID.TO_FLOOR, ModifierID.ON, -1:
			bathroom.spillShampoo()
			return (
				"Unsure of where to put the shampoo, you pour a glob of it onto the floor next to " +
				"the tub. It hits the ground with a satisfying *splat* and forms a small puddle. " +
				"(You'll need to be more specific if you want to put the shampoo on yourself.)"
			)
	return unknownParse()


func returnItem(returningSubjectID) -> String:
	match returningSubjectID:

		SubjectID.TOOTHPASTE, SubjectID.TOOTHPASTE_TUBE:

			if bathroom.playerHasToothpaste and bathroom.isCabinetOpen:
				bathroom.returnToothpaste()
				return (
					"You place the toothpaste back in the cabinet in case the spider wants to use it later."
				)
			elif bathroom.playerHasToothpaste:
				return (
					"You'd like to return the toothpaste, but the cabinet is currently closed."
				)
			else:
				return (
					"You don't have any toothpaste to put back."
				)
		
		SubjectID.TOOTHBRUSH:

			if bathroom.playerHasToothbrush and bathroom.isMiddleDrawerOpen:
				bathroom.returnToothbrush()
				return (
					"You put the toothbrush back in the drawer for now."
				)
			elif bathroom.playerHasToothbrush:
				return (
					"You want to put the toothbrush back where it belongs, but its drawer is closed."
				)
			else:
				return (
					"You don't have your toothbrush right now, so you can't " + reconstructCommand() + "."
				)

	return unknownParse()


func attemptOpenDoor() -> String:

	if bathroom.playerPosition == bathroom.PlayerPosition.IN_TUB:
		return "You'll have to get out of this cereal before you can even think about leaving the bathroom."
	else:
		if bathroom.isPlayerBlockedByCabinet():
			transitionToTripEnding("the door")
		else:
			bathroom.movePlayer(bathroom.PlayerPosition.IN_FRONT_OF_DOOR)
			if not bathroom.isKeyInLock:
				return (
					"You try to open the door to exit the bathroom but quickly find that it is locked " +
					"securely from the outside. What bozo installed this thing!?"
				)
			elif not bathroom.isDoorUnlocked:
				return (
					"The key is in the lock, but you haven't actually unlocked the door yet..."
				)
			else:
				return (
					"You reach for the handle of the unlocked door and pause momentarily... " +
					"How are you supposed to use this handle to open the door? You really don't want to " +
					"mess things up and would like additional instructions."
				)
	return unknownParse()


func attemptExitBathtub() -> String:
	if bathroom.playerPosition == bathroom.PlayerPosition.IN_TUB:
		if bathroom.isPlayerLubed:
			if bathroom.isShampooSpilled:
				SceneManager.transitionToScene(
				SceneManager.SceneID.ENDING,
				"With the help of your shampoo, you squirm your way out of the cereal and step onto " +
				"the bathroom floor. Unfortunately, you were a little too overzealous with the shampoo " +
				"earlier, and the puddle you left causes you to slip and fall backwards into the " +
				"cereal. On your way down, you smack the back of your head on the side of the bathtub, " +
				"splitting your scalp open and spilling blood into the cereal, which wastes no time in " +
				"igniting...",
				SceneManager.EndingID.SLIPPERY_SURPRISE
			)
			else:
				bathroom.exitTub()
				return (
					"With your freshly lubricated body, you spring out of the bathtub like a greasy kid " +
					"in a ball pit. Now you just need to leave the bathroom itself..."
				)
		else:
			SceneManager.transitionToScene(
				SceneManager.SceneID.ENDING,
				"With a few grunts and groans you manage to pull yourself up out of the cereal-filled " +
				"bathtub. However, you don't leave unscathed, as the rough cereal cuts and scrapes your " +
				"unprotected skin. Just as you are about to exit the bathtub for good, the blood pooling " +
				"on your skin drips into the cereal which instantly begins to combust...",
				SceneManager.EndingID.FIRST_BLOOD
			)
	else:
		return "You're already out of the bathtub."
	return unknownParse()


func attemptRinseToothbrush(rinseModifierID: int) -> String:
	if bathroom.playerHasToothbrush:
						
		match rinseModifierID:

			ModifierID.IN_SINK:
				return (
					"You shudder at the thought of dousing your toothbrush in grapefruit juice. " +
					"That would be disgusting!"
				)

			ModifierID.IN_TOILET:
				if not bathroom.isToiletSeatOpened:
					return (
						"The toilet seat is down right now, so you can't rinse your toothbrush."
					)
				if bathroom.isToothbrushToothpasted:
					return (
						"It would be wasteful to rinse all the toothpaste off of your toothbrush right now. " +
						"You need to brush your teeth first."
					)
				elif bathroom.isToiletToothpasted:
					return (
						"The residue from your last brushing is still present in the toilet. You'll " +
						"need fresh water if you want to clean off your toothbrush again."
					)
				elif bathroom.isToothbrushRinsed:
					return (
						"There's no toothpaste on your brush right now, so you don't need to rinse it."
					)
				else:
					bathroom.rinseToothbrush()
					return (
						"You dunk your toothbrush in the toilet bowl and swish it around vigorously. " +
						"It looks good as new now!"
					)

			-1:
				return requestAdditionalModifierContext("What", "in", ["in "])

	else:
		return "You don't have the toothbrush with you right now, so you can't " + reconstructCommand() + "."

	return unknownParse()


func transitionToTripEnding(movingTo: String):
	SceneManager.transitionToScene(
		SceneManager.SceneID.ENDING,
		"As you move across the bathroom to " + movingTo + ", you realize that you neglected to close up the cabinet. " +
		"This catches you by surpise as your leg snags on the open door, throwing you off balance. Uncontrollably, you " +
		"hurdle forward and fall towards the bathtub. Your gut strikes the edge of tub sharply, forcing saliva out " +
		"of your open mouth and into the cereal, which bursts into flames.",
		SceneManager.EndingID.HEAD_OVER_HEELS_FOR_CEREAL
	)
