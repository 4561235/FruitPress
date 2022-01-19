extends Node2D

var DefaultWorldRes = preload("res://Scenes/DefaultWorld/DefaultWorld.tscn")
var ShopRes = preload("res://Scenes/Shop/Shop.tscn")

onready var defaultWorld = $DefaultWorld
onready var shop = $Shop

func _ready() -> void:
	pass


func _on_LeftMenu_Pressing() -> void:
	if is_instance_valid(self.defaultWorld): return
	
	var def = DefaultWorldRes.instance()
	self.defaultWorld = def
	def.worldMusicsPath = $WorldMusics.get_path()
	add_child(def)
	
	self.shop.queue_free()

	$Hud/LeftMenu.foldMenu()



func _on_LeftMenu_Shop() -> void:
	if is_instance_valid(self.defaultWorld):
		remove_child(self.defaultWorld)
		self.defaultWorld.queue_free()
		
		var shop = ShopRes.instance()
		self.shop = shop
		$ShopLayer.add_child(shop)

		$Hud/LeftMenu.foldMenu()
