extends Node2D

var offset:int = 130

var objTable = []

func _ready():
#	print(addBottleIfNeeded(Enums.FRUITS.APPLE))
#	print(addBottleIfNeeded(Enums.FRUITS.PLUM))
#	yield(get_tree().create_timer(3), "timeout")
#	print(addBottleIfNeeded(Enums.FRUITS.PLUM))
#	yield(get_tree().create_timer(3), "timeout")
#	print(addBottleIfNeeded(Enums.FRUITS.APPLE))
#	yield(get_tree().create_timer(3), "timeout")
#	print(addBottleIfNeeded(Enums.FRUITS.APPLE))
#	print(addBottleIfNeeded(Enums.FRUITS.PLUM))
	pass

#Return global_position of bottle
func addBottleIfNeeded(fruitEnum:int) -> JuiceCountDisplayer:
	if self._checkIfBottleExists(fruitEnum): return getBottle(fruitEnum)
	
	var node2d = Node2D.new()
	var juiceDisplayer : JuiceCountDisplayer = load("res://Scenes/DefaultWorld/Hud/JuiceCountDisplayer/JuiceCountDisplayer.tscn").instance()
	var explodingTimer : ExplodingTimer = load("res://Scenes/DefaultWorld/Hud/JuiceCountBar/ExplodingTimer/ExplodingTimer.tscn").instance()
	self.add_child(node2d)
	
	
	juiceDisplayer.init(fruitEnum)
	node2d.add_child(juiceDisplayer)
	juiceDisplayer.position += Vector2(0,self._calcCurrentOffset(node2d))
	
	node2d.add_child(explodingTimer)
	explodingTimer.wait_time = 4
	explodingTimer.start()

	return getBottle(fruitEnum)

func getBottle(fruitEnum:int) -> JuiceCountDisplayer:
	for b in self.get_children():
		if b.get_child(0).currentFruitEnum == fruitEnum:
			b.get_child(1).stop()
			b.get_child(1).wait_time = 4
			b.get_child(1).start()
			return b.get_child(0)
	return null

func _calcCurrentOffset(obj):
	var res = 0
	var index = 0
	for i in self.objTable:
		if !is_instance_valid(i):
			self.objTable[index] = obj
			return res
		res += offset
		index+=1
		
	self.objTable.append(obj)
	return res
	pass

func _checkIfBottleExists(fruitEnum:int) -> bool:
	for b in self.get_children():
		if b.get_child(0).currentFruitEnum == fruitEnum: return true
	return false
