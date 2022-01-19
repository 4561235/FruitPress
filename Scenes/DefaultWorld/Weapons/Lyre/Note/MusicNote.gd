extends Node2D
class_name MusicNote

signal hit

var targetPos:Vector2 = Vector2.ZERO
var attackBuff:AttackBuff = AttackBuff.new()

func _ready():
	self._goToTarget(self.targetPos)
	pass
	
func init(texture:Texture, targetPos:Vector2):
	$Sprite.texture = texture
	self.targetPos = targetPos
	self.attackBuff = attackBuff
	#print(targetPos)
	pass

func _goToTarget(targetPos:Vector2):
	$Tween.interpolate_property(self,"position",self.position,targetPos,0.5)
	$Tween.start()
	yield($Tween,"tween_all_completed")
	self.emit_signal("hit")
	self.queue_free()
