extends Node2D
class_name JuiceGainAnim
signal animationEnd

var endPos : Vector2

func init(beginPos : Vector2, endPos : Vector2):
	self.position = beginPos
	self.endPos = endPos
	
func _ready():
	self._goTo(endPos)
	self._playSound()
	pass
	
func _goTo(destPos : Vector2) -> void:
	$Tween.interpolate_property(self,"position",self.position,destPos,1,Tween.TRANS_LINEAR)
	$Tween.start(); yield($AnimationPlayer,"animation_finished")
	emit_signal("animationEnd")
	self.queue_free()
	pass

func _playSound() -> void:
	$AudioStreamPlayer.play()
