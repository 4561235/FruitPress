extends CPUParticles2D

func init(singleShot:bool, speed:float, explosion:bool, color:Color = self.self_modulate):
	self.one_shot = singleShot
	if singleShot == false: self.emitting = true
	
	self.speed_scale = speed
	
	if explosion == false: self.explosiveness = false
	
	if color != null: self.self_modulate = color
	
	
	pass


func _ready():
	#yield(get_tree().create_timer(1),"timeout")
	self.emitting = true
	pass
