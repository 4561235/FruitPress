extends Node2D


func _ready():
	#changeColor(Enums.FRUITS.APPLE)
	self.emitting = true
	pass

func changeColor(color:Color) -> void:
	self.color = color


func _on_DespawnTimer_timeout():
	self.queue_free()
	pass # Replace with function body.
