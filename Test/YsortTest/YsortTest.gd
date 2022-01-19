extends Node2D


func _ready():
	$YSort/hammer.position = $BeginPos.position
	
#	$Tween.interpolate_property($YSort/hammer,"global_position",$BeginPos.global_position,$EndPos.global_position,8)
#	$Tween.start()
#	yield($Tween,"tween_all_completed")
#
#	$Tween.interpolate_property($YSort/hammer,"global_position",$EndPos.global_position,$BeginPos.global_position,8)
#	$Tween.start()
	pass
	
func _input(event):
   # Mouse in viewport coordinates.
	#if event is InputEventMouseButton:
	if event is InputEventMouseMotion:
		$YSort/hammer.global_position = event.global_position


func _on_AttackTimer_timeout():
#	var note:JuiceGainAnim = load("res://Scenes/DefaultWorld/Hud/JuiceGainAnim/JuiceGainAnim.tscn").instance()
#	note.init($YSort/hammer.global_position, $YSort/apple.global_position)
#	$YSort.add_child(note)
	pass # Replace with function body.
