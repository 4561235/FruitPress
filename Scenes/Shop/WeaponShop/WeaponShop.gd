extends Control


var containerInitialYPosition:float = 0

func _ready() -> void:
	self.containerInitialYPosition = $ItemsContainer.rect_position.y


func _input(event: InputEvent) -> void:
	if event is InputEventScreenDrag:
			$ItemsContainer.rect_position.y += event.relative.y


func _on_VisibilityNotifier2D_screen_exited() -> void:
	$Tween.interpolate_property($ItemsContainer,"rect_position:y",$ItemsContainer.rect_position.y, self.containerInitialYPosition, 0.5)
	$Tween.start()



func _on_WeaponShop_draw() -> void:
	$ItemsContainer.rect_position.y = self.containerInitialYPosition
