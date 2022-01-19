extends Node2D

export (NodePath) var particlePlaceholderPath
export (NodePath) var juiceBottleManagerPath

var juiceBottleManager:JuiceBottleManager
func _ready():
	self.juiceBottleManager = get_node(juiceBottleManagerPath)


func emitDrops(fruitEnum:int, fruitPosition:Vector2, juiceGained:float) -> void:
	var bottle:JuiceBottle = self.juiceBottleManager.getBottle(fruitEnum)
	
#	var dropNb = 10
#	var div = juiceGained/dropNb
#	for _i in range(dropNb):
	var drop:Drop = load("res://Scenes/DefaultWorld/Hud/JuiceDropsManager/Drop/Drop.tscn").instance()
	drop.connect("end",self,"_on_Drop_end")
	
	drop.init(fruitPosition, bottle, fruitEnum, juiceGained)
	get_node(particlePlaceholderPath).add_child(drop)


#Drop is giving it's value to the bottle at the end of it's animation
func _on_Drop_end(fruitEnum:int, dropValue:float):
	var bottle:JuiceBottle = self.juiceBottleManager.getBottle(fruitEnum)
	if bottle != null:
		#Adding value of the drop
		bottle.updateBarr(bottle.getCurrentDrops() + dropValue, GameStats.getMaxDrops(fruitEnum))
		#Reseting the bottle bar
		while bottle.getCurrentDrops() > GameStats.getMaxDrops(fruitEnum) -1:
			var diff = bottle.getCurrentDrops() - GameStats.getMaxDrops(fruitEnum)
			bottle.updateBarr(diff, GameStats.getMaxDrops(fruitEnum))
			#Updating juice amount label
			bottle.setJuiceAmount(bottle.getJuiceAmount() + 1)
			#Emitting gain bottle particles
			bottle.emitBottleGainParticles()
			
			

