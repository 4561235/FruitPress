extends Node2D
class_name Fox

var hammerInterface:TextureButton = null
var offset:int = 150
var attackPosition:Vector2 = Vector2.ZERO

func _ready() -> void:
	if is_instance_valid(self.hammerInterface):
		var destPos = self.hammerInterface.rect_global_position + Vector2(self.hammerInterface.rect_size.x, self.hammerInterface.rect_size.y/2)
		destPos += Vector2(self.offset,0)
		$Tween.interpolate_property(self, "global_position", self.global_position, destPos ,0.5)
		$Tween.start(); yield($Tween,"tween_all_completed")
		self.attackPosition = self.global_position
		$ActionTimer.start()


func init(hammerInterface:TextureButton) -> void:
	self.hammerInterface = hammerInterface
	pass



func _on_ActionTimer_timeout() -> void:
	if is_instance_valid(self.hammerInterface):
		var animSpeed:float = 0.15
		var jumpHeight:float = 250
		
		#To put the fox in the middle of the button
		var offsetAccuracy:float = 60
		
		#Half jump forward
		$Tween.interpolate_property(self, "global_position:x", self.attackPosition.x, self.attackPosition.x - (self.offset/2) - offsetAccuracy , animSpeed)
		$Tween.interpolate_property(self, "global_position:y", self.attackPosition.y, self.attackPosition.y - jumpHeight , animSpeed, Tween.TRANS_QUAD, Tween.EASE_OUT)
		$Tween.start(); yield($Tween,"tween_all_completed")
		
		#Land on button
		$Tween.interpolate_property(self, "global_position:x", self.global_position.x, self.attackPosition.x - self.offset - offsetAccuracy , animSpeed)
		$Tween.interpolate_property(self, "global_position:y", self.global_position.y, self.attackPosition.y - 50 , animSpeed, Tween.TRANS_QUAD, Tween.EASE_IN)
		$Tween.start(); yield($Tween,"tween_all_completed")
		
		if is_instance_valid(self.hammerInterface):
			self.hammerInterface.emulatePress()
			self.hammerInterface.emit_signal("button_down")
		
		#Half jump backward
		$Tween.interpolate_property(self, "global_position:x", self.global_position.x, self.attackPosition.x - (self.offset/2) , animSpeed)
		$Tween.interpolate_property(self, "global_position:y", self.global_position.y, self.attackPosition.y - jumpHeight , animSpeed, Tween.TRANS_QUAD, Tween.EASE_OUT)
		$Tween.start(); yield($Tween,"tween_all_completed")
		
		#Land on attack position
		$Tween.interpolate_property(self, "global_position:x", self.global_position.x, self.attackPosition.x, animSpeed)
		$Tween.interpolate_property(self, "global_position:y", self.global_position.y, self.attackPosition.y , animSpeed, Tween.TRANS_QUAD, Tween.EASE_IN)
		$Tween.start(); yield($Tween,"tween_all_completed")
		
	else:
		$Sprite.flip_h = true
		$Tween.interpolate_property(self, "global_position", self.global_position, self.global_position + Vector2(300, 0), 0.5)
		$Tween.start(); yield($Tween,"tween_all_completed")
		queue_free()
	pass # Replace with function body.
