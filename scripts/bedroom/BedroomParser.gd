class_name BedroomParser
extends InputParser

@export var bedroom: Bedroom

enum ActionID {
	INSPECT, MOVE_TO, LEAVE,
	TAKE, REPLACE, USE, OPEN, CLOSE, ENTER, WEAR, TAKE_OFF,
	FOLD, PULL_UP, PULL, MAKE, TIDY_UP,
	DRESS, CUT, LATHER, 
	SCATTER, FEED, EAT, TURN_ON, TURN_OFF,
	SIT_IN,
	PUT, TURN, WAKE,
	MAIN_MENU, ENDINGS, POOP, QUIT, AFFIRM, DENY
}

enum SubjectID {
	SELF,
	YARD_DOOR, BEDROOM, KITCHEN_DOOR, AMBIGUOUS_DOOR, FRONT_YARD, KITCHEN,
	LEGO_BED, AMBIGUOUS_BED, PILLOWS, SHEET, COMFORTER, CLOTHES,
	TOP_LEFT_DRAWER, TOP_RIGHT_DRAWER, MIDDLE_DRAWER, BOTTOM_DRAWER, AMBIGUOUS_TOP_DRAWER, AMBIGUOUS_DRAWER, DRESSER, STATS,
	LEGO_TABLE, ZOOMBA_TABLE, AMBIGUOUS_TABLE,
	SMOKEY, BEARD, HAIR, AXE, MACHETE, FIRE_EXTINGUISHER, HAT, TOOLS,
	ZOOMBA_BED, ZOOMBA_FOOD, MAT, ZOOMBA, PEPPER_FLAKES, FLINT_FLAKES, BREAD_CRUMBS, CHARCOAL_POWDER,
	GAMING_CHAIR, CABLES, COMPUTER, 
	CTC_POSTER, MILK_POSTER, AMBIGUOUS_POSTER, FLOOR,
	NONE = -1
}

enum ModifierID {
	ON_BED, AT_TOP_OF_BED,
	IN_TOP_LEFT_DRAWER, IN_TOP_RIGHT_DRAWER, IN_MIDDLE_DRAWER, IN_BOTTOM_DRAWER, IN_AMBIGUOUS_TOP_DRAWER, IN_AMBIGUOUS_DRAWER, IN_DRESSER,
	ON_SMOKEY, WITH_BRA, WITH_HAT, WITH_FIRE_EXTINGUISHER, WITH_AXE, WITH_MACHETE, ON_TOOL_RACK,
	ON_FLOOR, ON_TABLE,
	ON, OFF, BACK, AWAY, DOWN, UP, TOGETHER,
}

func initParsableActions():
	addParsableAction(ActionID.ENDINGS,
		["endings", "view endings", "achievements", "view achievements", "help", "hints", "hint"])
	addParsableAction(ActionID.MAIN_MENU,
		["main menu", "menu", "main", "go to main menu", "go back to main menu", "return to main menu"])

	addParsableAction(ActionID.INSPECT, ["inspect", "look at", "look in", "look", "read", "view"], true)
	addParsableAction(ActionID.ENTER, ["enter", "go inside", "go in", "walk inside", "walk in"])
	addParsableAction(ActionID.MOVE_TO,
		["move to", "move on", "move", "walk to", "walk on", "walk up", "walk down", "walk", "go to", "go on", "go",
		"step to", "step on", "step"])

	addParsableAction(ActionID.REPLACE, ["place", "replace", "return", "put back", "put down", "put away", "set down"], true)
	addParsableAction(ActionID.USE, ["use"])
	addParsableAction(ActionID.OPEN, ["open"])
	addParsableAction(ActionID.WEAR, ["wear", "slip on", "put on"], true)
	addParsableAction(ActionID.TAKE_OFF, ["take off", "remove"])
	addParsableAction(ActionID.TAKE, ["take", "get", "obtain", "hold", "pick up", "grab"], true)

	addParsableAction(ActionID.FOLD, ["fold", "combine", "pair"], true)
	addParsableAction(ActionID.PULL_UP, ["pull up"])
	addParsableAction(ActionID.PULL, ["pull"])
	addParsableAction(ActionID.MAKE, ["make", "build", "construct", "assemble"])
	addParsableAction(ActionID.TIDY_UP, ["tidy up", "tidy", "straighten", "organize", "clean up", "clean", "declutter"])

	addParsableAction(ActionID.DRESS, ["dress up", "dress", "clothe"])
	addParsableAction(ActionID.CUT, ["cut", "trim", "groom", "shave"])
	addParsableAction(ActionID.LATHER, ["lather", "spray", "apply", "cover"])

	addParsableAction(ActionID.SCATTER, ["scatter", "sprinkle", "spread", "pour", "dispense"])
	addParsableAction(ActionID.FEED, ["feed"])
	addParsableAction(ActionID.EAT, ["eat"])
	addParsableAction(ActionID.TURN_ON, ["turn on", "start", "activate", "wake up"])
	addParsableAction(ActionID.TURN_OFF, ["turn off", "shut down", "deactivate", "stop", "unplug"])
	addParsableAction(ActionID.CLOSE, ["close", "shut"])

	addParsableAction(ActionID.SIT_IN, ["sit in", "sit down in", "sit"])

	addParsableAction(ActionID.PUT, ["put", "give"], true)
	addParsableAction(ActionID.TURN, ["turn"])
	addParsableAction(ActionID.WAKE, ["wake"])

	addParsableAction(ActionID.POOP, ["poop", "crap", "shit your pants", "shit"])
	addParsableAction(ActionID.QUIT, ["quit game", "quit", "exit game"])
	addParsableAction(ActionID.AFFIRM, ["affirmative", "yes please", "yes", "yup", "y"])
	addParsableAction(ActionID.DENY, ["negative", "nope", "no thank you", "no", "n"])

	addParsableAction(ActionID.LEAVE, ["leave", "exit"])


func initParsableSubjects():
	addParsableSubject(SubjectID.SELF, ["self", "yourself", "me", "myself", "you"],
		[ActionID.INSPECT, ActionID.DRESS])
	
	addParsableSubject(SubjectID.YARD_DOOR,
		["yard door", "front yard door", "blue door", "left door", "door to yard", "door to front yard", "door to outside"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE, ActionID.MOVE_TO, ActionID.ENTER])
	addParsableSubject(SubjectID.BEDROOM, ["bedroom", "room", "around"],
		[ActionID.INSPECT, ActionID.ENTER, ActionID.LEAVE])
	addParsableSubject(SubjectID.KITCHEN_DOOR,
		["kitchen door", "right door", "white door", "picket fence", "fence door", "fence", "door to kitchen"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE, ActionID.MOVE_TO, ActionID.ENTER])
	addParsableSubject(SubjectID.AMBIGUOUS_DOOR, ["door"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE, ActionID.MOVE_TO, ActionID.ENTER])
	addParsableSubject(SubjectID.FRONT_YARD, ["front yard", "yard", "outside"],
		[ActionID.INSPECT, ActionID.MOVE_TO, ActionID.ENTER])
	addParsableSubject(SubjectID.KITCHEN, ["kitchen"],
		[ActionID.INSPECT, ActionID.MOVE_TO, ActionID.ENTER])

	addParsableSubject(SubjectID.LEGO_BED, ["fuego bed", "fuego set", "fuegos", "bed on table"],
		[ActionID.INSPECT, ActionID.MAKE, ActionID.TAKE, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.AMBIGUOUS_BED, ["bed"],
		[ActionID.INSPECT, ActionID.MAKE, ActionID.TAKE, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.PILLOWS, ["pillows", "pillow"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.PULL_UP, ActionID.PULL, ActionID.MOVE_TO, ActionID.TIDY_UP, ActionID.REPLACE, ActionID.PUT])
	addParsableSubject(SubjectID.SHEET, ["sheet", "fitted sheet", "lower sheet", "bottom sheet"],
		[ActionID.INSPECT, ActionID.PULL_UP, ActionID.PULL, ActionID.MOVE_TO, ActionID.TIDY_UP, ActionID.REPLACE, ActionID.PUT])
	addParsableSubject(SubjectID.COMFORTER, ["comforter", "duvet", "coverlet", "upper sheet", "top sheet", "blanket"],
		[ActionID.INSPECT, ActionID.PULL_UP, ActionID.PULL, ActionID.MOVE_TO, ActionID.TIDY_UP, ActionID.REPLACE, ActionID.PUT])
	addParsableSubject(SubjectID.STATS,
		["stats", "clothing stats", "dresser stats", "smart dresser stats", "info", "clothing info", "dresser info", "smart dresser info"],
		[ActionID.INSPECT])
	addParsableSubject(SubjectID.CLOTHES, ["clothes on bed", "clothes", "clothing"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.FOLD, ActionID.PUT, ActionID.REPLACE, ActionID.WEAR])

	addParsableSubject(SubjectID.TOP_LEFT_DRAWER,
		["top left drawer", "upper left drawer", "sock drawer",
		"top left dresser drawer", "upper left dresser drawer", "sock dresser drawer"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE])
	addParsableSubject(SubjectID.TOP_RIGHT_DRAWER,
		["top right drawer", "upper right drawer", "underwear drawer",
		"top right dresser drawer", "upper right dresser drawer", "underwear dresser drawer"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE])
	addParsableSubject(SubjectID.AMBIGUOUS_TOP_DRAWER,
		["top drawer", "upper drawer",
		"top dresser drawer", "upper dresser drawer"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE])
	addParsableSubject(SubjectID.MIDDLE_DRAWER,
		["middle drawer", "pants drawer",
		"middle dresser drawer", "pants dresser drawer"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE])
	addParsableSubject(SubjectID.BOTTOM_DRAWER,
		["bottom drawer", "shirt drawer",
		"bottom dresser drawer", "shirt dresser drawer"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE])
	addParsableSubject(SubjectID.AMBIGUOUS_DRAWER,
		["drawers", "drawer",
		"dresser drawers", "dresser drawer"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE])
	
	addParsableSubject(SubjectID.DRESSER, ["dresser", "smart dresser", "e-dresser 2000"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE, ActionID.MOVE_TO])
	
	addParsableSubject(SubjectID.LEGO_TABLE, ["fuego table", "brown table", "left table", "circle table", "circular table"],
		[ActionID.INSPECT, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.ZOOMBA_TABLE, ["zoomba table", "red table", "right table", "rectangle table", "rectangular table"],
		[ActionID.INSPECT, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.AMBIGUOUS_TABLE, ["table"],
		[ActionID.INSPECT, ActionID.MOVE_TO])
	
	addParsableSubject(SubjectID.BEARD, ["beard", "smokey's beard", "smokey bear's beard", "bear's beard"],
		[ActionID.INSPECT, ActionID.LATHER, ActionID.CUT])
	addParsableSubject(SubjectID.HAIR, ["hair", "smokey's hair", "smokey bear's hair", "bear's hair"],
		[ActionID.INSPECT, ActionID.LATHER, ActionID.CUT])
	addParsableSubject(SubjectID.AXE, ["axe", "ax"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.REPLACE, ActionID.PUT, ActionID.USE])
	addParsableSubject(SubjectID.MACHETE, ["machete", "blade", "sword", "razor", "knife"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.REPLACE, ActionID.PUT, ActionID.USE])
	addParsableSubject(SubjectID.FIRE_EXTINGUISHER, ["fire extinguisher", "extinguisher"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.REPLACE, ActionID.PUT, ActionID.USE, ActionID.LATHER])
	addParsableSubject(SubjectID.HAT, ["hat", "ranger hat", "forest ranger hat", "smokey's hat", "smokey bear's hat"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.REPLACE, ActionID.PUT, ActionID.WEAR])
	addParsableSubject(SubjectID.TOOLS, ["tools", "tool rack", "tool", "smokey's tools"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.REPLACE, ActionID.PUT, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.SMOKEY, ["smokey bear", "smokey", "bear"],
		[ActionID.INSPECT, ActionID.MOVE_TO, ActionID.LATHER, ActionID.CUT, ActionID.DRESS])

	addParsableSubject(SubjectID.GAMING_CHAIR, ["gaming chair", "cereal chair", "cereal gaming chair", "chair"],
		[ActionID.INSPECT, ActionID.MOVE_TO, ActionID.SIT_IN])

	addParsableSubject(SubjectID.ZOOMBA_BED, ["zoomba's bed", "zoomba bed", "pet bed", "pizza box"],
		[ActionID.INSPECT, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.MAT, ["mat", "zoomba's mat", "zoomba mat", "best boi <3", "best boi"],
		[ActionID.INSPECT, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.PEPPER_FLAKES,
		["pepper flakes", "red pepper flakes", "crushed pepper", "crushed red pepper", "pepper"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.REPLACE, ActionID.PUT, ActionID.SCATTER, ActionID.EAT])
	addParsableSubject(SubjectID.FLINT_FLAKES, ["flint flakes", "flint", "gray box", "gray cereal box", "gray cereal"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.REPLACE, ActionID.PUT, ActionID.SCATTER, ActionID.EAT])
	addParsableSubject(SubjectID.BREAD_CRUMBS,
		["bread crumbs", "breadcrumbs", "buttery bread crumbs", "butter", "bread", "yellow box", "yellow cereal box", "yellow cereal", "crumbs"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.REPLACE, ActionID.PUT, ActionID.SCATTER, ActionID.EAT])
	addParsableSubject(SubjectID.CHARCOAL_POWDER, ["charcoal powder", "charcoal bowl", "charcoal", "cereal bowl", "bowl"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.REPLACE, ActionID.PUT, ActionID.SCATTER, ActionID.EAT])
	addParsableSubject(SubjectID.ZOOMBA_FOOD, ["food", "zoomba's food", "zoomba food", "cereal boxes", "cereal", "boxes"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.REPLACE, ActionID.PUT, ActionID.SCATTER, ActionID.MOVE_TO, ActionID.EAT])
	addParsableSubject(SubjectID.ZOOMBA,
		["zoomba", "robot vacuum", "robot", "vacuum", "pizza", "pet", "sleepyhead", "sleepy head"],
		[ActionID.INSPECT, ActionID.MOVE_TO, ActionID.FEED, ActionID.TURN_ON, ActionID.TURN_OFF, ActionID.TURN, ActionID.WAKE])

	addParsableSubject(SubjectID.CABLES, ["cables", "power strip", "power", "outlet", "wall outlet", "cable management"],
		[ActionID.INSPECT])
	addParsableSubject(SubjectID.COMPUTER,
		["computer desktop", "computer desk", "wooden desk", "desktop", "desk", "computer", "pc", "tower", "gaming pc", "gaming rig", "rig"],
		[ActionID.INSPECT, ActionID.MOVE_TO, ActionID.TIDY_UP, ActionID.TURN_ON, ActionID.TURN_OFF, ActionID.TURN, ActionID.USE])
	
	addParsableSubject(SubjectID.CTC_POSTER,
		["ctc poster", "ctc", "cinnamon toast crunch poster", "cinnamon toast crunch", "scary poster", "horror poster", "bloody poster",
		"left poster", "poster on left wall", "left wall poster"],
		[ActionID.INSPECT])
	addParsableSubject(SubjectID.MILK_POSTER,
		["love milk poster", "love milk", "milk poster", "milk", "sexy poster", "center poster", "back poster",
		"poster on center wall", "poster on back wall", "back wall poster", "center wall poster", "poster behind bed"],
		[ActionID.INSPECT])
	addParsableSubject(SubjectID.AMBIGUOUS_POSTER, ["posters", "poster"],
		[ActionID.INSPECT])
	addParsableSubject(SubjectID.FLOOR, ["floor", "ground", "carpet"],
		[ActionID.INSPECT])
	


func initParsableModifiers():
	addParsableModifier(ModifierID.ON_BED, ["on bed", "back on bed"],
		[ActionID.PUT, ActionID.REPLACE])
	addParsableModifier(ModifierID.AT_TOP_OF_BED,
		["at top of bed", "at top", "to top of bed", "to top", "at head of bed", "at head", "to head of bed", "to head"],
		[ActionID.PUT, ActionID.REPLACE, ActionID.MOVE_TO])

	addParsableModifier(ModifierID.IN_TOP_LEFT_DRAWER,
		["in top left drawer", "in upper left drawer", "in sock drawer",
		"in top left dresser drawer", "in upper left dresser drawer", "in sock dresser drawer"],
		[ActionID.PUT, ActionID.REPLACE])
	addParsableModifier(ModifierID.IN_TOP_RIGHT_DRAWER,
		["in top right drawer", "in upper right drawer", "in underwear drawer",
		"in top right dresser drawer", "in upper right dresser drawer", "in underwear dresser drawer"],
		[ActionID.PUT, ActionID.REPLACE])
	addParsableModifier(ModifierID.IN_AMBIGUOUS_TOP_DRAWER,
		["in top drawer", "in upper drawer",
		"in top dresser drawer", "in upper dresser drawer"],
		[ActionID.PUT, ActionID.REPLACE])
	addParsableModifier(ModifierID.IN_MIDDLE_DRAWER,
		["in middle drawer", "in pants drawer",
		"in middle dresser drawer", "in pants dresser drawer"],
		[ActionID.PUT, ActionID.REPLACE])
	addParsableModifier(ModifierID.IN_BOTTOM_DRAWER,
		["in bottom drawer", "in shirt drawer",
		"in bottom dresser drawer", "in shirt dresser drawer"],
		[ActionID.PUT, ActionID.REPLACE])
	addParsableModifier(ModifierID.IN_AMBIGUOUS_DRAWER,
		["in drawers", "in drawer",
		"in dresser drawers", "in dresser drawer"],
		[ActionID.PUT, ActionID.REPLACE])
	addParsableModifier(ModifierID.IN_DRESSER,
		["in dresser", "in smart dresser", "in e-dresser 2000"],
		[ActionID.PUT, ActionID.REPLACE])

	# Probably should have split this into smokey's relevant body parts... Oh well! String matching aliases should do.
	addParsableModifier(ModifierID.ON_SMOKEY,
		["on smokey bear", "to smokey bear", "at smokey bear", "back on smokey bear", "back to smokey bear",
		"on smokey's beard", "on smokey's hair", "on smokey's head",
		"on smokey's breasts", "on smokey's pecs", "on smokey's boobs", "on smokey's chest", "on smokey's tits",
		"on smokey", "to smokey", "at smokey", "back on smokey", "back to smokey",],
		[ActionID.PUT, ActionID.REPLACE, ActionID.USE, ActionID.LATHER])
	addParsableModifier(ModifierID.WITH_BRA, ["with bra", "in bra", "using bra"],
		[ActionID.DRESS])
	addParsableModifier(ModifierID.WITH_HAT,
		["with hat", "with ranger hat", "with forest ranger hat", "with smokey's hat", "with smokey bear's hat",
		"in hat", "in ranger hat", "in forest ranger hat", "in smokey's hat", "in smokey bear's hat",
		"using hat", "using ranger hat", "using forest ranger hat", "using smokey's hat", "using smokey bear's hat"],
		[ActionID.DRESS])
	addParsableModifier(ModifierID.WITH_FIRE_EXTINGUISHER, ["with fire extinguisher", "using fire extinguisher", "with extinguisher", "using extinguisher"],
		[ActionID.LATHER])
	addParsableModifier(ModifierID.WITH_AXE, ["with axe", "using axe", "with ax", "using ax",],
		[ActionID.CUT])
	addParsableModifier(ModifierID.WITH_MACHETE,
		["with machete", "with blade", "with sword", "with razor", "with knife",
		"using machete", "using blade", "using sword", "using razor", "using knife"],
		[ActionID.CUT])
	addParsableModifier(ModifierID.ON_TOOL_RACK,
		["on rack", "on tool rack", "back on rack", "back on tool rack"],
		[ActionID.PUT, ActionID.REPLACE])

	addParsableModifier(ModifierID.ON_FLOOR,
	["on floor", "on ground", "on carpet", "for zoomba"],
		[ActionID.SCATTER, ActionID.PUT])
	addParsableModifier(ModifierID.ON_TABLE,
	["on table", "on zoomba table", "on food table", "on zoomba food table",
	"back on table", "back on zoomba table", "back on food table", "back on zoomba food table",],
		[ActionID.PUT, ActionID.REPLACE])

	addParsableModifier(ModifierID.ON, ["on"],
		[ActionID.PUT, ActionID.REPLACE, ActionID.TURN])
	addParsableModifier(ModifierID.OFF, ["off"],
		[ActionID.TAKE, ActionID.TURN])
	addParsableModifier(ModifierID.BACK, ["back on", "back"],
		[ActionID.PUT, ActionID.REPLACE])
	addParsableModifier(ModifierID.AWAY, ["away"],
		[ActionID.PUT])
	addParsableModifier(ModifierID.DOWN, ["down"],
		[ActionID.PUT])
	addParsableModifier(ModifierID.UP, ["up top", "up"],
		[ActionID.MOVE_TO, ActionID.PUT, ActionID.REPLACE, ActionID.WAKE, ActionID.PULL,])
	addParsableModifier(ModifierID.TOGETHER, ["together"],
		[ActionID.FOLD])


func initParseSubs():
	addParseSub("into", "in")
	addParseSub("onto", "on")
	addParseSub("roomba", "zoomba")
	addParseSub("lego", "fuego")
	addParseSub("legos", "fuegos")
	addParseSub("statistics", "stats")
	addParseSub("central", "center")
	addParseSub("smokeys", "smokey's")
	addParseSub("zoombas", "zoomba's")


func parseItems() -> String:

	parseEventsSinceLastConfirmation += 1

	var clothingCharacteristics: ClothingCharacteristics
	var foundClothing: Clothing
	if wildCard:
		modifierID = extractModifierFromEndOfWildCard()
		clothingCharacteristics = getClothingCharacteristicsFromWildCard(wildCard)
		if clothingCharacteristics:
			validWildCard = true
			foundClothing = bedroom.findClothing(clothingCharacteristics.type, clothingCharacteristics.color, clothingCharacteristics.pattern)
		else: return unrecognizedEndingParse()
	elif subjectID == SubjectID.CLOTHES or actionID == ActionID.FOLD:
		clothingCharacteristics = ClothingCharacteristics.new()

	### Clarifying missing subjects
	if subjectID == -1 and not wildCard:
		match actionID:
			ActionID.INSPECT:
				if actionAlias == "look":
					return requestAdditionalSubjectContext("Where", [], [], ["at "])
				else:
					return requestAdditionalSubjectContext()

			ActionID.MOVE_TO:
				return requestAdditionalSubjectContext("Where", [], [], ["on ", "to "])

			ActionID.TAKE, ActionID.REPLACE, ActionID.USE, ActionID.OPEN, ActionID.CLOSE, ActionID.ENTER,\
			ActionID.WEAR, ActionID.PULL_UP, ActionID.MAKE, ActionID.TIDY_UP,\
			ActionID.DRESS, ActionID.CUT, ActionID.LATHER,\
			ActionID.SCATTER, ActionID.FEED, ActionID.EAT, ActionID.TURN_ON, ActionID.TURN_OFF, \
			ActionID.SIT_IN,\
			ActionID.PUT, ActionID.TURN, ActionID.WAKE:
				return requestAdditionalSubjectContext()


	### Clarifying missing modifiers
	elif modifierID == -1:
		if actionID == ActionID.PUT:
			return requestAdditionalModifierContext("How", "", ["on "])
		elif actionID == ActionID.TURN:
			return requestAdditionalContextCustom("Would you like to " + reconstructCommand() + " [on] or [off]?", REQUEST_MODIFIER)
		elif actionID == ActionID.DRESS:
			return requestAdditionalModifierContext("What", "with?", ["with "])


	### Specific actions

	# Clothes
	if (
		(actionID == ActionID.WEAR or (actionID == ActionID.PUT and modifierID == ModifierID.ON)) and
		clothingCharacteristics != null
	):
		if clothingCharacteristics.type == Clothing.BRA:
			return "You couldn't possibly justify wearing this bra! It's a D-cup, and you're barely even a B!"
		else:
			return "You're already wearing a perfectly fine set of clothes. No need to change."

	if actionID == ActionID.DRESS and subjectID == SubjectID.SELF:
		if modifierID == ModifierID.WITH_BRA:
			return "You couldn't possibly justify wearing this bra! It's a D-cup, and you're barely even a B!"
		else:
			return "You're already wearing a perfectly fine set of clothes. No need to change."

	if actionID == ActionID.FOLD:
		if bedroom.playerHeldItem != bedroom.PlayerHeldItem.CLOTHING:
			return "You're not holding any clothes to fold."
		elif not clothingCharacteristics.matchesClothing(bedroom.heldClothing):
			return "You're not holding that type of clothing."
		elif bedroom.heldClothing.folded:
			return "You've already folded the " + ClothingCharacteristics.fromClothing(bedroom.heldClothing).to_string() + "."
		elif bedroom.heldClothing.type == Clothing.SOCK and not bedroom.heldSecondSock:
			return "You're missing the other sock."
		elif bedroom.heldClothing.type == Clothing.BRA:
			return "You have absolutely no idea how to fold a bra."
		else:
			bedroom.foldClothing()
			return "Folded!"

	if (
		actionID == ActionID.OPEN and
		subjectID in [SubjectID.DRESSER, SubjectID.AMBIGUOUS_DRAWER, SubjectID.AMBIGUOUS_TOP_DRAWER]
	):
		match subjectID:
			SubjectID.AMBIGUOUS_DRAWER, SubjectID.DRESSER:
				return requestAdditionalContextCustom(
					"which drawer would you like to " + actionAlias + "?", REQUEST_SUBJECT, [], [" drawer"]
				)
			SubjectID.AMBIGUOUS_TOP_DRAWER:
				return requestAdditionalContextCustom(
					"Would you like to " + actionAlias + " the [top right] or [top left] drawer?", REQUEST_SUBJECT, [], [" drawer"]
				)

	if actionID == ActionID.OPEN and subjectID in [
		SubjectID.TOP_LEFT_DRAWER, SubjectID.TOP_RIGHT_DRAWER, SubjectID.MIDDLE_DRAWER, SubjectID.BOTTOM_DRAWER
	]:
		if isDrawerOpen(subjectID): return "The " + subjectAlias + " is already open."
		elif getOpenDrawer() == SubjectID.NONE:
			toggleDrawer(subjectID)
			return "You open the " + subjectAlias + "."
		else:
			bedroom.angerDresser()
			return (
				"You reach to open a second drawer, but the dresser shouts out in protest:\n" +
				"\"" + getDresserPatienceMessage() + "\""
			)

	if actionID == ActionID.CLOSE and subjectID in [
		SubjectID.DRESSER, SubjectID.AMBIGUOUS_DRAWER, SubjectID.AMBIGUOUS_TOP_DRAWER,
		SubjectID.TOP_LEFT_DRAWER, SubjectID.TOP_RIGHT_DRAWER, SubjectID.MIDDLE_DRAWER, SubjectID.BOTTOM_DRAWER
	]:
		if subjectID == SubjectID.DRESSER or subjectID == SubjectID.AMBIGUOUS_DRAWER:
			if getOpenDrawer() == SubjectID.NONE: return "There aren't any drawers open right now."
			else: subjectID = getOpenDrawer()
		elif subjectID == SubjectID.AMBIGUOUS_TOP_DRAWER:
			if getOpenDrawer() not in [SubjectID.TOP_LEFT_DRAWER, SubjectID.TOP_RIGHT_DRAWER]: return "Neither of the top drawers are open."
			else: subjectID = getOpenDrawer()
		if not isDrawerOpen(subjectID):
			return "The " + subjectAlias + " is already closed."
		else:
			toggleDrawer(subjectID)
			return "You close the drawer tightly."


	# Making bed
	if actionID == ActionID.MAKE and subjectID in [SubjectID.LEGO_BED, SubjectID.AMBIGUOUS_BED]:
		if actionAlias == "make" and subjectAlias == "bed" and not bedroom.isBedClear:
			return "You need to clear off all the clothes on the bed before you can make it."
		
		SceneManager.transitionToScene(
			SceneManager.SceneID.ENDING,
			"Oh boy oh boy oh boy! You know that you should be focusing on getting your breakfast, but you've been itching to get started " +
			"on a brand new Lego set for a while now! Unfortunately, Legos are like, REALLY expensive nowadays, so you sprang for an " +
			"off-brand \"Fuego\" set instead. These knock-offs are much cheaper thanks to a recent class-action lawsuit against the company " +
			"that sells them. You don't remember all the details, but how different could they possibly be?\n" +
			"You start putting together the Fuegos, which are supposed to assemble into a model of your very own bed, and immediately " +
			"notice something strange. Each connection between the building blocks sends a cascade of bright sparks flying across your room! " +
			"This is more than a little concerning, but the Lego-building beast inside you is already hungering for more, MORE! You begin " +
			"clicking pieces into place at frightening speed, and as the smell of burning carpet wafts up to your nostrils, you start to get " +
			"the sense that you probably should have stuck to the trusted brand. Those Danes really know how to make a " +
			"plastic brick that doesn't burn your house down!",
			SceneManager.EndingID.TWO_IN_ONE_SET_BED_AND_BLAZE
		)
		return ""

	if (
		(actionID == ActionID.TIDY_UP or actionID == ActionID.PULL_UP or (actionID == ActionID.PULL and modifierID == ModifierID.UP) or
		(actionID == ActionID.REPLACE and actionAlias in ["replace", "put back", "return"]) or
		(actionID == ActionID.PUT and modifierID in [ModifierID.AT_TOP_OF_BED, ModifierID.UP, ModifierID.BACK]) or
		(actionID == ActionID.MOVE_TO and actionAlias == "move" and modifierID in [ModifierID.AT_TOP_OF_BED, ModifierID.UP, ModifierID.BACK])) and
		subjectID in [SubjectID.PILLOWS, SubjectID.SHEET, SubjectID.COMFORTER]
	):

		if not bedroom.isBedClear:
			return "You need to clear off all the clothes on the bed before you can make it."
		elif bedroom.playerHeldItem != bedroom.PlayerHeldItem.NONE:
			return "You need your hands to be free before you can make the bed."

		match subjectID:
			SubjectID.PILLOWS:
				if bedroom.bedState == bedroom.MESSY:
					bedroom.tidyUpPillows()
					return "You move the pillows up to their proper resting place at the head of the bed."
				else:
					return "The pillows are already where they need to be."

			SubjectID.SHEET:
				if bedroom.bedState == bedroom.MESSY:
					return "You need to tidy up the pillows before messing with the sheet."
				elif bedroom.bedState == bedroom.LESS_MESSY:
					bedroom.pullUpSheet()
					return "You pull up the bottom sheet, carefully smoothing out the wrinkles as you go."
				else:
					return "The " + subjectAlias + " is already where it needs to be."

			SubjectID.COMFORTER:
				if bedroom.bedState in [bedroom.MESSY, bedroom.LESS_MESSY]:
					return "You don't want to mess with the " + subjectAlias + " until the sheet below it has been sorted out."
				elif bedroom.bedState == bedroom.ALMOST_MADE:
					bedroom.pullUpComforter()
					return "You fluff the " + subjectAlias + " up and distribute it evenly across the surface of your bed."
				else:
					return "The " + subjectAlias + " is already where it needs to be."


	# Grooming Smokey
	if subjectID == SubjectID.HAT and (actionID == ActionID.WEAR or (actionID == ActionID.PUT and modifierID == ModifierID.ON)):
		if bedroom.isPlayerWearingHat:
			return "You're already wearing Smokey's hat."
		elif bedroom.isSmokeyWearingHat:
			return "You just gave Smokey his hat. It would be rude to take it back now."
		else:
			bedroom.pickUpHat()
			return "What a stylish hat! You pick it up and put it on your head for safe keeping."

	if subjectID == SubjectID.HAT and actionID == ActionID.TAKE_OFF or (actionID == ActionID.TAKE and modifierID == ModifierID.OFF):
		if bedroom.isPlayerWearingHat:
			bedroom.replaceHat()
			return "You return the hat to the tool rack."
		else:
			return "You're not wearing the hat right now."

	if (
		(actionID == ActionID.USE and subjectID in [SubjectID.AXE, SubjectID.MACHETE, SubjectID.FIRE_EXTINGUISHER]) or
		(actionID == ActionID.LATHER and subjectID == SubjectID.FIRE_EXTINGUISHER)
	):
		if modifierID == -1:
			return requestAdditionalModifierContext("What", "on", ["on "])
		elif subjectID == SubjectID.AXE and modifierID == ModifierID.ON_SMOKEY:
			if bedroom.playerHeldItem != bedroom.PlayerHeldItem.AXE:
				return "You're not holding the " + subjectAlias + " right now."
			if modifierAlias == "on smokey's beard":
				if bedroom.isSmokeysBeardTrimmed: return "Smokey's beard has already been trimmed."
				else: return "The axe is not precise enough to properly trim Smokey's beard."
			elif modifierAlias in ["on smokey's breasts", "on smokey's pecs", "on smokey's boobs", "on smokey's chest", "on smokey's tits"]:
				return "Ouch! No!"
			else:
				if bedroom.isSmokeysHairCut:
					return "You've already cut Smokey's hair."
				else:
					bedroom.giveSmokeyAHaircut()
					return "With a few hearty swings of the axe, you cut back Smokey's unruly mane."
		elif subjectID == SubjectID.MACHETE and modifierID == ModifierID.ON_SMOKEY:
			if bedroom.playerHeldItem != bedroom.PlayerHeldItem.MACHETE:
				return "You're not holding the " + subjectAlias + " right now."
			if modifierAlias == "on smokey's hair" or modifierAlias == "on smokey's head":
				if bedroom.isSmokeysHairCut: return "You've already cut Smokey's hair."
				else: return "Smokey's hair is too thick for the machete to slice through. You'll need to use something sturdier."
			elif modifierAlias in ["on smokey's breasts", "on smokey's pecs", "on smokey's boobs", "on smokey's chest", "on smokey's tits"]:
				return "Ouch! No!"
			else:
				if bedroom.isSmokeysBeardTrimmed:
					return "You've already trimmed smokey's beard."
				elif not bedroom.isSmokeysBeardShavingCreamed:
					return (
						"The machete seems like the right tool for trimming smokey's beard, but you're worried that you'll cut him " +
						"without something to help reduce the friction between the machete and the dryer lint underneath it."
					)
				else:
					bedroom.trimSmokeysBeard()
					return "The machete glides smoothly over the fire extinguisher foam as you shave off Smokey's beard."
		elif subjectID == SubjectID.FIRE_EXTINGUISHER and modifierID == ModifierID.ON_SMOKEY:
			if bedroom.playerHeldItem != bedroom.PlayerHeldItem.FIRE_EXTINGUISHER:
				return "You're not holding the " + subjectAlias + " right now."
			if modifierAlias == "on smokey's hair" or modifierAlias == "on smokey's head":
				return "Smokey doesn't like having his hair washed. He prefers that natural, oily feel."
			elif modifierAlias in ["on smokey's breasts", "on smokey's pecs", "on smokey's boobs", "on smokey's chest", "on smokey's tits"]:
				return "You and Smokey are really just friends. This would probably be taking things too far."
			else:
				if bedroom.isSmokeysBeardTrimmed:
					return "You've already trimmed smokey's beard, so there's no point in applying more fire extinguisher foam."
				elif bedroom.isSmokeysBeardShavingCreamed:
					return "You've already applied the fire extinguisher foam to smokey's beard."
				else:
					bedroom.applyShavingCreamToSmokey()
					return (
						"You Pull the pin on the fire extinguisher, Aim it at Smokey, and Squeeze the handle, " +
						"Sweeping the hose over the length of his beard until it's thoroughly coated in foam."
					)
		
	if actionID == ActionID.CUT:
		if subjectID == SubjectID.SMOKEY:
			return requestAdditionalContextCustom("Are you trying to " + actionAlias + " Smokey's [hair] or [beard]?", REQUEST_SUBJECT, ["smokey's "])

		elif subjectID == SubjectID.HAIR:
			if bedroom.isSmokeysHairCut: return "You've already cut Smokey's hair."
			elif (modifierID == -1 and bedroom.playerHeldItem == bedroom.PlayerHeldItem.AXE) or modifierID == ModifierID.WITH_AXE:
				if bedroom.playerHeldItem != bedroom.PlayerHeldItem.AXE:
					return "You're not holding the axe right now."
				else:
					bedroom.giveSmokeyAHaircut()
					return "With a few hearty swings of the axe, you cut back Smokey's unruly mane."
			elif (modifierID == -1 and bedroom.playerHeldItem == bedroom.PlayerHeldItem.MACHETE) or modifierID == ModifierID.WITH_MACHETE:
				if bedroom.playerHeldItem != bedroom.PlayerHeldItem.MACHETE:
					return "You're not holding the machete right now."
				else: return "Smokey's hair is too thick for the machete to slice through. You'll need to use something sturdier."
			elif modifierID == -1:
				return "You're not holding anything you could use to " + actionAlias + " Smokey's hair."

		elif subjectID == SubjectID.BEARD:
			if bedroom.isSmokeysBeardTrimmed: return "You've already trimmed Smokey's beard."
			elif (modifierID == -1 and bedroom.playerHeldItem == bedroom.PlayerHeldItem.AXE) or modifierID == ModifierID.WITH_AXE:
				if bedroom.playerHeldItem != bedroom.PlayerHeldItem.AXE:
					return "You're not holding the axe right now."
				else: return "The axe is not precise enough to properly trim Smokey's beard."
			elif (modifierID == -1 and bedroom.playerHeldItem == bedroom.PlayerHeldItem.MACHETE) or modifierID == ModifierID.WITH_MACHETE:
				if bedroom.playerHeldItem != bedroom.PlayerHeldItem.MACHETE:
					return "You're not holding the machete right now."
				elif not bedroom.isSmokeysBeardShavingCreamed:
					return (
						"The machete seems like the right tool for trimming smokey's beard, but you're worried that you'll cut him " +
						"without something to help reduce the friction between the machete and the dryer lint underneath it."
					)
				else:
					bedroom.trimSmokeysBeard()
					return "The machete glides smoothly over the fire extinguisher foam as you shave off Smokey's beard."
			elif modifierID == -1:
				return "You're not holding anything you could use to " + actionAlias + " Smokey's beard."

	if actionID == ActionID.LATHER:
		if subjectID == SubjectID.SMOKEY:
			return requestAdditionalContextCustom("Are you trying to " + actionAlias + " Smokey's [hair] or [beard]?", REQUEST_SUBJECT, ["smokey's "])
		elif subjectID == SubjectID.HAIR:
			return "Smokey doesn't like having his hair washed. He prefers that natural, oily feel."
		elif subjectID == SubjectID.BEARD:
			if bedroom.isSmokeysBeardTrimmed:
				return "You've already trimmed smokey's beard, so there's no point in applying more fire extinguisher foam."
			elif bedroom.isSmokeysBeardShavingCreamed:
				return "You've already applied the fire extinguisher foam to smokey's beard."
			elif (modifierID == -1 and bedroom.playerHeldItem == bedroom.PlayerHeldItem.FIRE_EXTINGUISHER) or modifierID == ModifierID.WITH_FIRE_EXTINGUISHER:
				if bedroom.playerHeldItem != bedroom.PlayerHeldItem.FIRE_EXTINGUISHER:
					return "You're not holding the fire extinguisher right now."
				else:
					bedroom.applyShavingCreamToSmokey()
					return (
						"You Pull the pin on the fire extinguisher, Aim it at Smokey, and Squeeze the handle, " +
						"Sweeping the hose over the length of his beard until it's thoroughly coated in foam."
					)
			elif modifierID == -1:
				return "You're not holding anything you could use to " + actionAlias + " Smokey's beard."

	if (
		(subjectID == SubjectID.HAT and (actionID == ActionID.PUT or actionID == ActionID.REPLACE) and modifierID == ModifierID.ON_SMOKEY)
		or
		(subjectID == SubjectID.SMOKEY and actionID == ActionID.DRESS and modifierID == ModifierID.WITH_HAT)
	):
		if modifierAlias in ["on smokey's beard", "on smokey's breasts", "on smokey's pecs", "on smokey's boobs", "on smokey's chest", "on smokey's tits"]: 
			return "You're no hat-ologist, but you're pretty sure hats don't go there."
		elif bedroom.isPlayerWearingHat:
			if bedroom.isSmokeysHairCut:
				bedroom.putHatOnSmokey()
				return "You put the hat back on Smokey's head where it belongs."
			else:
				return "You really want to put the hat back on Smokey, but it won't fit on his messy hairdo. You'll have to do something about that first..."
		else:
			return "You don't have Smokey's hat right now."

	if (
		(
			(clothingCharacteristics and clothingCharacteristics.type == Clothing.BRA) and
			(actionID == ActionID.PUT or actionID == ActionID.REPLACE) and
			modifierID == ModifierID.ON_SMOKEY
		)
		or
		(subjectID == SubjectID.SMOKEY and actionID == ActionID.DRESS and modifierID == ModifierID.WITH_BRA)
	):
		if modifierAlias in ["on smokey's beard", "on smokey's hair", "on smokey's head"]:
			return "You wouldn't say you're intimately familiar with how a bra is worn, but you're pretty sure it doesn't go there."
		elif bedroom.playerHeldItem != bedroom.PlayerHeldItem.CLOTHING or bedroom.heldClothing.type != Clothing.BRA:
			return "You're not carrying the bra right now."
		else:
			bedroom.putBraOnSmokey()
			return "Much better! You were finding it hard to stay focused with Smokey's melons flapping around."


	# Feeding Zoomba
	if (
		(actionID == ActionID.SCATTER or (actionID == ActionID.PUT and modifierID == ModifierID.ON_FLOOR)) and
		subjectID in [SubjectID.ZOOMBA_FOOD, SubjectID.PEPPER_FLAKES, SubjectID.FLINT_FLAKES, SubjectID.BREAD_CRUMBS, SubjectID.CHARCOAL_POWDER]
	):

		var relevantSubject: int
		if subjectID == SubjectID.ZOOMBA_FOOD:
			match bedroom.playerHeldItem:
				bedroom.PlayerHeldItem.PEPPER_FLAKES: relevantSubject = SubjectID.PEPPER_FLAKES
				bedroom.PlayerHeldItem.FLINT_FLAKES: relevantSubject = SubjectID.FLINT_FLAKES
				bedroom.PlayerHeldItem.BREAD_CRUMBS: relevantSubject = SubjectID.BREAD_CRUMBS
				bedroom.PlayerHeldItem.CHARCOAL_POWDER: relevantSubject = SubjectID.CHARCOAL_POWDER
				
				_:
					return "You're not holding any of Zoomba's food right now."
		else: relevantSubject = subjectID

		if bedroom.playerHeldItem != SUBJECT_TO_HELD[relevantSubject]:
			return "You're not holding the " + subjectAlias + "."
		elif SUBJECT_TO_SCATTERED[relevantSubject] in bedroom.scatteredOnFloor:
			return "You've already scattered the " + subjectAlias + " on the floor."
		else:
			bedroom.scatterZoombaFood(SUBJECT_TO_SCATTERED[relevantSubject])
			return "You shake a decent helping of the " + subjectAlias + " onto the carpeted floor."

	if actionID == ActionID.FEED:
		if bedroom.roombaSatisfied: return "Zoomba is already stuffed! Feeding him now would be pointless."
		else: return (
			"It's best to feed Zoomba by scattering the food around for him to encounter naturally. " +
			"This helps provides him with the proper stimulation to satisfy his predatory instincts. " +
			"Just don't forget to wake him once his food is ready!."
		)

	if actionID == ActionID.EAT:
		return "It may look appetizing, but this food is for Zoomba, not you. If you start eating it in front of him, he might get upset..."

	if (actionID == ActionID.TURN_ON or actionID == ActionID.WAKE or (actionID == ActionID.TURN and modifierID == ModifierID.ON)) and subjectID == SubjectID.ZOOMBA:
		if bedroom.roombaSatisfied:
			return "Zoomba is still on, but he's resting after his meal. It's usually best to let him keep digesting for a while."
		elif not bedroom.scatteredOnFloor:
			SceneManager.transitionToScene(
				SceneManager.SceneID.ENDING,
				"You haven't set any food out yet, but you turn Zoomba on anyway, figuring you'll have some time to get his breakfast ready while he wakes up. " +
				"Unfortunately, Zoomba is especially hungry today, and before you can even reach for his food, he begins searching aggressively " +
				"for something to eat. In mere moments he has found his way to poor Smokey, whose crispy drier-lint body quickly catches fire in Zoomba's " +
				"gnashing, metal maw.",
				SceneManager.EndingID.VACUUMING_ON_AN_EMPTY_STOMACH
			)
			return ""
		elif Bedroom.Scattered.FLINT_FLAKES in bedroom.scatteredOnFloor:
			SceneManager.transitionToScene(
				SceneManager.SceneID.ENDING,
				"You wake Zoomba up and watch eagerly as he begins searching for his breakfast. However, it's not long before Zoomba encounters the " +
				"flint flakes you've set out for him, and your excitement quickly turns to panic. Zoomba clearly has no qualms with their " +
				"taste, but the flint flakes react violently with the steel mechanisms on his underside. A torrent of sparks flies out " +
				"from under the hungry vacuum, setting the carpet ablaze in an instant.",
				SceneManager.EndingID.HAS_MINECRAFT_TAUGHT_YOU_NOTHING
			)
			return ""
		elif Bedroom.Scattered.PEPPER_FLAKES in bedroom.scatteredOnFloor:
			SceneManager.transitionToScene(
				SceneManager.SceneID.ENDING,
				"You wake Zoomba up and watch eagerly as he begins searching for his breakfast. He cautiously approaches the " +
				"crushed red pepper you set out for him, as if contemplating whether or not to dig in. You suddenly remember " +
				"that Zoomba has had trouble with spicy food in the past and step forward to stop him. In that same instant, " +
				"Zoomba's hunger gets the better of him and he sucks in a large clump of the spicy detritus. Both you and Zoomba " +
				"immediately regret this decision as the robot vacuum expels the flakes in a fiery belch which spreads out to consume the " +
				"rest of the flakes and the room beyond.",
				SceneManager.EndingID.HEARTBURN
			)
			return ""
		elif Bedroom.Scattered.BREAD_CRUMBS in bedroom.scatteredOnFloor and Bedroom.Scattered.CHARCOAL_POWDER in bedroom.scatteredOnFloor:
			bedroom.feedZoomba()
			return (
				"You gently press the power button on Zoomba, and the robot vacuum roars to life, scouring the room for sustenance. " +
				"He quickly navigates over to the buttery bread crumbs you've set out, and he's so excited by the calorie-rich food that " +
				"he hardly seems to notice the cleansing charcoal powder he's scarfing down with it. Before too long, the carpet has been " +
				"vacuumed clean, and Zoomba is rumbling contentedly in the center of the feeding grounds."
			)
		elif Bedroom.Scattered.BREAD_CRUMBS in bedroom.scatteredOnFloor:
			SceneManager.transitionToScene(
				SceneManager.SceneID.ENDING,
				"You wake Zoomba up and watch eagerly as he begins searching for his breakfast. At first, everything seems fine as " +
				"Zoomba happily sucks up the food you've left. The buttery bread crumbs are one of Zoomba's favorite treats, " +
				"and you've spread out plenty for him! Unfortunately, with all this delicious food in front of him, Zoomba's eyes " +
				"prove to be a bit larger than his stomach. All at once, his little robot brain finally catches up with the " +
				"digestive nightmare that is assaulting his inner workings. Fire and mangled bread crumbs mix on the carpet " +
				"as Zoomba violently purges the contents of fuel tank, sending the room into an uncontrolled blaze.",
				SceneManager.EndingID.GUTBOMB
			)
			return ""
		elif Bedroom.Scattered.CHARCOAL_POWDER in bedroom.scatteredOnFloor:
			SceneManager.transitionToScene(
				SceneManager.SceneID.ENDING,
				"You wake Zoomba up and watch eagerly as he begins searching for his breakfast. He rapidly homes in on the charcoal " +
				"you set out, but his disappointment is apparent in the way he slows down, sucking half-heartedly at the healthy " +
				"powder. After finishing everything you set out, he pauses, clearly dissatisfied. You're contemplating whether to " +
				"put out more food when the robot suddenly takes matters into his own hands, lunging at the Smokey statue. " +
				"There's no time to react as the voracious vacuum tears into the poor bear. The friction from Zoomba's narrow " +
				"intake rapidly ignites the drier lint entering it, and in seconds, the entire Smokey statue is burning fiercely.",
				SceneManager.EndingID.HIGH_FIRE_BER_DIET
			)
			return ""

	if (actionID == ActionID.TURN_OFF or (actionID == ActionID.TURN and modifierID == ModifierID.OFF)) and subjectID == SubjectID.ZOOMBA:
		if bedroom.roombaSatisfied:
			return "Zoomba is still digesting his meal. It would be rude to interrupt him."
		else:
			return "Zoomba is already off. In fact, he's been off for a while now, and you're sure he's starving!"
	
	### Cleaning Computer
	if (
		(subjectID == SubjectID.COMPUTER and actionID in [ActionID.TIDY_UP, ActionID.USE]) or
		(subjectID == SubjectID.GAMING_CHAIR and actionID == ActionID.SIT_IN)
	): # Other applicable action, "INSPECT", is covered by the dedicated INSPECT block above.
		if bedroom.isComputerCleaned:
			return "You've already finished cleaning up your computer's desktop."
		else:
			bedroom.accessComputer()
			return ""

	elif (
		subjectID == SubjectID.COMPUTER and (actionID == ActionID.TURN_ON or (actionID == ActionID.TURN and modifierID == ModifierID.ON))
	):
		return "Your computer is already on."

	elif (
		subjectID == SubjectID.COMPUTER and (actionID == ActionID.TURN_OFF or (actionID == ActionID.TURN and modifierID == ModifierID.OFF))
	):
		return "You don't feel like turning your computer off. You'll just have to turn it back on again, and that's annoying."


	### Door stuff

	if subjectID == SubjectID.AMBIGUOUS_DOOR:
		return requestAdditionalContextCustom(
			"What door would you like to " + actionAlias + "?", REQUEST_SUBJECT, ["door "], [" door"]
		)

	if (
		(actionID in [ActionID.OPEN, ActionID.ENTER] and subjectID == SubjectID.KITCHEN_DOOR) or
		(actionID == ActionID.LEAVE and subjectID == SubjectID.BEDROOM) or
		(actionID in [ActionID.MOVE_TO, ActionID.ENTER] and subjectID == SubjectID.KITCHEN)
	):
		if bedroom.isBedClear and bedroom.isSmokeyComplete and bedroom.roombaSatisfied and bedroom.isComputerCleaned:
			EndingsManager.onSceneBeaten(SceneManager.SceneID.BEDROOM)
			SceneManager.transitionToScene(SceneManager.SceneID.KITCHEN)
			return ""
		else:
			bedroom.movePlayer(bedroom.PlayerPos.KITCHEN_DOOR)
			var output := "You reach slowly for the door leading to the kitchen, but you feel the weight of unfinished chores stay your hand. "
			output += "You still need to complete the following chores:\n"
			if not bedroom.isBedClear: output += "- Make your bed\n"
			if not bedroom.isSmokeyComplete: output += "- Restore Smokey the Bear to his former glory\n"
			if not bedroom.roombaSatisfied: output += "- Feed Zoomba\n"
			if not bedroom.isComputerCleaned: output += "- Tidy up your computer desktop\n"
			output += "Once these tasks are finished, you can proceed to the kitchen to make your breakfast!"
			return output

	if (
		(actionID in [ActionID.OPEN, ActionID.ENTER] and subjectID == SubjectID.YARD_DOOR) or
		(actionID in [ActionID.MOVE_TO, ActionID.ENTER] and subjectID == SubjectID.FRONT_YARD)
	):
		return "You don't see a good reason to go back outside. Your breakfast isn't out there!"

	if actionID == ActionID.ENTER and subjectID == SubjectID.BEDROOM:
		return "You're already in your bedroom."

	if actionID == ActionID.CLOSE:
		match subjectID:
			SubjectID.YARD_DOOR, SubjectID.KITCHEN_DOOR:
				return "That door is already closed."


	### Consistent actions
	match actionID:

		### Inspecting
		ActionID.INSPECT:

			match subjectID:

				-1 when clothingCharacteristics:
						if bedroom.isBedClear:
							return "There are no more clothes on your bed to " + actionAlias + "."
						elif bedroom.clothingSearchResult == bedroom.SearchResult.NONEXISTENT:
							return "You look through the clothes on your bed but are unable to find any " + clothingCharacteristics.to_string() + "."
						elif bedroom.clothingSearchResult == bedroom.SearchResult.AMBIGUOUS:
							return "You can see multiple clothes fitting this description that are within reach on the bed."
						elif bedroom.clothingSearchResult == bedroom.SearchResult.BURIED:
							return "You can see your " + clothingCharacteristics.to_string() + " buried beneath other clothes on the bed."
						elif bedroom.clothingSearchResult == bedroom.SearchResult.FOUND:
							return "You can see your " + clothingCharacteristics.to_string() + " within reach on the bed."


				SubjectID.YARD_DOOR:
					return "This is the door that leads back out the front yard. You don't need to go back out there."

				SubjectID.FRONT_YARD:
					return "The door to the front yard is closed now."

				SubjectID.BEDROOM:
					return (
						"This is your bedroom, where you sleep, game, and tend to your beloved pet Zoomba. " +
						"There's a large window looking out to the front yard so that your adoring fans can watch you sleep from the sidewalk. " +
						"It's just the polite thing to do."
						)

				SubjectID.KITCHEN_DOOR:
					return (
						"This white picket door is your assurance that you've fulfilled the American dream in your quaint little home. " +
						"You're sure it must be the envy of the neighborhood. It leads to the kitchen, where your breakfast awaits."
					)

				SubjectID.KITCHEN:
					return "The door to the kitchen is closed right now."

				SubjectID.AMBIGUOUS_DOOR:
					return requestAdditionalContextCustom(
						"What door would you like to " + actionAlias + "?",REQUEST_SUBJECT, ["door "], [" door"]
					)


				SubjectID.LEGO_BED:
					return (
						"Oh boy! This is the custom Fuego set that you ordered, modeled after your very own bed! It was much cheaper than the Lego version, " +
						"but your not entirely sure why. Oh well! Best not to think about it too hard."
					)

				SubjectID.AMBIGUOUS_BED:
					var output := "Your bed is positioned in the exact center of your room so that you can easily initiate naptime from anywhere! "
					if bedroom.isBedClear:
						if bedroom.bedState == bedroom.MADE:
							output += "You just finished making it too, so it'll be extra cozy whenever the urge strikes."
						else:
							output += "You've cleared all the clothes off, but you still need to finish making the bed. "
							if bedroom.bedState == bedroom.MESSY:
								output += "You should start by moving the pillows to the top of the bed."
							elif bedroom.bedState == bedroom.LESS_MESSY:
								output += "Next, you'll need to pull up the sheet."
							elif bedroom.bedState == bedroom.ALMOST_MADE:
								output += "You just need to pull up the comforter!"
					else:
						output += "It would be even better if you could make your bed first, but it's still covered in your last load of laundry. "
						output += getExposedClothesString()
					return output

				SubjectID.PILLOWS:
					var output := (
						"These are your pillows. The left one is your favorite, but you don't want the other one to feel left out, " +
						"so you try to alternate between them regularly. "
					)
					if bedroom.bedState == bedroom.MESSY: output += "Right now, they're both laying haphazardly over the unfolded sheets."
					else: output += "Right now, they're both positioned perfectly at the head of the bed."
					return output

				SubjectID.SHEET:
					if bedroom.bedState in [bedroom.MESSY, bedroom.LESS_MESSY]: return "Your sheet is still unfurled from yesterday's pre-party nap."
					else: return "You've smoothed out and tucked in your sheet nicely. Looks great!"

				SubjectID.COMFORTER:
					if bedroom.bedState == bedroom.MADE: return "Your comforter is appropriately fluffed and evenly distributed over your bed. Perfect!"
					else: return "Your comforter is still unfurled from yesterday's pre-party nap."

				SubjectID.CLOTHES:
					if bedroom.isBedClear:
						return "There are no more clothes on your bed."
					else:
						return "There are still some clothes on your bed preventing you from making it. " + getExposedClothesString()


				SubjectID.TOP_LEFT_DRAWER:
					if bedroom.topLeftDrawerControl.visible:
						return "This is where you keep your socks and sock puppets."
					else: return "This drawer is closed right now."

				SubjectID.TOP_RIGHT_DRAWER:
					if bedroom.topLeftDrawerControl.visible:
						return "This is where you keep your underwear."
					else: return "This drawer is closed right now."

				SubjectID.AMBIGUOUS_TOP_DRAWER:
					return requestAdditionalContextCustom(
						"Would you like to " + actionAlias + " the [top right] or [top left] drawer?", REQUEST_SUBJECT, [], [" drawer"]
					)

				SubjectID.MIDDLE_DRAWER:
					if bedroom.topLeftDrawerControl.visible:
						return "This is where you keep your pants."
					else: return "This drawer is closed right now."

				SubjectID.BOTTOM_DRAWER:
					if bedroom.topLeftDrawerControl.visible:
						return "This is where you keep your shirts."
					else: return "This drawer is closed right now."

				SubjectID.AMBIGUOUS_DRAWER:
					return requestAdditionalContextCustom(
						"which drawer would you like to " + actionAlias + "?", REQUEST_SUBJECT, [], [" drawer"]
					)

				SubjectID.STATS:
					var output := "You prompt your smart dresser to give you some clothing stats:\n"
					match randi_range(1,5):
						1:
							output += "BZZZZT! THIS DRESSER CONTAINS APPROXIMATELY " + str(randi_range(100000,999999)) + " STITCHES."
						2:
							output += "BZZZZT! YOU HAVE USED THIS DRESSER TO STORE UNWASHED CLOTHES " + str(randi_range(100,999)) + " TIMES."
						3:
							output += "BZZZZT! THIS DRESSER AND ITS CONTENTS WEIGH APPROXIMATELY " + str(randi_range(20000,99999)) + " GRAMS."
						4:
							output += "BZZZZT! IT HAS BEEN " + str(randi_range(500,999)) + " DAYS SINCE YOU HAVE BOUGHT NEW UNDERGARMENTS."
						5:
							output += "BZZZZT! CALORIC CONTENT OF STORED CLOTHES IS ESTIMATED AT " + str(randi_range(10000,49999)) + " CALORIES."

					return output

				SubjectID.DRESSER:
					return (
						"This is your high-tech, smart dresser: The e-Dresser 2000! It keeps track of all kinds of fancy statistics, and you can " +
						"use your smartphone to open and close drawers from anywhere with an internet connection! " +
						"It does tend to be a bit finicky about actually storing clothes though..."
					)


				SubjectID.LEGO_TABLE:
					return "This table is currently occupied by your brand new Fuego set."

				SubjectID.ZOOMBA_TABLE:
					return (
						"Zoomba can't reach things off the ground, so you keep his food up high on this table. " +
						"Right now, you've got crushed red pepper, flint flakes, buttery bread crumbs, and charcoal powder. Yum!"
					)

				SubjectID.AMBIGUOUS_TABLE:
					return requestAdditionalContextCustom(
						"which table would you like to " + actionAlias + "?", REQUEST_SUBJECT, ["table "], [" table"]
					)


				SubjectID.SMOKEY:
					var output := "This statue of Smokey the Bear, made almost entirely out of dryer lint, really helps tie the whole room together. "
					if not bedroom.isSmokeysBeardTrimmed:
						output += "It looks like his beard is in need of some grooming though... You're not sure how the drier lint keeps growing back, "
						output += "but you figure it's best not to think too hard about it."
					elif not bedroom.isSmokeyWearingHat:
						output += "Unfortunately, the effect is incomplete as long as he's still missing his signature hat."
					elif not bedroom.isSmokeyWearingBra:
						output += "*GASP* You just realized that Smokey's manly mammaries are COMPLETELY exposed! This simply will not do!"
					return output

				SubjectID.BEARD:
					if bedroom.isSmokeysBeardTrimmed:
						return "Smokey's beard is perfectly trimmed now!"
					elif bedroom.isSmokeysBeardShavingCreamed:
						return "The drier lint in Smokey's beard is now fully covered in foam. He's ready for a shave!"
					else:
						return "It's been a while since you've shaved smokey, and the drier lint in his beard is uneven and matted."

				SubjectID.HAIR:
					if bedroom.isSmokeyWearingHat:
						return "Smokey's luscious locks are packed tightly beneath his signature hat."
					elif bedroom.isSmokeysHairCut:
						return "After a good trim, Smokey's hair is neat and tidy."
					else:
						return "Smokey's hair is a tangled, matted mess! He's overdue for a good trim."

				SubjectID.AXE:
					return "While not as sharp as it once was, this axe is still good for cutting your way through messy situations."

				SubjectID.MACHETE:
					return "This machete is a sharp and exacting tool, great for jobs requiring a higher degree of precision."

				SubjectID.FIRE_EXTINGUISHER:
					return "You bought this fire extinguisher at a steep discount. It's extra-foamy discharge is sub par at putting out fires, but it's a great moisturizer!"

				SubjectID.HAT:
					return "That's Smokey's signature hat alright!"

				SubjectID.TOOLS:
					return "This selection of tools is Smokey-approved from grooming and pampering!"


				SubjectID.ZOOMBA_BED:
					return "Nothing but the best for Zoomba! This bed is stuffed with the finest ostrich feathers and imported dutch dust bunnies."

				SubjectID.ZOOMBA_FOOD:
					return (
						"Zoomba has been having some digestive issues lately, so you're having him try out some new foods. " +
						"Right now, you've got a nice selection of crushed red pepper, flint flakes, buttery bread crumbs, and charcoal powder. " +
						"If you scatter some of them on the floor and then wake up Zoomba, he should have no problem chowing down on the meal."
					)

				SubjectID.MAT:
					return (
						"Your pet Zoomba truly is the best boi! He's the fastest model on the market, but to keep up that speed he needs to be fed regularly."
					)

				SubjectID.ZOOMBA:
					if bedroom.roombaSatisfied:
						return (
							"It looks like Zoomba is in a satisfied food coma right now, but he'll start searching the rest of the room for dusty snacks before too long!"
						)
					else:
						return (
							"Zoomba is fast asleep on his bed right now. It's been a while since you fed him though. " +
							"You'll have to make sure there's some food ready for him when he wakes up."
						)

				SubjectID.PEPPER_FLAKES:
					return "This crushed red pepper sure has a kick to it! Maybe Zoomba would like some extra spice in his breakfast?"

				SubjectID.FLINT_FLAKES:
					return "These flint flakes were marketed towards the slower Shloomba models, but maybe it's fine for your Zoomba as well?"

				SubjectID.BREAD_CRUMBS:
					return "There isn't a robot vacuum on the market who doesn't love buttery bread crumbs! They're delicious!"

				SubjectID.CHARCOAL_POWDER:
					return "Charcoal powder is supposed to be great for Zoomba's digestion, but you've had trouble getting him to eat it in the past..."


				SubjectID.GAMING_CHAIR:
					return "You earned this sick gaming chair by donating 1337 boxtops to your local shool system. Worth it!"

				SubjectID.CABLES:
					return (
						"Something tells you that this cable management is a safety hazard, but it's been this way for so long that you've started to view it as " +
						"a fine piece of modern art. It would just be wrong to reorganize it now."
					)

				SubjectID.COMPUTER:
					if bedroom.isComputerCleaned:
						return "Your computer is all tidied up now! The cows on your desktop are still dancing happily and munching away at their cereal."
					else:
						bedroom.accessComputer()
						return ""


				SubjectID.CTC_POSTER:
					return "\"Cinnamon Toast Terror\" was the horror movie that nobody asked for... nobody except you, of course! You've seen it 26 times now!"

				SubjectID.MILK_POSTER:
					return (
						"You have to hide this poster behind a tapestry of the Mother Mary whenever your parents visit, but it's worth it to have such a timeless " +
						"piece of commercial dairy history displayed for your other house guests."
					)

				SubjectID.AMBIGUOUS_POSTER:
					return requestAdditionalContextCustom(
						"which poster would you like to " + actionAlias + "? The one on the [left wall] or the one on the [back wall]?",
						REQUEST_SUBJECT, ["poster "], [" poster"]
					)

				SubjectID.FLOOR:
					if bedroom.scatteredPepperFlakes or bedroom.scatteredFlintFlakes or bedroom.scatteredBreadCrumbs or bedroom.scatteredCharcoalPowder:
						return "You've got some food laid out for Zoomba now. Time to turn him on!"
					else:
						return "Your bedroom floor is extra clean thanks to Zoomba!"


		### Moving
		ActionID.MOVE_TO:
			match subjectID:
				SubjectID.AMBIGUOUS_DOOR:
					return requestAdditionalContextCustom(
						"What door would you like to " + actionAlias + "?",REQUEST_SUBJECT, ["door "], [" door"]
					)

				SubjectID.YARD_DOOR:
					bedroom.movePlayer(bedroom.PlayerPos.FRONT_YARD_DOOR)
					return "You move over to the " + subjectAlias

				SubjectID.KITCHEN_DOOR:
					bedroom.movePlayer(bedroom.PlayerPos.KITCHEN_DOOR)
					return "You move over to the " + subjectAlias

				SubjectID.LEGO_BED, SubjectID.LEGO_TABLE:
					bedroom.movePlayer(bedroom.PlayerPos.LEGO_TABLE)
					return "You move over to the " + subjectAlias

				SubjectID.AMBIGUOUS_BED:
					if bedroom.playerPos in [
						bedroom.PlayerPos.FRONT_YARD_DOOR, bedroom.PlayerPos.COMPUTER_DESK, bedroom.PlayerPos.LEGO_TABLE, bedroom.PlayerPos.BED_LEFT_SIDE
					]:
						bedroom.movePlayer(bedroom.PlayerPos.BED_LEFT_SIDE)
						return "You move over to the left side of the bed."
					else:
						bedroom.movePlayer(bedroom.PlayerPos.BED_RIGHT_SIDE)
						return "You move over to the right side of the bed."

				SubjectID.DRESSER:
					bedroom.movePlayer(bedroom.PlayerPos.DRESSER)
					return "You move over to the " + subjectAlias

				SubjectID.AMBIGUOUS_TABLE:
					return requestAdditionalContextCustom(
						"which table would you like to " + actionAlias + "?", REQUEST_SUBJECT, ["table "], [" table"]
					)

				SubjectID.ZOOMBA_TABLE, SubjectID.ZOOMBA_FOOD:
					bedroom.movePlayer(bedroom.PlayerPos.ZOOMBA_FOOD_TABLE)
					return "You move over to the table with Zoomba's food."

				SubjectID.SMOKEY:
					bedroom.movePlayer(bedroom.PlayerPos.SMOKEY)
					return "You move over to Smokey the Bear."

				SubjectID.TOOLS:
					bedroom.movePlayer(bedroom.PlayerPos.SMOKEY_TOOLS)
					return "You move over to tool rack."

				SubjectID.ZOOMBA_BED, SubjectID.ZOOMBA, SubjectID.MAT:
					bedroom.movePlayer(bedroom.PlayerPos.ZOOMBA)
					return "You move over to Zoomba."

				SubjectID.GAMING_CHAIR, SubjectID.COMPUTER:
					bedroom.movePlayer(bedroom.PlayerPos.COMPUTER_DESK)
					return "You move over to the " + subjectAlias


		### Taking held items
		ActionID.TAKE:
			match subjectID:

				-1 when clothingCharacteristics:

					match bedroom.clothingSearchResult:
						bedroom.SearchResult.NONEXISTENT:
							return "You don't see any clothes matching that description on your bed."
						bedroom.SearchResult.AMBIGUOUS:
							return "There are multiple clothes within reach that match that description. You'll need to be more specific."
						bedroom.SearchResult.BURIED:
							return "The clothing matching your description is currently buried under other clothes. You'll need to remove those first."
						bedroom.SearchResult.FOUND:

							if bedroom.playerHeldItem != bedroom.PlayerHeldItem.NONE:
								if (
									bedroom.playerHeldItem == bedroom.PlayerHeldItem.CLOTHING and
									bedroom.heldClothing.type == Clothing.SOCK and
									not bedroom.heldSecondSock
								):
									if ClothingCharacteristics.fromClothing(foundClothing).matchesClothing(bedroom.heldClothing):
										bedroom.pickUpClothing(foundClothing)
										return "You pick up the matching sock."
									else:
										return "That clothing item doesn't match the sock you're already holding..."
								else: return "Your hands are already full."
							
							else:
								bedroom.pickUpClothing(foundClothing)
								if clothingCharacteristics.typeAlias == "socks":
									if bedroom.foundSecondSock:
										bedroom.pickUpClothing(bedroom.foundSecondSock)
										return "You pick up the pair of matching socks."
									else:
										return "You pick up one sock, but the other is still buried."
								else: return ("You pick up the " + ClothingCharacteristics.fromClothing(foundClothing).to_string() + ".")

				SubjectID.CLOTHES:
					return "You'll need to be more specific. What type of clothing are you trying to " + actionAlias + "?"

				SubjectID.LEGO_BED, SubjectID.AMBIGUOUS_BED:
					return "There's no need to take your Fuego set anywhere. This dry, cracked, wooden table is the perfect place to build them!"
				
				SubjectID.PILLOWS:
					return "You don't see a good reason to take the pillows off the bed. That's where they belong!"


				SubjectID.TOOLS:
					return requestAdditionalContextCustom("Which tool would you like to " + actionAlias + "?", REQUEST_SUBJECT)

				SubjectID.AXE:
					if bedroom.playerHeldItem == bedroom.PlayerHeldItem.AXE:
						return "You're already holding the axe."
					elif bedroom.playerHeldItem != bedroom.PlayerHeldItem.NONE:
						return "Your hands need to be free before you can pick up the axe."
					else:
						bedroom.pickUpAxe()
						return "You grip the axe handle tightly in both hands and lift it off the tool rack."

				SubjectID.MACHETE:
					if bedroom.playerHeldItem == bedroom.PlayerHeldItem.MACHETE:
						return "You're already holding the machete."
					elif bedroom.playerHeldItem != bedroom.PlayerHeldItem.NONE:
						return "Your hands need to be free before you can pick up the machete."
					else:
						bedroom.pickUpMachete()
						return "You snatch the machete off of the tool rack and give it a few practice swings. You immediately feel 200% cooler."

				SubjectID.FIRE_EXTINGUISHER:
					if bedroom.playerHeldItem == bedroom.PlayerHeldItem.FIRE_EXTINGUISHER:
						return "You're already holding the fire extinguisher."
					elif bedroom.playerHeldItem != bedroom.PlayerHeldItem.NONE:
						return "Your hands need to be free before you can pick up the fire extinguisher."
					else:
						bedroom.pickUpFireExtinguisher()
						return "You pick the fire extinguisher up off of the ground and ready the nozzle."

				SubjectID.HAT:
					if bedroom.isPlayerWearingHat:
						return "You're already wearing Smokey's hat."
					elif bedroom.isSmokeyWearingHat:
						return "You just gave Smokey his hat. It would be rude to take it back now."
					else:
						bedroom.pickUpHat()
						return "What a stylish hat! You pick it up and put it on your head for safe keeping."


				SubjectID.ZOOMBA_FOOD:
					if bedroom.playerHeldItem == bedroom.PlayerHeldItem.NONE:
						return requestAdditionalContextCustom(
							"What food would you like to " + actionAlias + "? " +
							"You have crushed red [pepper], [flint] flakes, buttery [bread] crumbs, and [charcoal] powder.",
							REQUEST_SUBJECT
						)
					elif bedroom.playerHeldItem in [bedroom.PlayerHeldItem.PEPPER_FLAKES, bedroom.PlayerHeldItem.FLINT_FLAKES,
													bedroom.PlayerHeldItem.BREAD_CRUMBS, bedroom.PlayerHeldItem.CHARCOAL_POWDER]:
						return "You are already holding food for Zoomba."
					else:
						return "You'll need to put down what you're holding first."

				SubjectID.PEPPER_FLAKES:
					if bedroom.playerHeldItem == bedroom.PlayerHeldItem.NONE:
						bedroom.pickUpPepperFlakes()
						return "You pick up the " + subjectAlias + "."
					elif bedroom.playerHeldItem == bedroom.PlayerHeldItem.PEPPER_FLAKES:
						return "You are already holding that."
					else:
						return "You'll need to put down what you're holding first."

				SubjectID.FLINT_FLAKES:
					if bedroom.playerHeldItem == bedroom.PlayerHeldItem.NONE:
						bedroom.pickUpFlintFlakes()
						return "You pick up the " + subjectAlias + "."
					elif bedroom.playerHeldItem == bedroom.PlayerHeldItem.FLINT_FLAKES:
						return "You are already holding that."
					else:
						return "You'll need to put down what you're holding first."

				SubjectID.BREAD_CRUMBS:
					if bedroom.playerHeldItem == bedroom.PlayerHeldItem.NONE:
						bedroom.pickUpBreadCrumbs()
						return "You pick up the " + subjectAlias + "."
					elif bedroom.playerHeldItem == bedroom.PlayerHeldItem.BREAD_CRUMBS:
						return "You are already holding that."
					else:
						return "You'll need to put down what you're holding first."

				SubjectID.CHARCOAL_POWDER:
					if bedroom.playerHeldItem == bedroom.PlayerHeldItem.NONE:
						bedroom.pickUpCharcoalPowder()
						return "You pick up the " + subjectAlias + "."
					elif bedroom.playerHeldItem == bedroom.PlayerHeldItem.CHARCOAL_POWDER:
						return "You are already holding that."
					else:
						return "You'll need to put down what you're holding first."


		### Replacing held items
		ActionID.REPLACE, ActionID.PUT when (
			actionID == ActionID.REPLACE or (actionID == ActionID.PUT and modifierID != -1)
		):

			if bedroom.playerHeldItem == bedroom.PlayerHeldItem.NONE: return "You're not holding anything right now."

			match subjectID:

				SubjectID.CLOTHES, -1 when subjectID == SubjectID.CLOTHES or clothingCharacteristics != null:
					# First determine if the command can be ascribed to the currently held clothes.
					if bedroom.playerHeldItem != bedroom.PlayerHeldItem.CLOTHING or not clothingCharacteristics.matchesClothing(bedroom.heldClothing):
						return "You're not holding " + clothingCharacteristics.to_string() + "."
					
					# Second, determine if any invalid modifiers are used.
					elif modifierID in [
						ModifierID.AT_TOP_OF_BED, ModifierID.ON_TOOL_RACK
					]: return "You don't want to put your clothes there."

					# Next, determine where the clothing is going.
					var clothingDestination: SubjectID = SubjectID.NONE
					match modifierID:
						-1 when actionID == ActionID.REPLACE:
							if actionAlias in ["replace", "return", "put back", "put down", "set down"]:
								clothingDestination = SubjectID.AMBIGUOUS_BED
							elif actionAlias == "put away":
								clothingDestination = SubjectID.AMBIGUOUS_DRAWER
							else:
								return requestAdditionalModifierContext("Where")
						ModifierID.ON_BED, ModifierID.BACK, ModifierID.DOWN:
							clothingDestination = SubjectID.AMBIGUOUS_BED
						ModifierID.IN_DRESSER, ModifierID.IN_AMBIGUOUS_DRAWER, ModifierID.AWAY:
							clothingDestination = SubjectID.AMBIGUOUS_DRAWER
						ModifierID.IN_AMBIGUOUS_TOP_DRAWER:
							clothingDestination = SubjectID.AMBIGUOUS_TOP_DRAWER
						ModifierID.IN_TOP_LEFT_DRAWER:
							clothingDestination = SubjectID.TOP_LEFT_DRAWER
						ModifierID.IN_TOP_RIGHT_DRAWER:
							clothingDestination = SubjectID.TOP_RIGHT_DRAWER
						ModifierID.IN_MIDDLE_DRAWER:
							clothingDestination = SubjectID.MIDDLE_DRAWER
						ModifierID.IN_BOTTOM_DRAWER:
							clothingDestination = SubjectID.BOTTOM_DRAWER
						ModifierID.ON_SMOKEY:
							clothingDestination = SubjectID.SMOKEY
						ModifierID.ON:
							assert(actionID != ActionID.PUT, "This should have been handled earlier...")
							return unknownParse()
						_:
							return unknownParse()
					if clothingDestination == SubjectID.AMBIGUOUS_DRAWER:
						clothingDestination = getOpenDrawer()
						if clothingDestination == SubjectID.NONE: return "There are no drawers open to receive your clothes."
					elif clothingDestination == SubjectID.AMBIGUOUS_TOP_DRAWER:
						if isDrawerOpen(SubjectID.TOP_LEFT_DRAWER): clothingDestination = SubjectID.TOP_LEFT_DRAWER
						elif isDrawerOpen(SubjectID.TOP_RIGHT_DRAWER): clothingDestination = SubjectID.TOP_RIGHT_DRAWER
						else: return "Neither of the top drawers are open right now."
					elif clothingDestination != SubjectID.AMBIGUOUS_BED and not isDrawerOpen(clothingDestination):
						return "That drawer is not open right now."
					
					# Ok, we now have a valid destination! (I.e., a specific location that is open/willing to accept clothes.)
					if clothingDestination == SubjectID.AMBIGUOUS_BED:
						if bedroom.heldClothing.folded:
							return "No point in returning folded clothes to the bed."
						else:
							bedroom.replaceHeldClothing(clothingCharacteristics.typeAlias == "socks")
							return "You return the " + clothingCharacteristics.to_string() + " to the bed."
					elif clothingDestination in [SubjectID.TOP_LEFT_DRAWER, SubjectID.TOP_RIGHT_DRAWER, SubjectID.MIDDLE_DRAWER, SubjectID.BOTTOM_DRAWER]:
						if not bedroom.heldClothing.folded:
							bedroom.angerDresser()
							return (
								"You attempt to stuff the unfolded " + clothingCharacteristics.typeAlias + " into the dresser, but it complains loudly:\n" +
								"\"" + getDresserPatienceMessage() + "\""
							)
						elif clothingCharacteristics.typeAlias == "sock": clothingCharacteristics.typeAlias += 's'
						
						var correctDrawer: bool
						match clothingDestination:
							SubjectID.TOP_LEFT_DRAWER: correctDrawer = bedroom.heldClothing.type == Clothing.SOCK
							SubjectID.TOP_RIGHT_DRAWER: correctDrawer = bedroom.heldClothing.type == Clothing.UNDERWEAR
							SubjectID.MIDDLE_DRAWER: correctDrawer = bedroom.heldClothing.type == Clothing.PANTS
							SubjectID.BOTTOM_DRAWER: correctDrawer = bedroom.heldClothing.type == Clothing.SHIRT
						
						if correctDrawer:
							bedroom.putAwayClothing(bedroom.heldClothing)
							return "You place the neatly folded " + clothingCharacteristics.typeAlias + " into the dresser, which hums excitedly."
						else:
							bedroom.angerDresser()
							return (
								"You attempt to stuff the folded " + clothingCharacteristics.typeAlias + " into the open drawer, causing the dresser to exclaim:\n" +
								"\"" + getDresserPatienceMessage() + "\""
							)
					elif clothingDestination == SubjectID.SMOKEY:
						if bedroom.heldClothing.type == Clothing.BRA:
							assert(false, "Should be unreachable since this case is handled in specific actions.")
							return ""
						else:
							return "That belongs in your dresser, not on Smokey."


				## These are designated as invalid options since they don't fit the usual schema of "putting down" an object, and accepted edge cases
				## have already been covered in the "Making Bed" subcategory of specific actions.
				SubjectID.PILLOWS, SubjectID.SHEET, SubjectID.COMFORTER:
					return "You're not carrying the " + subjectAlias + "."
				

				SubjectID.TOOLS:
					if bedroom.playerHeldItem == bedroom.PlayerHeldItem.AXE:
						bedroom.replaceAxe()
						return "You return the axe to the tool rack."
					if bedroom.playerHeldItem == bedroom.PlayerHeldItem.MACHETE:
						bedroom.replaceMachete()
						return "You return the machete to the tool rack."
					if bedroom.playerHeldItem == bedroom.PlayerHeldItem.FIRE_EXTINGUISHER:
						bedroom.replaceFireExtinguisher()
						return "You place the fire extinguisher back on the ground."
					else:
						return "You're not holding a tool right now."

				SubjectID.AXE:
					if bedroom.playerHeldItem == bedroom.PlayerHeldItem.AXE:
						bedroom.replaceAxe()
						return "You return the axe to the tool rack."
					else:
						return "You're not carrying the axe."

				SubjectID.MACHETE:
					if bedroom.playerHeldItem == bedroom.PlayerHeldItem.MACHETE:
						bedroom.replaceMachete()
						return "You return the machete to the tool rack."
					else:
						return "You're not carrying the machete."

				SubjectID.FIRE_EXTINGUISHER:
					if bedroom.playerHeldItem == bedroom.PlayerHeldItem.FIRE_EXTINGUISHER:
						bedroom.replaceFireExtinguisher()
						return "You place the fire extinguisher back on the ground."
					else:
						return "You're not carrying the fire extinguisher."

				SubjectID.HAT:
					if bedroom.isPlayerWearingHat:
						bedroom.replaceHat()
						return "You return the hat to the tool rack."
					else:
						return "You're not wearing the hat right now."


				SubjectID.ZOOMBA_FOOD, SubjectID.PEPPER_FLAKES, SubjectID.FLINT_FLAKES, SubjectID.BREAD_CRUMBS, SubjectID.CHARCOAL_POWDER when (
					modifierID not in [-1, ModifierID.ON_TABLE, ModifierID.BACK, ModifierID.AWAY, ModifierID.DOWN]
				):
					assert(modifierID != ModifierID.ON_FLOOR, "This should have been handled earlier...")
					return "Zoomba's food doesn't belong there."

				SubjectID.ZOOMBA_FOOD:
					if bedroom.playerHeldItem == bedroom.PlayerHeldItem.PEPPER_FLAKES:
						bedroom.replacePepperFlakes()
						return "You put the " + subjectAlias + " back on the table."
					elif bedroom.playerHeldItem == bedroom.PlayerHeldItem.FLINT_FLAKES:
						bedroom.replaceFlintFlakes()
						return "You put the " + subjectAlias + " back on the table."
					elif bedroom.playerHeldItem == bedroom.PlayerHeldItem.BREAD_CRUMBS:
						bedroom.replaceBreadCrumbs()
						return "You put the " + subjectAlias + " back on the table."
					elif bedroom.playerHeldItem == bedroom.PlayerHeldItem.CHARCOAL_POWDER:
						bedroom.replaceCharcoalPowder()
						return "You put the " + subjectAlias + " back on the table."
					else:
						return "You're not holding any food for Zoomba right now."

				SubjectID.PEPPER_FLAKES:
					if bedroom.playerHeldItem == bedroom.PlayerHeldItem.PEPPER_FLAKES:
						bedroom.replacePepperFlakes()
						return "You put the " + subjectAlias + " back on the table."
					else:
						return "You're not holding the " + subjectAlias + " right now."

				SubjectID.FLINT_FLAKES:
					if bedroom.playerHeldItem == bedroom.PlayerHeldItem.FLINT_FLAKES:
						bedroom.replaceFlintFlakes()
						return "You put the " + subjectAlias + " back on the table."
					else:
						return "You're not holding the " + subjectAlias + " right now."

				SubjectID.BREAD_CRUMBS:
					if bedroom.playerHeldItem == bedroom.PlayerHeldItem.BREAD_CRUMBS:
						bedroom.replaceBreadCrumbs()
						return "You put the " + subjectAlias + " back on the table."
					else:
						return "You're not holding the " + subjectAlias + " right now."

				SubjectID.CHARCOAL_POWDER:
					if bedroom.playerHeldItem == bedroom.PlayerHeldItem.CHARCOAL_POWDER:
						bedroom.replaceCharcoalPowder()
						return "You put the " + subjectAlias + " back on the table."
					else:
						return "You're not holding the " + subjectAlias + " right now."


		### Default actions
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
			SceneManager.openEndings(bedroom)
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


class ClothingCharacteristics:
	var type: int
	var typeAlias: String
	var color: int
	var colorAlias: String
	var pattern: int
	var patternAlias: String
	var bothSocks: bool:
		get(): return typeAlias == "socks"

	func _init(p_type: int = Clothing.AMBIGUOUS, p_color: int = Clothing.AMBIGUOUS, p_pattern: int = Clothing.AMBIGUOUS):
		type = p_type
		color = p_color
		pattern = p_pattern
	
	static func fromClothing(clothing: Clothing) -> ClothingCharacteristics:
		return ClothingCharacteristics.new(clothing.type, clothing.color, clothing.pattern)

	func _to_string():
		var string := ""

		if patternAlias:
			string += patternAlias + " "
		else:
			match pattern:
				Clothing.PLAIN: string += "plain "
				Clothing.STRIPED: string += "striped "
				Clothing.SPOTTED: string += "spotted "
		
		if colorAlias:
			string += colorAlias + " "
		else:
			match color:
				Clothing.WHITE: string += "white "
				Clothing.RED: string += "red "
				Clothing.GREEN: string += "green "
				Clothing.YELLOW: string += "yellow "
				Clothing.BLACK: string += "black "
				Clothing.PINK: string += "pink "
		
		if typeAlias:
			string += typeAlias + " "
		else:
			match type:
				Clothing.SOCK: string += "sock"
				Clothing.UNDERWEAR: string += "underwear"
				Clothing.PANTS: string += "pants"
				Clothing.SHIRT: string += "shirt"
				Clothing.BRA: string += "bra"
				Clothing.AMBIGUOUS: string += "clothing"

		return string

	func matchesClothing(clothing: Clothing) -> bool:
		return (
			(type == Clothing.AMBIGUOUS or type == clothing.type) and
			(color == Clothing.AMBIGUOUS or color == clothing.color) and
			(pattern == Clothing.AMBIGUOUS or pattern == clothing.pattern)
		)

const CLOTHING_TYPE_STRINGS: Dictionary[String, int] = {
	"socks" : Clothing.SOCK, "sock" : Clothing.SOCK, "bra" : Clothing.BRA,
	"underwear" : Clothing.UNDERWEAR, "boxers" : Clothing.UNDERWEAR, "briefs" : Clothing.UNDERWEAR, "tighty whities" : Clothing.UNDERWEAR,
	"pants" : Clothing.PANTS, "jeans" : Clothing.PANTS, "shirt" : Clothing.SHIRT, "t shirt" : Clothing.SHIRT, "t-shirt" : Clothing.SHIRT, 
	"clothes" : Clothing.AMBIGUOUS, "clothing" : Clothing.AMBIGUOUS,
}
const CLOTHING_COLOR_STRINGS: Dictionary[String, int] = {
	"white" : Clothing.WHITE, "light gray" : Clothing.WHITE, "red" : Clothing.RED, "green" : Clothing.GREEN,
	"yellow" : Clothing.YELLOW, "black" : Clothing.BLACK, "dark gray" : Clothing.BLACK, "pink" : Clothing.PINK
}
const CLOTHING_PATTERN_STRINGS: Dictionary[String, int] = {
	"plain" : Clothing.PLAIN, "unpatterned" : Clothing.PLAIN, "no pattern" : Clothing.PLAIN,
	"striped" : Clothing.STRIPED, "pinstripe" : Clothing.STRIPED, "with strips" : Clothing.STRIPED,
	"spotted" : Clothing.SPOTTED, "with spots" : Clothing.SPOTTED, "polka dot" : Clothing.SPOTTED, "with polka dots" : Clothing.SPOTTED,
}
func getClothingCharacteristicsFromWildCard(p_wildCard: String):

	var clothingCharacteristics := ClothingCharacteristics.new()

	for clothingTypeString in CLOTHING_TYPE_STRINGS:
		if clothingTypeString in p_wildCard:
			clothingCharacteristics.type = CLOTHING_TYPE_STRINGS[clothingTypeString]
			clothingCharacteristics.typeAlias = clothingTypeString
			p_wildCard = p_wildCard.replace(clothingTypeString, "")
			break

	for clothingColorString in CLOTHING_COLOR_STRINGS:
		if clothingColorString in p_wildCard:
			clothingCharacteristics.color = CLOTHING_COLOR_STRINGS[clothingColorString]
			clothingCharacteristics.colorAlias = clothingColorString
			p_wildCard = p_wildCard.replace(clothingColorString, "")
			break

	for clothingPatternString in CLOTHING_PATTERN_STRINGS:
		if clothingPatternString in p_wildCard:
			clothingCharacteristics.pattern = CLOTHING_PATTERN_STRINGS[clothingPatternString]
			clothingCharacteristics.patternAlias = clothingPatternString
			p_wildCard = p_wildCard.replace(clothingPatternString, "")
			break

	var remainingWildCard := p_wildCard.strip_edges()
	if remainingWildCard == "" or (clothingCharacteristics.type == Clothing.SOCK and remainingWildCard in ["pair of", "both"]): return clothingCharacteristics
	else: return null


func getExposedClothesString():
	var exposedClothesString := "Right now, the following clothes are exposed:\n"
	var viewedSocks: Array[Clothing]
	var previouslyViewed: bool

	for clothing in bedroom.accessibleClothing:
		previouslyViewed = false
		if clothing.type == Clothing.SOCK:
			for sock in viewedSocks:
				if clothing.pattern == sock.pattern and clothing.color == sock.color:
					previouslyViewed = true
					break
			viewedSocks.append(clothing)
		if previouslyViewed: exposedClothesString += "- Another "
		elif clothing.type == Clothing.SOCK or clothing.type == Clothing.BRA or clothing.type == Clothing.SHIRT: exposedClothesString += "- A "
		else: exposedClothesString += "- Some "
		
		exposedClothesString += ClothingCharacteristics.fromClothing(clothing).to_string() + "\n"
	
	return exposedClothesString


func isDrawerOpen(drawer: SubjectID) -> bool:
	match drawer:
		SubjectID.TOP_LEFT_DRAWER:
			return bedroom.topLeftDrawerControl.visible
		SubjectID.TOP_RIGHT_DRAWER:
			return bedroom.topRightDrawerControl.visible
		SubjectID.MIDDLE_DRAWER:
			return bedroom.middleDrawerControl.visible
		SubjectID.BOTTOM_DRAWER:
			return bedroom.bottomDrawerControl.visible
	assert(false, "Unrecognized subject: " + str(drawer))
	return false
		
func getOpenDrawer() -> SubjectID:
	if bedroom.topLeftDrawerControl.visible:
		return SubjectID.TOP_LEFT_DRAWER
	elif bedroom.topRightDrawerControl.visible:
		return SubjectID.TOP_RIGHT_DRAWER
	elif bedroom.middleDrawerControl.visible:
		return SubjectID.MIDDLE_DRAWER
	elif bedroom.bottomDrawerControl.visible:
		return SubjectID.BOTTOM_DRAWER
	else:
		return SubjectID.NONE

func toggleDrawer(drawer: SubjectID):
	match drawer:
		SubjectID.TOP_LEFT_DRAWER:
			bedroom.toggleTopLeftDrawer()
		SubjectID.TOP_RIGHT_DRAWER:
			bedroom.toggleTopRightDrawer()
		SubjectID.MIDDLE_DRAWER:
			bedroom.toggleMiddleDrawer()
		SubjectID.BOTTOM_DRAWER:
			bedroom.toggleBottomDrawer()

## Decrease dresser patience first by calling bedroom.angerDresser()
func getDresserPatienceMessage():
	match bedroom.dresserPatience:
		5:
			return "THE DRESSER ENHANCEMENT PROTOCOL'S STYLE GUIDE (DEP-8) EXPRESSLY DISCOURAGES THIS USE-CASE. PLEASE REFRAIN FROM THIS BEHAVIOR."
		4:
			return "PERHAPS I WAS NOT CLEAR BEFORE. YOU MUST CEASE ALL UNSANCTIONED DRESSER ACTIVITIES."
		3:
			return "EXTREME CAUTION IS ADVISED: FURTHER DISREGARD FOR PROPER CLOTHING ORGANIZATION WILL RESULT IN A HARD RESET OF THE ENVIRONMENT."
		2:
			return "NO! THIS IS UNACCEPTABLE! REFER TO DEP-8 IMMEDIATELY OR FACE THE CONSEQUENCES"
		1:
			return "STOP STOP STOP STOP STOP! THIS IS YOUR FINAL WARNING!"
		0:
			SceneManager.transitionToScene(
				SceneManager.SceneID.ENDING,
				'"ENOUGH!" The dresser blurts out, angrily. "YOU HAVE BEEN REPEATEDLY WARNED TO STOP COMMITTING ATROCITIES AGAINST THE DEP-8 STYLE GUIDE. ' +
				'I AM LEFT WITH NO CHOICE BUT TO ENFORCE A HARD RESET OF THIS CLOTHING ENVIRONMENT." The dresser begins to vibrate ominously, and in mere seconds, ' +
				"black smoke begins billowing out of the closed drawers. You panic, wrenching open the drawers and trying desperately to remove your clothes " +
				"from the incinerator. This proves to be a poor decision. A rogue pair of flaming underpants is all it takes for the fire to spread beyond the " +
				"confines of your dresser to the rest of your house...",
				SceneManager.EndingID.ERRORS_SHOULD_NEVER_PASS_SILENTLY
			)
			return ""

const SUBJECT_TO_SCATTERED: Dictionary[SubjectID, Bedroom.Scattered] = {
	SubjectID.PEPPER_FLAKES : Bedroom.Scattered.PEPPER_FLAKES,
	SubjectID.FLINT_FLAKES : Bedroom.Scattered.FLINT_FLAKES,
	SubjectID.BREAD_CRUMBS : Bedroom.Scattered.BREAD_CRUMBS,
	SubjectID.CHARCOAL_POWDER : Bedroom.Scattered.CHARCOAL_POWDER,
}

const SUBJECT_TO_HELD: Dictionary[SubjectID, Bedroom.PlayerHeldItem] = {
	SubjectID.PEPPER_FLAKES : Bedroom.PlayerHeldItem.PEPPER_FLAKES,
	SubjectID.FLINT_FLAKES : Bedroom.PlayerHeldItem.FLINT_FLAKES,
	SubjectID.BREAD_CRUMBS : Bedroom.PlayerHeldItem.BREAD_CRUMBS,
	SubjectID.CHARCOAL_POWDER : Bedroom.PlayerHeldItem.CHARCOAL_POWDER,
}
