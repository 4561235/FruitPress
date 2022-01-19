extends Node2D

signal selected(node)
signal deselected(node)
var selected:bool = false
var initialPosition:Vector2

func _ready():
	self.initialPosition = self.global_position
	pass


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventScreenDrag:
		#print("ok")
#		self.position = event.position
		emit_signal("selected",self)
		#self.selected = true
#		get_parent().bulletSelected = true
	pass # Replace with function body.


func _input(event):
	
	if self.selected and event is InputEventScreenDrag:
		self.global_position = event.position
		
	elif event is InputEventScreenTouch:
#		print("de-selected")
		if event.is_pressed() == false:
			self.selected = false
			emit_signal("deselected",self)
			$Tween.interpolate_property(self,"global_position",self.global_position,self.initialPosition,0.2)
			$Tween.start()


func _on_Area2D_area_entered(area):
	self.queue_free()
	pass # Replace with function body.
