extends Node2D
class_name Bullet
signal hit

var targetPos:Vector2 = Vector2.ZERO

func init(beginPos:Vector2, targetPos:Vector2):
	self.position = beginPos
	self.targetPos = targetPos


func _ready():
	self._goToTarget(self.targetPos)


func _goToTarget(targetPos:Vector2):
	$Tween.interpolate_property(self,"position",self.position,targetPos, 0.05)
	$Tween.start()
	yield($Tween,"tween_all_completed")
	$CollisionArea/CollisionShape2D.disabled = false
	yield(get_tree().create_timer(0.03),"timeout")
	self.emit_signal("hit")
	self.queue_free()


