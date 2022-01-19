extends RigidBody2D

var rng = RandomNumberGenerator.new()
var destPos:Vector2
	
func init(destPosition:Vector2) -> void:
	rng.randomize()
	self.destPos = destPosition
	self.linear_velocity.x = rng.randf_range(-100,100)
	pass


func _ready():
	rng.randomize()
	$Timer.wait_time = rng.randf_range(1,2.5)
	print($Timer.wait_time)
	$Timer.start()
	pass


func _on_Timer_timeout():
	$Tween.interpolate_property(self,"global_position",self.global_position,self.destPos,0.3)
	$Tween.start()
	$AudioStreamPlayer.play()
	yield($Tween,"tween_all_completed")
	
	self.queue_free()
	pass # Replace with function body.
