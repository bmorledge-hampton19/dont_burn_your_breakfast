class_name InputParser
extends Node

var terminal: Terminal

class _ParsableItem:
	var id: int
	var aliases: Array[String]
	func _init(p_id: int, p_aliases: Array[String]):
		id = p_id
		aliases = p_aliases

const omittedArticlesAndAdjectives: Array[String] = ["the", "a", "an", "this", "that", "these", "those", "your", "his", "my"]

var parsableActions: Array[_ParsableItem]
var actionsWithWildcards: Array[int]
var parsableSubjects: Dictionary
var parsableModifiers: Dictionary

var originalInputSansPunct: String
var workingInput: String

var actionAlias: String
var subjectAlias: String
var modifierAlias: String
var wildCard: String

var confirmingActionID: int
var previousActionID: int
var previousSubjectID: int
var previousModifierID: int

var parseEventsSinceLastConfirmation: int = 2
enum {REQUEST_SUBJECT, REQUEST_MODIFIER, REQUEST_WILDCARD}
var requestingSubject := false
var requestingModifier := false
var requestingWildCard := false
var requestingHelperPrefixes: Array
var requestingHelperSuffixes: Array

var storeThisMessage: bool
var lastMessage: String


func _ready():
	initParsableActions()
	initParsableSubjects()
	initParsableModifiers()
	testParsables()

func connectTerminal(p_terminal: Terminal, startingMessage: String):
	terminal = p_terminal
	terminal.sendInputForParsing.connect(receiveInputFromTerminal)
	lastMessage = startingMessage


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


func testParsables():
	print("Testing parsables...")
	var actionAliasesSoFar := []

	for parsableAction in parsableActions:
		for newAlias in parsableAction.aliases:
			for aliasSoFar in actionAliasesSoFar:
				if newAlias.begins_with(aliasSoFar):
					print("Action " + aliasSoFar + " hides " + newAlias)
			actionAliasesSoFar.append(newAlias)

		var subjectAliasesSoFar := []
		for parsableSubject in parsableSubjects[parsableAction.id]:
			for newAlias in parsableSubject.aliases:
				for aliasSoFar in subjectAliasesSoFar:
					if newAlias.begins_with(aliasSoFar):
						print("Subject " + aliasSoFar + " hides " + newAlias + " for action " + str(parsableAction.id))
				subjectAliasesSoFar.append(newAlias)
		
		var modifierAliasesSoFar := []
		for parsableModifier in parsableModifiers[parsableAction.id]:
			for newAlias in parsableModifier.aliases:
				for aliasSoFar in modifierAliasesSoFar:
					if newAlias.begins_with(aliasSoFar):
						print("Modifier " + aliasSoFar + " hides " + newAlias + " for action " + str(parsableAction.id))
				modifierAliasesSoFar.append(newAlias)


func receiveInputFromTerminal(input: String):
	storeThisMessage = true
	if input.to_lower() == "replay" or input.to_lower() == "replay message":
		terminal.initMessage(lastMessage)
	elif input:
		var message := parseInput(input)
		if storeThisMessage: lastMessage = message
		terminal.initMessage(message)

func parseInput(input: String) -> String:

	var actionID: int
	var subjectID: int
	var modifierID: int

	actionAlias = ""
	subjectAlias = ""
	modifierAlias = ""

	originalInputSansPunct = removePunctionation(input)
	workingInput = removeBlacklistedArticlesAndAdjectives(originalInputSansPunct)

	if requestingSubject:
		requestingSubject = false
		subjectID = checkForRequestedSubject(previousActionID)
		if subjectID != -1: return parseItems(previousActionID, subjectID, previousModifierID)
		for prefix in requestingHelperPrefixes:
			subjectID = checkForRequestedSubject(previousActionID, prefix)
			if subjectID != -1: return parseItems(previousActionID, subjectID, previousModifierID)
		for suffix in requestingHelperSuffixes:
			subjectID = checkForRequestedSubject(previousActionID, "", suffix)
			if subjectID != -1: return parseItems(previousActionID, subjectID, previousModifierID)
		if previousActionID in actionsWithWildcards: requestingWildCard = true

	if requestingModifier:
		requestingModifier = false
		modifierID = checkForRequestedModifier(previousActionID)
		if modifierID != -1: return parseItems(previousActionID, previousSubjectID, modifierID)
		for prefix in requestingHelperPrefixes:
			modifierID = checkForRequestedModifier(previousActionID, prefix)
			if modifierID != -1: return parseItems(previousActionID, previousSubjectID, modifierID)
		for suffix in requestingHelperSuffixes:
			modifierID = checkForRequestedModifier(previousActionID, "", suffix)
			if modifierID != -1: return parseItems(previousActionID, previousSubjectID, modifierID)
		if previousActionID in actionsWithWildcards: requestingWildCard = true

	if requestingWildCard:
		requestingWildCard = false
		wildCard = workingInput
		var parseResult := parseItems(previousActionID, previousSubjectID, previousModifierID)
		if parseResult != unknownParse(): return parseResult
		for prefix in requestingHelperPrefixes:
			wildCard = prefix + workingInput
			parseResult = parseItems(previousActionID, previousSubjectID, previousModifierID)
			if parseResult != unknownParse(): return parseResult
		for suffix in requestingHelperSuffixes:
			wildCard = workingInput + suffix
			parseResult = parseItems(previousActionID, previousSubjectID, previousModifierID)
			if parseResult != unknownParse(): return parseResult

	wildCard = ""

	actionID = findAction()
	if actionID == -1: return unknownParse()
	if not workingInput: return parseItems(actionID, -1, -1)

	subjectID = findSubject(actionID)
	if not workingInput: return parseItems(actionID, subjectID, -1)

	modifierID = findModifier(actionID)
	if not workingInput: return parseItems(actionID, subjectID, modifierID)
	elif actionID in actionsWithWildcards:
		wildCard = workingInput
		return parseItems(actionID, subjectID, modifierID)
	else: return unknownParse()


func removePunctionation(input: String) -> String:
	while input.length() > 1 and input[-1] in [',','.','!','?']:
		input = input.left(-1)
	return input


func removeBlacklistedArticlesAndAdjectives(input: String) -> String:
	var output := ""
	for word in input.split(' '):
		if word.to_lower() not in omittedArticlesAndAdjectives:
			output += word + " "
	return output.strip_edges()


func findAction() -> int:
	var inputForComparison = workingInput.to_lower()
	for action in parsableActions:
		for alias in action.aliases:
			if inputForComparison.begins_with(alias):
				workingInput = workingInput.erase(0,alias.length()).strip_edges()
				actionAlias = alias
				return action.id
	return -1

func findSubject(actionID: int) -> int:
	var inputForComparison = workingInput.to_lower()
	for subject in parsableSubjects[actionID]:
		for alias in subject.aliases:
			if inputForComparison.begins_with(alias):
				workingInput = workingInput.erase(0,alias.length()).strip_edges()
				subjectAlias = alias
				return subject.id
	return -1

func checkForRequestedSubject(actionID: int, helperPrefix := "", helperSuffix := "") -> int:
	for subject in parsableSubjects[actionID]:
		for alias: String in subject.aliases:

			var originalAlias := alias
			if helperPrefix and alias.begins_with(helperPrefix):
				alias = alias.right(-len(helperPrefix)).strip_edges()
			if helperSuffix and alias.ends_with(helperSuffix):
				alias = alias.left(-len(helperSuffix)).strip_edges()

			if actionID in actionsWithWildcards:
				if workingInput.to_lower().begins_with(alias):
					subjectAlias = originalAlias
					wildCard = workingInput.erase(0,alias.length()).strip_edges().to_lower()
					return subject.id
			else:
				if workingInput.to_lower() == alias:
					subjectAlias = originalAlias
					return subject.id
	return -1

func findModifier(actionID: int) -> int:
	var inputForComparison = workingInput.to_lower()
	for modifier in parsableModifiers[actionID]:
		for alias in modifier.aliases:
			if inputForComparison.begins_with(alias):
				workingInput = workingInput.erase(0,alias.length()).strip_edges()
				modifierAlias = alias
				return modifier.id
	return -1

func checkForRequestedModifier(actionID: int, helperPrefix := "", helperSuffix := "") -> int:
	for modifier in parsableModifiers[actionID]:
		for alias: String in modifier.aliases:

			var originalAlias := alias
			if helperPrefix and alias.begins_with(helperPrefix):
				alias = alias.right(-len(helperPrefix)).strip_edges()
			if helperSuffix and alias.ends_with(helperSuffix):
				alias = alias.left(-len(helperSuffix)).strip_edges()

			if actionID in actionsWithWildcards:
				if workingInput.to_lower().begins_with(alias):
					modifierAlias = originalAlias
					wildCard = workingInput.erase(0,alias.length()).strip_edges().to_lower()
					return modifier.id
			else:
				if workingInput.to_lower() == alias:
					modifierAlias = originalAlias
					return modifier.id
	return -1


func parseItems(actionID: int, subjectID: int, modifierID: int) -> String:
	print(actionID, subjectID, modifierID, wildCard)
	push_error("Unimplemented function.")
	return unknownParse()


func unknownParse() -> String:
	storeThisMessage = false
	return "You're not sure how to " + originalInputSansPunct + "."

func wrongContextParse() -> String:
	storeThisMessage = false
	return "You can't " + originalInputSansPunct + " right now."

func requestAdditionalSubjectContext(questionStart := "What", prefixes := [], suffixes := []) -> String:
	requestingSubject = true
	requestingHelperPrefixes = prefixes
	requestingHelperSuffixes = suffixes
	return questionStart.capitalize() + " would you like to " + originalInputSansPunct + "?"

func requestAdditionalModifierContext(questionStart := "How", questionEnd := "", prefixes := [], suffixes := []) -> String:
	requestingModifier = true
	requestingHelperPrefixes = prefixes
	requestingHelperSuffixes = suffixes
	if questionEnd and not questionEnd.begins_with(' '): questionEnd = ' ' + questionEnd
	return questionStart.capitalize() + " would you like to " + originalInputSansPunct + questionEnd + "?"

func requestAdditionalContextCustom(question: String, requestType: int, prefixes := [], suffixes := []) -> String:
	if requestType == REQUEST_SUBJECT: requestingSubject = true
	if requestType == REQUEST_MODIFIER: requestingModifier = true
	if requestType == REQUEST_WILDCARD: requestingWildCard = true
	requestingHelperPrefixes = prefixes
	requestingHelperSuffixes = suffixes
	return question

func requestSpecificAction() -> String:
	return "This item can be used, but you need to give a more specific action."

func requestConfirmation() -> String:
	return "Are you sure you want to " + originalInputSansPunct + "?"
