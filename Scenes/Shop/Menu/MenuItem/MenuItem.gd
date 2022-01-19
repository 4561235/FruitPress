tool
extends Control

export (String) var title
export (Color) var rectColor
export (Color) var buttonColor


func _ready() -> void:
	if self.title != "": $GuiPanel/Label.text = title
	$GuiPanel/Fill.self_modulate = rectColor
	$GuiButton/Fill.self_modulate = buttonColor
	pass
