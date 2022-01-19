extends TextureButton


func _ready() -> void:
	pass


func shine() -> void:
	#$UltiAnim.restart()
	self.modulate = Color(2,2,2,1)
	yield(get_tree().create_timer(0.15),"timeout")
	self.modulate = Color(1,1,1,1)
	pass
