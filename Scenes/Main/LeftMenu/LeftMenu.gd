extends Control

signal Pressing
signal Shop

func _ready() -> void:
	pass


func unfoldMenu() -> void:
	self._foldUnfoldMenu(true)
	$ArrowRight.visible = false
	pass


func foldMenu() -> void:
	self._foldUnfoldMenu(false)
	yield($Tween,"tween_all_completed")
	$ArrowRight.visible = true
	pass


func _foldUnfoldMenu(state:bool) -> void:
	var foldX:int = -250
	var unfoldX:int = 172
	var speed:float = 0.3
	
	if state == true:
		$Tween.interpolate_property($PanelSprite,"position:x", $PanelSprite.position.x, unfoldX, speed)
		$Tween.start()
	else:
		$Tween.interpolate_property($PanelSprite,"position:x", $PanelSprite.position.x, foldX, speed)
		$Tween.start()
	pass


func _on_ArrowRight_button_down() -> void:
	self.unfoldMenu()
	pass # Replace with function body.


func _on_ArrowLeft_button_down() -> void:
	self.foldMenu()
	pass # Replace with function body.


func _on_Pressing_pressed() -> void:
	emit_signal("Pressing")
	pass # Replace with function body.


func _on_Shop_pressed() -> void:
	emit_signal("Shop")
	pass # Replace with function body.


func _on_Garden_pressed() -> void:
	pass # Replace with function body.
