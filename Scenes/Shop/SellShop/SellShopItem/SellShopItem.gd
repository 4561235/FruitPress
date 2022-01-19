extends Control

export (String) var title
export (Enums.FRUITS) var fruit
signal SliderIsManipulated
signal SliderIsNotManipulated

var quantityToSell:int = 0

func _ready() -> void:
	self.updateDisplay()
	
	$GuiPanel/Title.text = self.title
	$GuiPanel/Bottle/FruitSticker.texture = GameData.FRUIT_TEXTURES[self.fruit]
	$GuiPanel/Bottle/Fill.self_modulate = GameData.FRUIT_COLORS[self.fruit]
	$GuiPanel/Fill.self_modulate = GameData.FRUIT_COLORS[self.fruit]
	
	self.updateQuantity()
	pass

func updateQuantity() -> void:
	$GuiSlider/Quantity.text = String(self.quantityToSell)


func _on_GuiSlider_value_changed(value: float) -> void:
	self.quantityToSell = int(value)
	self.updateQuantity()
	self.updateDisplay()


func _on_GuiSlider_mouse_entered() -> void:
	emit_signal("SliderIsManipulated")


func _on_GuiSlider_mouse_exited() -> void:
	emit_signal("SliderIsNotManipulated")


func _on_SellButton_pressed() -> void:
	GameStats.sellJuiceBottle(self.fruit, $GuiSlider.value)
	$GuiSlider.value = 0
	
	self.updateDisplay()

func updateDisplay() -> void:
	$GuiPanel/Bottle/Amount.text = String(GameStats.getTotalJuice(self.fruit))
	$GuiSlider.max_value = GameStats.getTotalJuice(self.fruit)
	$GuiSlider.tick_count = GameStats.getTotalJuice(self.fruit)
	$GuiPanel/Coin/Cost.text = String(GameStats.JUICE_COST[self.fruit] * $GuiSlider.value)
