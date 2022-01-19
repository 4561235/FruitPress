extends Node2D


func _ready():
	$AnimationPlayer.play("Default")
	$AnimationPlayer.advance(rand_range(0,5))
	pass
