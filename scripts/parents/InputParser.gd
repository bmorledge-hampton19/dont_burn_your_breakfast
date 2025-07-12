class_name InputParser
extends Node

var terminal: Terminal

class _ParsableItem:
	var id: int
	var aliases: Array[String]
	func _init(p_id: int, p_aliases: Array[String]):
		id = p_id
		aliases = p_aliases

const omittedArticlesAndAdjectives: Array[String] = [
	"the", "a", "an", "it", "this", "that", "these", "those", "your", "his", "my"
]

const replayPrompts: Array[String] = [
	"replay", "replay message", "replay last message",
	"repeat", "repeat message", "repeat last message"
]

var parsableActions: Array[_ParsableItem]
var actionsWithWildcards: Array[int]
var parsableSubjects: Dictionary
var parsableModifiers: Dictionary

var _originalInputSansPunct: String
var workingInput: String

var actionAlias: String
var previousActionAlias: String
var subjectAlias: String
var previousSubjectAlias: String
var modifierAlias: String
var previousModifierAlias: String
var wildCard: String
var previousWildCard: String
var validWildCard: bool

var actionID: int
var confirmingActionID: int
var previousActionID: int
var subjectID: int
var previousSubjectID: int
var modifierID: int
var previousModifierID: int

var parseSubs: Dictionary

var parseEventsSinceLastConfirmation: int = 2
enum {REQUEST_SUBJECT, REQUEST_MODIFIER, REQUEST_WILDCARD}
var requestingSubject := false
var requestingModifier := false
var requestingWildCard := false
var requestingHelperPrefixes: Array
var requestingHelperSuffixes: Array
var requestingExtraneousPrefixes: Array
var requestingExtraneousSuffixes: Array
var combineRequestingPrefixesAndSuffixes: bool

var storeThisMessage: bool


func _ready():
	initParsableActions()
	initParsableSubjects()
	initParsableModifiers()
	initParseSubs()
	if OS.is_debug_build(): testParsables()

func connectTerminal(p_terminal: Terminal):
	terminal = p_terminal
	terminal.sendInputForParsing.connect(receiveInputFromTerminal)

func disconnectTerminal():
	terminal.sendInputForParsing.disconnect(receiveInputFromTerminal)

func reconnectTerminal():
	terminal.sendInputForParsing.connect(receiveInputFromTerminal)

func addParsableAction(id: int, aliases: Array[String], allowWildCard = false):
	var newParsableAction = _ParsableItem.new(id, aliases)
	parsableActions.append(newParsableAction)
	if allowWildCard: actionsWithWildcards.append(id)
	parsableSubjects[id] = []
	parsableModifiers[id] = []

func initParsableActions():
	push_error("Unimplemented function.")


func addParsableSubject(id: int, aliases: Array[String], associatedActionIDs: Array[int]):
	var newParsableSubject = _ParsableItem.new(id, aliases)
	for associatedActionID in associatedActionIDs:
		parsableSubjects[associatedActionID].append(newParsableSubject)

func initParsableSubjects():
	push_error("Unimplemented function.")


func addParsableModifier(id: int, aliases: Array[String], associatedActionIDs: Array[int]):
	var newParsableModifier = _ParsableItem.new(id, aliases)
	for associatedActionID in associatedActionIDs:
		parsableModifiers[associatedActionID].append(newParsableModifier)

func initParsableModifiers():
	push_error("Unimplemented function.")

func addParseSub(subFrom: String, subTo: String):
	parseSubs[subFrom] = subTo

func addParseSubs(subFroms: Array[String], subTo: String):
	for subFrom in subFroms:
		parseSubs[subFrom] = subTo

func initParseSubs():
	pass

func invokeParseSubs(input: String) -> String:
	var inputPieces := input.split(' ')
	for i in range(len(inputPieces)):
		if inputPieces[i].to_lower() in parseSubs:
			inputPieces[i] = parseSubs[inputPieces[i].to_lower()]
	
	return ' '.join(inputPieces)


func testParsables():
	print("Testing parsables...")
	var actionAliasesSoFar := []
	var uniqueSubjectAliasesSoFar := {}
	var uniqueModifierAliasesSoFar := {}

	for parsableAction in parsableActions:
		for newAlias in parsableAction.aliases:
			for aliasSoFar in actionAliasesSoFar:
				if newAlias.begins_with(aliasSoFar):
					print("Action \"" + aliasSoFar + "\" hides \"" + newAlias + "\"")
			var afterParseSubs := invokeParseSubs(newAlias)
			if afterParseSubs != newAlias:
				print("Action \"" + newAlias + "\" altered to \"" + afterParseSubs + "\" following substitutions.")
			actionAliasesSoFar.append(newAlias)

		var subjectAliasesSoFar := []
		for parsableSubject in parsableSubjects[parsableAction.id]:
			for newAlias in parsableSubject.aliases:
				for aliasSoFar in subjectAliasesSoFar:
					if newAlias.begins_with(aliasSoFar):
						print("Subject \"" + aliasSoFar + "\" hides \"" + newAlias + "\" for action " + str(parsableAction.id))
				subjectAliasesSoFar.append(newAlias)
				if newAlias not in uniqueSubjectAliasesSoFar:
					uniqueSubjectAliasesSoFar[newAlias] = null
					var afterParseSubs := invokeParseSubs(newAlias)
					if afterParseSubs != newAlias:
						print("Subject \"" + newAlias + "\" altered to \"" + afterParseSubs + "\" following substitutions.")
		
		var modifierAliasesSoFar := []
		for parsableModifier in parsableModifiers[parsableAction.id]:
			for newAlias in parsableModifier.aliases:
				for aliasSoFar in modifierAliasesSoFar:
					if newAlias.begins_with(aliasSoFar):
						print("Modifier \"" + aliasSoFar + "\" hides \"" + newAlias + "\" for action " + str(parsableAction.id))
				modifierAliasesSoFar.append(newAlias)
				if newAlias not in uniqueModifierAliasesSoFar:
					uniqueModifierAliasesSoFar[newAlias] = null
					var afterParseSubs := invokeParseSubs(newAlias)
					if afterParseSubs != newAlias:
						print("Modifier \"" + newAlias + "\" altered to \"" + afterParseSubs + "\" following substitutions.")


func receiveInputFromTerminal(input: String):
	storeThisMessage = true
	if input.to_lower() in replayPrompts:
		terminal.initMessage(terminal.lastReplayableMessage, false)
	elif input:
		var message := parseInput(input)
		if not message: storeThisMessage = false
		terminal.initMessage(message, storeThisMessage)

func parseInput(input: String) -> String:

	previousActionID = actionID
	previousActionAlias = actionAlias

	previousSubjectID = subjectID
	previousSubjectAlias = subjectAlias

	previousModifierID = modifierID
	previousModifierAlias = modifierAlias

	previousWildCard = wildCard
	validWildCard = false

	_originalInputSansPunct = removePunctuation(input)
	workingInput = removeBlacklistedArticlesAndAdjectives(_originalInputSansPunct)
	workingInput = invokeParseSubs(workingInput)

	if requestingSubject:
		recallLastParse()
		requestingSubject = false
		subjectID = findBestMatch(findSubject, true)
		if subjectID != -1: return parseItems()
		elif previousActionID in actionsWithWildcards:
			subjectID = findBestMatch(findSubject, false)
			if subjectID != -1:
				wildCard = workingInput.strip_edges()
				return parseItems()
			else:
				requestingWildCard = true # I'm starting to think this is unnecessary... But I'm too afraid to try and remove it, lol.
		else: return unrecognizedResponseParse(input)

	if requestingModifier:
		recallLastParse()
		requestingModifier = false
		modifierID = findBestMatch(findModifier, true)
		if modifierID != -1: return parseItems()
		elif previousActionID in actionsWithWildcards:
			modifierID = findBestMatch(findModifier, false)
			if modifierID != -1:
				wildCard = workingInput.strip_edges()
				return parseItems()
			else:
				requestingWildCard = true # I'm starting to think this is unnecessary... But I'm too afraid to try and remove it, lol.
		else: return unrecognizedResponseParse(input)

	if requestingWildCard:
		recallLastParse()
		requestingWildCard = false
		wildCard = workingInput.strip_edges()
		var parseResult := parseItems()
		if validWildCard: return parseResult
		for prefix in requestingHelperPrefixes:
			wildCard = prefix + workingInput.strip_edges()
			parseResult = parseItems()
			if validWildCard: return parseResult
		for suffix in requestingHelperSuffixes:
			wildCard = workingInput.strip_edges() + suffix
			parseResult = parseItems()
			if validWildCard: return parseResult
		# Missing implementation for extraneous prefixes/suffixes and combined helper prefixes/suffixes...
		# It seems like they're never needed though?

		# This was a tricky bug...
		# Since we can run parseItems without returning the result, it's possible to reset "requesting" flags unintentionally...
		# Make sure to do it manually.
		requestingSubject = false
		requestingModifier = false
		requestingWildCard = false
		return unrecognizedResponseParse(input)

	actionID = -1
	actionAlias = ""

	subjectID = -1
	subjectAlias = ""

	modifierID = -1
	modifierAlias = ""

	wildCard = ""

	actionID = findAction()
	if actionID == -1: return unrecognizedActionParse()
	if not workingInput: return parseItems()

	subjectID = findSubject()
	if not workingInput: return parseItems()

	modifierID = findModifier()
	if not workingInput or actionID in actionsWithWildcards:
		wildCard = workingInput.strip_edges()
		return parseItems()
	else: return unrecognizedEndingParse()


func recallLastParse():
	actionID = previousActionID
	actionAlias = previousActionAlias
	subjectID = previousSubjectID
	subjectAlias = previousSubjectAlias
	modifierID = previousModifierID
	modifierAlias = previousModifierAlias
	wildCard = previousWildCard


func removePunctuation(input: String) -> String:
	while input.length() > 1 and input[-1] in ['.','!','?']:
		input = input.left(-1)
	input = input.replace(',', '')
	return input


func removeBlacklistedArticlesAndAdjectives(input: String) -> String:
	var output := ""
	for word in input.split(' '):
		if word.to_lower() not in omittedArticlesAndAdjectives:
			output += word + " "
	return output.strip_edges()


func findAction(exactMatchOnly: bool = false) -> int:
	var inputForComparison = workingInput.to_lower()
	for action in parsableActions:
		for alias in action.aliases:
			if inputForComparison.begins_with(alias):
				if len(alias) == len(inputForComparison): # exact match
					workingInput = ""
					actionAlias = alias
					return action.id
				elif not exactMatchOnly and inputForComparison[len(alias)] == " ": # not exact match but still word break
					workingInput = workingInput.erase(0,alias.length()).strip_edges()
					actionAlias = alias
					return action.id
	return -1

func findSubject(exactMatchOnly: bool = false) -> int:
	var inputForComparison = workingInput.to_lower()
	for subject in parsableSubjects[actionID]:
		for alias in subject.aliases:
			if inputForComparison.begins_with(alias):
				if len(alias) == len(inputForComparison): # exact match
					workingInput = ""
					subjectAlias = alias
					return subject.id
				elif not exactMatchOnly and inputForComparison[len(alias)] == " ": # not exact match but still word break
					workingInput = workingInput.erase(0,alias.length()).strip_edges()
					subjectAlias = alias
					return subject.id
	return -1

func findModifier(exactMatchOnly: bool = false) -> int:
	var inputForComparison = workingInput.to_lower()
	for modifier in parsableModifiers[actionID]:
		for alias in modifier.aliases:
			if inputForComparison.begins_with(alias):
				if len(alias) == len(inputForComparison): # exact match
					workingInput = ""
					modifierAlias = alias
					return modifier.id
				elif not exactMatchOnly and inputForComparison[len(alias)] == " ": # not exact match but still word break
					workingInput = workingInput.erase(0,alias.length()).strip_edges()
					modifierAlias = alias
					return modifier.id
	return -1

func extractModifierFromEndOfWildCard() -> int:
	var inputForComparison = wildCard.to_lower()
	for modifier in parsableModifiers[actionID]:
		for alias in modifier.aliases:
			if inputForComparison.ends_with(alias):
				wildCard = wildCard.erase(wildCard.length()-alias.length(),alias.length()).strip_edges()
				modifierAlias = alias
				return modifier.id
	return -1 

func findBestMatch(findFunction: Callable, exactMatchOnly: bool):
	var originalWorkingInput := workingInput
	var foundMatch: int

	workingInput = originalWorkingInput
	foundMatch = findFunction.call(exactMatchOnly)
	if foundMatch != -1: return foundMatch

	for prefix in requestingHelperPrefixes:
		workingInput = prefix + originalWorkingInput
		foundMatch = findFunction.call(exactMatchOnly)
		if foundMatch != -1: return foundMatch
	
	for suffix in requestingHelperSuffixes:
		workingInput = originalWorkingInput + suffix
		foundMatch = findFunction.call(exactMatchOnly)
		if foundMatch != -1: return foundMatch

	if combineRequestingPrefixesAndSuffixes:
		for prefix in requestingHelperPrefixes:
			for suffix in requestingHelperSuffixes:
				workingInput = prefix + originalWorkingInput + suffix
				foundMatch = findFunction.call(exactMatchOnly)
				if foundMatch != -1: return foundMatch

	for prefix in requestingExtraneousPrefixes:
		if originalWorkingInput.begins_with(prefix):
			workingInput = originalWorkingInput.right(-len(prefix)).strip_edges()
			foundMatch = findFunction.call(exactMatchOnly)
			if foundMatch != -1: return foundMatch
	
	for suffix in requestingExtraneousSuffixes:
		if originalWorkingInput.ends_with(suffix):
			workingInput = originalWorkingInput.left(-len(suffix)).strip_edges()
			foundMatch = findFunction.call(exactMatchOnly)
			if foundMatch != -1: return foundMatch

	if combineRequestingPrefixesAndSuffixes:
		for prefix in requestingExtraneousPrefixes:
			for suffix in requestingExtraneousSuffixes:
				if originalWorkingInput.begins_with(prefix):
					workingInput = originalWorkingInput.right(-len(prefix)).strip_edges()
					if originalWorkingInput.ends_with(suffix):
						workingInput = originalWorkingInput.left(-len(suffix)).strip_edges()
						foundMatch = findFunction.call(exactMatchOnly)
						if foundMatch != -1: return foundMatch

	workingInput = originalWorkingInput
	return -1


func parseItems() -> String:
	print(actionID, subjectID, modifierID, wildCard)
	push_error("Unimplemented function.")
	return unknownParse()


func reconstructCommand() -> String:
	var reconstructedCommand = actionAlias
	if subjectAlias: reconstructedCommand += " " + subjectAlias
	if modifierAlias: reconstructedCommand += " " + modifierAlias
	if wildCard and validWildCard: reconstructedCommand += " " + wildCard
	return reconstructedCommand

func unknownParse() -> String:
	storeThisMessage = false
	return "You're not sure how to " + _originalInputSansPunct + "."

func wrongContextParse() -> String:
	storeThisMessage = false
	return "You can't " + reconstructCommand() + " right now."

func unrecognizedActionParse() -> String:
	return unknownParse() + " (This command does not start with a recognized action.)"

func unrecognizedEndingParse() -> String:
	return (
		unknownParse() + " (It's clear that you want to \"" + reconstructCommand() + "\", " +
		"but the end of your command, \"" + workingInput + "\", is not recognized for this action."
	)

func unrecognizedResponseParse(input: String) -> String:
	var result := parseInput(input)
	if result.begins_with(unknownParse()) or result.begins_with(wrongContextParse()):
		# return(
		# 	"Your response is not recognized. " +
		# 	"Also, y" + result.substr(1)
		# )
		return "Your response is not valid."
	else: return result

func requestAdditionalSubjectContext(
	questionStart := "What", prefixes := [], suffixes := [], extraneousPrefixes := [], extraneousSuffixes := [],
	combinePrefixesAndSuffixes := false,
) -> String:
	requestingSubject = true
	requestingHelperPrefixes = prefixes
	requestingHelperSuffixes = suffixes
	requestingExtraneousPrefixes = extraneousPrefixes
	requestingExtraneousSuffixes = extraneousSuffixes
	combineRequestingPrefixesAndSuffixes = combinePrefixesAndSuffixes
	return questionStart + " would you like to " + reconstructCommand() + "?"

func requestAdditionalModifierContext(
	questionStart := "How", questionEnd := "", prefixes := [], suffixes := [], extraneousPrefixes := [], extraneousSuffixes := [],
	combinePrefixesAndSuffixes := false,
) -> String:
	requestingModifier = true
	requestingHelperPrefixes = prefixes
	requestingHelperSuffixes = suffixes
	requestingExtraneousPrefixes = extraneousPrefixes
	requestingExtraneousSuffixes = extraneousSuffixes
	combineRequestingPrefixesAndSuffixes = combinePrefixesAndSuffixes
	if questionEnd and not questionEnd.begins_with(' '): questionEnd = ' ' + questionEnd
	return questionStart + " would you like to " + reconstructCommand() + questionEnd + "?"

func requestAdditionalContextCustom(
	question: String, requestType: int, prefixes := [], suffixes := [], extraneousPrefixes := [], extraneousSuffixes := [],
	combinePrefixesAndSuffixes := false,
) -> String:
	if requestType == REQUEST_SUBJECT: requestingSubject = true
	if requestType == REQUEST_MODIFIER: requestingModifier = true
	if requestType == REQUEST_WILDCARD: requestingWildCard = true
	requestingHelperPrefixes = prefixes
	requestingHelperSuffixes = suffixes
	requestingExtraneousPrefixes = extraneousPrefixes
	requestingExtraneousSuffixes = extraneousSuffixes
	combineRequestingPrefixesAndSuffixes = combinePrefixesAndSuffixes
	return question

func requestSpecificAction() -> String:
	return "This item can be used, but you need to give a more specific action."

func requestConfirmation() -> String:
	return "Are you sure you want to " + reconstructCommand() + "?"
