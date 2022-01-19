extends Weapon

signal smashed(weapon)

func _init():
	self.dps = 1
	self.efficiencyPercentage = 100
	self.weaponEnum = Enums.WEAPONS.HAMMER
	self.weaponInterface = load("res://Scenes/DefaultWorld/Weapons/Hammer/Interface/HammerInterface.tscn")


func init():
	pass


func _ready():
	$AnimationPlayer.play("Idle")
	pass


func smash() -> void:
	$AnimationPlayer.play("Smash"); yield($AnimationPlayer,"animation_finished")
	
	#self.playSound()
	emit_signal("smashed",self,AttackBuff.new())
	$AnimationPlayer.play("Idle")


func playSound() -> void:
	pass

