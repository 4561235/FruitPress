extends Weapon
class_name Guitar
signal smashed(weapon)

var currentBuff = AttackBuff.new()
var worldMusics:Node = null
var screenDarkener:Control = null

func _init():
	self.weaponInterface = preload("res://Scenes/DefaultWorld/Weapons/Guitar/Interface/GuitarInterface.tscn")
	self.weaponEnum = Enums.WEAPONS.GUITAR
	self.dps = 1
	self.efficiencyPercentage = 0


func init(target:Fruit, worldMusics:Node, screenDarkener:Control) -> void:
	self.target = target
	self.worldMusics = worldMusics
	self.screenDarkener = screenDarkener


func _ready() -> void:
	$AnimationPlayer.play("Idle")


var lastTargetPosition:Vector2
func smash() -> void:
	if is_instance_valid(self.target): self.lastTargetPosition = self.target.global_position
	
	#Spawning skull
	var skull:Skull = load("res://Scenes/DefaultWorld/Weapons/Guitar/Skull/Skull.tscn").instance()
	skull.init($SkullSpawnPos.position, to_local(self.lastTargetPosition))
	skull.connect("hit",self,"_on_Skull_hit")
	self.add_child(skull)
	pass

func _on_Skull_hit():
	emit_signal("smashed", self, self.currentBuff)
	pass


func activeBlueBuff() -> void:
	self.currentBuff = AttackBuff.new()
	self.currentBuff.buffInfo[Enums.BUFF_PROPERTY.ATTACK] = float(70)
	pass


func activeGreenBuff() -> void:
	self.currentBuff = AttackBuff.new()
	self.currentBuff.buffInfo[Enums.BUFF_PROPERTY.ATTACK] = float(120)
	pass


func activeRedBuff() -> void:
	self.currentBuff = AttackBuff.new()
	self.currentBuff.buffInfo[Enums.BUFF_PROPERTY.ATTACK] = float(170)
	self.currentBuff.buffInfo[Enums.BUFF_PROPERTY.EFFICIENCY] = float(10)
	pass


func disableBuff() -> void:
	self.currentBuff = AttackBuff.new()
	pass


func playMusic() -> void:
	if !$Sounds/Music/GuitarMusic.playing:
		self.screenDarkener.changeDark(0.4)
		self.worldMusics.changeVolume(-30)
		$Sounds/Music/GuitarMusic.play()


func stopMusic() -> void:
	self.worldMusics.changeVolume(-15)
	self.screenDarkener.changeDark(0)
	$Sounds/Music/GuitarMusic.stop()


func playFailSound() -> void:
	if $Sounds/Music/GuitarMusic.playing:
		match randi()%3:
			0: $Sounds/FailSounds/Fail1.play()
			1: $Sounds/FailSounds/Fail2.play()
			2: $Sounds/FailSounds/Fail3.play()
