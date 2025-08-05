class_name ComputerCleaningParser
extends InputParser

const INFO_LOCKED_MESSAGE = "Clippy is still giving his presentation. It would be rude to interrupt..."

@export var computerCleaning: ComputerCleaning

enum ActionID {
	INSPECT,
	SPEED_UP, SLOW_DOWN, SKIP, CLOSE, OPEN, EXECUTE, FEED,
	MAIN_MENU, ENDINGS, POOP, QUIT, AFFIRM, DENY,
	EXIT_COMPUTER, END,
}

enum SubjectID {
	SELF,
	DESKTOP,
	AMBIGUOUS_WINDOW, AMBIGUOUS_WINDOWS,
	INFO_WINDOW, CLIPPY,
	RESOURCE_MONITOR, CPU, RAM, HEAT,
	CAT_WINDOW, CAT_WINDOWS,
	EXCEL_WINDOW, EXCEL_WINDOWS,
	MASSIVE_MOUSE_MAMA, MASSIVE_MOUSE_MAMA_IMPROPER, ANTIMATTER_CHEESE,
	BACKGROUND, TIME, END_BUTTON
}
const OPEN_EXECUTE_HYBRIDS = [
	SubjectID.MASSIVE_MOUSE_MAMA, SubjectID.MASSIVE_MOUSE_MAMA_IMPROPER, SubjectID.ANTIMATTER_CHEESE
]

enum ModifierID {
	
}


func initParsableActions():
	addParsableAction(ActionID.ENDINGS,
			["endings", "view endings", "achievements", "view achievements", "help", "hints", "hint"])
	addParsableAction(ActionID.INSPECT, ["inspect", "look at", "look in", "look", "read", "view"], true)
	addParsableAction(ActionID.MAIN_MENU,
			["main menu", "menu", "main", "go to main menu", "go back to main menu", "return to main menu"])
	addParsableAction(ActionID.POOP, ["poop", "crap", "shit your pants", "shit"])
	addParsableAction(ActionID.QUIT, ["quit game", "quit", "exit game"])

	addParsableAction(ActionID.SPEED_UP, ["speed up", "go fast", "ask clippy to speed up", "ask clippy to go fast"])
	addParsableAction(ActionID.SLOW_DOWN, ["slow down", "go slow", "slow", "ask clippy to slow down", "ask clippy to go slow"])
	addParsableAction(ActionID.SKIP, ["skip clippy", "skip", "shut up clippy", "shut up"])
	addParsableAction(ActionID.CLOSE, ["close", "delete", "destroy"], true)
	addParsableAction(ActionID.OPEN, ["open"])
	addParsableAction(ActionID.EXECUTE,
					  ["execute", "run", "click on", "click", "double click on", "double click", "double-click on", "double-click", "activate"])
	addParsableAction(ActionID.FEED, ["feed", "appease", "give mouse to"])
	addParsableAction(ActionID.EXIT_COMPUTER, ["exit computer", "exit", "leave computer", "leave", "bye", "back out", "back", "escape", "esc"])
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

	addParsableSubject(SubjectID.AMBIGUOUS_WINDOWS, ["all windows", "windows"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE])
	addParsableSubject(SubjectID.AMBIGUOUS_WINDOW, ["window"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE, ActionID.SKIP])

	addParsableSubject(SubjectID.INFO_WINDOW, ["info window", "clippy window", "help window", "presentation"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE, ActionID.SKIP, ActionID.SPEED_UP, ActionID.SLOW_DOWN])
	addParsableSubject(SubjectID.CLIPPY, ["firefighter clippy", "clippy", "firefighter"],
		[ActionID.INSPECT, ActionID.SKIP, ActionID.SPEED_UP, ActionID.SLOW_DOWN, ActionID.CLOSE])
	
	addParsableSubject(SubjectID.RESOURCE_MONITOR, ["resource monitor", "resource window", "resources", "resource"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE])
	addParsableSubject(SubjectID.HEAT, ["heat", "cpu heat"],
		[ActionID.INSPECT])
	addParsableSubject(SubjectID.CPU, ["cpu"],
		[ActionID.INSPECT])
	addParsableSubject(SubjectID.RAM, ["ram"],
		[ActionID.INSPECT])
	
	addParsableSubject(SubjectID.CAT_WINDOWS,
		["cat windows", "cat pictures", "cat pics", "cats",
		"all cat windows", "all cat pictures", "all cat pics", "all cats"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE, ActionID.FEED])
	addParsableSubject(SubjectID.CAT_WINDOW, ["cat window", "cat picture", "cat pic", "cat"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE, ActionID.FEED])

	addParsableSubject(SubjectID.EXCEL_WINDOWS,
		["excel windows", "spreadsheet windows", "spreadsheets",
		"all excel windows", "all spreadsheet windows", "all spreadsheets"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE])
	addParsableSubject(SubjectID.EXCEL_WINDOW, ["excel window", "spreadsheet window", "excel", "spreadsheet"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE])
	
	addParsableSubject(SubjectID.MASSIVE_MOUSE_MAMA,
		["massive mouse mama", "massive_mouse_mama.exe", "massive_mouse_mama", "the_big_mmm.exe"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.EXECUTE])
	addParsableSubject(SubjectID.MASSIVE_MOUSE_MAMA_IMPROPER,
		["massive mouse", "massive_mouse", "massive mama", "massive_mama", "mouse mama", "mouse_mama", "mouse", "mama"],
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
	addParseSub("faster", "fast")
	addParseSub("slower", "slow")
	addParseSub("mother", "mama")
	addParseSub("mom", "mama")

func parseItems() -> String:

	parseEventsSinceLastConfirmation += 1

	match actionID:

		ActionID.INSPECT:

			if wildCard:
				var potentialHeaderText: String
				if subjectAlias: potentialHeaderText = subjectAlias + ' ' + wildCard.to_lower()
				else: potentialHeaderText = wildCard.to_lower()

				if computerCleaning.getCatPicByHeader(potentialHeaderText):
					validWildCard = true
					return "These cats keep you company while you make more breakfast-themed spreadsheets."
				elif computerCleaning.getSpreadsheetByHeader(potentialHeaderText):
					validWildCard = true
					return "These spreadsheets help keep your mind busy when you come to check on your cats."
				else:
					return unrecognizedEndingParse()

			match subjectID:

				-1:
					if actionAlias == "look":
						return requestAdditionalSubjectContext("Where", [], [], ["at "])
					else:
						return requestAdditionalSubjectContext()
				
				SubjectID.SELF:
					return "Posture check!"

				SubjectID.DESKTOP:
					if computerCleaning.finished:
						return "Nice work! Your desktop looks much better now, and that's one more item checked off your to-do list!"
					elif computerCleaning.catPics or computerCleaning.spreadsheets:
						return "It looks like there's still more work to be done before your desktop is clean..."
					else:
						return "Your desktop looks much better now... So why are the fans on your PC running so hard?"

				SubjectID.AMBIGUOUS_WINDOW, SubjectID.AMBIGUOUS_WINDOWS:
					return "You've always thought it was strange that they're called windows when you can't even see through them..."

				SubjectID.INFO_WINDOW:
					if computerCleaning.infoWindow:
						return "Oh boy! It looks like Clippy has something special in store for you!"
					else:
						return "You've already closed that window."

				SubjectID.CLIPPY:
					if computerCleaning.infoWindow or computerCleaning.finished:
						return "Clippy has been dressed like this ever since you overclocked your CPU. You can't imagine why..."
					else:
						return "Clippy is nowhere to be found."

				SubjectID.RESOURCE_MONITOR:
					if computerCleaning.infoWindow:
						return "It's difficult to see what's going on behind Clippy's presentation. You'll have to wait for him to finish."
					elif computerCleaning.resourceMonitor in computerCleaning.taskbarItems:
						return "This info looks important..."
					else:
						return "You already closed the resource monitor."

				SubjectID.CPU:
					if computerCleaning.resourceMonitor in computerCleaning.taskbarItems:
						return "CPU... You're pretty sure that stands for \"Cat Pictures Unlimited\"."
					else:
						return "You already closed the resource monitor."

				SubjectID.RAM:
					if computerCleaning.resourceMonitor in computerCleaning.taskbarItems:
						return "RAM... Reproducing Asexual Mice?"
					else:
						return "You already closed the resource monitor."

				SubjectID.HEAT:
					if computerCleaning.resourceMonitor in computerCleaning.taskbarItems:
						return "You're beginning to regret overclocking your CPU to remove the safety shutoffs..."
					else:
						return "You already closed the resource monitor."

				SubjectID.CAT_WINDOW, SubjectID.CAT_WINDOWS:
					if computerCleaning.catPics:
						return "These cats keep you company while you make more breakfast-themed spreadsheets."
					else:
						return "No more cats... You'll have to open some more after you get off work."

				SubjectID.EXCEL_WINDOW, SubjectID.EXCEL_WINDOWS:
					if computerCleaning.spreadsheets:
						return "These spreadsheets help keep your mind busy when you come to check on your cats."
					else:
						return "You've already closed all the spreadsheets."

				SubjectID.MASSIVE_MOUSE_MAMA, SubjectID.MASSIVE_MOUSE_MAMA_IMPROPER:
					return "That's the Massive Mouse Mama. She's a huge help in keeping your cats happy."

				SubjectID.ANTIMATTER_CHEESE:
					return "You really ought to invest in a more humane method of euthanizing the mice...\nMaybe later."

				SubjectID.BACKGROUND:
					if computerCleaning.catPics or computerCleaning.spreadsheets:
						return "Your beautiful desktop background is still obscured by clutter..."
					else:
						return "Beautiful! The cows are enjoying their breakfast and looking as fine as ever!"

				SubjectID.TIME:
					return "Uh-oh! Would you look at the time! You'd better hurry up and finish your chores so you can go make breakfast!"

				SubjectID.END_BUTTON:
					return "Huh... You could have sworn that this button looked different yesterday..."


		ActionID.SPEED_UP:
			if not computerCleaning.infoWindow or computerCleaning.infoTextState == ComputerCleaningInfo.PAUSED:
				return wrongContextParse()
			elif computerCleaning.infoTextState == ComputerCleaningInfo.FAST_SCROLL:
				return "The presentation is already zooming! You don't think it can go any faster!"
			elif computerCleaning.infoTextState == ComputerCleaningInfo.SLOW_SCROLL:
				if computerCleaning.clippyAskingForSpeed:
					computerCleaning.infoWindow.displayClippyConfirmSpeed()
					return "You let Clippy know that are ready for SPEEEEED!"
				if computerCleaning.clippyAwaitingCommand:
					computerCleaning.infoWindow.displayClippyAskForAssurance()
					return "You've changed your mind. This presentation is agonizingly slow!"
				else:
					return wrongContextParse()


		ActionID.SLOW_DOWN:
			if not computerCleaning.infoWindow or computerCleaning.infoTextState == ComputerCleaningInfo.PAUSED:
				return wrongContextParse()
			elif computerCleaning.infoTextState == ComputerCleaningInfo.SLOW_SCROLL:
				return "The presentation is already crawling... You don't think it can go any slower..."
			elif computerCleaning.infoTextState == ComputerCleaningInfo.FAST_SCROLL:
				return "It looks like Clippy is pretending not to hear you..."


		ActionID.SKIP:
			if computerCleaning.infoWindow:
				computerCleaning.infoWindow.finish()
				return (
					"You decide you've had enough of Clippy's presentation. It's time to get cleaning!"
				)
			else:
				return (
					"Clippy has already finished his presentation. No need to skip past it now!"
				)


		ActionID.CLOSE:

			if wildCard:
				var potentialHeaderText: String
				if subjectAlias: potentialHeaderText = subjectAlias + ' ' + wildCard.to_lower()
				else: potentialHeaderText = wildCard.to_lower()

				var potentialCatPic := computerCleaning.getCatPicByHeader(potentialHeaderText)
				var potentialSpreadsheet := computerCleaning.getSpreadsheetByHeader(potentialHeaderText)

				if potentialCatPic:
					validWildCard = true
					if computerCleaning.infoWindow:
						return INFO_LOCKED_MESSAGE
					elif potentialCatPic.angry:
						return "That cat is too hungry and refuses to be closed. Quick! Get it a mouse!"
					else:
						computerCleaning.attemptCloseCatPic(potentialCatPic)
						return "Reluctantly, the cat closes as your CPU works to appease it."
				elif potentialSpreadsheet:
					validWildCard = true
					if computerCleaning.infoWindow:
						return INFO_LOCKED_MESSAGE
					else:
						computerCleaning.attemptCloseSpreadsheet(potentialSpreadsheet)
						return "The spreadsheet blinks out of existence, and its contents are temporarily transferred to RAM while it saves."
				else:
					AudioManager.playSound(AudioManager.badTextInput, true)
					return "You can't find a window to close with that name."

			match subjectID:

				-1:
					return requestAdditionalSubjectContext()
				
				SubjectID.AMBIGUOUS_WINDOW:
					return requestAdditionalContextCustom(
						"What window would you like to " + actionAlias + "?",
						REQUEST_SUBJECT, [], [" window"]
					)

				SubjectID.AMBIGUOUS_WINDOWS:
					if computerCleaning.infoWindow: computerCleaning.infoWindow.finish()
					if computerCleaning.resourceMonitor in computerCleaning.taskbarItems:
						computerCleaning.resourceMonitor.hide()
						computerCleaning.removeTaskbarItem(computerCleaning.resourceMonitor)
					while computerCleaning.attemptCloseCatPic(): pass
					while computerCleaning.attemptCloseSpreadsheet(): pass
					return "You rapidly close all the windows you can. That should do it!"

				SubjectID.INFO_WINDOW, SubjectID.CLIPPY:
					if computerCleaning.infoWindow:
						computerCleaning.infoWindow.finish()
						return (
							"You decide you've had enough of Clippy's presentation. It's time to get cleaning!"
						)
					else:
						return (
							"Clippy has already finished his presentation. No need to skip past it now!"
						)

				SubjectID.RESOURCE_MONITOR:
					if computerCleaning.infoWindow:
						return INFO_LOCKED_MESSAGE
					elif computerCleaning.resourceMonitor in computerCleaning.taskbarItems:
						computerCleaning.resourceMonitor.hide()
						computerCleaning.removeTaskbarItem(computerCleaning.resourceMonitor)
						return "This resource monitor looks like it might be helpful... For nerds! Get it outta here!"
					else:
						return "The resource monitor has already been closed."

				SubjectID.CAT_WINDOW:
					if computerCleaning.infoWindow:
						return INFO_LOCKED_MESSAGE
					elif computerCleaning.attemptCloseCatPic():
						return "Reluctantly, the cat closes as your CPU works to appease it."
					elif computerCleaning.catPics:
						return "Your cats are too hungry and refuse to be closed. Quick! Get them some mice!"
					else:
						return "You've already closed all the cats."

				SubjectID.CAT_WINDOWS:
					if computerCleaning.infoWindow:
						return INFO_LOCKED_MESSAGE
					elif computerCleaning.catPics:
						while computerCleaning.attemptCloseCatPic(): pass
						return "You quickly close all the cat pictures you can. That'll show 'em!"
					else:
						return "You've already closed all the cats."

				SubjectID.EXCEL_WINDOW:
					if computerCleaning.infoWindow:
						return INFO_LOCKED_MESSAGE
					elif computerCleaning.attemptCloseSpreadsheet():
						return "The spreadsheet blinks out of existence, and its contents are temporarily transferred to RAM while it saves."
					else:
						return "You've already closed all the spreadsheets."

				SubjectID.EXCEL_WINDOWS:
					if computerCleaning.infoWindow:
						return INFO_LOCKED_MESSAGE
					elif computerCleaning.spreadsheets:
						while computerCleaning.attemptCloseSpreadsheet(): pass
						return "You quickly close all the spreadsheets you can. Excel is icky!"
					else:
						return "You've already closed all the spreadsheets."


		ActionID.EXECUTE, ActionID.OPEN when subjectID in OPEN_EXECUTE_HYBRIDS:
			if computerCleaning.infoWindow:
				return INFO_LOCKED_MESSAGE
			else:
				match subjectID:
					SubjectID.MASSIVE_MOUSE_MAMA:
						if computerCleaning.finished:
							return "You just finished cleaning up your computer! It's best not to clutter the screen with more mice."
						elif len(computerCleaning.mice) >= 50:
							return (
								"You try to call on the awesome power of the massive mouse mama, but she refuses to comply. " +
								"It seems there are already too many mice on the screen."
							)
						else:
							computerCleaning.spawnMice(randi_range(3,5))
							return "You double click on the massive mouse mama and watch in awe as she brings new mice into existence."

					SubjectID.MASSIVE_MOUSE_MAMA_IMPROPER:
						return (
							"The massive_mouse_mama.exe refuses to be addressed by anything less than her full title. However, in " +
							"extenuating circumstances she will also accept her SoundCloud alias: \"The_Big_MMM.exe\""
						)

					SubjectID.ANTIMATTER_CHEESE:
						if computerCleaning.mice:
							computerCleaning.activateAntimatterCheese()
							return "You double click on the antimatter cheese and say a quick prayer for all the poor mice on your screen."
						else:
							return "You double click on the antimatter cheese, but nothing happens."


		ActionID.EXECUTE:
			if subjectID == -1:
				return requestAdditionalSubjectContext()

			elif subjectID == SubjectID.END_BUTTON:
				SceneManager.transitionToScene(
				SceneManager.SceneID.ENDING,
				"You could've sworn that the button in the bottom left corner of your computer screen used to say \"Start\", " +
				"but that's certainly not the case right now... Curiosity gets the better of you and you decide to try clicking on it.\n" +
				"You immediately regret this decision as your beautiful desktop is replaced by an avatar of breakfast-" +
				"themed wrath. A mixture of ominous laughter and Latin chanting begin to echo from your speakers, and jets of flame " +
				"erupt from your keyboard. Drat! You should have known that torrenting copies of the bible would come back to bite you...",
				SceneManager.EndingID.ITS_NOT_A_BUG_ITS_A_FEATURE
				)
				return ""


		ActionID.OPEN:
			if computerCleaning.infoWindow:
				if subjectID == SubjectID.INFO_WINDOW:
					return "You're already looking at the info window. No need to open another!"
				else:
					return INFO_LOCKED_MESSAGE

			match subjectID:

				-1:
					return requestAdditionalSubjectContext()
				
			return "You're trying to get rid of all these windows, not create more!"


		ActionID.FEED:
			if computerCleaning.infoWindow:
				return INFO_LOCKED_MESSAGE
			else:
				return "There's no need to feed your cats manually. They prefer to hunt the mice down themselves."


		ActionID.EXIT_COMPUTER:
			if computerCleaning.catPics or computerCleaning.spreadsheets:
				return "Your desktop still isn't clean, and it doesn't sit right with you to leave it in this state."
			elif not computerCleaning.finished:
				return (
					"Your desktop looks much better, but your CPU fans are still working overtime... You should probably " +
					"stick around to make sure everything is alright."
				)

			else:
				SceneManager.closeComputerCleaning()
				return "Wonderful! Your computer is all tidied up now."


		ActionID.END:
			SceneManager.transitionToScene(
				SceneManager.SceneID.ENDING,
				"You could've sworn that the button in the bottom left corner of your computer screen used to say \"Start\", " +
				"but that's certainly not the case right now... Curiosity gets the better of you and you decide to try clicking on it.\n" +
				"You immediately regret this decision as your beautiful desktop is replaced by an avatar of breakfast-" +
				"themed wrath. A mixture of ominous laughter and Latin chanting begin to echo from your speakers, and jets of flame " +
				"erupt from your keyboard. Drat! You should have known that torrenting copies of the bible would come back to bite you...",
				SceneManager.EndingID.ITS_NOT_A_BUG_ITS_A_FEATURE
			)
			return ""


		ActionID.POOP:
			return (
				"Nice try, but this isn't that game."
			)

		ActionID.MAIN_MENU:
			if parseEventsSinceLastConfirmation <= 1 and confirmingActionID == ActionID.MAIN_MENU:
				SceneManager.transitionToScene(SceneManager.SceneID.MAIN_MENU)
				return ""
			else:
				parseEventsSinceLastConfirmation = 0
				confirmingActionID = ActionID.MAIN_MENU
				return "Are you sure you want to return to the main menu?"

		ActionID.ENDINGS:
			return "Now's not the time to be looking at endings. You've got a computer to clean!"

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
			if computerCleaning.clippyAskingForSpeed:
				computerCleaning.infoWindow.displayClippyConfirmSpeed()
				return "You let Clippy know that are ready for SPEEEEED!"
			elif parseEventsSinceLastConfirmation <= 1:
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
			if computerCleaning.clippyAskingForSpeed:
				computerCleaning.infoWindow.displayClippyDenySpeed()
				return "You decide that the presentation should be allowed to move at its own pace. You can wait."
			elif parseEventsSinceLastConfirmation <= 1:
				return (
					"Okie-dokie artichokie! If you change your mind, just ask again."
				)
			else:
				return (
					"It's not clear what you want to say no to..."
				)

	return unknownParse()