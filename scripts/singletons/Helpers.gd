extends Node

func singularOrPlural(count: int, singular: String, plural := "") -> String:
	if count == 1: return singular
	elif plural: return plural
	else: return singular + "s"
