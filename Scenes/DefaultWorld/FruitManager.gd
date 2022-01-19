extends Node2D

export (NodePath) var rootSignalNodePath
export (NodePath) var particlesPlaceholderPath

signal FruitChanged(fruit)

func _ready():
#	self.global_position.y = OS.get_screen_size().y/2
#	self.global_position.y += 100
#	if OS.get_screen_size().y <= 1280: self.global_position.y -= 200
	self.global_position.y = 0
	self.global_position.y += OS.get_screen_size().y /4 + 200
	pass


func getFruit():
	if $FruitSlot.get_child_count() > 0: return $FruitSlot.get_child(0)
	else: return null


func _changeFruit(fruit:Fruit):
	if self.getFruit() != null:
		self.getFruit().queue_free()
	
	$FruitSlot.add_child(fruit)
	emit_signal("FruitChanged",fruit)


func spawnFruit(fruitEnum:int, loadFromTempData:bool = false) -> Fruit:
	#INSTANCING
	var fruit:Fruit = GameData.FRUIT_SCENES[fruitEnum].instance()
	
	#INITING FRUIT
	fruit.init(get_node(self.particlesPlaceholderPath), loadFromTempData)
	fruit.connect("dead", get_node(self.rootSignalNodePath), "_on_Fruit_dead")
	
	self._changeFruit(fruit)
	return fruit
	pass
