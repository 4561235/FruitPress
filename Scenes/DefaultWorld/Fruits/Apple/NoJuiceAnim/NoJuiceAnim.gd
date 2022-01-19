extends CPUParticles2D

func init(texture : Texture):
	self.texture = texture

func _ready():
	self.emitting = true
	self.transparent()
	pass

func _physics_process(_delta):
	if self.emitting == false:
		self.queue_free()

func transparent() -> void:
	var beginTrans : Color = Color(1,1,1,1)
	var endTrans : Color = Color(1,1,1,0)
	var time : float = 1.5
	$Tween.interpolate_property(self,"modulate",beginTrans,endTrans,time)
	$Tween.start(); yield($Tween,"tween_all_completed")
