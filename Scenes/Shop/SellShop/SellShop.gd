extends Control

var sliderManipulation:bool = false
var containerInitialYPosition:float = 0

func _ready() -> void:
	self.containerInitialYPosition = $ItemsContainer.rect_position.y
	for cont in $ItemsContainer.get_children():
		cont.connect("SliderIsManipulated",self,"_on_Slider_Manipulated")
		cont.connect("SliderIsNotManipulated",self,"_on_Slider_NotManipulated")


func _input(event: InputEvent) -> void:
	if event is InputEventScreenDrag and !self.sliderManipulation:
			$ItemsContainer.rect_position.y += event.relative.y


func _on_VisibilityNotifier2D_screen_exited() -> void:
	$Tween.interpolate_property($ItemsContainer,"rect_position:y",$ItemsContainer.rect_position.y, self.containerInitialYPosition, 0.5)
	$Tween.start()


func _on_SellShop_draw() -> void:
	$ItemsContainer.rect_position.y = self.containerInitialYPosition
	pass # Replace with function body.


func _on_Slider_Manipulated():
	self.sliderManipulation = true


func _on_Slider_NotManipulated():
	self.sliderManipulation = false
