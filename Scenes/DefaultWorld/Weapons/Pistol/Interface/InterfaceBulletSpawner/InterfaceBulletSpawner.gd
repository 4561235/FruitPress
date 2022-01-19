extends Node2D

var rng:RandomNumberGenerator = RandomNumberGenerator.new()
var bulletSelected = null

func _ready():
#	for i in range(6):
#		self.spawnBullet()
	pass

func spawnBullet() -> void:
	#Initialising bullet
	var bullet = load("res://Scenes/DefaultWorld/Weapons/Pistol/Interface/InterfaceBulletSpawner/InterfaceBullet/InterfaceBullet.tscn").instance()
	bullet.connect("selected",self,"_on_InterfaceBullet_selected")
	bullet.connect("deselected",self,"_on_InterfaceBullet_deselected")
	
	#Adding to tree
	rng.randomize()
	var offsetX:float = rng.randf_range(-50,50)
	var offsetY:float = rng.randf_range(-50,50)
	bullet.rotation_degrees = rng.randf_range(0,360)
	bullet.global_position += Vector2(offsetX,offsetY)
	self.add_child(bullet)
	
	

func _on_InterfaceBullet_selected(node):
	if self.bulletSelected == null:
		self.bulletSelected = node
		node.selected = true
	pass # Replace with function body.


func _on_InterfaceBullet_deselected(_node):
	self.bulletSelected = null
	pass # Replace with function body.
