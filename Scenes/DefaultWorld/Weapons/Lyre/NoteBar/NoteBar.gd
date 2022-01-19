extends Node2D

func _ready():
	var currentOffset:int = 0
	var offset:int = 45
	for pos in $Bar/Positions.get_children():
		pos.position.x += currentOffset
		currentOffset += offset
	
	randomize()
	
#	var speed:float = 0.15
#	yield(get_tree().create_timer(2),"timeout")
	
#	for j in range(100):
#		for i in range(10):
#			yield(get_tree().create_timer(speed),"timeout")
#			addNote()
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

func addNote(noteEnum:int) -> void:
	var sprite:Sprite = Sprite.new()
	sprite.texture = GameData.LYRE_NOTES_TEXTURES[noteEnum]
	sprite.scale = Vector2(0.7,0.7)
	
	$Bar/Notes.add_child(sprite)
	sprite.global_position = $Bar/BeginPos.global_position
	
	#Trying to get position basing on number of notes
	var pos = $Bar/Positions.get_child($Bar/Notes.get_child_count() - 1)
	
	#If no position found it means that there is more notes than positions so we need to scroll
	if pos != null:
		$Tween.interpolate_property(sprite, "global_position", sprite.global_position, pos.global_position,0.2)
		$Tween.interpolate_property(sprite, "self_modulate", Color(1,1,1,0), Color(1,1,1,1), 0.15)
		$Tween.start()
	else:
		self.deleteNote(1)


func _scrollBar() -> void:
	#Scrolling remaining notes
	var noteNumber = 0
	for note in $Bar/Notes.get_children():
		var pos = $Bar/Positions.get_child(noteNumber)
		if pos != null:
			$Tween.interpolate_property(note,"global_position", note.global_position, pos.global_position,0.1)
			$Tween.start()
		noteNumber+=1
	pass


func deleteNote(number:int, buffAnim:bool = false) -> void:
	var firstNote = $Bar/Notes.get_child(number-1)
	#If there is no note in the bar we stop here
	if firstNote == null: return
	
	#We need to move the note elsewere to free the space in notes and
	#begin animation without problems
	$Bar/Notes.remove_child(firstNote)
	$Bar.add_child(firstNote)
	
	self._scrollBar()
	
	if buffAnim:
		var noteExplosionAnim = load("res://Scenes/DefaultWorld/Weapons/Lyre/NoteExplosionAnim/NoteExplosionAnim.tscn").instance()
		$Bar.add_child(noteExplosionAnim)
		noteExplosionAnim.global_position = firstNote.global_position
		firstNote.queue_free()
	else:
		$Tween.interpolate_property(firstNote,"global_position", firstNote.global_position, $Bar/EndPos.global_position,0.15)
		$Tween.interpolate_property(firstNote,"self_modulate",firstNote.self_modulate,Color(1,1,1,0),0.3)
		$Tween.start()
		yield($Tween,"tween_all_completed")
		firstNote.queue_free()
