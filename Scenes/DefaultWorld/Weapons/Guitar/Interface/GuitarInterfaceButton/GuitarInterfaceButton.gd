extends TextureButton
class_name GuitarInterfaceButton
signal buttonMissed

var speed:float = 0
var despawnPosition:Vector2 = Vector2.ZERO

func _ready() -> void:
	pass


func init(speed:float, despawnPosition:Vector2) -> void:
	self.speed = speed
	self.despawnPosition = despawnPosition


func _physics_process(delta: float) -> void:
	self.rect_position.x += speed * delta
	
	if self.rect_global_position.x >= self.despawnPosition.x:
		emit_signal("buttonMissed")
		self.queue_free()


#When button cliqued = despawn
func _on_GuitarInterfaceButton_button_down() -> void:
	self.queue_free()
	pass # Replace with function body.


func changeSpeed(value:float) -> void:
	self.speed = value
	pass
