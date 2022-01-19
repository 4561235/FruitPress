extends Node2D

signal ammoAdded

func _ready():
#	for _i in range(6):
#		yield(get_tree().create_timer(1),"timeout")
#		self.addAmmo()
#	for _i in range(6):
#		yield(get_tree().create_timer(1),"timeout")
#		self.removeAmmo()
	pass


func addAmmo() -> void:
	if self.getAmmoNumber() < 6:
		var textureRect:TextureRect = TextureRect.new()
		textureRect.texture = load("res://Scenes/DefaultWorld/Weapons/Pistol/Bullet/bullet.png")
		$Sprite/VBoxContainer.add_child(textureRect)


func removeAmmo() -> void:
	$Sprite/VBoxContainer.get_children()[getAmmoNumber() - 1].queue_free()
	$AnimationPlayer.play("AmmoRemoved")


func getAmmoNumber() -> int:
	return $Sprite/VBoxContainer.get_child_count()


func _on_Area2D_area_entered(_area):
	emit_signal("ammoAdded")
	$AnimationPlayer.play("AmmoAdded")
	$AudioStreamPlayer.play()
	self.addAmmo()
	pass # Replace with function body.
