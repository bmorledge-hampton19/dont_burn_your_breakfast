class_name EndingParser
extends InputParser

@export var endingScene: Ending

var firstParse = true
const endingMessage = (
	"Oh no! You burned your breakfast...\n\n" +
	"Would you like to [r]etry the current level or return to the [m]ain menu?"
)

enum ActionID {
	POOP, QUIT, MAIN_MENU, ENDINGS, RETRY, AFFIRM, DENY, BURN_BREAKFAST,
}

const BURN_BREAKFAST_ALIASES: Array[String] = [
	"burn breakfast", "burn cereal bowl", "burn bowl of cereal", "burn cereal", "burn ending", "burn scene",
	"burn it all", "burn it", "burn baby burn", "burn everything", "burn",
	"set breakfast on fire", "set cereal bowl on fire", "set bowl of cereal on fire", "set cereal on fire", "set ending on fire",
	"set scene on fire", "set it on fire", "set everything on fire", "set on fire",
	"ignite breakfast", "ignite cereal bowl", "ignite bowl of cereal", "ignite cereal", "ignite ending", "ignite scene",
	"ignite it all", "ignite it", "ignite everything", "ignite",
	"incinerate breakfast", "incinerate cereal bowl", "incinerate bowl of cereal", "incinerate cereal", "incinerate ending",
	"incinerate scene", "incinerate it all", "incinerate it", "incinerate everything", "incinerate",
	"start fire", "let it burn", "fire", "torch"
]

enum SubjectID {

}

enum ModifierID {
	
}


func initParsableActions():
	addParsableAction(ActionID.ENDINGS,
			["endings", "view endings", "achievements", "view achievements", "help", "hints", "hint"])
	addParsableAction(ActionID.BURN_BREAKFAST, BURN_BREAKFAST_ALIASES)
	addParsableAction(ActionID.MAIN_MENU,
			["main menu", "menu", "main", "go to the main menu","go to main menu", "go back to the main menu",
			"go back to main menu", "return to the main menu", "return to main menu", "m"])
	addParsableAction(ActionID.RETRY,
			["retry level", "retry current level", "retry", "replay level",
			 "back", "restart level", "restart current level", "restart", "r",])
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
		if input.to_lower() in REPLAY_PROMPTS:
			terminal.initMessage(
				terminal.lastReplayableMessage +
				"\n(Ok, fine. I guess *technically* you have to input any command EXCEPT one that replays the last message " +
				"to continue.)", false
			)
			AudioManager.playDefaultTextInputSound()
		elif input.to_lower() in [
			"retry level", "retry the current level", "retry", "replay level", "r", "back",
			"restart level", "restart the current level", "restart",
		]:
			SceneManager.transitionToScene(SceneManager.SceneID.LAST_SCENE)
			return ""
		elif SceneManager.endingID == SceneManager.EndingID.CHAMPION_OF_BREAKFASTS and input.to_lower() in BURN_BREAKFAST_ALIASES:
			terminal.initMessage(burnBreakfast(), true)
		else:
			firstParse = false
			if SceneManager.endingID == SceneManager.EndingID.CHAMPION_OF_BREAKFASTS:
				var message: String
				if EndingsManager.areAllEndingsUnlocked():
					message = (
						"Congratulations on reaching the end of the game! You're a true breakfast champion!\n" + 
						"It looks like you've found all the endings too. Impressive!\n" +
						"That means you've unlocked some secret settings in the options menu, " +
						"and I'll bet you're rolling in cereal coins too! " +
						"There's also a little surprise waiting for you at the main menu. " +
						"Be sure to go check it out. You've earned it!\n\n" +
						"(You can either return to the [m]ain menu now or [r]estart the current level.)"
					)
				else:
					message = (
						"Congratulations on reaching the end of the game! You're a true breakfast champion!\n" + 
						"But... It looks like you still have some endings left to find. " +
						"Don't forget that you can buy hints for the ones you're missing!\n" +
						"(You can either return to the [m]ain menu now or [r]estart the current level.)"
					)
				AudioManager.playDefaultTextInputSound()
				terminal.initMessage(message, true)
			else:
				AudioManager.stopMusic()
				AudioManager.playSound(AudioManager.youBurnedYourBreakfast, true, "OtherSounds", 1.3).finished.connect(
					func():
						await get_tree().create_timer(3).timeout
						AudioManager.startNewMusic(SceneManager.SceneID.ENDING, false, true)
				)
				endingScene.setMainEndingTexture()
				terminal.initMessage(endingMessage, true)
	else: super(input)


func parseItems() -> String:

	parseEventsSinceLastConfirmation += 1

	match actionID:

		ActionID.RETRY:
			SceneManager.transitionToScene(SceneManager.SceneID.LAST_SCENE)
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
			SceneManager.openEndings(endingScene)
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

		ActionID.BURN_BREAKFAST:
			if SceneManager.endingID == SceneManager.EndingID.CHAMPION_OF_BREAKFASTS:
				return burnBreakfast()
			else:
				return wrongContextParse()

	return unknownParse()


func burnBreakfast():
	firstParse = true
	endingScene.burnBreakfast()
	AudioManager.stopMusic()
	AudioManager.startNewMusic(SceneManager.SceneID.ENDING, false)
	return (
		"GAAAH! You just couldn't help yourself, huh? You beat the game, you got your breakfast, and somehow you STILL " +
		"found a way to burn it. Typical...\nAh well. I suppose it's still impressive in a sad, destructive sort of way. " +
		"Here's your secret ending. Does this mean you've got them all now?" +
		"\n(Input any command to continue.)"
	)
