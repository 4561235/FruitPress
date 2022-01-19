extends Control

var pistol:Weapon = null

func _ready():
	for _i in range(pistol.ammo):
		$AmmoCharger.addAmmo()
	pistol.connect("ammoUpdated", self, "_on_Pistol_ammoUpdated")
	pass
	

func init(pistol:Weapon) -> void:
	self.pistol = pistol
	pass


func _on_Pistol_ammoUpdated(amount):
	var diff = amount - $AmmoCharger.getAmmoNumber()
	if diff < 0:
		for _i in range(abs(diff)):
			$AmmoCharger.removeAmmo()
			$InterfaceBulletSpawner.spawnBullet()
	else:
		for _i in range(abs(diff)):
			$AmmoCharger.addAmmo()
	pass


func _on_AmmoCharger_ammoAdded():
	pistol.ammo += 1
	pass # Replace with function body.
