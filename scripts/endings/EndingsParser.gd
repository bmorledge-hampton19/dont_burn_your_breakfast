class_name EndingsParser
extends InputParser

@export var endings: Endings

enum ActionID {
	INSPECT,
	UNLOCK, LOCK, COLLECT_COINS, ENDING, BUY, USE, PREVIOUS, NEXT, GO_BACK, TAKE_SHORTCUT,
	MAIN_MENU, ENDINGS, POOP, QUIT, AFFIRM, DENY,
}

enum SubjectID {
	SHORTCUT, COINS, ENDING, PREVIOUS, NEXT, LEVEL, UNLOCKING_HINT, AVOIDING_HINT, AMBIGUOUS_HINT,
}

enum ModifierID {
	
}


func initParsableActions():
	addParsableAction(ActionID.ENDINGS,
			["endings", "view endings", "achievements", "view achievements", "help", "hints", "hint"])
	addParsableAction(ActionID.INSPECT, ["inspect", "look at", "look in", "look", "read", "view"], true)
	addParsableAction(ActionID.QUIT, ["quit game", "quit the game", "quit", "exit game", "exit the game"])
	addParsableAction(ActionID.MAIN_MENU,
			["main menu", "menu", "main", "go to the main menu","go to main menu", "go back to the main menu",
			"go back to main menu", "return to the main menu", "return to main menu"])
	addParsableAction(ActionID.TAKE_SHORTCUT, ["take shortcut", "use shortcut", "shortcut"])
	addParsableAction(ActionID.UNLOCK, ["unlock"])
	addParsableAction(ActionID.LOCK, ["lock"])
	addParsableAction(ActionID.COLLECT_COINS,
			["collect coins", "collect all coins", "collect cereal coins", "collect cc", "collect all", "collect"])
	addParsableAction(ActionID.ENDING, ["ending", "end"], true)
	addParsableAction(ActionID.BUY, ["buy", "purchase"], true)
	addParsableAction(ActionID.USE, ["use"], true)
	addParsableAction(ActionID.PREVIOUS,
			["previous page", "previous level", "previous", "prev", "got to previous page", "go to previous level", "<"])
	addParsableAction(ActionID.NEXT, ["next page", "next level", "next", "go to next page", "go to next level", ">"])
	addParsableAction(ActionID.GO_BACK,
			["go back to endings", "go back", "back", "return to endings", "return", "close ending", "close", "exit", "leave"])
	addParsableAction(ActionID.POOP, ["poop", "crap", "shit your pants", "shit"])
	addParsableAction(ActionID.AFFIRM, ["affirmative", "yes please", "yes", "yup", "y"])
	addParsableAction(ActionID.DENY, ["negative", "nope", "no thank you", "no", "n"])


func initParsableSubjects():
	addParsableSubject(SubjectID.SHORTCUT, ["shortcut", "lock"],
			[ActionID.INSPECT, ActionID.LOCK, ActionID.UNLOCK])
	addParsableSubject(SubjectID.COINS, ["coins", "coin", "cc", "cereal coins", "cereal coin", "money"],
			[ActionID.INSPECT])
	addParsableSubject(SubjectID.ENDING, ["ending", "end"],
			[ActionID.INSPECT, ActionID.BUY])
	addParsableSubject(SubjectID.PREVIOUS, ["previous", "prev", "<"],
			[ActionID.INSPECT])
	addParsableSubject(SubjectID.NEXT, ["next", ">"],
			[ActionID.INSPECT])
	addParsableSubject(SubjectID.LEVEL, ["level", "background"],
			[ActionID.INSPECT])
	addParsableSubject(SubjectID.UNLOCKING_HINT,
			["unlocking hints", "unlocking hint", "hint for unlocking", "hint to unlock", "unlocking", "unlock hint", "unlock"],
			[ActionID.INSPECT, ActionID.BUY, ActionID.USE])
	addParsableSubject(SubjectID.AVOIDING_HINT,
			["avoiding hints", "avoiding hint", "hint for avoiding", "hint to avoid", "avoiding", "avoid hint", "avoid"],
			[ActionID.INSPECT, ActionID.BUY, ActionID.USE])
	addParsableSubject(SubjectID.AMBIGUOUS_HINT, ["hints", "hint"],
			[ActionID.INSPECT, ActionID.BUY, ActionID.USE])
	

func initParsableModifiers():
	pass


func parseItems() -> String:

	parseEventsSinceLastConfirmation += 1

	match actionID:

		ActionID.INSPECT:

			if wildCard and subjectID not in [
				SubjectID.ENDING, SubjectID.UNLOCKING_HINT, SubjectID.AVOIDING_HINT, SubjectID.AMBIGUOUS_HINT, -1
			]: return unrecognizedEndingParse()

			match subjectID:

				-1:
					if not wildCard:
						if actionAlias == "look":
							return requestAdditionalSubjectContext("Where", [], [], ["at "])
						else:
							return requestAdditionalSubjectContext()
					elif not endings.viewingEnding:
						return attemptViewEnding()
					elif wildCard.is_valid_int():
						return "Are you trying to view a hint? Make sure to specify what kind of hint you want to view."

				SubjectID.SHORTCUT:
					if endings.viewingEnding or endings.currentLevel == SceneManager.SceneID.MAIN_MENU:
						return wrongContextParse()
					elif EndingsManager.isSceneShortcutUnlocked(endings.currentLevel):
						return (
							"You've unlocked a shortcut to this level! To use it, input the command \"start from " +
							SceneManager.SceneID.keys()[endings.currentLevel].to_lower().replace('_', ' ') + "\" " +
							"on the main menu."
						)
					else:
						return (
							"This shortcut is still locked... To unlock it, complete the previous level and " +
							"find all of its endings. " +
							"Don't forget to buy hints if you're having trouble finding an ending!"
						)

				SubjectID.COINS:
					return (
						"These are cereal coins, the best currency! You can use them here to buy hints, and you'll earn more " +
						"for every ending you unlock."
					)
				
				SubjectID.ENDING:

					if not wildCard:
						return requestAdditionalContextCustom(
							"Which ending would you like to view? (Input the corresponding number)",
							REQUEST_WILDCARD
						)
					else:
						return attemptViewEnding()
				
				SubjectID.PREVIOUS:
					if endings.viewingEnding or endings.currentLevel == SceneManager.SceneID.MAIN_MENU:
						return wrongContextParse()
					else:
						return "Type \"prev\" to return to the previous level's endings."
				
				SubjectID.NEXT:
					if endings.viewingEnding or endings.currentLevel == SceneManager.SceneID.BATHROOM:
						return wrongContextParse()
					else:
						return "Type \"next\" to return to the next level's endings."
				
				SubjectID.LEVEL:
					if endings.viewingEnding: return wrongContextParse()
					match endings.currentLevel:
						SceneManager.SceneID.MAIN_MENU:
							return (
								"This is the main menu screen. You were just there!"
							)
						SceneManager.SceneID.BATHROOM:
							return (
								"This is the bathroom screen. It reminds you of excessive dental hygiene"
							)
				
				SubjectID.UNLOCKING_HINT:
					if not endings.viewingEnding: return wrongContextParse()
					return attemptViewHint(EndingsManager.UNLOCKING)
				
				SubjectID.AVOIDING_HINT:
					if not endings.viewingEnding: return wrongContextParse()
					return attemptViewHint(EndingsManager.AVOIDING)
				
				SubjectID.AMBIGUOUS_HINT:
					if not endings.viewingEnding: return wrongContextParse()
					return requestAdditionalContextCustom(
						"Are you trying to view an [unlocking hint] or an [avoiding hint]?",
						REQUEST_SUBJECT
					)
		

		ActionID.UNLOCK:
			if endings.viewingEnding or endings.currentLevel == SceneManager.SceneID.MAIN_MENU:
				return wrongContextParse()
			else:
				if EndingsManager.isSceneShortcutUnlocked(endings.currentLevel):
					return (
						"You've already unlocked this shortcut. To use it, input the command \"start from " +
							SceneManager.SceneID.keys()[endings.currentLevel].to_lower().replace('_', ' ') + "\" " +
							"on the main menu."
					)
				else:
					return (
						"This shortcut is still locked... To unlock it, complete the previous level and " +
						"find all of its endings. " +
						"Don't forget to buy hints if you're having trouble finding an ending!"
					)


		ActionID.LOCK:
			if endings.viewingEnding or endings.currentLevel == SceneManager.SceneID.MAIN_MENU:
				return wrongContextParse()
			else:
				if EndingsManager.isSceneShortcutUnlocked(endings.currentLevel):
					return "What? Why? Just leave the shortcut unlocked, silly!"
				else:
					return "Yup. This shortcut is indeed locked."


		ActionID.TAKE_SHORTCUT:
			return "You have to be at the main menu to use a shortcut."


		ActionID.COLLECT_COINS:
			if endings.viewingEnding: return "You need to [go back] to the endings first."
			else:
				var collectedCoins := endings.collectCoins()
				if collectedCoins > 100:
					AudioManager.playSound(AudioManager.collectLotsOfCerealCoins, true)
					return "Wow! You're a breakfast superstar! Have ALL the cereal coins!"
				elif collectedCoins > 1:
					AudioManager.playSound(AudioManager.collectCerealCoins, true)
					return "Collected " + str(collectedCoins) + " cereal coins!"
				elif collectedCoins == 1:
					AudioManager.playSound(AudioManager.collectCerealCoins, true)
					return "Collected 1 cereal coin."
				else:
					return "There are no cereal coins to collect for this level."


		ActionID.ENDING:
			if not wildCard:
				return requestAdditionalContextCustom(
					"Which ending would you like to view? (Input the corresponding number)",
					REQUEST_WILDCARD
				)
			else:
				return attemptViewEnding()

				
		ActionID.BUY:

			if subjectID == -1 and wildCard: return unknownParse()
			elif subjectID != -1 and wildCard and not wildCard.is_valid_int(): return unknownParse()

			if not endings.viewingEnding: return wrongContextParse()

			if parseEventsSinceLastConfirmation <= 1 and confirmingActionID == ActionID.BUY and (
				subjectID == SubjectID.AMBIGUOUS_HINT or subjectID == -1 or
				(subjectID == SubjectID.UNLOCKING_HINT and endings.confirmingHintType == EndingsManager.UNLOCKING) or 
				(subjectID == SubjectID.AVOIDING_HINT and endings.confirmingHintType == EndingsManager.AVOIDING)
			):
				if EndingsManager.getCerealCoins() < endings.confirmingHintCost:
					return "Sorry... You're too poor to buy this hint!"
				else:
					AudioManager.playSound(AudioManager.buyHint, true)
					return (
						"Enjoy your new hint! Here it is:\n" +
						EndingsManager.buyHint(endings.viewingEndingID, endings.confirmingHintType)
					)

			match subjectID:
				SubjectID.UNLOCKING_HINT:
					return attemptBuyHint(EndingsManager.UNLOCKING)
				
				SubjectID.AVOIDING_HINT:
					return attemptBuyHint(EndingsManager.AVOIDING)
				
				SubjectID.AMBIGUOUS_HINT:
					return requestAdditionalContextCustom(
						"Are you trying to buy an [unlocking hint] or an [avoiding hint]?",
						REQUEST_SUBJECT
					)
				
				-1:
					return requestAdditionalSubjectContext()


		ActionID.USE:
			match subjectID:
				SubjectID.UNLOCKING_HINT:
					if not endings.viewingEnding: return wrongContextParse()
					return attemptViewHint(EndingsManager.UNLOCKING)
				
				SubjectID.AVOIDING_HINT:
					if not endings.viewingEnding: return wrongContextParse()
					return attemptViewHint(EndingsManager.AVOIDING)
				
				SubjectID.AMBIGUOUS_HINT:
					if not endings.viewingEnding: return wrongContextParse()
					return requestAdditionalContextCustom(
						"Are you trying to view an [unlocking hint] or an [avoiding hint]?",
						REQUEST_SUBJECT
					)


		ActionID.PREVIOUS:
			if endings.viewingEnding: return "You need to [go back] to the endings first."
			else:
				match endings.currentLevel:
					SceneManager.SceneID.MAIN_MENU:
						return wrongContextParse()
					SceneManager.SceneID.BATHROOM:
						endings.changeLevel(SceneManager.SceneID.MAIN_MENU)
						return ""
					SceneManager.SceneID.FRONT_YARD:
						endings.changeLevel(SceneManager.SceneID.BATHROOM)
						return ""
					SceneManager.SceneID.BEDROOM:
						endings.changeLevel(SceneManager.SceneID.FRONT_YARD)
						return ""
					SceneManager.SceneID.KITCHEN:
						endings.changeLevel(SceneManager.SceneID.BEDROOM)
						return ""
					SceneManager.SceneID.ENDING:
						endings.changeLevel(SceneManager.SceneID.KITCHEN)
						return ""


		ActionID.NEXT:
			if endings.viewingEnding: return "You need to [go back] to the endings first."
			else:
				match endings.currentLevel:
					SceneManager.SceneID.MAIN_MENU:
						endings.changeLevel(SceneManager.SceneID.BATHROOM)
						return ""
					SceneManager.SceneID.BATHROOM:
						if EndingsManager.isSceneBeaten(SceneManager.SceneID.BATHROOM):
							endings.changeLevel(SceneManager.SceneID.FRONT_YARD)
							return ""
						else:
							return "Hey! No peeking!\n(You haven't reached the next level yet.)"
					SceneManager.SceneID.FRONT_YARD:
						if EndingsManager.isSceneBeaten(SceneManager.SceneID.FRONT_YARD):
							endings.changeLevel(SceneManager.SceneID.BEDROOM)
							return ""
						else:
							return "Hey! No peeking!\n(You haven't reached the next level yet.)"
					SceneManager.SceneID.BEDROOM:
						if EndingsManager.isSceneBeaten(SceneManager.SceneID.BEDROOM):
							endings.changeLevel(SceneManager.SceneID.KITCHEN)
							return ""
						else:
							return "Hey! No peeking!\n(You haven't reached the next level yet.)"
					SceneManager.SceneID.KITCHEN:
						if EndingsManager.isEndingUnlocked(SceneManager.EndingID.FINISHING_STRONG):
							endings.changeLevel(SceneManager.SceneID.ENDING)
							return ""
						else:
							return "You get the strange sense that there's a secret ending somewhere still waiting to be unlocked..."
					SceneManager.SceneID.ENDING:
						return wrongContextParse()


		ActionID.GO_BACK:
			if endings.viewingEnding:
				endings.returnFromEnding()
				return ""
			else:
				SceneManager.closeEndings()
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
			return (
				"You're already viewing the endings screen. Use the command \"exit\" to return to the screen you came here from."
			)

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
					ActionID.BUY:
						if EndingsManager.getCerealCoins() < endings.confirmingHintCost:
							return "Sorry... You're too poor to buy this hint!"
						else:
							AudioManager.playSound(AudioManager.buyHint, true)
							return (
								"Enjoy your new hint! Here it is:\n" +
								EndingsManager.buyHint(endings.viewingEndingID, endings.confirmingHintType)
							)

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


func attemptViewEnding() -> String:

	wildCard = wildCard.replace("ending", "").replace("end", "").strip_edges()
	if not wildCard.is_valid_int():
		return wildCard + " is not a valid ending number."
	var endingNum = wildCard.to_int()
	if endingNum < 1 or endingNum > endings.currentLevelEndingPreviews.size():
		return wildCard + " is not a valid ending number."

	validWildCard = true

	if endings.viewingEnding:
		return "You are already viewing an ending. [Go back] to view a different ending."

	endings.viewEnding(endingNum-1)
	var endingID = endings.viewingEndingID
	var totalUnlockingHints := EndingsManager.getNumberOfHints(endingID, EndingsManager.UNLOCKING, EndingsManager.TOTAL)
	var totalAvoidingHints := EndingsManager.getNumberOfHints(endingID, EndingsManager.AVOIDING, EndingsManager.TOTAL)
	var boughtUnlockingHints := EndingsManager.getNumberOfHints(endingID, EndingsManager.UNLOCKING, EndingsManager.BOUGHT)
	var boughtAvoidingHints := EndingsManager.getNumberOfHints(endingID, EndingsManager.AVOIDING, EndingsManager.BOUGHT)

	var terminalOutput: String
	if EndingsManager.isEndingUnlocked(endingID):
		terminalOutput = (
			SceneManager.SceneID.keys()[endings.currentLevel].capitalize() + " ending " + str(endingNum) +
			": \"" + SceneManager.getEndingName(endingID) + "\"\n" +
			"This ending has " + str(totalUnlockingHints) + " unlocking " +
			Helpers.singularOrPlural(totalUnlockingHints, "hint") + " and " +
			str(totalAvoidingHints) + " avoiding " + Helpers.singularOrPlural(totalAvoidingHints, "hint") + ". "
		)

		if totalAvoidingHints == boughtAvoidingHints:
				terminalOutput += "All of these hints are available to you."
		else:
			terminalOutput += (
				"All the unlocking hints are available to you, and you have bought " +
				str(boughtAvoidingHints) +
				" of the avoiding hints."
			)

	else:
		terminalOutput = (
			"You have not unlocked this ending yet.\n" + "It has " + str(totalUnlockingHints) +
			" unlocking " + Helpers.singularOrPlural(totalUnlockingHints, "hint") + ", and you have "
		)
		if totalUnlockingHints == 1:
			if boughtUnlockingHints == 1:
				terminalOutput += "already bought it."
			else:
				terminalOutput += "not bought it yet."
		else:
			if totalUnlockingHints == boughtUnlockingHints:
				terminalOutput += "bought all of them."
			else:
				terminalOutput += "bought " + str(boughtUnlockingHints) + " of them."

	return terminalOutput


func attemptViewHint(hintType: int) -> String:

	var endingID := endings.viewingEndingID
	if hintType == EndingsManager.AVOIDING and not EndingsManager.isEndingUnlocked(endingID):
		return "You cannot view avoiding hints until you have unlocked this ending."

	var hintText: String
	if hintType == EndingsManager.UNLOCKING: hintText = "unlocking"
	else: hintText = "avoiding"

	var viewingCost := "cost" in wildCard
	wildCard = wildCard.replace("hint", "").replace("unlocking", "").replace("avoiding", "").replace("cost", "").strip_edges()
	if not wildCard:
		return requestAdditionalContextCustom(
			"Which " + hintText + " hint would you like to view? (Input the corresponding number)",
			REQUEST_WILDCARD
		)
	if not wildCard.is_valid_int():
		return wildCard + " is not a valid " + hintText + " hint number."
	var hintNum = wildCard.to_int()
	if hintNum < 1 or hintNum > EndingsManager.getNumberOfHints(endingID, hintType, EndingsManager.TOTAL):
		return wildCard + " is not a valid " + hintText + " hint number."

	validWildCard = true

	if EndingsManager.hasHintBeenBought(endingID, hintType, hintNum-1):
		if viewingCost:
			return "You already own this hint. It costs nothing now! :)"
		else:
			return EndingsManager.getHint(endingID, hintType, hintNum-1)
	elif viewingCost:
		var hintCost := EndingsManager.getHintCost(endingID, hintType, hintNum-1)

		return "This hint costs " + str(hintCost) + " cereal " + Helpers.singularOrPlural(hintCost, "coin") + "."
	else:
		return "You haven't bought this hint yet."


func attemptBuyHint(hintType: int) -> String:

	var endingID := endings.viewingEndingID
	if hintType == EndingsManager.AVOIDING and not EndingsManager.isEndingUnlocked(endingID):
		return "You cannot view avoiding hints until you have unlocked this ending."

	var hintText: String
	if hintType == EndingsManager.UNLOCKING: hintText = "unlocking"
	else: hintText = "avoiding"

	wildCard = wildCard.replace("hint", "").replace("unlocking", "").replace("avoiding", "").strip_edges()
	var hintNum := 0
	if wildCard:
		if not wildCard.is_valid_int():
			return wildCard + " is not a valid " + hintText + " hint number."
		hintNum = wildCard.to_int()
		if hintNum < 1 or hintNum > EndingsManager.getNumberOfHints(endingID, hintType, EndingsManager.TOTAL):
			return wildCard + " is not a valid " + hintText + " hint number."

	validWildCard = true

	var nextHintIndex := EndingsManager.getNumberOfHints(endingID, hintType, EndingsManager.BOUGHT)
	if hintNum == 0:
		if nextHintIndex == EndingsManager.getNumberOfHints(endingID, hintType, EndingsManager.TOTAL):
			return "You already own all the " + hintText + " hints for this ending. Go you!"
		else:
			parseEventsSinceLastConfirmation = 0
			confirmingActionID = ActionID.BUY
			endings.confirmingHintType = hintType
			endings.confirmingHintCost =EndingsManager.getHintCost(endingID, hintType, nextHintIndex)
			return (
				"The next " + hintText + " hint will cost " + str(endings.confirmingHintCost) +
				" cereal " + Helpers.singularOrPlural(endings.confirmingHintCost, "coin") + ". " + 
				"Are you sure you want to buy it?"
			)
	else:
		if EndingsManager.hasHintBeenBought(endingID, hintType, hintNum-1):
			return "You already own this " + hintText + " hint. You can't buy it again, but you're free to view it if you wish."
		elif nextHintIndex != (hintNum-1):
			return (
				"You must buy hints in order. The next " + hintText + " hint available for purchase is hint #" +
				str(nextHintIndex+1) + ". (When purchasing hints, it's easier to omit the hint number altogether.)"
			)
		else:
			parseEventsSinceLastConfirmation = 0
			confirmingActionID = ActionID.BUY
			endings.confirmingHintType = hintType
			endings.confirmingHintCost = EndingsManager.getHintCost(endingID, hintType, nextHintIndex)
			return (
				hintText.capitalize() + " hint " + str(hintNum) + " will cost " + str(endings.confirmingHintCost) +
				" cereal " + Helpers.singularOrPlural(endings.confirmingHintCost, "coin") + ". " +
				"Are you sure you want to buy it?"
			)
