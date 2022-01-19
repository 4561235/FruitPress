extends Node2D
class_name DamageLabel

func _ready():
	#self.init(Color(1,1,1,1),"ok")
	$AnimationPlayer.play("GoUp")
	pass

func init(globPosition:Vector2, color:Color, text:String):
	$Label.set("custom_colors/font_color", color)
	$Label.text = text
	self.global_position = globPosition
	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "GoUp": self.queue_free()
