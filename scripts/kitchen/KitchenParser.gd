class_name KitchenParser
extends InputParser

@export var kitchen: Kitchen

enum ActionID {
	INSPECT, MOVE_TO, MOVE,
	TAKE, REPLACE, USE, OPEN, CLOSE, TURN_ON, TURN_OFF,
	PET, FLIP,
	INPUT, INPUT_DOOR_CODE, INPUT_MILK_CODE, INPUT_CODE_AMBIGUOUS, UNLOCK, LOCK, WEAR, COUNT,
	HEAT, PREHEAT, READ,
	FEED, WASH, EXORCISE,
	SCRAMBLE, SCATTER, GARNISH,
	POUR, EAT,
	PUT, TURN, 
	MAIN_MENU, ENDINGS, POOP, QUIT, AFFIRM, DENY
}

enum SubjectID {
	SELF, ZOOMBA, KITCHEN, BEDROOM, FLOOR,

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
	IN_FRYING_PAN,
	ON_FRONT_LEFT_BURNER, ON_BACK_LEFT_BURNER, ON_BACK_RIGHT_BURNER, ON_FRONT_RIGHT_BURNER, ON_AMBIGUOUS_BURNER,
	TO_FRONT_LEFT_BURNER, TO_BACK_LEFT_BURNER, TO_BACK_RIGHT_BURNER, TO_FRONT_RIGHT_BURNER, TO_AMBIGUOUS_BURNER,
	ON_TABLE, ON_HEAD,

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

const NONE := -1

func initParsableActions():

	addParsableAction(ActionID.MOVE_TO,
		["move to", "move on", "walk to", "walk on", "walk up", "walk down", "walk", "go to", "go on", "go",
		"step to", "step on", "step"])
	addParsableAction(ActionID.MOVE, ["move", "switch"])

	addParsableAction(ActionID.TAKE, ["take", "get", "obtain", "hold", "pick up", "grab"])
	addParsableAction(ActionID.REPLACE, ["replace", "return", "put back", "put down", "put away", "set down"])
	addParsableAction(ActionID.USE, ["use"])
	addParsableAction(ActionID.OPEN, ["open", "crack open", "crack", "split open", "split"])
	addParsableAction(ActionID.CLOSE, ["close", "shut"])
	addParsableAction(ActionID.TURN_ON, ["turn on", "start", "activate", "run"], true)
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
	addParsableAction(ActionID.INPUT, ["push", "press", "click", "input", "enter", "set"], true)
	addParsableAction(ActionID.UNLOCK, ["unlock", "free"], true)
	addParsableAction(ActionID.LOCK, ["lock"])
	addParsableAction(ActionID.WEAR, ["wear", "put on"])
	addParsableAction(ActionID.COUNT, ["count", "number"])

	addParsableAction(ActionID.HEAT, ["heat up", "heat", "warm up", "warm", "burn", "fry", "cook", "melt", "thaw", "bake"], true)
	addParsableAction(ActionID.PREHEAT, ["preheat"])
	addParsableAction(ActionID.READ, ["read", "turn to"], true)

	addParsableAction(ActionID.FEED, ["feed", "serve", "deliver", "give"])
	addParsableAction(ActionID.WASH, ["wash", "clean"])
	addParsableAction(ActionID.EXORCISE, ["exorcise", "banish",])

	addParsableAction(ActionID.SCRAMBLE, ["scramble", "mix up", "mix", "mangle"])
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
		[ActionID.INSPECT])
	addParsableSubject(SubjectID.ZOOMBA,["zoomba", "robot vacuum", "robot", "vacuum", "pizza", "pet", "sleepyhead", "sleepy head"],
		[ActionID.INSPECT, ActionID.MOVE_TO, ActionID.FEED, ActionID.TURN_ON, ActionID.TURN_OFF, ActionID.TURN, ActionID.PET])
	addParsableSubject(SubjectID.KITCHEN, ["kitchen", "surroundings", "around"],
		[ActionID.INSPECT, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.BEDROOM, ["bedroom"],
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
	addParsableSubject(SubjectID.DINO_CEREAL_BOX,
		["dino eggs cereal box", "dino eggs cereal", "dino eggs", "dino-mite eggs cereal box", "dino-mite eggs cereal", "dino-mite eggs",
		 "box of dino eggs cereal", "box of dino eggs", "box of dino-mite eggs cereal", "box of dino-mite eggs"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.EAT, ActionID.POUR, ActionID.REPLACE, ActionID.PUT, ActionID.MOVE_TO, ActionID.FEED])
	addParsableSubject(SubjectID.IMPRISONED_CEREAL_BOX,
		["shredded wheat cereal box", "shredded wheat cereal", "shredded wheat", "imprisoned cereal box", "imprisoned cereal", "prisoner", "prison"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.EAT, ActionID.UNLOCK, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.AMBIGUOUS_CEREAL_BOX, ["cereal boxes", "cereal box", "cereal", "box of cereal"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.EAT, ActionID.POUR, ActionID.REPLACE, ActionID.PUT, ActionID.MOVE_TO, ActionID.FEED])
	
	addParsableSubject(SubjectID.MICROWAVE, ["microwave time", "quantum microwave time", "microwave", "quantum microwave"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE, ActionID.USE, ActionID.INPUT, ActionID.TURN_ON, ActionID.TURN_OFF, ActionID.TURN,
		 ActionID.HEAT, ActionID.MOVE_TO])
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
		[ActionID.INSPECT, ActionID.USE, ActionID.INPUT, ActionID.INPUT_DOOR_CODE, ActionID.INPUT_CODE_AMBIGUOUS])
	addParsableSubject(SubjectID.GREEN_BUTTON, ["green button", "green"],
		[ActionID.INSPECT, ActionID.USE, ActionID.INPUT, ActionID.INPUT_DOOR_CODE, ActionID.INPUT_CODE_AMBIGUOUS])
	addParsableSubject(SubjectID.RED_BUTTON, ["red button", "red"],
		[ActionID.INSPECT, ActionID.USE, ActionID.INPUT, ActionID.INPUT_DOOR_CODE, ActionID.INPUT_CODE_AMBIGUOUS])
	addParsableSubject(SubjectID.YELLOW_BUTTON, ["yellow button", "yellow"],
		[ActionID.INSPECT, ActionID.USE, ActionID.INPUT, ActionID.INPUT_DOOR_CODE, ActionID.INPUT_CODE_AMBIGUOUS])
	addParsableSubject(SubjectID.AMBIGUOUS_BUTTON, ["button"],
		[ActionID.INSPECT, ActionID.USE, ActionID.INPUT, ActionID.INPUT_DOOR_CODE, ActionID.INPUT_CODE_AMBIGUOUS])
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
		 ActionID.SCRAMBLE, ActionID.HEAT, ActionID.GARNISH, ActionID.FEED, ActionID.EAT])
	addParsableSubject(SubjectID.GRAPEFRUIT_JUICE,
		["grapefruit juice", "grapefruit", "juice boxes", "juice box", "juice", "cartons", "carton", "boxes in fridge", "box in fridge"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.EAT, ActionID.COUNT])
	addParsableSubject(SubjectID.NOTE, ["note in fridge", "note", "paper", "list", "strange note"],
		[ActionID.INSPECT, ActionID.READ])
	addParsableSubject(SubjectID.MILK, ["gallon of milk", "jug of milk", "milk jug", "milk"],
		[ActionID.INSPECT, ActionID.UNLOCK, ActionID.TAKE, ActionID.USE, ActionID.POUR, ActionID.REPLACE, ActionID.PUT, ActionID.LOCK,
		 ActionID.HEAT, ActionID.FEED, ActionID.EAT])
	addParsableSubject(SubjectID.LOCK, ["lock", "padlock"],
		[ActionID.INSPECT, ActionID.UNLOCK, ActionID.TAKE, ActionID.LOCK])
	
	addParsableSubject(SubjectID.TIMER, ["timer", "clock", "countdown timer", "countdown", "stadium timer", "time"],
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
	addParsableSubject(SubjectID.DEMON, ["demon", "devil", "blob", "creature", "breakfast demon", "cereal demon", "cheeriofel"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.FEED, ActionID.EXORCISE, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.PENTAGRAM, ["pentagram", "red star", "red circle", "star", "circle", "portal"],
		[ActionID.INSPECT])
	addParsableSubject(SubjectID.FORK, ["fork"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.USE, ActionID.REPLACE, ActionID.PUT])
	
	addParsableSubject(SubjectID.WINDOW, ["windowsill", "window sill", "windows", "window"],
		[ActionID.INSPECT])
	addParsableSubject(SubjectID.POTTED_PLANT, ["potted plant", "pot", "plant", "vines", "string of bananas"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.EAT])
	addParsableSubject(SubjectID.BACKYARD, ["backyard", "yard", "outside", "grass", "trees", "tree", "bushes", "bush", "out window"],
		[ActionID.INSPECT, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.HAMMOCK, ["hammock"],
		[ActionID.INSPECT, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.FRUIT_BASKET, ["fruit basket", "fruit", "basket", "apples", "apple", "mold", "fungus"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.EAT])
	addParsableSubject(SubjectID.GOULASH_INGREDIENTS,
		["goulash ingredients", "pasta", "noodles", "tomato sauce", "marinara", "jars of sauce", "jars", "jar", "sauces", "sauce",],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.EAT])
	
	addParsableSubject(SubjectID.OVEN, ["oven door", "oven", "foodcinerator 9000", "foodcinerator"],
		[ActionID.INSPECT, ActionID.OPEN, ActionID.CLOSE, ActionID.USE, ActionID.TURN_ON, ActionID.TURN_OFF, ActionID.TURN,
		 ActionID.HEAT, ActionID.PREHEAT, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.ASHES, ["ashes", "pile of ashes", "burnt strategy guide", "burnt book", "burnt magazine"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.USE, ActionID.SCATTER, ActionID.REPLACE, ActionID.PUT, ActionID.FEED, ActionID.HEAT])
	addParsableSubject(SubjectID.STOVE_TOP, ["stove top", "stove"],
		[ActionID.INSPECT, ActionID.USE, ActionID.TURN_ON, ActionID.TURN_OFF, ActionID.TURN, ActionID.MOVE_TO])
	addParsableSubject(SubjectID.FRYING_PAN, ["frying pan", "pan"],
		[ActionID.INSPECT, ActionID.TAKE, ActionID.USE, ActionID.REPLACE, ActionID.PUT, ActionID.HEAT, ActionID.MOVE, ActionID.FEED])
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
	addParsableModifier(ModifierID.IN_MICROWAVE, ["in microwave", "back in microwave"],
		[ActionID.REPLACE, ActionID.PUT, ActionID.HEAT])
	addParsableModifier(ModifierID.IN_FREEZER,
		["in freezer", "in upper fridge", "in top of fridge",
		 "back in freezer", "back in upper fridge", "back in top of fridge"],
		[ActionID.REPLACE, ActionID.PUT])
	addParsableModifier(ModifierID.IN_FRIDGE,
		["in fridge", "in lower fridge", "in bottom of fridge",
		 "back in fridge", "back in lower fridge", "back in bottom of fridge"],
		[ActionID.REPLACE, ActionID.PUT])
	addParsableModifier(ModifierID.ON_PENTAGRAM, ["in pentagram", "on pentagram", "in star", "on star", "in red circle", "on red circle"],
		[ActionID.REPLACE, ActionID.PUT])
	addParsableModifier(ModifierID.IN_SINK,
		["in sink", "in wash basin", "in basin", "in kitchen sink",
		 "back in sink", "back in wash basin", "back in basin", "back in kitchen sink"],
		[ActionID.REPLACE, ActionID.POUR, ActionID.PUT])
	addParsableModifier(ModifierID.IN_BOWL, ["in bowl", "in cereal bowl", "in cereal"],
		[ActionID.REPLACE, ActionID.PUT, ActionID.POUR, ActionID.OPEN])
	addParsableModifier(ModifierID.ON_FAN, ["on fan", "on drying fan"],
		[ActionID.REPLACE, ActionID.PUT, ActionID.OPEN])
	addParsableModifier(ModifierID.ON_COUNTER, ["on counter top", "on counter", "back on counter top", "back on counter"],
		[ActionID.REPLACE, ActionID.PUT, ActionID.OPEN])
	addParsableModifier(ModifierID.IN_OVEN,
		["in oven", "in foodcinerator 9000", "in foodcinerator",
		 "back in oven", "back in foodcinerator 9000", "back in foodcinerator"],
		[ActionID.REPLACE, ActionID.PUT, ActionID.HEAT])
	addParsableModifier(ModifierID.ON_STOVE,
		["on stove top", "on stove", "on top of oven",
		 "back on stove top", "back on stove", "back on top of oven"],
		[ActionID.REPLACE, ActionID.PUT])
	addParsableModifier(ModifierID.IN_FRYING_PAN, ["in frying pan", "on frying pan", "in pan", "on pan"],
		[ActionID.REPLACE, ActionID.PUT, ActionID.POUR, ActionID.OPEN, ActionID.HEAT])
	addParsableModifier(ModifierID.ON_FRONT_LEFT_BURNER,
		["on front left burner", "on left burner", "on bottom left burner", "on lower left burner",
		 "back on front left burner", "back on left burner", "back on bottom left burner", "back on lower left burner",],
		[ActionID.REPLACE, ActionID.PUT, ActionID.OPEN])
	addParsableModifier(ModifierID.ON_BACK_LEFT_BURNER,
		["on back left burner", "on top burner", "on upper burner", "on top left burner", "on upper left burner",
		 "back on back left burner", "back on top burner", "back on upper burner", "back on top left burner", "back on upper left burner"],
		[ActionID.REPLACE, ActionID.PUT, ActionID.OPEN])
	addParsableModifier(ModifierID.ON_BACK_RIGHT_BURNER,
		["on back right burner", "on right burner", "on top right burner", "on upper right burner",
		 "back on back right burner", "back on right burner", "back on top right burner", "back on upper right burner"],
		[ActionID.REPLACE, ActionID.PUT, ActionID.OPEN])
	addParsableModifier(ModifierID.ON_FRONT_RIGHT_BURNER,
		["on front right burner", "on bottom burner", "on lower burner", "on bottom right burner", "on lower right burner",
		 "back on front right burner", "back on bottom burner", "back on lower burner", "back on bottom right burner", "back on lower right burner"],
		[ActionID.REPLACE, ActionID.PUT, ActionID.OPEN])
	addParsableModifier(ModifierID.ON_AMBIGUOUS_BURNER,
		["on burners", "on burner", "back on burners", "back on burner"],
		[ActionID.REPLACE, ActionID.PUT, ActionID.OPEN])
	addParsableModifier(ModifierID.TO_FRONT_LEFT_BURNER,
		["to front left burner", "to left burner", "to bottom left burner", "to lower left burner",],
		[ActionID.MOVE])
	addParsableModifier(ModifierID.TO_BACK_LEFT_BURNER,
		["to back left burner", "to top burner", "to upper burner", "to top left burner", "to upper left burner"],
		[ActionID.MOVE])
	addParsableModifier(ModifierID.TO_BACK_RIGHT_BURNER,
		["to back right burner", "to right burner", "to top right burner", "to upper right burner"],
		[ActionID.MOVE])
	addParsableModifier(ModifierID.TO_FRONT_RIGHT_BURNER,
		["to front right burner", "to bottom burner", "to lower burner", "to bottom right burner", "to lower right burner"],
		[ActionID.MOVE])
	addParsableModifier(ModifierID.TO_AMBIGUOUS_BURNER,
		["to burners", "to burner"],
		[ActionID.MOVE])
	addParsableModifier(ModifierID.ON_TABLE, ["on table", "on kitchen table", "back on table", "back on kitchen table"],
		[ActionID.REPLACE, ActionID.PUT])
	addParsableModifier(ModifierID.ON_HEAD, ["on self", "on player", "on head"],
		[ActionID.INSPECT, ActionID.PUT, ActionID.OPEN, ActionID.WEAR])

	addParsableModifier(ModifierID.WITH_CODE, ["with code", "with combination", "using code", "using combination"],
		[ActionID.UNLOCK])
	
	addParsableModifier(ModifierID.WITH_FORK, ["with fork", "using fork"],
		[ActionID.EAT, ActionID.SCRAMBLE])
	addParsableModifier(ModifierID.WITH_ASHES,
		["with ashes", "using ashes", "with pile of ashes", "using pile of ashes", "with burnt strategy guide", "using burnt strategy guide"],
		[ActionID.GARNISH])
	addParsableModifier(ModifierID.ON_EGGS, ["on eggs", "on egg", "on fried eggs", "on fried egg", "on scrambled eggs", "on scrambled egg"],
		[ActionID.SCATTER, ActionID.PUT, ActionID.REPLACE])
	addParsableModifier(ModifierID.TO_DEMON,
	    ["to demon", "to devil", "to blob", "to creature", "to breakfast demon", "to cereal demon", "to cheeriofel"],
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
			"steady on your feet again, the kitchen is a hot, flaming mess.",
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

			ActionID.MOVE, ActionID.TAKE, ActionID.REPLACE, ActionID.USE, ActionID.OPEN, ActionID.CLOSE, ActionID.TURN_ON, ActionID.TURN_OFF,\
			ActionID.PET, ActionID.FLIP,\
			ActionID.INPUT, ActionID.UNLOCK, ActionID.LOCK, ActionID.WEAR, ActionID.COUNT,\
			ActionID.HEAT, ActionID.PREHEAT, ActionID.READ,\
			ActionID.FEED, ActionID.WASH, ActionID.EXORCISE,\
			ActionID.SCRAMBLE, ActionID.SCATTER, ActionID.GARNISH,\
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

		ActionID.INSPECT, ActionID.READ:
			match subjectID:

				-1, SubjectID.STRATEGY_GUIDE, SubjectID.BLOCK_OF_ICE, SubjectID.ASHES when wildCard:

					return attemptReadStrategyGuide()

				SubjectID.SELF:
					return "Your tummy rumbles eagerly in anticipation of breakfast."

				SubjectID.ZOOMBA:
					return "Zoomba is prowling around the kitchen for crumbs like the good boy he is."

				SubjectID.KITCHEN:
					return "You've finally made it to the kitchen! This place is chock full of high-tech appliances perfect for overcomplicating mealtime."

				SubjectID.BEDROOM:
					return "That's where you came from. No need to go back now."

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
								"He must have left his regular pitchfork back in Hell..."
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

				
				SubjectID.COLORED_CEREAL_BOXES:
					if kitchen.isTopLeftCupboardOpen:
						return (
							"Strangely, these brightly colored cereal boxes are all empty, " +
							"and you get the sense that they're only here to help you remember something..."
						)
					else:
						return wrongContextParse()

				SubjectID.NUMBERED_CEREAL_BOXES:
					if kitchen.isBottomLeftCupboardOpen:
						return (
							"This cupboard holds a few monochrome cereal boxes, each with a number prominently displayed on the spine. " +
							"They're all empty though, and you get the sense that they're only here to help you remember something..."
						)
					else:
						return wrongContextParse()

				SubjectID.DINO_CEREAL_BOX:
					return (
						"Oh boy! Dino-mite Eggs was one of your favorite cereals growing up, and even now, starting your day with it fills " +
						"you with a warm fuzzy feeling. (You're not sure if that's from the nostalgia or the real TNT pieces hiding inside each egg.)"
					)

				SubjectID.IMPRISONED_CEREAL_BOX:
					if kitchen.isBottomRightCupboardOpen:
						return "This box of UNFROSTED shredded wheat is still serving its 5-year prison sentence for impersonating its frosted counterpart."
					else: return wrongContextParse()

				SubjectID.AMBIGUOUS_CEREAL_BOX:
					if not kitchen.isTopLeftCupboardOpen and not kitchen.isBottomLeftCupboardOpen and not kitchen.isBottomRightCupboardOpen:
						return (
							"Oh boy! Dino-mite Eggs was one of your favorite cereals growing up, and even now, starting your day with it fills " +
							"you with a warm fuzzy feeling. (You're not sure if that's from the nostalgia or the real TNT pieces hiding inside each egg.)"
						)
					else:
						return (
							"You can see a few different cereal boxes when you look around your kitchen. Your eyes linger on the box of \"Dino-mite Eggs\" though." +
							"Those would make for a great breakfast!"
						)

				
				SubjectID.MICROWAVE:
					return (
						"This is a top-of-the-line quantum microwave! It's substantially more powerful than traditional microwaves and can deliver the same " +
						"amount of heat in a fraction of the time! All you have to do is input the time a normal microwave would take, and it achieves the same result " +
						"in an instant! Now that's efficient!"
					)

				SubjectID.OUTLET:
					return "You had to have a dryer outlet installed in your kitchen to satisfy the needs of your quantum microwave."

				
				SubjectID.TOP_FRIDGE_DOOR:
					if kitchen.isTopFridgeDoorOpen:
						return "The freezer door is wide open. Brrrr!"
					else:
						return "The freezer door is currently closed."

				SubjectID.BOTTOM_FRIDGE_DOOR:
					if kitchen.isBottomFridgeDoorOpen:
						return "The refrigerator door is wide open. There's a slight chill in the air."
					elif kitchen.isFridgeUnlocked:
						return "The refrigerator door is unlocked and ready to open."
					else:
						return "The refrigerator door is closed and locked up tight. No one's burgling your milk now!"

				SubjectID.FRIDGE:
					if kitchen.isBottomFridgeDoorOpen:
						return (
							"This is where you keep your milk, as well as other, less important things. " +
							"You've got some spoons, eggs, grapefruit juice, and a strange note..."
						)
					else:
						return (
							"You had a special combination lock added to your fridge to prevent anyone from stealing your precious milk. " +
							"You can open it by pressing the colored buttons in the right order, which is... Hmmm... You seem to have forgotten the combination. " +
							"Perhaps you left clues for yourself somewhere around the kitchen?"
						)

				SubjectID.FREEZER:
					if kitchen.isTopFridgeDoorOpen: return "OH NO! You're out of ice cream! You'll have to remember to get some after work."
					else: return "This is your freezer. It freezes things."

				SubjectID.QUAKER_DRAWING:
					if kitchen.isTopFridgeDoorOpen:
						return wrongContextParse()
					else:
						return (
							"Your niece made this beautiful drawing of the Quaker mascot just for you! " +
							"You're pretty sure it would sell for millions at an art auction, but to you, it's priceless."
						)

				SubjectID.PICTURES:
					if kitchen.isBottomFridgeDoorOpen:
						return wrongContextParse()
					else:
						return (
							"There are several christmas cards from friends and family. " +
							"You get the sense that their lives are a little more put together than yours..."
						)

				SubjectID.BLUE_BUTTON:
					return "The blue button is blue."

				SubjectID.GREEN_BUTTON:
					return "The green button is green."

				SubjectID.RED_BUTTON:
					return "The red button is red."

				SubjectID.YELLOW_BUTTON:
					return "The yellow button is................ Yellow."

				SubjectID.AMBIGUOUS_BUTTON:
					return requestAdditionalContextCustom("Which button would you like to " + actionAlias + "?", REQUEST_SUBJECT, [], [" button"])

				SubjectID.BLOCK_OF_ICE:
					if (
						kitchen.playerHeldItem == Kitchen.PlayerHeldItem.FROZEN_STRATEGY_GUIDE or
						(kitchen.isStrategyGuideFrozen and kitchen.isStrategyGuideInOven) or
						(kitchen.isStrategyGuideInFridge and kitchen.isTopFridgeDoorOpen)
					):
						return (
							"Drat! It looks like your friends pulled a prank on you while you were passed out last night... " +
							"You'll need to melt this ice if you want to regain access to your breakfast strategy guide. " +
							"(You make a mental note to add a lock to your freezer as well.)"
						)
					else:
						return wrongContextParse()

				SubjectID.STRATEGY_GUIDE:
					if kitchen.playerHeldItem == Kitchen.PlayerHeldItem.FROZEN_STRATEGY_GUIDE:
						return "You can't read the strategy guide while it's frozen in ice..."
					elif kitchen.playerHeldItem == Kitchen.PlayerHeldItem.ASHES:
						return "The strategy guide is burnt beyond all recognition..."
					elif kitchen.playerHeldItem != Kitchen.PlayerHeldItem.THAWED_STRATEGY_GUIDE:
						return (
							"This is a limited-edition Preemuh Games breakfast strategy guide! " +
							"Looking through the table of contents, a few interesting entries catch your eye:\n" +
							"- Page 25: Fancy breakfast for fancy people\n" +
							"- Page 36: Breakfast evangelism 101\n" +
							"- Page 64: Incubating dino eggs to perfection\n" +
							"- Page 81: The cereal mixing manifesto\n" +
							"- Page 121: Appeasing the infernal offspring of Breakfast Hell"
						)
					else:
						return "You need to be holding the strategy guide to get a closer look at it."

				SubjectID.DINO_NUGGETS:
					if kitchen.isTopFridgeDoorOpen:
						return "Mmmmm... Dino nuggets... You really should wait until 5:00 to start indulging in these guys though..."
					else:
						return wrongContextParse()

				SubjectID.SPOON:
					if kitchen.playerHeldItem == Kitchen.PlayerHeldItem.SPOON:
						return "Holding this spoon makes you even hungrier for breakfast!"
					elif kitchen.isBottomFridgeDoorOpen:
						return "Your spoons are perfectly chilled and ready for breakfast!"
					else:
						return wrongContextParse()

				SubjectID.EGG:
					if kitchen.isPlayerWearingEgg:
						return "You trained for years in the Himalayan institute of ovate equilibrium. This egg is perfectly safe!"
					elif modifierID == ModifierID.ON_HEAD or not kitchen.isBottomFridgeDoorOpen:
						return wrongContextParse()
					else:
						return "Sometimes, you dream about eating fresh eggs you laid yourself, just like the farmers of yore..."

				SubjectID.GRAPEFRUIT_JUICE:
					if kitchen.isBottomFridgeDoorOpen:
						return "Ugh... You really wish your aunt would stop sending you so much grapefruit juice..."
					else:
						return wrongContextParse()

				SubjectID.NOTE:
					if kitchen.isBottomFridgeDoorOpen:
						return (
							"It looks like you wrote this note to help you remember something. " +
							"It has a picture of an egg, then a spoon, then a grapefruit... " +
							"If you only you could remember what this was supposed to help you remember! Then you could remember it!"
						)
					else:
						return wrongContextParse()

				SubjectID.MILK:
					if kitchen.playerHeldItem == Kitchen.PlayerHeldItem.MILK or (kitchen.isBottomFridgeDoorOpen and kitchen.isMilkUnlocked):
						return (
							"You had this milk imported specially from Cow Planet. " +
							"It's rich in vitamin B29, and it never goes bad! It's perfect for making cereal too! " +
							"You've often wondered how it's made, but every time you try to google it, your browser mysteriously crashes... Oh well! " +
							"You've unlocked the milk, and now it's ready to be poured! "
						)
					elif kitchen.isBottomFridgeDoorOpen:
						return (
							"You had this milk imported specially from Cow Planet. " +
							"It's rich in vitamin B29, and it never goes bad! It's perfect for making cereal too! " +
							"You've often wondered how it's made, but every time you try to google it, your browser mysteriously crashes... Oh well! " +
							"The milk is still secured firmly to the side of the fridge and locked in place with a padlock, safe and sound. " +
							"You'll need to input the correct 3-digit code to unlock it."
						)
					else:
						return wrongContextParse()

				SubjectID.LOCK:
					if kitchen.isBottomFridgeDoorOpen:
						if kitchen.isMilkUnlocked:
							return "The lock is lying open on the fridge shelf."
						else:
							return (
								"The lock is keeping the milk fastened securely to the side of the fridge. " +
								"You'll need to input the correct 3-digit code to unlock it."
							)
					else:
						return wrongContextParse()

				
				SubjectID.TIMER:
					return "This clock is set to BST (Breakfast Standard Time) and is always counting down to the proper time to have breakfast."

				SubjectID.LARRY_LIGHT_SWITCH:
					return (
						"You try to look at Larry the Light Switch, but space bends and warps ominously around him. The more you try to make sense " +
						"of what you're seeing, the more your head hurts. Eventually, you are forced to look away."
					)

				SubjectID.AMBIGUOUS_LIGHT_SWITCH:
					return "It's a pretty normal light switch."

				
				SubjectID.FAN:
					return "Instead of a traditional drying rack, you opted to have a box fan mounted in your counter. It dries dishes in record time!"

				SubjectID.SINK:
					if kitchen.bowlState == Kitchen.DIRTY:
						return "A lone cereal bowl sits at the bottom of the sink. You'll need to wash it before you can use it again."
					else:
						return "Your sink is empty, just like your stomach..."

				SubjectID.FAUCET:
					if kitchen.isDemonSatisfied:
						return "With the demon below your sink focused on his breakfast, the faucet is operational again!"
					else:
						return "The faucet doesn't appear to be working right now... Maybe you should check the cupboard below the sink?"

				SubjectID.CEREAL_BOWL:
					match kitchen.bowlState:
						Kitchen.DIRTY:
							return "This bowl is still filthy from last night's cereal bender. You'll need to wash it before you can use it again."
						Kitchen.CLEAN:
							return "The cereal bowl has been rinsed and dried, and that's good enough for you. Time to fill it!"
						Kitchen.JUST_MILK:
							return "The cereal bowl is full of milk. Now for the cereal..."
						Kitchen.JUST_CEREAL:
							return "The cereal bowl is full of cereal. Now for the milk..."
						Kitchen.UNHATCHED:
							return "The Dino-mite Eggs cereal is happily marinating in the milk. Now you just need to get it warm enough for the eggs to hatch!"
						Kitchen.HATCHED:
							return "Your stomach growls as you stare at the hatched Dino-mite eggs. Quickly! To the table!"

				SubjectID.PLUMBING:
					if not kitchen.isMiddleRightCupboardOpen and not kitchen.isMiddleLeftCupboardOpen:
						return wrongContextParse()
					elif kitchen.isMiddleRightCupboardOpen and not kitchen.isMiddleLeftCupboardOpen:
						return "Hmmm... The plumbing looks fine on this side. What about the other one?"
					elif kitchen.isDemonSatisfied:
						return "The pipes have been freed from the grip of Cheeriofel. The faucet should work now!"
					else:
						return (
							"Ah. You can see the problem now. That cereal demon that's been hanging around has latched onto the plumbing again... " +
							"Upon seeing you, he begins shouting his usual tirade in a frantic, high-pitched voice:\n" +
							HUNGRY_DEMON_SPIEL + "\nIt looks like you'll have to make his breakfast first if you want access to running water again..."
						)


				SubjectID.DEMON:
					if not kitchen.isMiddleLeftCupboardOpen:
						return wrongContextParse()
					elif kitchen.isDemonSatisfied:
						return (
							"The breakfast demon is sitting on the frying pan making loud slurping noises. " +
							"At least he's not blocking your plumbing any more!"
						)
					else:
						return (
							"You accidentally summoned this breakfast demon after making your 6666th bowl of cereal. " +
							"As a housemate, he leaves a little something to be desired... " +
							"Upon seeing you, he begins shouting his usual tirade in a frantic, high-pitched voice:\n" +
							HUNGRY_DEMON_SPIEL + "\nIt looks like you'll have to make his breakfast first if you want access to running water again..."
						)

				SubjectID.PENTAGRAM:
					if not kitchen.isMiddleLeftCupboardOpen:
						return wrongContextParse()
					elif kitchen.isDemonSatisfied:
						return (
							"The breakfast demon is sitting on the frying pan making loud slurping noises. " +
							"At least he's not blocking your plumbing any more!"
						)
					else:
						return "This is the portal the breakfast demon entered through. It's made of ketchup, and as far as you can tell, it's impossible to remove."

				SubjectID.FORK:
					if kitchen.playerHeldItem == Kitchen.PlayerHeldItem.FORK:
						return "This fork won't be much good for eating cereal, but you can probably find another use for it."
					elif kitchen.isMiddleRightCupboardOpen:
						return (
							"*Sigh* It looks like the breakfast demon has appropriated your fork again... " +
							"He must have left his regular pitchfork back in Hell..."
						)
					else:
						return wrongContextParse()

				
				SubjectID.WINDOW:
					return (
						"This window looks out into your backyard, where your hammock sways gently in the morning breeze."
					)

				SubjectID.POTTED_PLANT:
					return (
						"You got this \"string of bananas\" plant under the assumption that it would produce a constant supply " +
						"of delicious, yellow fruit. The bananas it's made so far are much smaller and greener than you expected, " +
						"but that's okay. It's trying it's best, and it would be rude to rush it. You can wait."
					)

				SubjectID.BACKYARD:
					return (
						"Your hammock is strung carefully between the plum trees, and the tulips at the fence line are in full bloom. " +
						"All is as it should be."
					)


				SubjectID.HAMMOCK:
					return (
						"The sight of your hammock on a warm summer's morning makes your heart ache with longing... With difficulty, you " +
						"tear your gaze away from it refocus on the task at hand. You've got to finish preparing your breakfast and get to work! " +
						"There will be time to relax in your hammock once crisis has been averted."
					)

				SubjectID.FRUIT_BASKET:
					return (
						"This used to be a fruit basket, but after a few weeks of neglect, now it's more of a mold basket. Gross... " +
						"You'd throw it out, but that would require touching it, and you'd rather not..."
					)

				SubjectID.GOULASH_INGREDIENTS:
					return (
						"Your loyal army of pasta ingredients is standing at attention. You've got the next 4 months of dinners planned out right here!"
					)

				
				SubjectID.OVEN:
					return (
						"This baby is the foodcinerator 9000, and it makes short work of all your baking and frying needs! It's been recalled by the " +
						"manufacturer several times for safety concerns, but you have yet to order a new one. You're pretty sure they're just jealous."
					)

				SubjectID.ASHES:
					if kitchen.isStrategyGuideBurnt:
						return "\"Ashes to ashes\", you mutter to yourself. You immediately feel 200% cooler."
					else:
						return wrongContextParse()

				SubjectID.STOVE_TOP:
					return (
						"This stove top is powerful enough to boil water in under a minute and " +
						"has the added bonus of singing off your unibrow if you get close enough."
					)

				SubjectID.FRYING_PAN:
					if kitchen.isDemonSatisfied:
						return "Hopefully no one tries to steal your milk while the demon is busy with your frying pan."
					else:
						return "This trusty frying pan doubles as a weapon against would-be milk thieves."

				SubjectID.FUME_HOOD:
					return (
						"You recently had the genius idea of rerouting your fume hood to the house's HVAC system instead of venting it outdoors. " +
						"That way, you can smell a freshly cooked meal anywhere in your house!"
					)


				SubjectID.FRONT_LEFT_BURNER:
					if kitchen.activeBurner == kitchen.FRONT_LEFT:
						return (
							"That burner is cooking the dickens out of your frying pan. " +
							"You're not sure what dickens are, but there sure aren't any left in the pan."
						)
					else:
						return "That burner is off"

				SubjectID.BACK_LEFT_BURNER:
					if kitchen.activeBurner == kitchen.BACK_LEFT:
						return (
							"That burner is cooking the dickens out of your frying pan. " +
							"You're not sure what dickens are, but there sure aren't any left in the pan."
						)
					else:
						return "That burner is off"

				SubjectID.BACK_RIGHT_BURNER:
					if kitchen.activeBurner == kitchen.BACK_RIGHT:
						return (
							"That burner is cooking the dickens out of your frying pan. " +
							"You're not sure what dickens are, but there sure aren't any left in the pan."
						)
					else:
						return "That burner is off"

				SubjectID.FRONT_RIGHT_BURNER:
					if kitchen.activeBurner == kitchen.FRONT_RIGHT:
						return (
							"That burner is cooking the dickens out of your frying pan. " +
							"You're not sure what dickens are, but there sure aren't any left in the pan."
						)
					else:
						return "That burner is off"

				SubjectID.AMBIGUOUS_BURNER:
					return requestAdditionalContextCustom("Which burner would you like to " + actionAlias + "?", REQUEST_SUBJECT, [], [" burner"])

				
				SubjectID.TABLE:
					return "This is where you eat breakfast! (and other meals too, you suppose.)"

				SubjectID.CHAIRS:
					return "Zoomba has a bad habit of getting stuck in between the legs of these chairs..."

				SubjectID.SALT_AND_PEPPER_SHAKERS:
					return (
						"You recently had the brilliant idea to fill the salt and pepper shakers with powdered milk and pancake mix! " +
						"It looks like they're empty right now though."
					)

				
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

			match subjectID:

				SubjectID.KITCHEN:
					return "You are already in the kitchen."

				SubjectID.BEDROOM:
					return "There's no need to go back into your bedroom. Your breakfast is here in the kitchen!"


				SubjectID.ZOOMBA:
					kitchen.movePlayer(Kitchen.PlayerPos.ZOOMBA)
					return "You walk over to Zoomba"


				SubjectID.MICROWAVE, SubjectID.OUTLET:
					kitchen.movePlayer(Kitchen.PlayerPos.MICROWAVE)
					return "You walk over to the microwave"
				
				SubjectID.BOTTOM_LEFT_CUPBOARD, SubjectID.NUMBERED_CEREAL_BOXES:
					kitchen.movePlayer(Kitchen.PlayerPos.MICROWAVE)
					return "You walk over to the cupboard under the microwave"
				
				SubjectID.TOP_LEFT_CUPBOARD, SubjectID.COLORED_CEREAL_BOXES:
					kitchen.movePlayer(Kitchen.PlayerPos.MICROWAVE)
					return "You walk over to the cupboard over the microwave"


				SubjectID.TOP_FRIDGE_DOOR, SubjectID.BOTTOM_FRIDGE_DOOR, SubjectID.FRIDGE, SubjectID.FREEZER:
					kitchen.movePlayer(Kitchen.PlayerPos.FRIDGE)
					return "You walk over to the refrigerator."
				

				SubjectID.BOTTOM_DRAWER, SubjectID.MIDDLE_DRAWER, SubjectID.TOP_DRAWER, SubjectID.AMBIGUOUS_DRAWER:
					kitchen.movePlayer(Kitchen.PlayerPos.DRAWERS)
					return "You walk over to the drawers."

				SubjectID.FAN:
					kitchen.movePlayer(Kitchen.PlayerPos.DRAWERS)
					return "You walk over to the fan."


				SubjectID.MIDDLE_LEFT_CUPBOARD, SubjectID.MIDDLE_CUPBOARDS:
					kitchen.movePlayer(Kitchen.PlayerPos.MIDDLE_LEFT_CUPBOARD)
					return "You walk over to the cupboards under the sink."

				SubjectID.DEMON:
					kitchen.movePlayer(Kitchen.PlayerPos.MIDDLE_LEFT_CUPBOARD)
					return "You walk over to the cupboard with the breakfast demon."


				SubjectID.MIDDLE_RIGHT_CUPBOARD:
					kitchen.movePlayer(Kitchen.PlayerPos.MIDDLE_RIGHT_CUPBOARD)
					return "You walk over to the cupboards under the sink."

				SubjectID.SINK:
					kitchen.movePlayer(Kitchen.PlayerPos.MIDDLE_RIGHT_CUPBOARD)
					return "You walk over to the sink."

				SubjectID.TIMER:
					kitchen.movePlayer(Kitchen.PlayerPos.MIDDLE_RIGHT_CUPBOARD)
					return "You walk over to the " + subjectAlias + "."


				SubjectID.OVEN:
					kitchen.movePlayer(Kitchen.PlayerPos.OVEN)
					return "You walk over to the oven."

				SubjectID.STOVE_TOP:
					kitchen.movePlayer(Kitchen.PlayerPos.OVEN)
					return "You walk over to the stove."

				SubjectID.COUNTER:
					kitchen.movePlayer(Kitchen.PlayerPos.OVEN)
					return "You walk over to an open section of the counter."


				SubjectID.TABLE:
					kitchen.movePlayer(Kitchen.PlayerPos.TABLE)
					return "You walk over to the table."


				SubjectID.BOTTOM_RIGHT_CUPBOARD, SubjectID.IMPRISONED_CEREAL_BOX:
					kitchen.movePlayer(Kitchen.PlayerPos.RIGHT_CUPBOARD)
					return "You walk over to the cupboard containing cereal jail."


				SubjectID.HAMMOCK, SubjectID.BACKYARD:
					return "There's no time to be lounging around outside. You've got to eat your breakfast and get to work!"


				SubjectID.DINO_CEREAL_BOX, SubjectID.AMBIGUOUS_CEREAL_BOX:
					if kitchen.playerHeldItem == Kitchen.PlayerHeldItem.CEREAL_BOX:
						return "This cereal box is already with you wherever you go!"
					elif kitchen.isCerealInOven:
						kitchen.movePlayer(Kitchen.PlayerPos.OVEN)
						return "You walk over to the cereal box in the oven."
					elif kitchen.isCerealOnCounter:
						kitchen.movePlayer(Kitchen.PlayerPos.OVEN)
						return "You walk over to the cereal box on the counter."
					elif kitchen.isCerealOnTable:
						kitchen.movePlayer(Kitchen.PlayerPos.TABLE)
						return "You walk over to the cereal box on the table."

				SubjectID.BOTTOM_CUPBOARD, SubjectID.AMBIGUOUS_CUPBOARD:
					return requestAdditionalContextCustom(
						"Which of the cupboards would you like to " + actionAlias + "?",
						REQUEST_SUBJECT, [], [" cupboard"]
					)


		ActionID.MOVE:
			if subjectID == SubjectID.FRYING_PAN:
				var movingOffActiveBurner: bool
				match modifierID:
					ModifierID.ON_FRONT_LEFT_BURNER:
						if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.FRYING_PAN and kitchen.ovenFryingPanPos == kitchen.FRONT_LEFT:
							return "The frying pan is already there."
						else:
							if kitchen.playerHeldItem == Kitchen.PlayerHeldItem.FRYING_PAN:
								kitchen.putFryingPanBack()
							kitchen.moveFryingPan(Kitchen.FRONT_LEFT)
							if kitchen.activeBurner == NONE or kitchen.activeBurner == kitchen.ovenFryingPanPos:
								return "You move the frying pan over to the front left burner."
							else:
								movingOffActiveBurner = true
					ModifierID.ON_FRONT_RIGHT_BURNER:
						if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.FRYING_PAN and kitchen.ovenFryingPanPos == kitchen.FRONT_RIGHT:
							return "The frying pan is already there."
						else:
							if kitchen.playerHeldItem == Kitchen.PlayerHeldItem.FRYING_PAN:
								kitchen.putFryingPanBack()
							kitchen.moveFryingPan(Kitchen.FRONT_RIGHT)
							if kitchen.activeBurner == NONE or kitchen.activeBurner == kitchen.ovenFryingPanPos:
								return "You move the frying pan over to the front right burner."
							else:
								movingOffActiveBurner = true
					ModifierID.ON_BACK_LEFT_BURNER:
						if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.FRYING_PAN and kitchen.ovenFryingPanPos == kitchen.BACK_LEFT:
							return "The frying pan is already there."
						else:
							if kitchen.playerHeldItem == Kitchen.PlayerHeldItem.FRYING_PAN:
								kitchen.putFryingPanBack()
							kitchen.moveFryingPan(Kitchen.BACK_LEFT)
							if kitchen.activeBurner == NONE or kitchen.activeBurner == kitchen.ovenFryingPanPos:
								return "You move the frying pan over to the back left burner."
							else:
								movingOffActiveBurner = true
					ModifierID.ON_BACK_RIGHT_BURNER:
						if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.FRYING_PAN and kitchen.ovenFryingPanPos == kitchen.BACK_RIGHT:
							return "The frying pan is already there."
						else:
							if kitchen.playerHeldItem == Kitchen.PlayerHeldItem.FRYING_PAN:
								kitchen.putFryingPanBack()
							kitchen.moveFryingPan(Kitchen.BACK_RIGHT)
							if kitchen.activeBurner == NONE or kitchen.activeBurner == kitchen.ovenFryingPanPos:
								return "You move the frying pan over to the back right burner."
							else:
								movingOffActiveBurner = true
					ModifierID.ON_AMBIGUOUS_BURNER, -1:
						return requestAdditionalContextCustom("Which burner would you like to move the pan to?", REQUEST_SUBJECT, [], [" burner"])
				
				if movingOffActiveBurner:
					SceneManager.transitionToScene(
						SceneManager.SceneID.ENDING,
						"The burner underneath the frying pan is still red hot, with flames licking out around it, " +
						"but for some reason you feel a pressing need to take the frying pan away from it. " +
						"A smarter man might have turned off the burner first, but you are not that man. As soon as you remove the pan, " +
						"the jet of fire that it was blocking shoots up into the air. You watch in awe as the column of flame rapidly climbs to the ceiling. " +
						"A man of low to moderate intelligence might have turned off the burner now, but sadly, you are not that man either.",
						SceneManager.EndingID.DRY_FIRE
					)
					return ""


		ActionID.TAKE:

			match subjectID:

				SubjectID.COLORED_CEREAL_BOXES:
					if kitchen.isTopLeftCupboardOpen:
						return "There's not actually any cereal in these boxes, so there's no point in taking them."
					else:
						return wrongContextParse()

				SubjectID.NUMBERED_CEREAL_BOXES:
					if kitchen.isBottomLeftCupboardOpen:
						return "There's not actually any cereal in these boxes, so there's no point in taking them."
					else:
						return wrongContextParse()

				SubjectID.DINO_CEREAL_BOX, SubjectID.AMBIGUOUS_CEREAL_BOX:
					return attemptTakeDinoEggsCereal()

				SubjectID.IMPRISONED_CEREAL_BOX:
					if kitchen.isBottomRightCupboardOpen:
						return "You can't release the prisoner until they've finished serving their sentence."
					else:
						return wrongContextParse()


				SubjectID.QUAKER_DRAWING, SubjectID.PICTURES:
					return "The Feng Shui of your fridge is perfect right now. You don't want to mess with it."

				SubjectID.BLOCK_OF_ICE, SubjectID.STRATEGY_GUIDE when subjectID == SubjectID.BLOCK_OF_ICE or kitchen.isStrategyGuideFrozen:
					if not kitchen.isStrategyGuideFrozen:
						return wrongContextParse()
					elif kitchen.playerHeldItem == Kitchen.PlayerHeldItem.FROZEN_STRATEGY_GUIDE:
						return "You're already holding that. (Brrrr!)"
					elif kitchen.isStrategyGuideInFridge:
						if kitchen.isTopFridgeDoorOpen:
							if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.NONE:
								return "You're already carrying something. You'll need to put it down first."
							else:
								kitchen.takeFrozenStrategyGuideFromFridge()
								return "You pick up the block of ice containing the strategy guide."
						else:
							return wrongContextParse()
					elif kitchen.isStrategyGuideInOven:
						if kitchen.isOvenDoorOpen:
							if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.NONE:
								return "You're already carrying something. You'll need to put it down first."
							else:
								kitchen.takeFrozenStrategyGuideFromOven()
								return "You pick up the block of ice containing the strategy guide."
						else:
							return "You'll need to open the oven door first."

				SubjectID.ASHES, SubjectID.STRATEGY_GUIDE when subjectID == SubjectID.ASHES or kitchen.isStrategyGuideBurnt:
					if not kitchen.isStrategyGuideBurnt:
						return wrongContextParse()
					elif kitchen.playerHeldItem == Kitchen.PlayerHeldItem.ASHES:
						return "You're already holding that."
					elif kitchen.isStrategyGuideInOven:
						if kitchen.isOvenDoorOpen:
							if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.NONE:
								return "You're already carrying something. You'll need to put it down first."
							else:
								kitchen.takeAshesFromOven()
								return "You pick up the ashes that were once a breakfast strategy guide. (Your hands take +2 fire damage)"
						else:
							return "You'll need to open the oven door first."
					elif kitchen.isStrategyGuideOnCounter:
						if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.NONE:
							return "You're already carrying something. You'll need to put it down first."
						else:
							kitchen.takeAshesFromCounter()
							return "You pick up the ashes that were once a breakfast strategy guide."

				SubjectID.STRATEGY_GUIDE:
					if kitchen.playerHeldItem == Kitchen.PlayerHeldItem.THAWED_STRATEGY_GUIDE:
						return "You're already holding that."
					elif kitchen.isStrategyGuideInOven:
						if kitchen.isOvenDoorOpen:
							if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.NONE:
								return "You're already carrying something. You'll need to put it down first."
							else:
								kitchen.takeThawedStrategyGuideFromOven()
								return "You pick up the freshly thawed strategy guide."
						else:
							return "You'll need to open the oven door first."
					elif kitchen.isStrategyGuideOnCounter:
						if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.NONE:
							return "You're already carrying something. You'll need to put it down first."
						else:
							kitchen.takeStrategyGuideFromCounter()
							return "You pick up the breakfast strategy guide."
					elif kitchen.isStrategyGuideOnTable:
						if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.NONE:
							return "You're already carrying something. You'll need to put it down first."
						else:
							kitchen.takeStrategyGuideFromTable()
							return "You pick up the breakfast strategy guide."

				SubjectID.DINO_NUGGETS:
					if not kitchen.isTopFridgeDoorOpen:
						return wrongContextParse()
					else:
						return "As delicious as these are, they're not really breakfast food..."

				SubjectID.SPOON:
					if kitchen.playerHeldItem == Kitchen.PlayerHeldItem.SPOON:
						return "You're already holding that."
					elif not kitchen.isBottomFridgeDoorOpen:
						return wrongContextParse()
					elif kitchen.playerHeldItem != Kitchen.PlayerHeldItem.NONE:
						return "You're already carrying something. You'll need to put it down first."
					else:
						kitchen.takeSpoonFromFridge()
						return "You pick up a spoon."

				SubjectID.EGG:
					if kitchen.isPlayerWearingEgg:
						return "You've already got an egg."
					elif not kitchen.isBottomFridgeDoorOpen:
						return wrongContextParse()
					elif kitchen.isEggInPan or kitchen.isEggOnFloor:
						kitchen.movePlayer(Kitchen.PlayerPos.FRIDGE)
						return "You've already taken an egg"
					else:
						kitchen.takeEggFromFridge()
						return "You take an egg and balance it carefully on your head."

				SubjectID.GRAPEFRUIT_JUICE:
					if not kitchen.isBottomFridgeDoorOpen:
						return wrongContextParse()
					else:
						return "Yuck! That stuff is NOT good breakfast material, and you don't want anything to do with it."
				
				SubjectID.MILK:
					if kitchen.playerHeldItem == Kitchen.PlayerHeldItem.MILK:
						return "You're already holding that."
					elif not kitchen.isBottomFridgeDoorOpen:
						return wrongContextParse()
					elif not kitchen.isMilkUnlocked:
						return "The milk is still chained to the side of the fridge. You'll need to unlock it first."
					elif kitchen.playerHeldItem != Kitchen.PlayerHeldItem.NONE:
						return "You're already carrying something. You'll need to put it down first."
					else:
						kitchen.takeMilk()
						return "You pick up the milk and take a quick swig from the jug. Refreshing!"
				
				SubjectID.LOCK:
					if not kitchen.isBottomFridgeDoorOpen:
						return wrongContextParse()
					else:
						return "It's better if this stays in the fridge."


				SubjectID.CEREAL_BOWL:
					if kitchen.playerHeldItem == Kitchen.PlayerHeldItem.CEREAL_BOWL:
						return "You're already holding that."
					elif kitchen.bowlState == Kitchen.DIRTY:
						return "You should really wash it first..."
					elif kitchen.isCerealBowlInMicrowave:
						if not kitchen.isMicrowaveDoorOpen:
							return "You'll need to open the microwave first."
						elif kitchen.playerHeldItem != Kitchen.PlayerHeldItem.NONE:
							return "You're already carrying something. You'll need to put it down first."
						else:
							kitchen.takeCerealBowl()
							return "You pick up the cereal bowl"
					elif kitchen.isCerealBowlOnFan or kitchen.isCerealBowlOnTable:
						if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.NONE:
							return "You're already carrying something. You'll need to put it down first."
						else:
							kitchen.takeCerealBowl()
							return "You pick up the cereal bowl"


				SubjectID.DEMON:
					if not kitchen.isMiddleLeftCupboardOpen:
						return wrongContextParse()
					else:
						return "That seems like a really bad idea."

				SubjectID.FORK:
					if kitchen.playerHeldItem == Kitchen.PlayerHeldItem.FORK:
						return "You're already holding that."
					elif not kitchen.isMiddleRightCupboardOpen:
						return wrongContextParse()
					elif kitchen.playerHeldItem != Kitchen.PlayerHeldItem.NONE:
						return "You're already carrying something. You'll need to put it down first."
					else:
						kitchen.takeFork()
						return "You pick up the fork."


				SubjectID.POTTED_PLANT:
					return "Your plant doesn't like being pushed around. You'd rather let it grow in peace."

				SubjectID.FRUIT_BASKET:
					return "Gross... You don't want to touch that."

				SubjectID.GOULASH_INGREDIENTS:
					return "These aren't breakfast ingredients, so you don't need them right now."


				SubjectID.FRYING_PAN:
					if kitchen.playerHeldItem == Kitchen.PlayerHeldItem.FRYING_PAN:
						return "You're already holding that."
					elif kitchen.isDemonSatisfied:
						return "The breakfast demon is busy with the frying pan right now. Best to leave him be..."
					elif kitchen.playerHeldItem != Kitchen.PlayerHeldItem.NONE:
						return "You're already carrying something. You'll need to put it down first." 
					elif kitchen.activeBurner == kitchen.ovenFryingPanPos:
						SceneManager.transitionToScene(
							SceneManager.SceneID.ENDING,
							"The burner underneath the frying pan is still red hot, with flames licking out around it, " +
							"but for some reason you feel a pressing need to take the frying pan away from it. " +
							"A smarter man might have turned off the burner first, but you are not that man. As soon as you remove the pan, " +
							"the jet of fire that it was blocking shoots up into the air. You watch in awe as the column of flame rapidly climbs to the ceiling. " +
							"A man of low to moderate intelligence might have turned off the burner now, but sadly, you are not that man either.",
							SceneManager.EndingID.DRY_FIRE
						)
						return ""
					else:
						kitchen.takeFryingPan()
						return "You pick up the frying pan."


				SubjectID.SALT_AND_PEPPER_SHAKERS:
					return "You briefly pick up each shaker. They're both empty..."


				SubjectID.BREAKFAST:
					if kitchen.bowlState == Kitchen.HATCHED:
						if kitchen.playerHeldItem == Kitchen.PlayerHeldItem.CEREAL_BOWL:
							return "You're already holding that."
						elif kitchen.isCerealBowlInMicrowave:
							if not kitchen.isMicrowaveDoorOpen:
								return "You'll need to open the microwave first."
							elif kitchen.playerHeldItem != Kitchen.PlayerHeldItem.NONE:
								return "You're already carrying something. You'll need to put it down first."
							else:
								kitchen.takeCerealBowl()
								return "You pick up your breakfast!"
						elif kitchen.isCerealBowlOnFan or kitchen.isCerealBowlOnTable:
							if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.NONE:
								return "You're already carrying something. You'll need to put it down first."
							else:
								kitchen.takeCerealBowl()
								return "You pick up your breakfast!"
					else:
						return "You don't have any breakfast fully prepared yet... Keep going!"


		ActionID.REPLACE, ActionID.PUT:
			if actionID == ActionID.PUT and modifierID in [ModifierID.BACK, ModifierID.AWAY, ModifierID.DOWN]:
				modifierID = -1
			
			match subjectID:
				
				SubjectID.BLOCK_OF_ICE, SubjectID.STRATEGY_GUIDE when subjectID == SubjectID.BLOCK_OF_ICE or kitchen.isStrategyGuideFrozen:
					if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.FROZEN_STRATEGY_GUIDE:
						return "You're not holding that right now."
					match modifierID:
						-1:
							if kitchen.isTopFridgeDoorOpen:
								kitchen.putFrozenStrategyGuideInFridge()
								return "You put the " + subjectAlias + " back in the freezer."
							if kitchen.isOvenDoorOpen:
								kitchen.putFrozenStrategyGuideInOven()
								return "You put the " + subjectAlias + " in the oven."
							else:
								return wrongContextParse()
						ModifierID.IN_FREEZER:
							if kitchen.isTopFridgeDoorOpen:
								kitchen.putFrozenStrategyGuideInFridge()
								return "You put the " + subjectAlias + " back in the freezer."
							else:
								return "You'll need to open the freezer first."
						ModifierID.IN_FRIDGE:
							return "For some reason, it just feels wrong putting a block of ice in the refrigerator..."
						ModifierID.IN_OVEN:
							if kitchen.isOvenDoorOpen:
								kitchen.putFrozenStrategyGuideInOven()
								return "You put the " + subjectAlias + " in the oven."
							else:
								return "You'll need to open the over door first."
						ModifierID.IN_MICROWAVE:
							return "The block of ice is too big to fit in the microwave."
						ModifierID.IN_FRYING_PAN, ModifierID.ON_BACK_LEFT_BURNER, ModifierID.ON_BACK_RIGHT_BURNER,\
						ModifierID.ON_FRONT_LEFT_BURNER, ModifierID.ON_FRONT_RIGHT_BURNER, ModifierID.ON_AMBIGUOUS_BURNER:
							return "The block of ice is too big to fit in the frying pan, and you don't think it's a good idea to put it on a burner without it."
						ModifierID.ON_COUNTER:
							return "You don't like the idea of the ice melting all over your counter..."
						ModifierID.ON_TABLE:
							return "You don't have a coaster big enough for the ice..."


				SubjectID.ASHES, SubjectID.STRATEGY_GUIDE when subjectID == SubjectID.ASHES or kitchen.isStrategyGuideBurnt:
					if not kitchen.isStrategyGuideBurnt: return wrongContextParse()
					if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.ASHES:
						return "You're not carrying the ashes right now."
					match modifierID:
						-1:
							if kitchen.isOvenDoorOpen:
								kitchen.putBurntStrategyGuideInOven()
								return "You put the " + subjectAlias + " in the oven."
							else:
								kitchen.putAshesOnCounter()
								return "You put the " + subjectAlias + " on the counter."
						ModifierID.IN_OVEN:
							if kitchen.isOvenDoorOpen:
								kitchen.putBurntStrategyGuideInOven()
								return "You put the " + subjectAlias + " in the oven."
							else:
								return "You'll need to open the over door first."
						ModifierID.ON_COUNTER:
							kitchen.putAshesOnCounter()
							return "You put the " + subjectAlias + " on the counter."
						ModifierID.ON_TABLE:
							return "Your wooden table probably isn't the best place to put hot ashes."
						ModifierID.IN_FRIDGE, ModifierID.IN_FREEZER:
							return "The fridge is meant for cold things, and these ashes are hot, hot, hot!"
						ModifierID.IN_FRYING_PAN:
							if kitchen.isDemonSatisfied:
								return "The demon will ask for more ashes (loudly) if he wants them."
							elif kitchen.isEggInPan:
								kitchen.addAshes()
								return "You sprinkle some of the ashes on top of the egg."
							else:
								return "Ashes are one of those spices that go best on top of something, you know? Right now, the frying pan is empty."
						ModifierID.ON_EGGS:
							if kitchen.isDemonSatisfied:
								return "The demon will ask for more ashes (loudly) if he wants them."
							elif kitchen.isEggInPan:
								kitchen.addAshes()
								return "You sprinkle some of the ashes on top of the egg."
							else:
								return wrongContextParse()
						ModifierID.IN_MICROWAVE:
							return "You just cleaned out the microwave and don't want to get it dirty right now."


				SubjectID.STRATEGY_GUIDE:
					if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.THAWED_STRATEGY_GUIDE:
						return "You're not holding that right now."
					match modifierID:
						-1:
							if kitchen.isOvenDoorOpen:
								kitchen.putThawedStrategyGuideInOven()
								return "You put the " + subjectAlias + " in the oven."
							else:
								kitchen.putStrategyGuideOnCounter()
								return "You put the " + subjectAlias + " on the counter."
						ModifierID.IN_OVEN:
							if kitchen.isOvenDoorOpen:
								kitchen.putThawedStrategyGuideInOven()
								return "You put the " + subjectAlias + " in the oven."
							else:
								return "You'll need to open the over door first."
						ModifierID.ON_COUNTER:
							kitchen.putStrategyGuideOnCounter()
							return "You put the " + subjectAlias + " on the counter."
						ModifierID.ON_TABLE:
							kitchen.putStrategyGuideOnTable()
							return "You put the " + subjectAlias + " on the table."
						ModifierID.IN_FRIDGE, ModifierID.IN_FREEZER:
							return "You just finished thawing the strategy guide. Putting it back in the fridge would be counterproductive."
						ModifierID.IN_FRYING_PAN, ModifierID.IN_MICROWAVE:
							return "The strategy guide is supposed to help you cook, but not like that..."


				SubjectID.SPOON:
					if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.SPOON:
						return "You're not holding that right now."
					match modifierID:
						-1, ModifierID.IN_FRIDGE:
							if kitchen.isBottomFridgeDoorOpen:
								kitchen.putSpoonInFridge()
								return "You put the spoon back in the fridge."
							else:
								return "You can't return the spoon while the fridge door is closed."
						ModifierID.IN_BOWL:
							if kitchen.bowlState == Kitchen.HATCHED:
								return win()
							else:
								return "Your breakfast isn't ready to be eaten yet."
						ModifierID.IN_MICROWAVE:
							return "You may not be the deepest spoon in the drawer, but you know not to put one in the microwave."


				SubjectID.EGG:
					return attemptPlaceEgg(false)

				SubjectID.MILK:
					if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.MILK:
						return "You're not holding that right now."
					match modifierID:
						-1, ModifierID.IN_FRIDGE:
							if kitchen.isBottomFridgeDoorOpen:
								kitchen.putMilkBack()
								return "You put the milk back in the fridge."
							else:
								return "You can't return the milk while the fridge door is closed."
						ModifierID.IN_BOWL:
							if kitchen.bowlState == Kitchen.DIRTY:
								return "Gross! This bowl still needs to be washed."
							if not kitchen.bowlHasMilk:
								if kitchen.bowlState == Kitchen.CLEAN:
									kitchen.pourMilkInBowl()
									return "You pour the milk into the bowl first. A chill runs down your spine as you realize what you've just done."
								else:
									kitchen.pourMilkInBowl()
									return "You pour milk into the bowl."
							else:
								return "There's already plenty of milk in the bowl."
						ModifierID.IN_MICROWAVE:
							return "The milk jug doesn't fit in the microwave. Maybe you can heat up the milk in a different container?"
						ModifierID.IN_FRYING_PAN:
							return (
								"This wouldn't be the first time you made cereal in a frying pan to avoid washing the dishes, " +
								"but you promised yourself it would never happen again."
							)
						ModifierID.IN_SINK:
							return "How wasteful!"


				SubjectID.DINO_CEREAL_BOX, SubjectID.AMBIGUOUS_CEREAL_BOX:
					if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.CEREAL_BOX:
						return "You're not holding that right now."
					match modifierID:
						-1:
							if kitchen.isOvenDoorOpen:
								kitchen.putCerealInOven()
								return "You put the " + subjectAlias + " in the oven."
							else:
								kitchen.putCerealOnCounter()
								return "You put the " + subjectAlias + " on the counter."
						ModifierID.IN_OVEN:
							if kitchen.isOvenDoorOpen:
								kitchen.putCerealInOven()
								return "You put the " + subjectAlias + " in the oven."
							else:
								return "You'll need to open the over door first."
						ModifierID.ON_COUNTER:
							kitchen.putCerealOnCounter()
							return "You put the " + subjectAlias + " on the counter."
						ModifierID.ON_TABLE:
							kitchen.putCerealOnTable()
							return "You put the " + subjectAlias + " on the table."
						ModifierID.IN_BOWL:
							if kitchen.bowlState == Kitchen.DIRTY:
								return "Gross! This bowl still needs to be washed."
							if not kitchen.bowlHasCereal:
								if kitchen.bowlState == Kitchen.CLEAN:
									kitchen.pourCerealInBowl()
									return "You pour cereal into the bowl."
								else:
									kitchen.pourCerealInBowl()
									return (
										"Every fiber of your being resists as you force yourself to pour the cereal into the bowl after the milk. " +
										"You feel sick."
									)
							else:
								return "There's already plenty of cereal in the bowl."
						ModifierID.IN_FRYING_PAN:
							return (
								"This wouldn't be the first time you made cereal in a frying pan to avoid washing the dishes, " +
								"but you promised yourself it would never happen again."
							)
						ModifierID.IN_SINK:
							return "That would be wasteful!"

				SubjectID.CEREAL_BOWL:
					if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.CEREAL_BOWL:
						return "You're not holding that right now."
					match modifierID:
						-1, ModifierID.ON_TABLE:
							kitchen.putCerealBowlOnTable()
							return "You put the " + subjectAlias + " down on the table."
						ModifierID.ON_FAN:
							kitchen.putCerealBowlOnFan()
							return "You put the " + subjectAlias + " back on the fan."
						ModifierID.IN_MICROWAVE:
							if not kitchen.isMicrowaveDoorOpen:
								return "You need to open the microwave door first."
							else:
								kitchen.putCerealBowlInMicrowave()
								return "You put the " + subjectAlias + " in the microwave."
						ModifierID.IN_FRYING_PAN, ModifierID.ON_BACK_LEFT_BURNER, ModifierID.ON_BACK_RIGHT_BURNER,\
						ModifierID.ON_FRONT_LEFT_BURNER, ModifierID.ON_FRONT_RIGHT_BURNER, ModifierID.ON_AMBIGUOUS_BURNER, ModifierID.IN_OVEN:
							return "This plastic cereal bowl isn't rated for the kind of heat that the foodcinerator 9000 puts out..."
						ModifierID.IN_SINK:
							return "Your cereal bowl is clean enough for now."

				SubjectID.FORK:
					if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.FORK:
						return "You're not holding that right now."
					match modifierID:
						-1, ModifierID.IN_CUPBOARD:
							if kitchen.isMiddleRightCupboardOpen:
								kitchen.putForkBack()
								return "You put the fork back in the cupboard. Hopefully Cheeriofel never realized it was gone."
							else:
								return "You'll need to open up the cupboard under the sink first."
						ModifierID.IN_FRYING_PAN:
							if kitchen.isEggInPan:
								if kitchen.isEggScrambled:
									return "You've already scrambled the egg."
								else:
									kitchen.scrambleEgg()
									return "You rough the egg up something good. That'll show it!"
							else:
								return wrongContextParse()
						ModifierID.IN_BOWL:
							return "That's not how civilized people eat cereal."
						ModifierID.IN_MICROWAVE:
							return "You may not be the pointiest fork in the drawer, but you know not to put one in the microwave."


				SubjectID.FRYING_PAN:
					if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.FRYING_PAN:
						return "You're not holding that right now."
					match modifierID:
						-1:
							kitchen.putFryingPanBack()
						ModifierID.ON_FRONT_LEFT_BURNER:
							kitchen.putFryingPanBack()
							kitchen.moveFryingPan(Kitchen.FRONT_LEFT)
							return "You set the frying pan down on the front left burner."
						ModifierID.ON_FRONT_RIGHT_BURNER:
							kitchen.putFryingPanBack()
							kitchen.moveFryingPan(Kitchen.FRONT_RIGHT)
							return "You set the frying pan down on the front right burner."
						ModifierID.ON_BACK_LEFT_BURNER:
							kitchen.putFryingPanBack()
							kitchen.moveFryingPan(Kitchen.BACK_LEFT)
							return "You set the frying pan down on the back left burner."
						ModifierID.ON_BACK_RIGHT_BURNER:
							kitchen.putFryingPanBack()
							kitchen.moveFryingPan(Kitchen.BACK_RIGHT)
							return "You set the frying pan down on the back right burner."
						ModifierID.ON_AMBIGUOUS_BURNER:
							return requestAdditionalContextCustom("Which burner would you like to set the pan on?", REQUEST_SUBJECT, [], [" burner"])
						ModifierID.ON_PENTAGRAM:
							return attemptFeedDemon()
						ModifierID.IN_MICROWAVE:
							return "The frying pan doesn't fit in the microwave."
						ModifierID.IN_SINK:
							return (
								"You heard somewhere that you're not supposed to wash cast iron pans. " +
								"You're not sure if this pan is cast iron or not, but it's easier to just assume that it is and never wash it."
							)

				


		ActionID.USE:
			return requestSpecificAction()


		ActionID.OPEN:
			
			if kitchen.arePlayersHandsFull:
				return "Your hands are a bit full at the moment..."
			
			match subjectID:

				SubjectID.TOP_LEFT_CUPBOARD:
					if kitchen.isTopLeftCupboardOpen:
						return "That cupboard is already open."
					else:
						kitchen.openTopLeftCupboard()
						return "You open the cupboard above the microwave."

				SubjectID.BOTTOM_LEFT_CUPBOARD:
					if kitchen.isBottomLeftCupboardOpen:
						return "That cupboard is already open."
					else:
						kitchen.openBottomLeftCupboard()
						return "You open the cupboard below the microwave."

				SubjectID.MIDDLE_LEFT_CUPBOARD:
					if kitchen.isMiddleLeftCupboardOpen:
						return "That cupboard is already open."
					else:
						kitchen.openMiddleLeftCupboard()
						return "You open the left cupboard below the sink."

				SubjectID.MIDDLE_RIGHT_CUPBOARD:
					if kitchen.isMiddleRightCupboardOpen:
						return "That cupboard is already open."
					else:
						kitchen.openMiddleRightCupboard()
						return "You open the right cupboard below the sink."

				SubjectID.MIDDLE_CUPBOARDS:
					if kitchen.isMiddleLeftCupboardOpen and kitchen.isMiddleRightCupboardOpen:
						return "Those cupboards are already open."
					else:
						if not kitchen.isMiddleLeftCupboardOpen: kitchen.openMiddleLeftCupboard()
						if not kitchen.isMiddleRightCupboardOpen: kitchen.openMiddleRightCupboard()
						return "You open the cupboards below the sink."

				SubjectID.BOTTOM_RIGHT_CUPBOARD:
					if kitchen.isBottomRightCupboardOpen:
						return "That cupboard is already open."
					else:
						kitchen.openBottomRightCupboard()
						return "You open the cupboard next to the oven."

				SubjectID.BOTTOM_CUPBOARD:
					if (
						kitchen.isBottomLeftCupboardOpen and kitchen.isMiddleLeftCupboardOpen and
						kitchen.isMiddleRightCupboardOpen and kitchen.isBottomRightCupboardOpen
					):
						return "Those cupboards are already open."
					else:
						if not kitchen.isBottomLeftCupboardOpen: kitchen.openBottomLeftCupboard()
						if not kitchen.isMiddleLeftCupboardOpen: kitchen.openMiddleLeftCupboard()
						if not kitchen.isMiddleRightCupboardOpen: kitchen.openMiddleRightCupboard()
						if not kitchen.isBottomRightCupboardOpen: kitchen.openBottomRightCupboard()
						return "You open the cupboards below the counter."

				SubjectID.AMBIGUOUS_CUPBOARD:
					return requestAdditionalContextCustom("Which cupboard would you like to " + actionAlias + "?", REQUEST_SUBJECT, [], [" cupboard"])

				SubjectID.TOP_DRAWER:
					if kitchen.isTopDrawerOpen:
						return "That drawer is already open."
					else:
						kitchen.openTopDrawer()
						return "You open the top drawer."

				SubjectID.MIDDLE_DRAWER:
					if kitchen.isMiddleDrawerOpen:
						return "That drawer is already open."
					else:
						kitchen.openMiddleDrawer()
						return "You open the middle drawer."

				SubjectID.BOTTOM_DRAWER:
					if kitchen.isBottomDrawerOpen:
						return "That drawer is already open."
					else:
						kitchen.openBottomDrawer()
						return "You open the bottom drawer."

				SubjectID.AMBIGUOUS_DRAWER:
					return requestAdditionalContextCustom("Which cupboard would you like to " + actionAlias + "?", REQUEST_SUBJECT, [], [" cupboard"])


				SubjectID.MICROWAVE:
					if kitchen.isMicrowaveDoorOpen:
						return "The microwave is already open."
					elif kitchen.isVaporInMicrowave:
						SceneManager.transitionToScene(
							SceneManager.SceneID.ENDING,
							"Strange... After heating up the milk this time, there seems to be a light green fog filling your microwave. " +
							"You open the door to get a better look, and the compressed milk vapors erupt into the room, stinging your eyes and clawing at " +
							"the back of your throat. You start coughing uncontrollably, and a faint mooing begins sounding in your ears. You " +
							"hobble over to the oven and desperately try to turn on the fume hood. " +
							"However, with your vision obscured you accidentally turn on the stove instead, " +
							"and as luck would have it, these milk fumes are flammable too...",
							SceneManager.EndingID.EVAPORATED_MILK
						)
						return ""
					else:
						kitchen.openMicrowaveDoor()
						return "You open the microwave door."


				SubjectID.TOP_FRIDGE_DOOR, SubjectID.FREEZER:
					if kitchen.isTopFridgeDoorOpen:
						return "The freezer is already open."
					else:
						kitchen.openTopFridgeDoor()
						return "You open up the freezer."

				SubjectID.BOTTOM_FRIDGE_DOOR, SubjectID.FRIDGE:
					if kitchen.isBottomFridgeDoorOpen:
						return "The refrigerator is already open."
					elif kitchen.isFridgeUnlocked:
						kitchen.openBottomFridgeDoor()
						return "You open up the refrigerator."
					else:
						return "You tug on the refrigerator door, but it's locked shut. You'll need to unlock it first."


				SubjectID.OVEN:
					if kitchen.isOvenDoorOpen:
						return "The oven door is already open."
					elif kitchen.isOvenOn:
						SceneManager.transitionToScene(
							SceneManager.SceneID.ENDING,
							"The Foodcinerator 9000 is still running at full power when you decide to open the door. " +
							"The heat that radiates out hits you with force of a raging bonfire, scorching your clothes and " +
							"singing what little hair you have left. There's hardly even time for you to panic before your " +
							"kitchen is consumed by the growing blaze...",
							SceneManager.EndingID.KITCHENCINERATOR
						)
						return ""
					else:
						kitchen.openOvenDoor()
						return "You open the oven door."


				SubjectID.EGG:
					return attemptPlaceEgg(true)


		ActionID.CLOSE:

			if kitchen.arePlayersHandsFull:
				return "Your hands are a bit full at the moment..."
			
			match subjectID:

				SubjectID.TOP_LEFT_CUPBOARD:
					if not kitchen.isTopLeftCupboardOpen:
						return "That cupboard is already closed."
					else:
						kitchen.closeTopLeftCupboard()
						return "You close the cupboard above the microwave."

				SubjectID.BOTTOM_LEFT_CUPBOARD:
					if not kitchen.isBottomLeftCupboardOpen:
						return "That cupboard is already closed."
					else:
						kitchen.closeBottomLeftCupboard()
						return "You close the cupboard below the microwave."

				SubjectID.MIDDLE_LEFT_CUPBOARD:
					if not kitchen.isMiddleLeftCupboardOpen:
						return "That cupboard is already closed."
					else:
						kitchen.closeMiddleLeftCupboard()
						return "You close the left cupboard below the sink."

				SubjectID.MIDDLE_RIGHT_CUPBOARD:
					if not kitchen.isMiddleRightCupboardOpen:
						return "That cupboard is already closed."
					else:
						kitchen.closeMiddleRightCupboard()
						return "You close the right cupboard below the sink."

				SubjectID.MIDDLE_CUPBOARDS:
					if not kitchen.isMiddleLeftCupboardOpen and not kitchen.isMiddleRightCupboardOpen:
						return "Those cupboards are already closed."
					else:
						if kitchen.isMiddleLeftCupboardOpen: kitchen.closeMiddleLeftCupboard()
						if kitchen.isMiddleRightCupboardOpen: kitchen.closeMiddleRightCupboard()
						return "You close the cupboards below the sink."

				SubjectID.BOTTOM_RIGHT_CUPBOARD:
					if not kitchen.isBottomRightCupboardOpen:
						return "That cupboard is already closed."
					else:
						kitchen.closeBottomRightCupboard()
						return "You close the cupboard next to the oven."

				SubjectID.BOTTOM_CUPBOARD:
					if (
						not kitchen.isBottomLeftCupboardOpen and not kitchen.isMiddleLeftCupboardOpen and
						not kitchen.isMiddleRightCupboardOpen and not kitchen.isBottomRightCupboardOpen
					):
						return "Those cupboards are already closed."
					else:
						if kitchen.isBottomLeftCupboardOpen: kitchen.closeBottomLeftCupboard()
						if kitchen.isMiddleLeftCupboardOpen: kitchen.closeMiddleLeftCupboard()
						if kitchen.isMiddleRightCupboardOpen: kitchen.closeMiddleRightCupboard()
						if kitchen.isBottomRightCupboardOpen: kitchen.closeBottomRightCupboard()
						return "You close the cupboards below the counter."

				SubjectID.AMBIGUOUS_CUPBOARD:
					return requestAdditionalContextCustom("Which cupboard would you like to " + actionAlias + "?", REQUEST_SUBJECT, [], [" cupboard"])

				SubjectID.TOP_DRAWER:
					if not kitchen.isTopDrawerOpen:
						return "That drawer is already closed."
					else:
						kitchen.closeTopDrawer()
						return "You close the top drawer."

				SubjectID.MIDDLE_DRAWER:
					if not kitchen.isMiddleDrawerOpen:
						return "That drawer is already closed."
					else:
						kitchen.closeMiddleDrawer()
						return "You close the middle drawer."

				SubjectID.BOTTOM_DRAWER:
					if not kitchen.isBottomDrawerOpen:
						return "That drawer is already closed."
					else:
						kitchen.closeBottomDrawer()
						return "You close the bottom drawer."

				SubjectID.AMBIGUOUS_DRAWER:
					return requestAdditionalContextCustom("Which cupboard would you like to " + actionAlias + "?", REQUEST_SUBJECT, [], [" cupboard"])


				SubjectID.MICROWAVE:
					if not kitchen.isMicrowaveDoorOpen:
						return "The microwave is already closed."
					else:
						kitchen.closeMicrowaveDoor()
						return "You close the microwave door."


				SubjectID.TOP_FRIDGE_DOOR, SubjectID.FREEZER:
					if not kitchen.isTopFridgeDoorOpen:
						return "The freezer is already closed."
					else:
						kitchen.closeTopFridgeDoor()
						return "You close the freezer."

				SubjectID.BOTTOM_FRIDGE_DOOR, SubjectID.FRIDGE:
					if not kitchen.isBottomFridgeDoorOpen:
						return "The refrigerator is already closed."
					else:
						kitchen.closeBottomFridgeDoor()
						return "You close the refrigerator."


				SubjectID.OVEN:
					if not kitchen.isOvenDoorOpen:
						return "The oven door is already closed."
					else:
						kitchen.closeOvenDoor()
						return "You close the oven door."


		ActionID.TURN_ON, ActionID.TURN when actionID == ActionID.TURN_ON or (actionID == ActionID.TURN and modifierID == ModifierID.ON):

			if wildCard and subjectID != SubjectID.MICROWAVE: return unrecognizedEndingParse()

			match subjectID:

				SubjectID.ZOOMBA:
					return "Zoomba is already on."

				SubjectID.MICROWAVE:
					return attemptUseMicrowave()

				SubjectID.TIMER:
					if kitchen.isTimerOn:
						return "The timer is already on."
					else:
						kitchen.turnTimerOn()
						return "You turn the timer back on, and it looks like the backup circuits have preserved the proper time even while it was off."

				SubjectID.FAN:
					return "You don't need to dry anything right now."

				SubjectID.SINK, SubjectID.FAUCET:
					return attemptCleanBowl()

				SubjectID.OVEN:
					return attemptTurnOnOven()

				SubjectID.FUME_HOOD:
					return "There's no need. You're not cooking anything especially fragrant for breakfast."

				SubjectID.STOVE_TOP, SubjectID.AMBIGUOUS_BURNER:
					return requestAdditionalContextCustom("Which burner do you want to turn on?", REQUEST_SUBJECT, [], [" burner"])

				SubjectID.FRONT_LEFT_BURNER:
					return attemptTurnOnBurner(Kitchen.FRONT_LEFT)

				SubjectID.BACK_LEFT_BURNER:
					return attemptTurnOnBurner(Kitchen.BACK_LEFT)

				SubjectID.BACK_RIGHT_BURNER:
					return attemptTurnOnBurner(Kitchen.BACK_RIGHT)

				SubjectID.FRONT_RIGHT_BURNER:
					return attemptTurnOnBurner(Kitchen.FRONT_RIGHT)
				


		ActionID.TURN_OFF, ActionID.TURN when actionID == ActionID.TURN_OFF or (actionID == ActionID.TURN and modifierID == ModifierID.OFF):
			
			if wildCard: return unrecognizedEndingParse()

			match subjectID:

				SubjectID.ZOOMBA:
					return "Zoomba's just loving life right now. It wouldn't be right to stop him."

				SubjectID.MICROWAVE, SubjectID.OUTLET:
					return "The quantum microwave has a 30-minute boot cycle, so it's really not worth turning off."

				SubjectID.TIMER:
					if not kitchen.isTimerOn:
						return "The timer is already off."
					else:
						kitchen.turnTimerOn()
						return (
							"You turn the display on the timer off. " +
							"The backup circuits should still keep track of the proper time, but now you won't be distracted by it."
						)

				SubjectID.FAN:
					return "The fan isn't on right now."

				SubjectID.SINK, SubjectID.FAUCET:
					return "The water's not running right now."

				SubjectID.OVEN:
					if kitchen.isOvenOn:
						kitchen.turnOvenOff()
						if kitchen.isStrategyGuideInOven:
							if kitchen.isStrategyGuideBurnt:
								return "You turn off the oven. The strategy guide has been reduced to a pile of smoldering ashes."
							else:
								return "You turn off the oven. The strategy guide has been freed from its icy prison!"
						else:
							return "You turn the oven off."
					else:
						return "The oven isn't on right now."

				SubjectID.FUME_HOOD:
					return "The fume hood isn't on right now."

				SubjectID.STOVE_TOP, SubjectID.AMBIGUOUS_BURNER:
					if kitchen.activeBurner == kitchen.NONE:
						return "None of the burners on the stove top are currently active."
					else:
						return attemptTurnOffBurner(kitchen.activeBurner)

				SubjectID.FRONT_LEFT_BURNER:
					return attemptTurnOffBurner(kitchen.FRONT_LEFT)

				SubjectID.BACK_LEFT_BURNER:
					return attemptTurnOffBurner(kitchen.BACK_LEFT)

				SubjectID.BACK_RIGHT_BURNER:
					return attemptTurnOffBurner(kitchen.BACK_RIGHT)

				SubjectID.FRONT_RIGHT_BURNER:
					return attemptTurnOffBurner(kitchen.FRONT_RIGHT)


		ActionID.PET:
			kitchen.movePlayer(Kitchen.PlayerPos.ZOOMBA)
			return "You reach down and pet Zoomba lovingly. His motor whirrs contentedly."


		ActionID.FLIP:
			if subjectID == SubjectID.LARRY_LIGHT_SWITCH:
				if kitchen.isTimeReverting:
					return "Larry is already performing his magic. The thought of disturbing him now terrifies you."
				elif kitchen.hasTimeReverted:
					return "Larry has already blessed you with his power once. You don't want to push your luck."
				else:
					kitchen.flipLarryTheLightSwitch()
					return (
						"You're so close to completing your breakfast, but you need more time... There's no way around it. You need to call upon " +
						"the eldritch might of Larry the Light Switch. You glance over at the switch below your kitchen timer where space seems to " +
						"bend inward. You take a deep breath, and reach into the anomaly, hoping that Larry is feeling merciful today. " +
						"You feel your stomach turn and your vision blurs as time bends around you. In an instant, things are back to normal, but " +
						"a quick glance at the kitchen timer reveals that Larry is on your side today! You have the time you need now!"
					)
			elif subjectID == SubjectID.AMBIGUOUS_LIGHT_SWITCH:
				kitchen.movePlayer(Kitchen.PlayerPos.MIDDLE_RIGHT_CUPBOARD)
				return "You absent mindedly flip the switch by the sink on and off. It doesn't do anything."


		ActionID.INPUT:
			if subjectID == SubjectID.MICROWAVE:
				return attemptUseMicrowave()

			elif subjectID in [SubjectID.BLUE_BUTTON, SubjectID.GREEN_BUTTON, SubjectID.RED_BUTTON, SubjectID.YELLOW_BUTTON, SubjectID.AMBIGUOUS_BUTTON]:
				if wildCard: return unrecognizedEndingParse()
				else: return attemptInputFridgeButton(subjectID)


		ActionID.INPUT_DOOR_CODE, ActionID.INPUT_CODE_AMBIGUOUS when not kitchen.isBottomFridgeDoorOpen:
			if wildCard: return unrecognizedEndingParse()
			if subjectID == -1: subjectID = SubjectID.AMBIGUOUS_BUTTON
			if subjectID in [SubjectID.BLUE_BUTTON, SubjectID.GREEN_BUTTON, SubjectID.RED_BUTTON, SubjectID.YELLOW_BUTTON, SubjectID.AMBIGUOUS_BUTTON]:
				return attemptInputFridgeButton(subjectID)

		ActionID.INPUT_MILK_CODE, ActionID.INPUT_CODE_AMBIGUOUS when kitchen.isBottomFridgeDoorOpen:
			if subjectID != -1: return wrongContextParse()
			return attemptInputMilkCode()


		ActionID.UNLOCK:
			if subjectID in [SubjectID.MILK, SubjectID.LOCK]:
				return attemptInputMilkCode()
			elif subjectID == SubjectID.IMPRISONED_CEREAL_BOX:
				if kitchen.isBottomRightCupboardOpen:
					return "You can't release the prisoner until they've finished serving their sentence."
				else:
					return wrongContextParse()


		ActionID.LOCK:
			if subjectID == SubjectID.MILK:
				if not kitchen.isBottomFridgeDoorOpen:
					return wrongContextParse()
				elif kitchen.playerHeldItem == Kitchen.PlayerHeldItem.MILK:
					return "You need to put down the milk first."
				elif kitchen.isMilkUnlocked:
					kitchen.lockMilk()
					return "You take milk security very seriously, so you lock the milk back up now that you're done with it."
				else:
					return "The milk is already locked to the side of the fridge."


		ActionID.WEAR:
			if subjectID == SubjectID.EGG:
				if kitchen.isPlayerWearingEgg:
					return "You've already got an egg."
				elif not kitchen.isBottomFridgeDoorOpen:
					return wrongContextParse()
				elif kitchen.isEggInPan or kitchen.isEggOnFloor:
					kitchen.movePlayer(Kitchen.PlayerPos.FRIDGE)
					return "You've already taken an egg."
				else:
					kitchen.takeEggFromFridge()
					return "You take an egg and balance it carefully on your head."


		ActionID.COUNT:
			match subjectID:

				SubjectID.EGG:
					if not kitchen.isBottomFridgeDoorOpen:
						return wrongContextParse()
					elif kitchen.isPlayerWearingEgg:
						kitchen.movePlayer(Kitchen.PlayerPos.FRIDGE)
						return (
							"You count " + str(kitchen.eggNum-1) + " " + Helpers.singularOrPlural(kitchen.eggNum-1, "egg", "eggs") +
							" in the fridge, plus the 1 on your head."
						)
					elif kitchen.isEggInPan:
						kitchen.movePlayer(Kitchen.PlayerPos.FRIDGE)
						return (
							"You count " + str(kitchen.eggNum-1) + " " + Helpers.singularOrPlural(kitchen.eggNum-1, "egg", "eggs") +
							" in the fridge, plus the 1 you put in the pan."
						)
					elif kitchen.isEggOnFloor:
						kitchen.movePlayer(Kitchen.PlayerPos.FRIDGE)
						return "THIS SHOULD TRIGGER THE EGG ENDING. IF YOU'RE SEEING THIS TEXT, SOMETHING WENT WRONG."
					else:
						kitchen.movePlayer(Kitchen.PlayerPos.FRIDGE)
						return "You count " + str(kitchen.eggNum) + " eggs in the fridge."

				SubjectID.SPOON:
					if not kitchen.isBottomFridgeDoorOpen:
						return wrongContextParse()
					elif kitchen.playerHeldItem == Kitchen.PlayerHeldItem.SPOON:
						kitchen.movePlayer(Kitchen.PlayerPos.FRIDGE)
						return (
							"You count " + str(kitchen.spoonNum-1) + " " + Helpers.singularOrPlural(kitchen.spoonNum-1, "spoon", "spoons") +
							" in the fridge, plus the 1 you're holding."
						)
					else:
						kitchen.movePlayer(Kitchen.PlayerPos.FRIDGE)
						return "You count " + str(kitchen.spoonNum) + " spoons in the fridge."

				SubjectID.GRAPEFRUIT_JUICE:
					if not kitchen.isBottomFridgeDoorOpen:
						return wrongContextParse()
					else:
						kitchen.movePlayer(Kitchen.PlayerPos.FRIDGE)
						return (
							"You count " + str(kitchen.grapefruitJuiceNum) + " " +
							Helpers.singularOrPlural(kitchen.grapefruitJuiceNum, "carton", "cartons") + " of grapefruit juice in the fridge."
						)


		ActionID.HEAT:
			match subjectID:

				SubjectID.MICROWAVE:
					if modifierID != -1: return unknownParse()
					return attemptUseMicrowave()

				SubjectID.BLOCK_OF_ICE, SubjectID.STRATEGY_GUIDE when subjectID == SubjectID.BLOCK_OF_ICE or kitchen.isStrategyGuideFrozen:
					if wildCard: return unrecognizedEndingParse()

					if (not kitchen.isStrategyGuideFrozen) or (kitchen.isStrategyGuideInFridge and not kitchen.isTopFridgeDoorOpen):
						return wrongContextParse()
					if modifierID == ModifierID.IN_FRYING_PAN or modifierID == ModifierID.IN_MICROWAVE:
						return "It doesn't look like the " + subjectAlias + "will fit in there..."
					elif not kitchen.isStrategyGuideInOven:
						if modifierID == ModifierID.IN_OVEN:
							return "You'll need to put the " + subjectAlias + " in the oven first."
						else:
							return "You can't " + reconstructCommand() + " in its current state. Maybe you could make use of one of the kitchen appliances?"
					else:
						return attemptTurnOnOven()

				SubjectID.ASHES, SubjectID.STRATEGY_GUIDE when subjectID == SubjectID.ASHES or kitchen.isStrategyGuideBurnt:
					if wildCard: return unrecognizedEndingParse()
					
					if not kitchen.isStrategyGuideBurnt:
						return wrongContextParse()
					else:
						return "There's no need to heat the strategy guide up anymore. It's already burnt to a crisp..."

				SubjectID.STRATEGY_GUIDE:
					if wildCard: return unrecognizedEndingParse()

					if modifierID == ModifierID.IN_FRYING_PAN or modifierID == ModifierID.IN_MICROWAVE:
						return "The strategy guide is supposed to help you cook, but not like that..."
					if not kitchen.isStrategyGuideInOven:
						if modifierID == ModifierID.IN_OVEN:
							return "You'll need to put the " + subjectAlias + " in the oven first."
						else:
							return "You can't " + reconstructCommand() + " in its current state. Maybe you could make use of one of the kitchen appliances?"
					else:
						return attemptTurnOnOven()

				SubjectID.EGG:
					if wildCard: return unrecognizedEndingParse()

					if kitchen.isDemonSatisfied or kitchen.isEggOnFloor:
						return wrongContextParse()
					elif not kitchen.isBottomFridgeDoorOpen and not (kitchen.isPlayerWearingEgg or kitchen.isEggInPan):
						return wrongContextParse()
					elif kitchen.isEggInPan and kitchen.playerHeldItem != Kitchen.PlayerHeldItem.FRYING_PAN:
						if kitchen.activeBurner != Kitchen.NONE:
							return "The egg is already frying."
						else:
							return attemptTurnOnBurner(kitchen.ovenFryingPanPos)
					else:
						if modifierID == ModifierID.IN_FRYING_PAN:
							return "You'll need to put the " + subjectAlias + " in the frying pan first."
						elif modifierID == -1:
							return "You can't " + reconstructCommand() + " in its current state. Maybe you could make use of one of the kitchen appliances?"
						else:
							return "That's not how you cook an egg. You'd think an \"egg head\" like you would know that!"

				SubjectID.MILK:
					if wildCard and modifierID != ModifierID.IN_MICROWAVE and (not kitchen.isCerealBowlInMicrowave or not kitchen.bowlHasMilk):
						return unrecognizedEndingParse()
					
					if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.MILK and not kitchen.bowlHasMilk and not kitchen.isBottomFridgeDoorOpen:
						return wrongContextParse()
					elif kitchen.playerHeldItem == Kitchen.PlayerHeldItem.MILK or (not kitchen.bowlHasMilk and kitchen.isBottomFridgeDoorOpen):
						return "There's a warning on the milk jug that says not to heat the milk in this container."
					elif kitchen.bowlHasMilk:
						if modifierID in [ModifierID.IN_OVEN, ModifierID.IN_FRYING_PAN]:
							return "This plastic cereal bowl isn't rated for the kind of heat that the foodcinerator 9000 puts out..."
						elif kitchen.isCerealBowlInMicrowave:
							return attemptUseMicrowave()
						elif modifierID == ModifierID.IN_MICROWAVE:
							return "You'll need to put the " + subjectAlias + " in the microwave first."
						else:
							return "You can't " + reconstructCommand() + " in its current state. Maybe you could make use of one of the kitchen appliances?"

				SubjectID.CEREAL_BOWL:
					if wildCard and modifierID != ModifierID.IN_MICROWAVE and not kitchen.isCerealBowlInMicrowave:
						return unrecognizedEndingParse()
					
					if modifierID in [ModifierID.IN_OVEN, ModifierID.IN_FRYING_PAN]:
						return "This plastic cereal bowl isn't rated for the kind of heat that the foodcinerator 9000 puts out..."
					elif kitchen.isCerealBowlInMicrowave:
						return attemptUseMicrowave()
					elif modifierID == ModifierID.IN_MICROWAVE:
						return "You'll need to put the " + subjectAlias + " in the microwave first."
					else:
						return "You can't " + reconstructCommand() + " in its current state. Maybe you could make use of one of the kitchen appliances?"

				SubjectID.OVEN:
					if wildCard: return unrecognizedEndingParse()
					if modifierID != -1: return unknownParse()
					return attemptTurnOnOven()

				SubjectID.FRYING_PAN:
					if wildCard: return unrecognizedEndingParse()
					if modifierID != -1: return unknownParse()

					if kitchen.isDemonSatisfied: return wrongContextParse()
					elif kitchen.playerHeldItem == Kitchen.PlayerHeldItem.FRYING_PAN:
						return "You'll need to put the frying pan on the stove first."
					elif kitchen.activeBurner != Kitchen.NONE:
						return "The frying pan is already on an active burner."
					else:
						return attemptTurnOnBurner(kitchen.ovenFryingPanPos)

				SubjectID.FRONT_LEFT_BURNER:
					if wildCard: return unrecognizedEndingParse()
					if modifierID != -1: return unknownParse()
					else: return attemptTurnOnBurner(Kitchen.FRONT_LEFT)

				SubjectID.BACK_LEFT_BURNER:
					if wildCard: return unrecognizedEndingParse()
					if modifierID != -1: return unknownParse()
					else: return attemptTurnOnBurner(Kitchen.BACK_LEFT)

				SubjectID.BACK_RIGHT_BURNER:
					if wildCard: return unrecognizedEndingParse()
					if modifierID != -1: return unknownParse()
					else: return attemptTurnOnBurner(Kitchen.BACK_RIGHT)

				SubjectID.FRONT_RIGHT_BURNER:
					if wildCard: return unrecognizedEndingParse()
					if modifierID != -1: return unknownParse()
					else: return attemptTurnOnBurner(Kitchen.FRONT_RIGHT)

				SubjectID.AMBIGUOUS_BURNER:
					if wildCard: return unrecognizedEndingParse()
					if modifierID != -1: return unknownParse()
					else: return requestAdditionalContextCustom("Which burner would you like to " + actionAlias + "?", REQUEST_SUBJECT, [], [" burner"])


		ActionID.PREHEAT:
			if subjectID == SubjectID.OVEN:
				return "The Foodcinerator 9000 has no need for a puny preheat button. Just turn it on!"


		ActionID.FEED:
			
			if subjectID == SubjectID.DEMON:
				return attemptFeedDemon()
			
			elif (
				subjectID in [SubjectID.EGG, SubjectID.MILK, SubjectID.FRYING_PAN, SubjectID.ASHES, SubjectID.DINO_CEREAL_BOX, SubjectID.AMBIGUOUS_CEREAL_BOX] and
				modifierID == -1
			):
				return requestAdditionalModifierContext("What", "to", ["to "])
			
			elif modifierID == ModifierID.TO_DEMON:
				match subjectID:
					SubjectID.EGG: return attemptFeedDemon(EGG)
					SubjectID.MILK: return attemptFeedDemon(MILK)
					SubjectID.FRYING_PAN: return attemptFeedDemon(FRYING_PAN)
					SubjectID.ASHES: return attemptFeedDemon(ASHES)
					SubjectID.DINO_CEREAL_BOX, SubjectID.AMBIGUOUS_CEREAL_BOX: return attemptFeedDemon(CEREAL)


		ActionID.WASH:
			if subjectID == SubjectID.CEREAL_BOWL: return attemptCleanBowl()


		ActionID.EXORCISE:
			if subjectID == SubjectID.DEMON:
				if not kitchen.isMiddleLeftCupboardOpen: 
					return wrongContextParse() + " (You need to open the cupboard under the sink first.)"
				else: return "You've been meaning to call Father Kellogg to get the demon exorcised, but you haven't gotten around to it yet."


		ActionID.SCRAMBLE:
			if subjectID == SubjectID.EGG:
				if kitchen.isEggInPan:
					if kitchen.isEggScrambled:
						return "You've already scrambled the egg."
					elif kitchen.playerHeldItem != Kitchen.PlayerHeldItem.FORK:
						return "You're not holding anything you can use to " + reconstructCommand() + "." 
					else:
						kitchen.scrambleEgg()
						return "You rough the egg up something good. That'll show it!"
				else:
					return wrongContextParse()


		ActionID.SCATTER:
			if modifierID == -1: return requestAdditionalModifierContext("Where", "", ["on "])
			if subjectID == SubjectID.ASHES:
				if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.ASHES:
					return "You're not carrying the ashes now."
				elif kitchen.isDemonSatisfied:
					return "The demon will ask for more ashes (loudly) if he wants them."
				elif kitchen.isEggInPan:
					kitchen.addAshes()
					return "You sprinkle some of the ashes on top of the egg."
				else:
					return wrongContextParse()


		ActionID.GARNISH:
			if modifierID == -1: return requestAdditionalModifierContext("What", "with", ["with "])
			if subjectID == SubjectID.EGG and modifierID == ModifierID.WITH_ASHES:
				if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.ASHES:
					return "You're not carrying the ashes now."
				elif kitchen.isDemonSatisfied:
					return "The demon will ask for more ashes (loudly) if he wants them."
				elif kitchen.isEggInPan:
					kitchen.addAshes()
					return "You sprinkle some of the ashes on top of the egg."
				else:
					return wrongContextParse()


		ActionID.POUR:
			match subjectID:

				SubjectID.DINO_CEREAL_BOX, SubjectID.AMBIGUOUS_CEREAL_BOX:
					if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.CEREAL_BOX:
						return "You're not carrying any cereal with you."
					elif modifierID == -1:
						return requestAdditionalModifierContext("Where", "", ["in ", "on "])
					elif modifierID == ModifierID.ON_FLOOR or modifierID == ModifierID.IN_SINK:
						return "That would be wasteful!"
					elif modifierID == ModifierID.IN_FRYING_PAN:
						return (
							"This wouldn't be the first time you made cereal in a frying pan to avoid washing the dishes, " +
							"but you promised yourself it would never happen again."
						)
					elif modifierID == ModifierID.IN_BOWL:
						if kitchen.bowlState == Kitchen.DIRTY:
							return "Gross! This bowl still needs to be washed."
						elif not kitchen.bowlHasCereal:
							if kitchen.bowlState == Kitchen.CLEAN:
								kitchen.pourCerealInBowl()
								return "You pour cereal into the bowl."
							else:
								kitchen.pourCerealInBowl()
								return (
									"Every fiber of your being resists as you force yourself to pour the cereal into the bowl after the milk. " +
									"You feel sick."
								)
						else:
							return "There's already plenty of cereal in the bowl."

				SubjectID.MILK:
					if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.MILK:
						return "You don't have any milk with you."

					match modifierID:

						ModifierID.ON_FLOOR, -1:
							SceneManager.transitionToScene(
								SceneManager.SceneID.ENDING,
								"You're meandering around the kitchen, milk in hand, when you suddenly feel a chill go down your spine, " +
								"and an uncontrollable impulse washes over you, as though you were just given an irresistible command by some higher being... " +
								"Without warning, you tear the lid off the milk and flip it upside down, spilling it all over the kitchen floor. " +
								"By the time you've snapped back to your senses, you're standing in a sizeable puddle of Cow Planet's finest export. " +
								"At first, you stare blankly at the scene before you, unable to comprehend what you've done. " +
								"Then, the full scale of the tragedy snaps into focus, and you feel tears welling up in your eyes, a sharp pain in your chest. " +
								"\"MY MIIIIIILLKKKKK!!\" you scream hysterically. \"MY PRECIOUS MIIIIIIIIIIILLLKKK!!!!\" You're flying into a fit of rage now, " +
								"and nothing is safe. You slam your head into the fridge door, starting the security system's self destruct sequence. " +
								"You kick in the glass door on the oven, which roars to life as you smash a fist into the controls. " +
								"Not even the microwave is safe from your tantrum, as you rip out exposed wires, sending out showers of white-hot sparks. " +
								"You keep going, screaming and sobbing and seething, until the destruction around you " +
								"mirrors the turmoil in your heart... Why did you spill your milk!? WHY!?!?!?",
								SceneManager.EndingID.CRYING_OVER_SPILLED_MILK
							)
							return ""
						ModifierID.IN_BOWL:
							if kitchen.bowlState == Kitchen.DIRTY:
								return "Gross! This bowl still needs to be washed."
							if not kitchen.bowlHasMilk:
								if kitchen.bowlState == Kitchen.CLEAN:
									kitchen.pourMilkInBowl()
									return "You pour the milk into the bowl first. A chill runs down your spine as you realize what you've just done."
								else:
									kitchen.pourMilkInBowl()
									return "You pour milk into the bowl."
							else:
								return "There's already plenty of milk in the bowl."
						ModifierID.IN_FRYING_PAN:
							return (
								"This wouldn't be the first time you made cereal in a frying pan to avoid washing the dishes, " +
								"but you promised yourself it would never happen again."
							)
						ModifierID.IN_SINK:
							return "How wasteful!"


		ActionID.EAT:
			match subjectID:
				SubjectID.COLORED_CEREAL_BOXES:
					if kitchen.isTopLeftCupboardOpen: return "There isn't actually any cereal in these boxes..."
					else: return wrongContextParse()
				
				SubjectID.NUMBERED_CEREAL_BOXES:
					if kitchen.isBottomLeftCupboardOpen: return "There isn't actually any cereal in these boxes..."
					else: return wrongContextParse()

				SubjectID.IMPRISONED_CEREAL_BOX:
					if kitchen.isBottomRightCupboardOpen: return "You would rather starve."
					else: return wrongContextParse()

				SubjectID.DINO_CEREAL_BOX, SubjectID.AMBIGUOUS_CEREAL_BOX:
					if kitchen.bowlState == Kitchen.DIRTY or kitchen.bowlState == Kitchen.CLEAN or kitchen.bowlState == Kitchen.JUST_MILK:
						return "You can't just eat the cereal dry! How barbaric! You'll need to get it in a bowl with some milk first..."
					elif kitchen.bowlState == Kitchen.JUST_CEREAL:
						return "You've got the cereal in a bowl now, but it's still too dry to eat. Where's the milk!?"
					elif kitchen.bowlState == Kitchen.UNHATCHED:
						return "The cereal is nearly ready to eat! You just need to get the Dino-mite pieces to hatch, and then you can feast!"
					elif kitchen.playerHeldItem != Kitchen.PlayerHeldItem.SPOON:
						return "The cereal is ready, but you need something to eat it with!"
					else:
						return win()

				SubjectID.DINO_NUGGETS:
					if kitchen.isTopFridgeDoorOpen:
						return "You love dino nuggets as much as the next guy, but you still don't want to have them for breakfast..."
					else:
						return wrongContextParse()

				SubjectID.EGG:
					if kitchen.isDemonSatisfied:
						return "You've asked the demon before if he's willing to share. It didn't go over well..."
					elif kitchen.isEggInPan or kitchen.isEggOnFloor:
						return "You're actually only interested in the shell. You'll need to make something else for breakfast."
					elif kitchen.isPlayerWearingEgg or kitchen.isBottomFridgeDoorOpen:
						return "You'll need to crack it open first."
					else:
						return wrongContextParse()

				SubjectID.GRAPEFRUIT_JUICE:
					if kitchen.isBottomFridgeDoorOpen:
						return "Blech! Just the thought of that unholy liquid makes your stomach turn."
					else:
						return wrongContextParse()

				SubjectID.MILK:
					if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.MILK:
						return "You don't have the milk with you right now."
					else:
						return "You're almost desperate enough drink milk straight from the jug... Almost, but not quite."

				SubjectID.POTTED_PLANT:
					return "It doesn't look ripe to you..."

				SubjectID.FRUIT_BASKET:
					return "It looks like something else is already eating the fruit. You'll have to wait your turn."

				SubjectID.GOULASH_INGREDIENTS:
					return "You already have pasta every night for dinner. You don't think you could stomach having it for breakfast too..."

				SubjectID.BREAKFAST:
					if kitchen.bowlState == Kitchen.DIRTY or kitchen.bowlState == Kitchen.CLEAN:
						return "You're sure the makings of a good breakfast are nearby, but nothing's coming together just yet..."
					elif kitchen.bowlState == Kitchen.JUST_MILK or kitchen.bowlState == Kitchen.JUST_CEREAL:
						return "With one ingredient in your trust cereal bowl, your breakfast is finally starting to take shape. (It's still not ready to eat though.)"
					elif kitchen.bowlState == Kitchen.UNHATCHED:
						return "Your breakfast is nearly ready! You just need to get the Dino-mite pieces to hatch, and then you can feast!"
					elif kitchen.playerHeldItem != Kitchen.PlayerHeldItem.SPOON:
						return "Your breakfast is ready, but you need something to eat it with!"
					else:
						return win()
				

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


func attemptReadStrategyGuide() -> String:
	var pageNumber: int
	if wildCard == "table of contents": pageNumber = 0
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
		0:
			return (
				"Looking through the table of contents, a few interesting entries catch your eye:\n" +
				"- Page 25: Fancy breakfast for fancy people\n" +
				"- Page 36: Breakfast evangelism 101\n" +
				"- Page 64: Incubating dino eggs to perfection\n" +
				"- Page 81: The cereal mixing manifesto\n" +
				"- Page 121: Appeasing the infernal offspring of Breakfast Hell"
			)
		25:
			return (
				"This page discusses preparations for an especially fancy breakfast:\n" +
				"\"Start by preparing a modest portion of caviar. (It is recommended that the roe be obtained " +
				"directly from local sturgeon populations to maximize freshness.) Carefully pour 4 ounces of the caviar " +
				"into a clean china bowl for each guest partaking in the dish. If you are not entertaining guests, " +
				"the rest of the caviar should be disposed of posthaste, lest the odors accumulate and speak poorly " +
				"of your hospitality. Carefully ladle a healthy volume of 19th century Merlot over the caviar, just " +
				"to the point of submersion. In the absence of this vintage, a red wine from the early 1900s can be " +
				"substituted, albeit with some detriment to the overall flavor profile. Serve with tea and " +
				"crumpets in your estate's sunroom.\"\n" +
				"(You quietly wonder who Merlot is.)"
			)
		36:
			return (
				"This page discusses strategies for convincing friends and family of the benefits of breakfast:\n" +
				"\"We often hear breakfast described as the 'most important meal of the day', and while many understand " +
				"this claim on a rational level, few have taken the necessary steps to truly accept it into their " +
				"heart. For the masses that claim that they 'don't really eat breakfast' or 'aren't that hungry in " +
				"the morning', remember that it is not a deficit of the mind, but a deficit of the soul that leads " +
				"them to these self-destructive tendencies. Our tasks as true breakfast believers, therefore, is not " +
				"to argue with these loved ones but instead to show them the light that we hold within, fueled " +
				"by the balanced meals that we accept into our bodies each morning. Breakfast does not come into " +
				"anyone's life by force but is instead a beautiful choice that must be made willingly.\"\n" +
				"(You nod thoughtfully as you meditate on these words of wisdom)."
			)
		64:
			return (
				"This page discusses proper protocol for hatching various Dino Egg breakfast products:\n" +
				"\"While the breadth of products containing exciting 'hatchables' has rapidly " +
				"expanded in the last decade, there is still a steadfast methodology for properly experiencing them. " +
				"The robust mixture of dextrose and partially hydrogenated oils forming the eggshell readily " +
				"solubilizes at temperatures just shy of water's boiling point. Assuming a half cup of liquid media " +
				"(water or milk) and a microwave of conventional wattage, a cook time of " +
				str((kitchen.minMilkHeat + kitchen.maxMilkHeat)/2) +
				" seconds is typically sufficient to degrade the composite carbohydrate and lipid shell.\"\n" +
				"(You absentmindedly glance at the protocol's authors. To no one's surprise, Dr. Quaker is listed "+
				"as the corresponding author. That man is never going to retire...)"

			)
		81:
			return (
				"This page discusses the importance of maintaining sugar equilibrium in breakfast cereal pairings:\n" +
				"While the novice breakfast enthusiast may reach for popular, sugar-rich cereal brands in isolation, " +
				"the expert understands the importance of balancing sugar content in more sophisticated combinations. " +
				"The first axiom of cereal combinatorics states that a cereal high in sugar (dubbed a 'sugar cereal') " +
				"must be counterbalanced with one of lower sugar content (dubbed a 'non-sugar cereal'). This rule serves " +
				"as the foundation of cereal theory and is only superseded by the existence of several 'medium' class " +
				"cereals with sugar content sufficient to balance the entire bowl on their own. Notable examples of " +
				"medium cereals include Frosted Shredded Mini Wheats, Honey Bunches of Oats, and Dino-mite Eggs.\n" +
				"(This entry is nothing new to you, but it's always nice to review the basics.)"
			)
		121:
			return (
				"This page discusses strategies for dealing with various breakfast demons. " +
				"You look through the entries until you find one matching the creature under your sink:\n" +
				"\"The Cheerio family of breakfast demons (Cheeriobub, Cheeriofer, Cheeriofel, etc.) is partial " +
				"to egg dishes, usually scrambled. Ensure that the dish is cooked through, and if requested, " +
				"go the extra mile by garnishing with the ashes of some informative text. We recommend keeping " +
				"a dictionary or encyclopedia on hand for this purpose. Like most breakfast demons, these can be " +
				"exorcised by sprinkling Grape Nuts around their home and reading the nutrition facts in Latin.\"\n" +
				"(It would be nice to get rid of the demon for good, " +
				"but you wouldn't be caught dead carrying around a box of Grape Nuts.)"
			)
		_:
			return "This page talks at length about preparing a " + getRandomOmelet(pageNumber) + "."

func getRandomOmelet(pageNumber: int) -> String:
	var omeletRNG = RandomNumberGenerator.new()
	omeletRNG.seed = pageNumber
	var firstIngredient = firstOmeletteIngredients[omeletRNG.randi_range(0,len(firstOmeletteIngredients)-1)]
	var secondIngredient = secondOmeletteIngredients[omeletRNG.randi_range(0,len(secondOmeletteIngredients)-1)]
	return firstIngredient + " and " + secondIngredient + " omelet"


func attemptTakeDinoEggsCereal() -> String:
	if kitchen.playerHeldItem == Kitchen.PlayerHeldItem.CEREAL_BOX:
		return "You're already carrying that."
	elif kitchen.isCerealInOven:
		kitchen.movePlayer(Kitchen.PlayerPos.OVEN)
		if kitchen.isOvenDoorOpen:
			if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.NONE:
				return "You're already carrying something. You'll need to put it down first."
			else:
				kitchen.takeCereal()
				return "You pick up the box of cereal."
		else:
			return "You'll need to open the oven first."
	elif kitchen.isCerealOnCounter:
		kitchen.movePlayer(Kitchen.PlayerPos.OVEN)
		if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.NONE:
			return "You're already carrying something. You'll need to put it down first."
		else:
			kitchen.takeCereal()
			return "You pick up the box of cereal."
	elif kitchen.isCerealOnTable:
		kitchen.movePlayer(Kitchen.PlayerPos.TABLE)
		if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.NONE:
			return "You're already carrying something. You'll need to put it down first."
		else:
			kitchen.takeCereal()
			return "You pick up the box of cereal."
	else: return unknownParse()


func attemptPlaceEgg(opening: bool) -> String:
	var crackingEggInPan: bool
	if not kitchen.isPlayerWearingEgg:
		return "You don't have an egg with you at the moment."
	elif modifierID == ModifierID.ON_FLOOR or (modifierID == -1 and opening):
		kitchen.crackEggOnFloor()
		return (
			"You crack the egg open and spill its contents onto the floor next to the oven. " +
			"Not wanting to be wasteful, you pop the pieces of the broken shell into your mouth and chew vigorously. Mmmm! Calcium!"
		)
	elif modifierID == -1 and not opening:
		if kitchen.isBottomFridgeDoorOpen:
			kitchen.putEggInFridge()
			return "You return the egg to the carton."
	elif modifierID == ModifierID.IN_FRYING_PAN:
		crackingEggInPan = true
	elif modifierID == ModifierID.ON_BACK_LEFT_BURNER:
		if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.FRYING_PAN and kitchen.ovenFryingPanPos == kitchen.BACK_LEFT:
			crackingEggInPan = true
		else:
			return "You don't see a good reason to put the egg on an empty burner."
	elif modifierID == ModifierID.ON_BACK_RIGHT_BURNER:
		if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.FRYING_PAN and kitchen.ovenFryingPanPos == kitchen.BACK_RIGHT:
			crackingEggInPan = true
		else:
			return "You don't see a good reason to put the egg on an empty burner."
	elif modifierID == ModifierID.ON_FRONT_LEFT_BURNER:
		if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.FRYING_PAN and kitchen.ovenFryingPanPos == kitchen.FRONT_LEFT:
			crackingEggInPan = true
		else:
			return "You don't see a good reason to put the egg on an empty burner."
	elif modifierID == ModifierID.ON_FRONT_RIGHT_BURNER:
		if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.FRYING_PAN and kitchen.ovenFryingPanPos == kitchen.FRONT_RIGHT:
			crackingEggInPan = true
		else:
			return "You don't see a good reason to put the egg on an empty burner."
	elif modifierID == ModifierID.ON_AMBIGUOUS_BURNER:
		return requestAdditionalContextCustom("Which burner?", REQUEST_SUBJECT, [], [" burner"])

	elif modifierID == ModifierID.IN_BOWL:
		return "This bowl is reserved exclusively for cereal."
	elif modifierID == ModifierID.ON_FAN:
		return "That would be a nightmare to clean..."
	elif modifierID == ModifierID.ON_COUNTER:
		if opening:
			return "That would just make a mess..."
		else:
			return "You should put the egg back in the fridge if you're not going to use it."
	elif modifierID == ModifierID.ON_HEAD:
		if opening:
			return "Your training in ovate equilibrium forbids you from breaking the egg over your own head."
		else:
			return "That's already where it is, silly!"

	if crackingEggInPan:
		kitchen.addRawEggToPan()
		if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.FRYING_PAN and kitchen.activeBurner == kitchen.ovenFryingPanPos:
			kitchen.fryEgg()
			return (
				"You expertly flip the egg off your head and karate chop it open in midair, " +
				"ejecting the innards into the frying pan. The egg sizzles loudly as it begins to fry. " +
				"Not wanting to be wasteful, you pop the pieces of the broken shell into your mouth and chew vigorously. Mmmm! Calcium!"
			)
		else:
			return (
				"You expertly flip the egg off your head and karate chop it open in midair, " +
				"ejecting the innards into the frying pan with a soft plop. " +
				"Not wanting to be wasteful, you pop the pieces of the broken shell into your mouth and chew vigorously. Mmmm! Calcium!"
			)

	return unknownParse()


enum {FRYING_PAN, MILK, EGG, ASHES, CEREAL}
func attemptFeedDemon(specificItem: int = NONE) -> String:
	if not kitchen.isMiddleLeftCupboardOpen:
		return wrongContextParse() + " (You need to open the cupboard under the sink first.)"
	if kitchen.isDemonSatisfied:
		return "The demon is already munching happily on his breakfast."
	if specificItem == NONE:
		if kitchen.playerHeldItem == Kitchen.PlayerHeldItem.FRYING_PAN:
			specificItem = FRYING_PAN
		elif kitchen.playerHeldItem == Kitchen.PlayerHeldItem.MILK:
			specificItem = MILK
		elif kitchen.isPlayerWearingEgg:
			specificItem = EGG
		elif kitchen.playerHeldItem == Kitchen.PlayerHeldItem.ASHES:
			specificItem = ASHES
		elif kitchen.playerHeldItem == Kitchen.PlayerHeldItem.CEREAL_BOX:
			specificItem = CEREAL
		else:
			return "You're not carrying anything that you can use to " + reconstructCommand() + "."

	var isDemonAngry: bool
	if specificItem == FRYING_PAN or (specificItem == EGG and kitchen.isEggInPan):
		if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.FRYING_PAN:
			return "You're not carrying that right now."
		else:
			if kitchen.isEggScrambled and kitchen.isEggFried and kitchen.areAshesOnEgg:
				kitchen.feedDemon()
				return (
					"You tentatively place the meal you've prepared in front of the demon and wait nervously for his response. " +
					"He slowly looks over the mass of scrambled eggs and ashes, appraising it. Then, his breaks into a wide grin " +
					"and he leaps from the plumbing onto the frying pan, attacking the dish with gusto. Whew! It looks like he's " +
					"satisfied, and you should actually be able to use your sink now!"
				)
			else:
				isDemonAngry = true
	elif specificItem == MILK:
		if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.MILK:
			return "You're not carrying that right now."
		else:
			isDemonAngry = true
	elif specificItem == EGG:
		if not kitchen.isPlayerWearingEgg:
			return "You're not carrying that right now."
		else:
			isDemonAngry = true
	elif specificItem == ASHES:
		if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.ASHES:
			return "You're not carrying that right now."
		else:
			isDemonAngry = true
	elif specificItem == CEREAL:
		if kitchen.playerHeldItem != Kitchen.PlayerHeldItem.CEREAL_BOX:
			return "You're not carrying that right now."
		else:
			isDemonAngry = true
	
	if isDemonAngry:
		SceneManager.transitionToScene(
			SceneManager.SceneID.ENDING,
			"It's really hard to tell what the demon wants when he refuses to speak like a normal person... You've " +
			"tried your best to meet his expectations, but you're not very confident that you were successful. " +
			"As you put down the dish you think the demon ordered, his face twists into a knot of indignation that " +
			"quickly progresses to rage. \"WHAT IS THIS? THIS IS NOT WHAT I ORDERED!!\" he bellows. " +
			"\"WHERE IS YOUR MASTER!? I MUST SPEAK WITH HIM IMMEDIATELY! THE SERVICE HERE IS ABYSMAL! " +
			"AND I BET YOU'RE STILL EXPECTING TO BE TIPPED FOR YOUR INEPTITUDE. BAH!! HERE'S WHAT I THINK OF THAT!\" " +
			"Without further warning, the demon begins belching blobs of something hot and viscous onto his surroundings. " +
			"You desperately try to calm him down, promising that you'll have a word with the kitchen staff as soon as you can, " +
			"but his rage is already burning white-hot, and there's no stopping him now...",
			SceneManager.EndingID.ONE_STAR_REVIEW
		)
		return ""

	return unknownParse()


func attemptUseMicrowave():
	if kitchen.isMicrowaveDoorOpen:
		return "You need to close the microwave door first."
	
	if not wildCard:
		return requestAdditionalContextCustom("How long (in seconds) do you want to run the microwave for?", REQUEST_WILDCARD)

	if wildCard.begins_with("to"): wildCard = wildCard.replace("to", "")
	if wildCard.begins_with("for"): wildCard = wildCard.replace("for", "")
	if wildCard.ends_with("seconds"): wildCard = wildCard.replace("seconds", "")
	wildCard = wildCard.strip_edges()

	var seconds: int
	if not wildCard.is_valid_int(): return unrecognizedEndingParse()
	else: seconds = int(wildCard)
	if seconds < 1: return "You can't run the microwave for " + wildCard + " seconds."

	validWildCard = true
	if not kitchen.isCerealBowlInMicrowave or kitchen.bowlState in [kitchen.CLEAN, kitchen.JUST_CEREAL]:
		SceneManager.transitionToScene(
			SceneManager.SceneID.ENDING,
			"As you key in the cook time for the quantum microwave to simulate, you can't help but feel like " +
			"you're forgetting something... You pause for a moment, trying to recall what your chemistry teacher " +
			"once said about how microwaves function, but it's no use. Oh well. You've always learned best through experience anyway. " +
			"You hit start on the microwave's display, and high-energy photons immediately begin bouncing around its interior, " +
			"furiously seeking out other particles to vibe with. They find none, and the vast power produced by the high-tech " +
			"appliance begins to coalesce into arcs of plasma and showers of sparks... Oh! You just remembered: It's water molecules! " +
			"The microwaves are absorbed by water molecules! As you watch your microwave go supercritical, you're pretty confident " +
			"you'll remember that next time, assuming there IS a next time...",
			SceneManager.EndingID.MICROWAVE_MAYHEM
		)
		return ""
	else:
		kitchen.addHeatToMilk(seconds)
	
	if kitchen.isVaporInMicrowave:
		return (
			"You set the quantum microwave to apply " + wildCard + " seconds worth of normal microwave heat. " +
			"When it finishes, you notice that a green vapor has filled the inside of the microwave. Peculiar..."
		)
	elif kitchen.bowlState == Kitchen.HATCHED:
		return (
			"You set the quantum microwave to apply " + wildCard + " seconds worth of normal microwave heat. " +
			"When it finishes, you can see the dynamite pieces begin to hatch in the warm milk. It's ready!"
		)
	else:
		return (
			"You set the quantum microwave to apply " + wildCard + " seconds worth of normal microwave heat. " +
			"The energy is delivered instantaneously, but you can't see any visible difference in the microwave's contents."
		)


func attemptCleanBowl() -> String:
	if not kitchen.isDemonSatisfied:
		kitchen.movePlayer(Kitchen.PlayerPos.MIDDLE_LEFT_CUPBOARD)
		if kitchen.isMiddleLeftCupboardOpen:
			return (
				"You try turning on the kitchen sink to wash the bowl, but the faucet just rattles ominously... " +
				"At the same time, the creature below your sink begins shouting his usual tirade in a frantic, high-pitched voice:\n" +
				HUNGRY_DEMON_SPIEL + "\nIt looks like you'll have to make his breakfast first if you want access to running water again..."
			)
		else:
			return (
				"You try turning on the kitchen sink to wash the bowl, but the faucet just rattles ominously... " +
				"At the same time you hear muffled yelling from under the sink. What is going on?"
			)
	elif kitchen.bowlState != Kitchen.DIRTY:
		return "There's no need for that. You've already washed the cereal bowl."
	else:
		kitchen.cleanCerealBowl()
		return (
			"Now that you've regained control of your sink, you can finally wash out this bowl! " +
			"You fill it up with lukewarm water and swirl the contents around a few times before emptying it again. " +
			"Then you move the bowl to the fan and briefly turn it on to dry it off and blow away " +
			"the remaining scraps of food. Good enough!"
		)


func attemptTurnOnOven() -> String:
	if kitchen.isOvenOn:
		return "The oven is already running at full blast."
	elif kitchen.isCerealInOven:
		SceneManager.transitionToScene(
			SceneManager.SceneID.ENDING,
			"In a rush of culinary inspiration, you " +
			"decide to try baking the Dino-mite eggs in the cereal box instead of putting them in milk first. " +
			"You've always prided yourself on your avant-garde cooking style, but alas, in today's " +
			"climate, even the cooking appliances are critics. The resounding series of explosions from within the oven " +
			"assure you that your genius has gone underappreciated yet again...",
			SceneManager.EndingID.TNTASTY
		)
		return ""
	elif kitchen.isOvenDoorOpen:
		SceneManager.transitionToScene(
			SceneManager.SceneID.ENDING,
			"The door to the Foodcinerator 9000 is still wide open when you decide to turn it on at full blast. " +
			"The heat that radiates out hits you with force of a raging bonfire, scorching your clothes and " +
			"singing what little hair you have left. There's hardly even time for you to panic before your " +
			"kitchen is consumed by the growing blaze...",
			SceneManager.EndingID.KITCHENCINERATOR
		)
		return ""
	else:
		if kitchen.isStrategyGuideInOven:
			if kitchen.isStrategyGuideFrozen: kitchen.thawStrategyGuide()
			elif kitchen.isStrategyGuideThawed: kitchen.burnStrategyGuide()
		return (
			"After a few quick inputs on the display, the Foodcinerator 9000 roars to life and the interior " +
			"is wreathed in flames. Even with the door sealed tightly, you can feel the ambient temperature of the room rising."
		)


func attemptTurnOnBurner(whichBurner: int):
	if kitchen.activeBurner == whichBurner:
		return "That burner is already active."
	elif whichBurner == Kitchen.FRONT_RIGHT:
		return (
			"You try to turn the burner on, but nothing happens. Come to think of it, that burner has been broken for a long time. " +
			"That's why you turned it into the frying pan docking station."
		)
	elif whichBurner == kitchen.ovenFryingPanPos and kitchen.playerHeldItem != Kitchen.PlayerHeldItem.FRYING_PAN:
		kitchen.turnOnBurner(whichBurner)
		if kitchen.isEggInPan and not kitchen.isEggFried:
			kitchen.fryEgg()
			return "You turn the burner on full blast, and the egg inside the pan sizzles as it cooks."
		else:
			return "You turn the burner on full blast. You can see a faint red glow at the base of the frying pan."
	else:
		SceneManager.transitionToScene(
			SceneManager.SceneID.ENDING,
			"You turn the knob of the oven to activate one of the burners, despite the fact that there is nothing on it. " +
			"A smarter man might have put the pan on the burner first, but you are not that man. As soon as you turn the burner on, " +
			"a jet of fire leaps out from it and ascends into the air. You watch in awe as the column of flame rapidly climbs to the ceiling. " +
			"A man of low to moderate intelligence might have turned off the burner now, but sadly, you are not that man either.",
			SceneManager.EndingID.DRY_FIRE
		)
		return ""

func attemptTurnOffBurner(whichBurner: int):
	if kitchen.activeBurner == whichBurner:
		kitchen.turnOffBurner()
		return "You turn off the active burner"
	else:
		return "That burner is already off."


const BUTTON_SUBJECT_ID_TO_COLOR = {
	SubjectID.BLUE_BUTTON : Kitchen.BLUE_BUTTON_COLOR,
	SubjectID.GREEN_BUTTON : Kitchen.BLUE_BUTTON_COLOR,
	SubjectID.RED_BUTTON : Kitchen.BLUE_BUTTON_COLOR,
	SubjectID.YELLOW_BUTTON : Kitchen.BLUE_BUTTON_COLOR,
}
func attemptInputFridgeButton(button: SubjectID) -> String:

	if kitchen.isBottomFridgeDoorOpen: return wrongContextParse()
	elif kitchen.isFridgeUnlocked: return "The refrigerator door is already unlocked."

	if button == SubjectID.AMBIGUOUS_BUTTON:
		return requestAdditionalContextCustom("Which button do you want to " + actionAlias + "?", REQUEST_SUBJECT, [], [" button"])

	kitchen.pressButton(BUTTON_SUBJECT_ID_TO_COLOR[button])
	if kitchen.checkFridgeLock():
		return (
			"You press the " + subjectAlias + " and hear a sharp *click* from inside the fridge door. " +
			"That did it! You should be able to open the fridge now."
		)
	elif len(kitchen.inputtedFridgeButtons) < 4:
		return "You press the " + subjectAlias + "."
	else:
		SceneManager.transitionToScene(
			SceneManager.SceneID.ENDING,
			"As soon as you input the fourth color for the refrigerator's combination lock, a piercing alarm starts " +
			"blaring from the appliance. Then, a sharp mechanical voice sounds over the cacophony. \"INTRUDER ALERT! INTRUDER ALERT! " +
			"UNRECOGNIZED CREDENTIALS HAVE BEEN LOGGED. SELF DESTRUCTING IN 5... 4... 3...\" Well, that's that. You came to " +
			"terms with this possibility long ago when you had the security system installed. If you can't have your milk, " +
			"at least you can rest easy knowing it won't fall into the wrong hands. You look on mournfully as the security " +
			"system triggers the incendiary charges hidden within the refrigerator door, engulfing it in flames.",
			SceneManager.EndingID.REFRIGERATOR_TERMINATOR
		)
		return ""

func attemptInputMilkCode() -> String:
	if not kitchen.isBottomFridgeDoorOpen: return wrongContextParse()
	elif kitchen.isMilkUnlocked: return "The lock securing the milk is already opened."
	elif not wildCard: return requestAdditionalContextCustom("What code would you like to enter?", REQUEST_WILDCARD)

	wildCard = wildCard.replace('-', '')
	wildCard = wildCard.replace(' ', '')

	if wildCard.is_valid_int(): validWildCard = true
	else: return unrecognizedEndingParse()

	if len(wildCard) != 3:
		return "This combination won't work. The lock on the milk takes a 3-digit code."
	elif kitchen.checkMilkCombo(wildCard):
		return "You input the combination and the lock anchoring the milk to the fridge pops open with a satisfying *click*."
	else:
		return "You input the combination and tug on the lock, but nothing happens. It's still locked up tight..."


func win() -> String:
	SceneManager.transitionToScene(
		SceneManager.SceneID.ENDING,
		"After a journey fraught with peril, your breakfast is finally ready! " +
		"You plunge your spoon triumphantly into the cereal and begin devouring it in record time. " +
		"As you chase the last few TNT pieces around the bowl and gulp the rest of the milk down, " +
		"you let out a sigh of relief and are filled with the strangest sense that you've just " +
		"avoided dozens of improbable, fiery disasters... You're not sure what the rest of the day " +
		"has in store for you, but with the most important meal of the day spurring you onward, " +
		"you're sure you can handle it!",
		SceneManager.EndingID.CHAMPION_OF_BREAKFASTS
	)
	return ""