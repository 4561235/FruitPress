extends TextureButton


func _ready() -> void:
	pass # Replace with function body.

func emulatePress() -> void:
	var normalTexture = self.texture_normal
	self.texture_normal = self.texture_pressed
	yield(get_tree().create_timer(0.15),"timeout")
	self.texture_normal = normalTexture
	pass
