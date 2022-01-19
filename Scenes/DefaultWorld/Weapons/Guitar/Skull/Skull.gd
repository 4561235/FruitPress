extends Node2D
class_name Skull
signal hit

var targetPos:Vector2 = Vector2.ZERO

func init(beginPos:Vector2, targetPos:Vector2):
	self.position = beginPos
	self.targetPos = targetPos


func _ready():
	self._goToTarget(self.targetPos)


func _goToTarget(targetPos:Vector2):
#	$Tween.interpolate_property(self,"position", self.position, targetPos, 1, Tween.TRANS_SINE)
#	$Tween.interpolate_property(self, "position:x", self.position.x, targetPos.x, 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
#	$Tween.interpolate_property(self, "position:y", self.position.y, targetPos.y, 0.5, Tween.TRANS_QUAD, Tween.EASE_OUT)
#	$Tween.interpolate_property(self, "position:y", targetPos.y, self.position.y, 0.5, Tween.TRANS_QUAD, Tween.EASE_IN)
#	$Tween.interpolate_property(self, "position:y", targetPos.y, self.position.y, 0.5, Tween.TRANS_QUAD, Tween.EASE_OUT, 0.5)
	randomize()
	var yDist:float = randi()%200+50
	match randi()%2:
		0: yDist = yDist
		1: yDist = -yDist
	
	$Tween.interpolate_property(self, "position:x", self.position.x, targetPos.x/2, 0.5)
	$Tween.interpolate_property(self, "position:y", self.position.y, self.position.y - yDist, 0.5, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$Tween.start(); yield($Tween,"tween_all_completed")
	$Tween.interpolate_property(self, "position:x", self.position.x, targetPos.x, 0.5)
	$Tween.interpolate_property(self, "position:y", self.position.y, self.position.y + yDist, 0.5, Tween.TRANS_QUAD, Tween.EASE_IN)
	$Tween.start(); yield($Tween,"tween_all_completed")
	
	self.emit_signal("hit")
	self.queue_free()
