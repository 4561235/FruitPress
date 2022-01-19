extends Node

#[currentSmash,maxSmash,TotalJuice]
var FRUIT_STATS = {
	Enums.FRUITS.APPLE : [0,25,5],
	Enums.FRUITS.PLUM : [0,20,4],
	Enums.FRUITS.KIWI : [0,30,3],
	Enums.FRUITS.BANANA : [0,15,2]
}

var JUICE_COST = {
	Enums.FRUITS.APPLE : 10,
	Enums.FRUITS.PLUM : 20,
	Enums.FRUITS.KIWI : 30,
	Enums.FRUITS.BANANA : 40
}

var money:int = 0

func _ready():
#	print(self.getCurrentSmash(Enums.FRUITS.PLUM))
#	setCurrentSmash(Enums.FRUITS.PLUM, 50)
#	print(self.getCurrentSmash(Enums.FRUITS.PLUM))
	pass
	
func getMaxDrops(fruitEnum:int) -> float:
	return self.FRUIT_STATS[fruitEnum][1]

func getCurrentDrops(fruitEnum:int) -> float:
	return self.FRUIT_STATS[fruitEnum][0]

func setCurrentDrops(fruitEnum:int, amount:float) -> void:
	self.FRUIT_STATS[fruitEnum][0] = amount

func getTotalJuice(fruitEnum:int) -> float:
	return self.FRUIT_STATS[fruitEnum][2]
	
func setTotalJuice(fruitEnum:int, amount:float) -> void:
	self.FRUIT_STATS[fruitEnum][2] = amount

func sellJuiceBottle(fruitEnum:int, amount:float) -> void:
	var calc:int = self.getTotalJuice(fruitEnum) - amount
	if calc >= 0:
		self.setTotalJuice(fruitEnum, calc)
		self.money = calc * self.JUICE_COST[fruitEnum]
