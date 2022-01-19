extends Control

func _ready() -> void:
	pass # Replace with function body.

func changeDark(value:float) -> void:
	#$ColorRect.color.a = value
	$Tween.interpolate_property($ColorRect,"color:a",$ColorRect.color.a, value, 0.5)
	$Tween.start()
	pass

