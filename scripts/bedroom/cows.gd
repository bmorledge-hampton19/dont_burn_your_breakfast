class_name Cows extends Control

@export var cows: Array[TextureRect]

func dance():
    var flip := 1
    for cow in cows:
        flip *= -1
        var freq = randf_range(0.5, 0.75)
        var tween = create_tween()
        tween.tween_interval(freq)
        tween.tween_property(cow, "rotation", randf_range(PI/16, PI/12)*flip, 0)
        tween.tween_interval(freq)
        tween.tween_property(cow, "rotation", randf_range(PI/16, PI/12)*flip*-1, 0)
        tween.set_loops()
