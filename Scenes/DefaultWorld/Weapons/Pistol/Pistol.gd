extends Weapon
signal smashed(weapon)
signal ammoUpdated(amount)

var weaponInterfacePlaceholderNode
var targetBoardNode

var ammo:int = 6

func _init():
	self.weaponInterface = preload("res://Scenes/DefaultWorld/Weapons/Pistol/Interface/PistolInterface.tscn")
	self.weaponEnum = Enums.WEAPONS.PISTOL
	self.dps = 3
	self.efficiencyPercentage = -50


func init(target:Fruit, weaponInterfacePlaceholderNode):
	self.target = target
	print(weaponInterfacePlaceholderNode)
	self.weaponInterfacePlaceholderNode = weaponInterfacePlaceholderNode


func _ready():
	$AnimationPlayer.play("MoveWings")
	var targetBoard:TargetBoard = load("res://Scenes/DefaultWorld/Weapons/Pistol/TargetBoard/TargetBoard.tscn").instance()
	self.weaponInterfacePlaceholderNode.add_child(targetBoard)
	targetBoard.init(self.target.global_position)
	targetBoard.connect("outsideHited",self,"_on_TargetBoard_outsideHited")
	targetBoard.connect("middleHited",self,"_on_TargetBoard_middleHited")
	
	self.targetBoardNode = targetBoard


func _physics_process(_delta):
	self.rotation_degrees = rad2deg(self.global_position.angle_to_point(self.targetBoardNode.getViewFinderPosition())) - 200


func smash() -> void:
	#If there is no ammo, do nothing
	if self.ammo <= 0:
		$AnimationPlayer.play("ShotWithoutAmmo")
		$Sounds/ShotWithoutAmmo.play()
		return
	
	self.ammo -= 1
	emit_signal("ammoUpdated",self.ammo)
	
	
	#INSTANCING BULLET
	var bullet:Bullet = load("res://Scenes/DefaultWorld/Weapons/Pistol/Bullet/Bullet.tscn").instance()
	bullet.init($BulletPoint.position, to_local(self.targetBoardNode.getViewFinderPosition()))

	self.add_child(bullet)
	
	$AnimationPlayer.play("Shoot")
	$Sounds/Shot.play()
	yield($AnimationPlayer,"animation_finished")
	$AnimationPlayer.play("INIT"); yield($AnimationPlayer,"animation_finished")
	$AnimationPlayer.play("MoveWings")
	

func _on_TargetBoard_outsideHited():
	emit_signal("smashed",self,AttackBuff.new())


func _on_TargetBoard_middleHited():
	var attackBuff:AttackBuff = AttackBuff.new()
	attackBuff.buffInfo[Enums.BUFF_PROPERTY.ATTACK] = float(150)
	emit_signal("smashed",self,attackBuff)
