class_name OneShotAudio extends AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func init(p_stream: AudioStream, busName: String = "OtherSound", p_volume_linear: float = 1):
	stream = p_stream
	bus = busName
	volume_linear = p_volume_linear
	finished.connect(selfDestruct)
	play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func selfDestruct():
	queue_free()