extends Node2D

var rng = RandomNumberGenerator.new()

func _ready():
	randomize()
	for _i in range(60):
		yield(get_tree().create_timer(0.08),"timeout")
		var drop = load("res://Test/DropsTest/Drop.tscn").instance()
		
		drop.init($Position2D.global_position)
		self.add_child(drop)
	pass
