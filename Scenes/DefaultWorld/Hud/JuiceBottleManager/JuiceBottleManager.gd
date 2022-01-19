extends Control
class_name JuiceBottleManager

var bottleArray = []
var posOffset:int = 200
#var currentPos:int = 0

func _ready():
#	yield(get_tree().create_timer(0.5),"timeout")
#	self.displayBottle(Enums.FRUITS.APPLE)
#	yield(get_tree().create_timer(0.5),"timeout")
#	self.displayBottle(Enums.FRUITS.PLUM)
#	yield(get_tree().create_timer(0.5),"timeout")
#	self.displayBottle(Enums.FRUITS.KIWI)
#	yield(get_tree().create_timer(0.5),"timeout")
#	self.displayBottle(Enums.FRUITS.BANANA)
	pass


#Display bottle on screen and give it's position
func displayBottle(fruitEnum:int) -> void:
	for bottle in self.get_children():
		if bottle.getColor() == GameData.FRUIT_COLORS[fruitEnum]:
			bottle.refreshDespawnTime()
			return
	
	var bottle = load("res://Scenes/DefaultWorld/Hud/JuiceBottleManager/JuiceBottle/JuiceBottle.tscn").instance()
	
	var resOffset = _calcCurrentOffset(bottle)
	
	#Initing bottle
	bottle.position.y += resOffset
	bottle.init(Vector2(-200,0))
	bottle.updateBarr(GameStats.getCurrentDrops(fruitEnum), GameStats.getMaxDrops(fruitEnum), false)
	bottle.setJuiceAmount(GameStats.getTotalJuice(fruitEnum))
	bottle.changeFruitSprite(fruitEnum)
	
	self.add_child(bottle)
	bottle.changeColor(GameData.FRUIT_COLORS[fruitEnum])


#Return bottle basing on the color of the fruit
func getBottle(fruitEnum:int) -> JuiceBottle:
	for bottle in self.get_children():
		if bottle.getColor() == GameData.FRUIT_COLORS[fruitEnum]: 
			return bottle
	return null


func _calcCurrentOffset(obj):
	var res = 0
	var index = 0
	for i in self.bottleArray:
		if !is_instance_valid(i):
			self.bottleArray[index] = obj
			return res
		res += self.posOffset
		index+=1
		
	self.bottleArray.append(obj)
	return res
	pass
