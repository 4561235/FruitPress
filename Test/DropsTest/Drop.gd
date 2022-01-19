extends RigidBody2D
class_name Drop

signal end(fruitEnum,dropValue)

var rng = RandomNumberGenerator.new()
var destNode:Node2D
var fruitEnum:int
var dropValue:float


func init(beginPos:Vector2, destNode:Node2D, fruitEnum:int, dropValue:float) -> void:
	rng.randomize()
	self.global_position = beginPos
	self.destNode = destNode
	self.fruitEnum = fruitEnum
	self.dropValue = dropValue
	$TextureProgress.tint_progress = GameData.FRUIT_COLORS[fruitEnum]
	self.modulate.a = 0.8
	self.linear_velocity.x = rng.randf_range(-100,100)
	pass


func _ready():
	rng.randomize()
	$Timer.wait_time = rng.randf_range(1,2.5)
	$Timer.start()
	pass


func _on_Timer_timeout():
	if !is_instance_valid(self.destNode):
		self.queue_free()
		return
	
	if self.destNode is JuiceBottle: self.destNode.refreshDespawnTime()
	$Tween.interpolate_property(self,"global_position",self.global_position,self.destNode.global_position,0.3)
	$Tween.start()
	yield($Tween,"tween_all_completed")
	
	
	emit_signal("end",self.fruitEnum,self.dropValue)
	
	self.queue_free()
	pass # Replace with function body.
