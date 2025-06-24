class_name KitchenParser
extends InputParser

@export var kitchen: Kitchen

enum ActionID {
	INSPECT, MOVE_TO,
	TAKE, REPLACE, USE, OPEN, CLOSE, TURN_ON, TURN_OFF,
	PET, FLIP,
	INPUT, INPUT_DOOR_CODE, INPUT_MILK_CODE, INPUT_CODE_AMBIGUOUS, UNLOCK, LOCK, WEAR, COUNT,
	HEAT, READ,
	FEED, WASH, EXORCISE,
	FRY, SCRAMBLE, SCATTER, GARNISH,
	POUR, EAT,
	PUT, TURN, 
	MAIN_MENU, ENDINGS, POOP, QUIT, AFFIRM, DENY
}

enum SubjectID {
	SELF, ZOOMBA, KITCHEN, FLOOR,

	TOP_LEFT_CUPBOARD, BOTTOM_LEFT_CUPBOARD, MIDDLE_LEFT_CUPBOARD, MIDDLE_RIGHT_CUPBOARD,
	BOTTOM_RIGHT_CUPBOARD, MIDDLE_CUPBOARDS, BOTTOM_CUPBOARD, AMBIGUOUS_CUPBOARD,
	TOP_DRAWER, MIDDLE_DRAWER, BOTTOM_DRAWER, AMBIGUOUS_DRAWER, COUNTER,

	COLORED_CEREAL_BOXES, NUMBERED_CEREAL_BOXES, DINO_CEREAL_BOX, IMPRISONED_CEREAL_BOX, AMBIGUOUS_CEREAL_BOX,

	MICROWAVE, OUTLET,

	TOP_FRIDGE_DOOR, BOTTOM_FRIDGE_DOOR, FRIDGE, FREEZER, QUAKER_DRAWING, PICTURES,
	BLUE_BUTTON, GREEN_BUTTON, RED_BUTTON, YELLOW_BUTTON, AMBIGUOUS_BUTTON,
	BLOCK_OF_ICE, STRATEGY_GUIDE, DINO_NUGGETS, SPOON, EGG, GRAPEFRUIT_JUICE, NOTE, MILK, LOCK,

	TIMER, LARRY_LIGHT_SWITCH, AMBIGUOUS_LIGHT_SWITCH,

	FAN, SINK, FAUCET, CEREAL_BOWL, PLUMBING, DEMON, PENTAGRAM, FORK,

	WINDOW, POTTED_PLANT, BACKYARD, HAMMOCK, FRUIT_BASKET, GOULASH_INGREDIENTS,

	OVEN, ASHES, STOVE_TOP, FRYING_PAN, FUME_HOOD,
	FRONT_LEFT_BURNER, BACK_LEFT_BURNER, BACK_RIGHT_BURNER, FRONT_RIGHT_BURNER, AMBIGUOUS_BURNER,

	TABLE, CHAIRS, SALT_AND_PEPPER_SHAKERS,

	BREAKFAST

}

enum ModifierID {
	ON_FLOOR, IN_CUPBOARD, IN_MICROWAVE, IN_FREEZER, IN_FRIDGE, ON_PENTAGRAM, IN_SINK, IN_BOWL, ON_FAN, ON_COUNTER, IN_OVEN, ON_STOVE,
	IN_FRYING_PAN, ON_FRONT_LEFT_BURNER, ON_BACK_LEFT_BURNER, ON_BACK_RIGHT_BURNER, ON_FRONT_RIGHT_BURNER, ON_AMBIGUOUS_BURNER,
	ON_TABLE,

	WITH_CODE,

	WITH_FORK, WITH_ASHES, ON_EGGS, TO_DEMON,

	ON, OFF, BACK, AWAY, DOWN,
}

const HUNGRY_DEMON_SPIEL: String = (
	'"FOOLISH MORTAL! AS YOU CAN SEE, I HAVE ONCE AGAIN DOMINATED THIS LIFE SUPPORT SYSTEM, AND IF YOU WISH TO WREST CONTROL FROM MY IRON-FORTIFIED GRIP, ' +
	'YOU MUST SUBMIT TO MY DEMANDS! NO ONE HAS BROUGHT ME MY MOST IMPORTANT SACRIFICE OF THE DAY, AND I HUNGER FOR UNBORN OFFSPRING, MANGLED BEYOND RECOGNITION ' +
	'AND SEASONED WITH THE ASHES OF KNOWLEDGE! BRING ME THIS INFERNAL DISH BEFORE I SNAP, CRACKLE, POP YOUR BRITTLE BONES!! '+
	'THE HUNGER OF THE GREAT CHEERIOFEL KNOWS NO BOUNDS, AND MY PATIENCE RAPIDLY WANES!"'
)

var firstOmeletteIngredients: Array[String] = [
	"hot fudge", "marshmallow cream", "Nutella", "whipped cream", "caramel", "grape jelly",
	"huckleberry", "strawberry", "blueberry", "raspberry", "banana", "raisin",
	"Reese's", "gummy bear", "gummy worm", "candy corn", "Hershey's kiss", "bubble gum", "M&M",
	"powdered sugar", "brown sugar", "coffee", "sugar cube", "apple sauce", "cherry Kool-Aid"
]

var secondOmeletteIngredients: Array[String] = [
	"cilantro", "parsley", "arugula", "kale", "spinach", "quinoa", "chia seed", "bean sprout",
	"ham", "cheese", "turkey", "chicken", "steak", "pork", "bison", "beef jerky",
	"pretzel", "saltine", "goldfish", "crouton", "bagel chip", "Doritos", "Cheez-it",
	"paprika", "soy sauce", "bbq sauce", "ketchup", "mustard", "mayonnaise", "chili powder"
]


func initParsableActions():

	addParsableAction(ActionID.MOVE_TO,
		["move to", "move on", "move", "walk to", "walk on", "walk up", "walk down", "walk", "go to", "go on", "go",
		"step to", "step on", "step"])

	addParsableAction(ActionID.TAKE, ["take", "get", "obtain", "hold", "pick up", "grab"])
	addParsableAction(ActionID.REPLACE, ["replace", "return", "put back", "put down", "put away", "set down"])
	addParsableAction(ActionID.USE, ["use"])
	addParsableAction(ActionID.OPEN, ["open", "crack open", "crack", "split open", "split"])
	addParsableAction(ActionID.CLOSE, ["close", "shut"])
	addParsableAction(ActionID.TURN_ON, ["turn on", "start", "activate"])
	addParsableAction(ActionID.TURN_OFF, ["turn off", "shut down", "deactivate", "stop", "unplug"])

	addParsableAction(ActionID.PET, ["pet", "give pets to", "pat"])
	addParsableAction(ActionID.FLIP, ["flip", "toggle"])

	addParsableAction(ActionID.INPUT_DOOR_CODE,
		["input door code", "enter door code", "input door combination", "enter door combination",
		 "input code for door", "enter code for door", "input combination for door", "enter combination for door",

		 "input fridge code", "enter fridge code", "input fridge combination", "enter fridge combination",
		 "input code for fridge", "enter code for fridge", "input combination for fridge", "enter combination for fridge",

		 "input fridge door code", "enter fridge door code", "input fridge door combination", "enter fridge door combination",
		 "input code for fridge door", "enter code for fridge door", "input combination for fridge door", "enter combination for fridge door",])
	addParsableAction(ActionID.INPUT_MILK_CODE,
		["input milk code", "enter milk code", "input milk combination", "enter milk combination",
		 "input code for milk", "enter code for milk", "input combination for milk", "enter combination for milk",],
		true)
	addParsableAction(ActionID.INPUT_CODE_AMBIGUOUS, ["input code", "enter code", "input combination", "enter combination",], true)
	addParsableAction(ActionID.INPUT, ["push", "press", "click", "input", "enter", "set"])
	addParsableAction(ActionID.UNLOCK, ["unlock", "free"], true)
	addParsableAction(ActionID.LOCK, ["lock"])
	addParsableAction(ActionID.WEAR, ["wear", "put on"])
	addParsableAction(ActionID.COUNT, ["count", "number"])

	addParsableAction(ActionID.HEAT, ["heat up", "heat", "warm up", "warm", "burn", "fry", "cook", "melt", "thaw"])
	addParsableAction(ActionID.READ, ["read", "turn to"], true)

	addParsableAction(ActionID.FEED, ["feed", "serve", "deliver", "give"])
	addParsableAction(ActionID.WASH, ["wash", "clean"])
	addParsableAction(ActionID.EXORCISE, ["exorcise", "banish",])

	addParsableAction(ActionID.FRY, ["fry", "cook"])
	addParsableAction(ActionID.SCRAMBLE, ["scramble", "mix", "mangle"])
	addParsableAction(ActionID.SCATTER, ["scatter", "sprinkle", "spread", "add"])
	addParsableAction(ActionID.GARNISH, ["garnish", "top"])

	addParsableAction(ActionID.POUR, ["pour", "spill", "add"])
	addParsableAction(ActionID.EAT, ["eat", "enjoy", "consume", "drink"])
	
	addParsableAction(ActionID.PUT, ["put", "place"])
	addParsableAction(ActionID.TURN, ["turn to", "turn"])

	addParsableAction(ActionID.ENDINGS,
			["endings", "view endings", "achievements", "view achievements", "help", "hints", "hint"])
	addParsableAction(ActionID.INSPECT, ["inspect", "look at", "look in", "look", "view"], true)
	addParsableAction(ActionID.MAIN_MENU,
			["main menu", "menu", "main", "go to main menu", "go back to main menu", "return to main menu"])
	addParsableAction(ActionID.POOP, ["poop", "crap", "shit your pants", "shit"])
	addParsableAction(ActionID.QUIT, ["quit game", "quit", "exit game"])
	addParsableAction(ActionID.AFFIRM, ["affirmative", "yes please", "yes", "yup", "y"])
	addParsableAction(ActionID.DENY, ["negative", "nope", "no thank you", "no", "n"])


func initParsableSubjects():
	addParsableSubject(SubjectID.SELF, ["self", "yourself", "me", "myself", "you"],
		[ActionID.INSPECT, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.ZOOMBA,["zoomba", "robot vacuum", "robot", "vacuum", "pizza", "pet", "sleepyhead", "sleepy head"],
		[ActionID.INSPECT, ActionID.MOVE_TO, ActionID.FEED, ActionID.TURN_ON, ActionID.TURN_OFF, ActionID.TURN, ActionID.PET])
	addParsableSubject(SubjectID.KITCHEN, ["kitchen", "surroundings", "around"],
		[ActionID.INSPECT, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.FLOOR, ["kitchen floor", "floor", "ground", "tiles", "transparency", "transparent background"],
		[ActionID.INSPECT])
	
	addParsableSubject(SubjectID.TOP_LEFT_CUPBOARD,
		["top left cupboard", "upper left cupboard", "top cupboard", "upper cupboard", "cupboard above microwave", "cupboard over microwave", "larry"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.BOTTOM_LEFT_CUPBOARD,
		["bottom left cupboard", "lower left cupboard", "cupboard below microwave", "cupboard beneath microwave", "perry"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.MIDDLE_LEFT_CUPBOARD,
		["middle left cupboard", "center left cupboard", "left cupboard below sink", "left cupboard beneath sink", "harry"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.MIDDLE_RIGHT_CUPBOARD, 
		["middle right cupboard", "center right cupboard", "right cupboard below sink", "right cupboard beneath sink", "mary"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.MIDDLE_CUPBOARDS,
		["middle cupboards", "middle cupboard", "center cupboards", "center cupboard",
		 "cupboards below sink", "cupboard below sink", "cupboards beneath sink", "cupboard beneath sink"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.BOTTOM_RIGHT_CUPBOARD,
		["bottom right cupboard", "lower right cupboard", "cupboard below pasta", "cupboard beneath pasta", "cupboard by oven", "cupboard next to oven", "carrie"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.BOTTOM_CUPBOARD, ["bottom cupboards", "bottom cupboard", "lower cupboards", "lower cupboards"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.AMBIGUOUS_CUPBOARD, ["cupboard"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.TOP_DRAWER, ["top drawer", "upper drawer", "first drawer", "drawer 1"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.MIDDLE_DRAWER, ["middle drawer", "center drawer", "second drawer", "drawer 2"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.BOTTOM_DRAWER, ["bottom drawer", "lower drawer", "third drawer", "drawer 3"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.AMBIGUOUS_DRAWER, ["drawer"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.COUNTER, ["counter top", "counter"],
		[ActionID.INSPECT, ActionID.MOVE_TO])
	
	addParsableSubject(SubjectID.COLORED_CEREAL_BOXES,
		["colored cereal boxes", "colored cereal box", "colored cereal", "upper cereal boxes", "upper cereal box", "upper cereal"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.EAT, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.NUMBERED_CEREAL_BOXES,
		["numbered cereal boxes", "numbered cereal box", "numbered cereal", "lower cereal boxes", "lower cereal box", "lower cereal"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.EAT, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.DINO_CEREAL_BOX, ["dino eggs cereal box", "dino eggs cereal", "dino-mite eggs cereal box", "dino-mite eggs cereal"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.EAT, ActionID.POUR, ActionID.PUT, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.IMPRISONED_CEREAL_BOX,
		["shredded wheat cereal box", "shredded wheat cereal", "shredded wheat", "imprisoned cereal box", "imprisoned cereal", "prisoner", "prison"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.EAT, ActionID.UNLOCK, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.AMBIGUOUS_CEREAL_BOX, ["cereal boxes", "cereal box", "cereal"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.EAT, ActionID.MOVE_TO])
	
	addParsableSubject(SubjectID.MICROWAVE, ["microwave", "quantum microwave"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE, ActionID.USE, ActionID.INPUT, ActionID.TURN_ON, ActionID.TURN_OFF, ActionID.TURN, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.OUTLET, ["outlet", "power outlet", "dryer power outlet", "power cord"],
		[ActionID.INSPECT, ActionID.TURN_OFF, ActionID.MOVE_TO])
	
	addParsableSubject(SubjectID.TOP_FRIDGE_DOOR, ["top fridge door", "upper fridge door", "freezer door",],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.BOTTOM_FRIDGE_DOOR, ["bottom fridge door", "lower fridge door", "fridge door"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.FRIDGE, ["fridge"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.FREEZER, ["freezer", "icebox", "ice box"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.QUAKER_DRAWING, ["quaker drawing", "drawing", "quaker", "artwork", "art"],
		[ActionID.INSPECT, ActionID.TAKE])
	addParsableSubject(SubjectID.PICTURES, ["pictures", "picture", "cards", "card", "christmas cards", "christmas card", "postcards", "postcard"],
		[ActionID.INSPECT, ActionID.TAKE])
	addParsableSubject(SubjectID.BLUE_BUTTON, ["blue button", "blue"],
		[ActionID.INSPECT, ActionID.USE, ActionID.INPUT])
	addParsableSubject(SubjectID.GREEN_BUTTON, ["green button", "green"],
		[ActionID.INSPECT, ActionID.USE, ActionID.INPUT])
	addParsableSubject(SubjectID.RED_BUTTON, ["red button", "red"],
		[ActionID.INSPECT, ActionID.USE, ActionID.INPUT])
	addParsableSubject(SubjectID.YELLOW_BUTTON, ["yellow button", "yellow"],
		[ActionID.INSPECT, ActionID.USE, ActionID.INPUT])
	addParsableSubject(SubjectID.AMBIGUOUS_BUTTON, ["button"],
		[ActionID.INSPECT, ActionID.USE, ActionID.INPUT])
	addParsableSubject(SubjectID.BLOCK_OF_ICE, ["block of ice", "frozen strategy guide", "frozen book", "frozen magazine", "ice block", "ice"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.REPLACE, ActionID.PUT, ActionID.HEAT, ActionID.READ])
	addParsableSubject(SubjectID.STRATEGY_GUIDE, ["strategy guide", "breakfast strategy guide", "book", "magazine", "table of contents"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.REPLACE, ActionID.PUT, ActionID.HEAT, ActionID.READ])
	addParsableSubject(SubjectID.DINO_NUGGETS, ["dino nuggets", "dino chicken nuggets", "chicken nuggets", "box in freezer"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.EAT])
	addParsableSubject(SubjectID.SPOON, ["spoons", "spoon"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.USE, ActionID.REPLACE, ActionID.PUT, ActionID.COUNT])
	addParsableSubject(SubjectID.EGG, ["eggs", "egg", "fried eggs", "fried egg", "scrambled eggs", "scrambled egg"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.WEAR, ActionID.USE, ActionID.REPLACE, ActionID.PUT, ActionID.OPEN, ActionID.COUNT,
		 ActionID.FRY, ActionID.SCRAMBLE, ActionID.HEAT, ActionID.GARNISH, ActionID.FEED])
	addParsableSubject(SubjectID.GRAPEFRUIT_JUICE,
		["grapefruit juice", "grapefruit", "juice boxes", "juice box", "juice", "cartons", "carton", "boxes in fridge", "box in fridge"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.EAT, ActionID.COUNT])
	addParsableSubject(SubjectID.NOTE, ["note in fridge", "note", "paper", "list"],
		[ActionID.INSPECT, ActionID.INSPECT, ActionID.READ])
	addParsableSubject(SubjectID.MILK, ["gallon of milk", "jug of milk", "milk jug", "milk"],
		[ActionID.INSPECT, ActionID.UNLOCK, ActionID.TAKE, ActionID.USE, ActionID.POUR, ActionID.REPLACE, ActionID.PUT, ActionID.LOCK, ActionID.HEAT])
	addParsableSubject(SubjectID.LOCK, ["lock", "padlock"],
		[ActionID.INSPECT, ActionID.UNLOCK, ActionID.TAKE, ActionID.LOCK])
	
	addParsableSubject(SubjectID.TIMER, ["timer", "clock", "countdown timer", "countdown", "stadium timer"],
		[ActionID.INSPECT, ActionID.TURN_OFF, ActionID.TURN_ON, ActionID.TURN, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.LARRY_LIGHT_SWITCH, ["larry light switch", "larry"],
		[ActionID.INSPECT, ActionID.USE, ActionID.FLIP])
	addParsableSubject(SubjectID.AMBIGUOUS_LIGHT_SWITCH, ["light switch", "switch"],
		[ActionID.INSPECT, ActionID.USE, ActionID.FLIP])
	
	addParsableSubject(SubjectID.FAN, ["fan", "drying fan"],
		[ActionID.INSPECT, ActionID.USE, ActionID.TURN_ON, ActionID.TURN_OFF, ActionID.TURN])
	addParsableSubject(SubjectID.SINK, ["sink", "wash basin", "basin", "kitchen sink"],
		[ActionID.INSPECT, ActionID.USE, ActionID.TURN_ON, ActionID.TURN_OFF, ActionID.TURN, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.FAUCET, ["faucet", "sink faucet", "kitchen sink faucet", "water"],
		[ActionID.INSPECT, ActionID.USE, ActionID.TURN_ON, ActionID.TURN_OFF, ActionID.TURN])
	addParsableSubject(SubjectID.CEREAL_BOWL, ["cereal bowl", "bowl", "dirty bowl", "clean bowl"],
		[ActionID.INSPECT, ActionID.WASH, ActionID.TAKE, ActionID.REPLACE, ActionID.PUT, ActionID.HEAT])
	addParsableSubject(SubjectID.PLUMBING, ["pipes", "plumbing"],
		[ActionID.INSPECT])
	addParsableSubject(SubjectID.DEMON, ["demon", "devil", "blob", "creature", "breakfast demon", "cereal demon"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.FEED, ActionID.EXORCISE, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.PENTAGRAM, ["pentagram", "red star", "red circle", "star", "circle"],
		[ActionID.INSPECT])
	addParsableSubject(SubjectID.FORK, ["fork"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.USE, ActionID.REPLACE, ActionID.PUT])
	
	addParsableSubject(SubjectID.WINDOW, ["windowsill", "window sill", "windows", "window"],
		[ActionID.INSPECT])
	addParsableSubject(SubjectID.POTTED_PLANT, ["potted plant", "pot", "plant", "vines", "string of bananas"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.EAT])
	addParsableSubject(SubjectID.BACKYARD, ["backyard", "yard", "outside", "grass", "trees", "tree", "bushes", "bush", "out window"],
		[ActionID.INSPECT])
	addParsableSubject(SubjectID.HAMMOCK, ["hammock"],
		[ActionID.INSPECT])
	addParsableSubject(SubjectID.FRUIT_BASKET, ["fruit basket", "fruit", "basket", "apples", "apple", "mold", "fungus"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.EAT])
	addParsableSubject(SubjectID.GOULASH_INGREDIENTS,
		["goulash ingredients", "pasta", "noodles", "tomato sauce", "marinara", "jars of sauce", "jars", "jar", "sauces", "sauce",],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.EAT])
	
	addParsableSubject(SubjectID.OVEN, ["oven door", "oven", "foodcinerator 9000", "foodcinerator"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE, ActionID.USE, ActionID.TURN_ON, ActionID.TURN_OFF, ActionID.TURN, ActionID.HEAT, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.ASHES, ["ashes", "pile of ashes", "burnt strategy guide", "burnt book", "burnt magazine"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.USE, ActionID.SCATTER, ActionID.REPLACE, ActionID.PUT])
	addParsableSubject(SubjectID.STOVE_TOP, ["stove top", "stove"],
		[ActionID.INSPECT, ActionID.USE, ActionID.TURN_ON, ActionID.TURN_OFF, ActionID.TURN, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.FRYING_PAN, ["frying pan", "pan"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.USE, ActionID.REPLACE, ActionID.PUT, ActionID.HEAT])
	addParsableSubject(SubjectID.FUME_HOOD, ["fume hood", "oven vent", "vent above oven", "vent over oven", "ventilation", "vent"],
		[ActionID.INSPECT, ActionID.USE, ActionID.TURN_ON, ActionID.TURN_OFF, ActionID.TURN])
	addParsableSubject(SubjectID.FRONT_LEFT_BURNER, ["front left burner", "left burner", "bottom left burner", "lower left burner"],
		[ActionID.INSPECT, ActionID.USE, ActionID.TURN_ON, ActionID.TURN_OFF, ActionID.TURN, ActionID.HEAT])
	addParsableSubject(SubjectID.BACK_LEFT_BURNER, ["back left burner", "top burner", "upper burner", "top left burner", "upper left burner"],
		[ActionID.INSPECT, ActionID.USE, ActionID.TURN_ON, ActionID.TURN_OFF, ActionID.TURN, ActionID.HEAT])
	addParsableSubject(SubjectID.BACK_RIGHT_BURNER, ["back right burner", "right burner", "top right burner", "upper right burner"],
		[ActionID.INSPECT, ActionID.USE, ActionID.TURN_ON, ActionID.TURN_OFF, ActionID.TURN, ActionID.HEAT])
	addParsableSubject(SubjectID.FRONT_RIGHT_BURNER, ["front right burner", "bottom burner", "lower burner", "bottom right burner", "lower right burner"],
		[ActionID.INSPECT, ActionID.USE, ActionID.TURN_ON, ActionID.TURN_OFF, ActionID.TURN, ActionID.HEAT])
	addParsableSubject(SubjectID.AMBIGUOUS_BURNER, ["burners", "burner"],
		[ActionID.INSPECT, ActionID.USE, ActionID.TURN_ON, ActionID.TURN_OFF, ActionID.TURN, ActionID.HEAT])
	
	addParsableSubject(SubjectID.TABLE, ["table", "kitchen table"],
		[ActionID.INSPECT, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.CHAIRS, ["chairs", "chair"],
		[ActionID.INSPECT])
	addParsableSubject(SubjectID.SALT_AND_PEPPER_SHAKERS,
		["shakers", "shaker", "salt and pepper shakers", "salt shaker", "pepper shaker",
		 "mills", "mill", "salt and pepper mills", "salt mill", "pepper mill",
		 "grinders", "grinder", "salt and pepper grinders", "salt grinder", "pepper grinder",
		 "salt and pepper", "salt", "pepper", "powdered milk", "pancake mix"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.USE])
	
	addParsableSubject(SubjectID.BREAKFAST, ["breakfast", "most important meal of day"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.EAT])
	

func initParsableModifiers():
	addParsableModifier(ModifierID.ON_FLOOR, ["on floor", "on ground", "down on floor", "down on ground"],
		[ActionID.REPLACE, ActionID.PUT, ActionID.POUR, ActionID.OPEN])
	addParsableModifier(ModifierID.IN_CUPBOARD,["in cupboard", "back in cupboard"],
		[ActionID.REPLACE, ActionID.PUT])
	addParsableModifier(ModifierID.IN_MICROWAVE, ["in microwave"],
		[ActionID.REPLACE, ActionID.PUT])
	addParsableModifier(ModifierID.IN_FREEZER, ["in freezer", "in upper fridge", "in top of fridge"],
		[ActionID.REPLACE, ActionID.PUT])
	addParsableModifier(ModifierID.IN_FRIDGE, ["in fridge", "in lower fridge", "in bottom of fridge"],
		[ActionID.REPLACE, ActionID.PUT])
	addParsableModifier(ModifierID.ON_PENTAGRAM, ["in pentagram", "on pentagram", "in star", "on star", "in red circle", "on red circle"],
		[ActionID.REPLACE, ActionID.PUT])
	addParsableModifier(ModifierID.IN_SINK, ["in sink", "in wash basin", "in basin", "in kitchen sink"],
		[ActionID.REPLACE, ActionID.PUT])
	addParsableModifier(ModifierID.IN_BOWL, ["in bowl", "in cereal bowl", "in cereal"],
		[ActionID.REPLACE, ActionID.PUT, ActionID.POUR, ActionID.OPEN])
	addParsableModifier(ModifierID.ON_FAN, ["on fan", "on drying fan"],
		[ActionID.REPLACE, ActionID.PUT, ActionID.OPEN])
	addParsableModifier(ModifierID.ON_COUNTER, ["on counter top", "on counter"],
		[ActionID.REPLACE, ActionID.PUT, ActionID.OPEN])
	addParsableModifier(ModifierID.IN_OVEN, ["in oven", "in foodcinerator 9000", "in foodcinerator"],
		[ActionID.REPLACE, ActionID.PUT])
	addParsableModifier(ModifierID.ON_STOVE, ["on stove top", "on stove", "on top of oven"],
		[ActionID.REPLACE, ActionID.PUT])
	addParsableModifier(ModifierID.IN_FRYING_PAN, ["in frying pan", "on frying pan", "in pan", "on pan"],
		[ActionID.REPLACE, ActionID.PUT, ActionID.OPEN])
	addParsableModifier(ModifierID.ON_FRONT_LEFT_BURNER,
		["on front left burner", "on left burner", "on bottom left burner", "on lower left burner"],
		[ActionID.REPLACE, ActionID.PUT, ActionID.OPEN])
	addParsableModifier(ModifierID.ON_BACK_LEFT_BURNER,
		["on back left burner", "on top burner", "on upper burner", "on top left burner", "on upper left burner"],
		[ActionID.REPLACE, ActionID.PUT, ActionID.OPEN])
	addParsableModifier(ModifierID.ON_BACK_RIGHT_BURNER,
		["on back right burner", "on right burner", "on top right burner", "on upper right burner"],
		[ActionID.REPLACE, ActionID.PUT, ActionID.OPEN])
	addParsableModifier(ModifierID.ON_FRONT_RIGHT_BURNER,
		["on front right burner", "on bottom burner", "on lower burner", "on bottom right burner", "on lower right burner"],
		[ActionID.REPLACE, ActionID.PUT, ActionID.OPEN])
	addParsableModifier(ModifierID.ON_AMBIGUOUS_BURNER,
		["on burners", "on burner"],
		[ActionID.REPLACE, ActionID.PUT, ActionID.OPEN])
	addParsableModifier(ModifierID.ON_TABLE, ["on table", "on kitchen table"],
		[ActionID.REPLACE, ActionID.PUT])
	
	addParsableModifier(ModifierID.WITH_CODE, ["with code", "with combination", "using code", "using combination"],
		[ActionID.UNLOCK])
	
	addParsableModifier(ModifierID.WITH_FORK, ["with fork", "using fork"],
		[ActionID.EAT, ActionID.SCRAMBLE])
	addParsableModifier(ModifierID.WITH_ASHES,
		["with ashes", "using ashes", "with pile of ashes", "using pile of ashes", "with burnt strategy guide", "using burnt strategy guide"],
		[ActionID.GARNISH])
	addParsableModifier(ModifierID.ON_EGGS, ["on eggs", "on egg", "on fried eggs", "on fried egg", "on scrambled eggs", "on scrambled egg"],
		[ActionID.SCATTER, ActionID.PUT, ActionID.REPLACE])
	addParsableModifier(ModifierID.TO_DEMON, ["to demon", "to devil", "to blob", "to creature", "to breakfast demon", "to cereal demon"],
		[ActionID.FEED])
	
	addParsableModifier(ModifierID.ON, ["on"],
		[ActionID.PUT, ActionID.REPLACE, ActionID.TURN])
	addParsableModifier(ModifierID.OFF, ["off"],
		[ActionID.TAKE, ActionID.TURN])
	addParsableModifier(ModifierID.BACK, ["back on", "back"],
		[ActionID.PUT])
	addParsableModifier(ModifierID.AWAY, ["away"],
		[ActionID.PUT])
	addParsableModifier(ModifierID.DOWN, ["down"],
		[ActionID.PUT])


func initParseSubs():
	addParseSub("into", "in")
	addParseSub("onto", "on")
	addParseSub("roomba", "zoomba")
	addParseSub("refrigerator", "fridge")
	addParseSub("combo", "combination")
	addParseSub("stovetop", "stove top")
	addParseSub("cabinet", "cupboard")


var eggParsing: bool
var startingPlayerPos: Kitchen.PlayerPos
func eggParse() -> String:
	eggParsing = true
	startingPlayerPos = kitchen.playerPos
	var parseResult = parseItems()
	if startingPlayerPos != kitchen.playerPos:
		SceneManager.transitionToScene(
			SceneManager.SceneID.ENDING,
			"As you start to walk away from the oven, your foot lands squarely on the egg you left on the ground. " + 
			"The yolk squishes and slides under your heel, shifting your weight unexpectedly, and robbing you of your balance. " +
			"In an effort to regain your composure, you begin blundering around your kitchen, flailing your limbs wildly. " +
			"In the ensuing chaos you somehow manage to turn on all the burners on the stove, start the oven with the door open, "+
			"set the microwave to run for 99 minutes and 99 seconds, and do a pretty impressive cartwheel. By the time you're " +
			"steady on your feet again, the kitchen is hot, flaming mess.",
			SceneManager.EndingID.EGGSISTENTIAL_CRISIS
		)
		return ""
	else: return parseResult


func parseItems() -> String:

	if kitchen.isEggOnFloor and not eggParsing:
		return eggParse()

	parseEventsSinceLastConfirmation += 1

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

			ActionID.TAKE, ActionID.REPLACE, ActionID.USE, ActionID.OPEN, ActionID.CLOSE, ActionID.TURN_ON, ActionID.TURN_OFF,\
			ActionID.PET, ActionID.FLIP,\
			ActionID.INPUT, ActionID.UNLOCK, ActionID.LOCK, ActionID.WEAR, ActionID.COUNT,\
			ActionID.HEAT, ActionID.READ,\
			ActionID.FEED, ActionID.WASH, ActionID.EXORCISE,\
			ActionID.FRY, ActionID.SCRAMBLE, ActionID.SCATTER, ActionID.GARNISH,\
			ActionID.POUR, ActionID.EAT,\
			ActionID.PUT, ActionID.TURN:
				return requestAdditionalSubjectContext()


	### Clarifying missing modifiers
	elif modifierID == -1:
		if actionID == ActionID.PUT:
			return requestAdditionalModifierContext("How", "", ["on "])
		elif actionID == ActionID.TURN:
			return requestAdditionalContextCustom("Would you like to " + reconstructCommand() + " [on] or [off]?", REQUEST_MODIFIER)


	### Main Action Parsing
	match actionID:

		ActionID.INSPECT:
			match subjectID:

				-1 when wildCard:

					var pageNumber: int
					if wildCard.begins_with("page"):
						wildCard = wildCard.replace("page", "").strip_edges()
						if not wildCard.is_valid_int(): return wildCard + " is not a valid page number."
						else: pageNumber = int(wildCard)
					else:
						if not wildCard.is_valid_int(): return unrecognizedEndingParse()
						else: pageNumber = int(wildCard)
					
					validWildCard = true
					if kitchen.playerHeldItem == Kitchen.PlayerHeldItem.FROZEN_STRATEGY_GUIDE:
						return "You can't read the strategy guide while it's frozen in ice..."
					elif kitchen.playerHeldItem == Kitchen.PlayerHeldItem.ASHES:
						return "The strategy guide is burnt beyond all recognition..."
					elif kitchen.playerHeldItem != Kitchen.PlayerHeldItem.THAWED_STRATEGY_GUIDE:
						return "You're not holding anything with page numbers."
					elif pageNumber < 1 or pageNumber > 128:
						return "That page isn't in the strategy guide. It only has 128 pages."
					
					match pageNumber:
						_:
							return "This page talks at length about preparing a " + getRandomOmelet(pageNumber) + "."

				SubjectID.SELF:
					return "Your tummy rumbles eagerly in anticipation of breakfast."

				SubjectID.ZOOMBA:
					return "Zoomba is prowling around the kitchen for crumbs like the good boy he is."

				SubjectID.KITCHEN:
					return "You've finally made it to the kitchen! This place is chock full of high-tech appliances perfect for overcomplicating mealtime."

				SubjectID.FLOOR:
					return "Looking down, you're struck with the odd sense that you should be able to see through your tiled floor to the bathroom below."


				SubjectID.TOP_LEFT_CUPBOARD:
					if kitchen.isTopLeftCupboardOpen:
						return (
							"This cupboard holds a few brightly colored cereal boxes. They're all empty though, " +
							"and you get the sense that they're only here to help you remember something..."
						)
					else:
						return "That cupboard is currently closed."

				SubjectID.BOTTOM_LEFT_CUPBOARD:
					if kitchen.isBottomLeftCupboardOpen:
						return (
							"This cupboard holds a few monochrome cereal boxes, each with a number prominently displayed on the spine. " +
							"They're all empty though, and you get the sense that they're only here to help you remember something..."
						)
					else:
						return "That cupboard is currently closed."

				SubjectID.MIDDLE_LEFT_CUPBOARD:
					if kitchen.isMiddleLeftCupboardOpen:
						if kitchen.isDemonSatisfied:
							return (
								"The breakfast demon is sitting on the frying pan making loud slurping noises. " +
								"At least he's not blocking your plumbing any more!"
							)
						else:
							return (
								"Drat... It looks like the breakfast demon under your sink is still hanging around. " +
								"Upon seeing you, he begins shouting his usual tirade in a frantic, high-pitched voice:\n" +
								HUNGRY_DEMON_SPIEL + "\nIt looks like you'll have to make his breakfast first if you want access to running water again..."
							)
					else:
						return "That cupboard is currently closed."

				SubjectID.MIDDLE_RIGHT_CUPBOARD:
					if kitchen.isMiddleRightCupboardOpen:
						if kitchen.playerHeldItem == Kitchen.PlayerHeldItem.FORK:
							return "You'd better return the fork before the demon finds another reason to throw a tantrum..."
						else:
							return (
								"*Sigh* It looks like the breakfast demon has appropriated your fork again... " +
								"Why must have left his regular pitchfork back in Hell..."
							)
					else:
						return "That cupboard is currently closed."

				SubjectID.BOTTOM_RIGHT_CUPBOARD:
					if kitchen.isBottomRightCupboardOpen:
						return "This box of UNFROSTED shredded wheat is still serving its prison sentence for being one of the worst cereals known to man."
					else: return "That cupboard is currently closed."

				SubjectID.MIDDLE_CUPBOARDS:
					return "There are two cupboards doors below your sink. They are named Harry and Mary."

				SubjectID.BOTTOM_CUPBOARD:
					return "These are your friendliest cupboards for the vertically challenged. From left to right they're named Perry, Harry, Marry, and Carrie."

				SubjectID.AMBIGUOUS_CUPBOARD:
					return requestAdditionalContextCustom("Which cupboard would you like to " + actionAlias + "?", REQUEST_SUBJECT, [], [" cupboard"])

				SubjectID.TOP_DRAWER:
					if kitchen.isTopDrawerOpen:
						return (
							"The knife population in your silverware drawer has recently exploded, " +
							"and you've had to relocate the other utensils to protect them from over-predation while the ecosystem stabilizes."
						)
					else:
						return "That drawer is currently closed."

				SubjectID.MIDDLE_DRAWER:
					if kitchen.isMiddleDrawerOpen:
						return "This is your junk drawer. For some reason, it's filled with various species of algae and unicellular autotrophs."
					else:
						return "That drawer is currently closed."

				SubjectID.BOTTOM_DRAWER:
					if kitchen.isBottomDrawerOpen:
						return "You recently removed all the 9V batteries from your smoke detectors so they could party together in the 54V drawer."
					else:
						return "That drawer is currently closed."

				SubjectID.AMBIGUOUS_DRAWER:
					return requestAdditionalContextCustom("Which drawer would you like to " + actionAlias + "?", REQUEST_SUBJECT, [], [" drawer"])

				SubjectID.COUNTER:
					return (
						"Your counter tops are made of industrial grade phenolic resin, so there's nothing stopping you from " +
						"running a western blot while you prepare dinner!"
					)

				
				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				
				SubjectID.:
					return ""

				SubjectID.:
					return ""

				
				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				
				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				
				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				
				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				
				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				
				SubjectID.:
					return ""

				SubjectID.:
					return ""

				SubjectID.:
					return ""

				
				SubjectID.BREAKFAST:
					if kitchen.bowlState == Kitchen.DIRTY or kitchen.bowlState == Kitchen.CLEAN:
						return "You're sure the makings of a good breakfast are nearby, but nothing's coming together just yet..."
					elif kitchen.bowlState == Kitchen.JUST_MILK or kitchen.bowlState == Kitchen.JUST_CEREAL:
						return "With one ingredient in your trust cereal bowl, your breakfast is finally starting to take shape."
					elif kitchen.bowlState == Kitchen.UNHATCHED:
						return "Your breakfast is nearly ready! You just need to get the Dino-mite pieces to hatch."
					elif kitchen.bowlState == Kitchen.HATCHED:
						return "Your breakfast is ready! Time to eat!"


		ActionID.MOVE_TO:
			pass


		ActionID.TAKE:
			pass


		ActionID.REPLACE, ActionID.PUT:
			if actionID == ActionID.PUT and modifierID in [ModifierID.BACK, ModifierID.AWAY, ModifierID.DOWN]:
				modifierID = -1
			
			match subjectID:
				pass


		ActionID.USE:
			pass


		ActionID.OPEN:
			pass


		ActionID.CLOSE:
			pass


		ActionID.TURN_ON, ActionID.TURN when actionID == ActionID.TURN_ON or (actionID == ActionID.TURN and modifierID == ModifierID.ON):
			pass


		ActionID.TURN_OFF, ActionID.TURN when actionID == ActionID.TURN_OFF or (actionID == ActionID.TURN and modifierID == ModifierID.OFF):
			pass


		ActionID.PET:
			pass


		ActionID.FLIP:
			pass


		ActionID.INPUT:
			pass


		ActionID.INPUT_DOOR_CODE:
			pass


		ActionID.INPUT_MILK_CODE:
			pass


		ActionID.INPUT_CODE_AMBIGUOUS:
			pass


		ActionID.UNLOCK:
			pass


		ActionID.LOCK:
			pass


		ActionID.WEAR:
			pass


		ActionID.COUNT:
			pass


		ActionID.HEAT:
			pass


		ActionID.READ:
			pass


		ActionID.FEED:
			pass


		ActionID.WASH:
			pass


		ActionID.EXORCISE:
			pass


		ActionID.FRY:
			pass


		ActionID.SCRAMBLE:
			pass


		ActionID.SCATTER:
			pass


		ActionID.GARNISH:
			pass


		ActionID.POUR:
			pass


		ActionID.EAT:
			pass


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
			SceneManager.openEndings(kitchen)
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



func getRandomOmelet(pageNumber: int) -> String:
	var omeletRNG = RandomNumberGenerator.new()
	omeletRNG.seed = pageNumber
	var firstIngredient = firstOmeletteIngredients[omeletRNG.randi_range(0,len(firstOmeletteIngredients)-1)]
	var secondIngredient = secondOmeletteIngredients[omeletRNG.randi_range(0,len(secondOmeletteIngredients)-1)]
	return firstIngredient + " and " + secondIngredient + " omelet"