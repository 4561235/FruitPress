tool
extends Control
export (Texture) var texture
export (String) var title
export (String) var price
export (Color) var color = Color(1,1,1,1)


func _ready() -> void:
	if self.texture != null: $GuiPanel/ItemTexture.texture = self.texture
	if self.title != "": $GuiPanel/ItemTitle.text = self.title
	if self.price != "": $GuiPanel/Price.text = self.price
	if self.color != null: $GuiPanel/Fill.self_modulate = self.color
	pass
