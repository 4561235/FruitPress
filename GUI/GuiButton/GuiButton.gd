extends TextureButton


func _on_GuiButton_button_down() -> void:
	$PressOverlay.visible = true


func _on_GuiButton_button_up() -> void:
	$PressOverlay.visible = false
