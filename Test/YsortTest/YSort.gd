extends YSort


func _ready():
	var res = self.distance_to($hammer,$Reference)
	print(res)
	pass
	

func _physics_process(delta):
	
	for child in self.get_children():
		var distance = self.distance_to(child,$Reference)
		#print(distance)
		
		var divRatio = distance / 150
		#print(divRatio)

		if divRatio > 0:
			if divRatio < 1: divRatio = 1
			child.scale = Vector2(1,1) * divRatio
			
		elif divRatio < 0:
			if divRatio > -1: divRatio = 1
			child.scale = Vector2(1,1) / abs(divRatio)
		
		if child.scale > Vector2(1.5,1.5): child.scale = Vector2(1.5,1.5)
	

func distance_to(node1:Node2D, node2:Node2D) -> float:
	#var xdi = node1.global_position.x - node2.global_position.x
	#var ydi = node1.global_position.y - node2.global_position.y
	#var res = sqrt((xdi * xdi) + (ydi * ydi))
	var res = node1.global_position.y - node2.global_position.y
	return res
