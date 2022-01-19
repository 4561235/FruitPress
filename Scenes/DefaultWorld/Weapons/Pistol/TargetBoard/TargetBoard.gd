extends Node2D
class_name TargetBoard

signal cycleCompleted
signal middleHited
signal outsideHited


func init(position:Vector2):
	self.global_position = position
	pass


func _ready():
	self._beginCycle()
	pass


func _beginCycle() -> void:
	
	var viewFinderSpeed:float = 1
	
	$Tween.interpolate_property($ViewFinder,"position",$ViewFinder.position, Vector2(200,0),viewFinderSpeed)
	$Tween.start(); yield($Tween,"tween_all_completed")
	
	$Tween.interpolate_property($ViewFinder,"position", $ViewFinder.position, Vector2(-200,0),viewFinderSpeed)
	$Tween.start(); yield($Tween,"tween_all_completed")
	
	emit_signal("cycleCompleted")


func _on_MiddleArea_area_entered(_area):
	emit_signal("middleHited")
	pass # Replace with function body.


func _on_OutsideArea_area_entered(_area):
	emit_signal("outsideHited")
	pass # Replace with function body.


func _on_TargetBoard_cycleCompleted():
	self._beginCycle()
	pass # Replace with function body.

func getViewFinderPosition() -> Vector2:
	return $ViewFinder.global_position
