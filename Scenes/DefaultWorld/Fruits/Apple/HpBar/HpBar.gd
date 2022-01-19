extends Control


func _ready():
	self.value = 0
	pass

func updateBar(value : float,Maxvalue : float) -> void:
	var percent = round((value / Maxvalue) * 100)
	
	if self.value < value:
		self.value = percent
	else:
		$Tween.interpolate_property(self,"value",self.value,percent,0.1)
		$Tween.start()
	#self.value = percent
