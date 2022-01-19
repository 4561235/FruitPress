extends Node2D
signal blueBuffActivated
signal greenBuffActivated
signal redBuffActivated
signal noBuffActivated

func _ready() -> void:
	self.updateGauge(0, 1) 
	$TextureProgress/BlueParticles.emitting = false
	$TextureProgress/GreenParticles.emitting = false
	$TextureProgress/RedParticles.emitting = false
	pass



func updateGauge(value:float, maxValue:float) -> void:
	var percent:float = round((value / maxValue) * 100)
	#$TextureProgress.value = percent
	$Tween.interpolate_property($TextureProgress,"value",$TextureProgress.value, percent, 0.2)
	$Tween.start()
	#print(percent)
	
	if percent >= 90:
		self._disableEmitting()
		$TextureProgress/RedParticles.emitting = true
		$TextureProgress/BlueParticles.emitting = true
		$TextureProgress/GreenParticles.emitting = true
		emit_signal("redBuffActivated")
	elif percent >= 70:
		self._disableEmitting()
		$TextureProgress/BlueParticles.emitting = true
		$TextureProgress/GreenParticles.emitting = true
		emit_signal("greenBuffActivated")
	elif percent >= 33:
		self._disableEmitting()
		$TextureProgress/BlueParticles.emitting = true
		emit_signal("blueBuffActivated")
	elif percent < 33:
		self._disableEmitting()
		emit_signal("noBuffActivated")
#
#	if percent < 33:
#		$TextureProgress/BlueParticles.emitting = false
#		emit_signal("blueBuffChanged",false)
#	if percent < 70:
#		$TextureProgress/GreenParticles.emitting = false
#		emit_signal("greenBuffChanged",false)
#	if percent < 90:
#		$TextureProgress/RedParticles.emitting = false
#		emit_signal("redBuffChanged",false)
	pass

func _disableEmitting() -> void:
	$TextureProgress/BlueParticles.emitting = false
	$TextureProgress/GreenParticles.emitting = false
	$TextureProgress/RedParticles.emitting = false
	pass
