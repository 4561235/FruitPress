extends Node2D

var fruitArray = []

func _ready():
	var currentOffset:int = 0
	var offset:int = 60
	for pos in $Bar/Positions.get_children():
		pos.position.x += currentOffset
		currentOffset += offset
	
	randomize()
	
	#var speed:float = 0.40
#	yield(get_tree().create_timer(2),"timeout")
#
#	for j in range(100):
#		for i in range(10):
#			yield(get_tree().create_timer(speed),"timeout")
#			var en:int = Enums.FRUITS.values()[randi() % len(Enums.FRUITS)]
#			addFruit(en)
			
#
#		yield(get_tree().create_timer(1),"timeout")
#		for i in range(3):
#			yield(get_tree().create_timer(speed),"timeout")
#			_deleteNote(1)

#		yield(get_tree().create_timer(speed),"timeout")
#		_deleteNote(5)
#		yield(get_tree().create_timer(speed),"timeout")
#		_deleteNote(4)
#		yield(get_tree().create_timer(speed),"timeout")
#		_deleteNote(3)
#		yield(get_tree().create_timer(speed),"timeout")
#		_deleteNote(2)
#		yield(get_tree().create_timer(speed),"timeout")
#		_deleteNote(1)
		
#		yield(get_tree().create_timer(speed),"timeout")
#		for i in range(3):
#			yield(get_tree().create_timer(speed),"timeout")
#			_deleteNote(3)
#		yield(get_tree().create_timer(1),"timeout")

	pass

func addFruit(fruitEnum:int) -> void:
	#Adding to array
	self.fruitArray.append(fruitEnum)
	
	#Extracting sprite
	var sprite:Sprite = Sprite.new()
	sprite.texture = GameData.FRUIT_TEXTURES[fruitEnum]
	sprite.scale = Vector2(0.3,0.3)
	
	$Bar/Fruits.add_child(sprite)
	sprite.global_position = $Bar/BeginPos.global_position
	
	#Trying to get position basing on number of Fruits
	var pos = $Bar/Positions.get_child($Bar/Fruits.get_child_count() - 1)
	
	#If no position found it means that there is more Fruits than positions so we need to scroll
	if pos != null:
		$Tween.interpolate_property(sprite, "global_position", sprite.global_position, pos.global_position,0.2)
		$Tween.interpolate_property(sprite, "self_modulate", Color(1,1,1,0), Color(1,1,1,1), 0.15)
		$Tween.start()
	else:
		self.deleteFruit(1)


func _scrollBar() -> void:
	#Scrolling remaining Fruits
	var noteNumber = 0
	
	for note in $Bar/Fruits.get_children():
		var pos = $Bar/Positions.get_child(noteNumber)
		if pos != null:
			$Tween.interpolate_property(note,"global_position", note.global_position, pos.global_position,0.1)
			$Tween.start()
		noteNumber+=1
	pass

#Number does not count as n-1 
func deleteFruit(number:int) -> void:
	var firstFruit = $Bar/Fruits.get_child(number-1)
	#If there is no note in the bar we stop here
	if firstFruit == null: return
	
	self.fruitArray.remove(number-1)
	
	#We need to move the note elsewere to free the space in Fruits and
	#begin animation without problems
	$Bar/Fruits.remove_child(firstFruit)
	$Bar.add_child(firstFruit)
	
	self._scrollBar()
	

	$Tween.interpolate_property(firstFruit,"global_position", firstFruit.global_position, $Bar/EndPos.global_position,0.15)
	$Tween.interpolate_property(firstFruit,"self_modulate",firstFruit.self_modulate,Color(1,1,1,0),0.3)
	$Tween.start()
	yield($Tween,"tween_all_completed")
	firstFruit.queue_free()

#Number does not count as n-1 
func getFruit(number:int):
	return self.fruitArray[number-1]

