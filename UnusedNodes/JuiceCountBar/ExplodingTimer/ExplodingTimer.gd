extends Timer
class_name ExplodingTimer

func _ready():
	pass

func _on_ExplodingTimer_timeout():
	self.get_parent().queue_free()
	pass # Replace with function body.
