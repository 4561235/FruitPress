extends Node2D
class_name Fruit

#SIGNALS
signal dead
signal hitAnimFinished


var particlePlaceholder

#FOR BUMPING ANIMATION
onready var beginScale : Vector2 = Vector2($Sprites/Sprite.scale.x,$Sprites/Sprite.scale.y)
onready var endScale : Vector2 = Vector2($Sprites/Sprite.scale.x,0.6)

#PARTICLES
var EmptyFruitRes = preload("res://Scenes/DefaultWorld/Fruits/Apple/NoJuiceAnim/NoJuiceAnim.tscn")
onready var emptyFruitTexture : Texture = $Sprites/Sprite.texture


#HEALTH POINTS
var hpMax : int = 20
var hp : int = 20

#STATS

var fruitEnum = Enums.FRUITS.APPLE
var fruitTypeEnum = Enums.FRUIT_TYPES.NORMAL



func init(particlePlaceholder:Node2D, loadFromTempData:bool = false) -> void:
	self.particlePlaceholder = particlePlaceholder
	if loadFromTempData:
		self.loadHpFromTempData()
	pass

func _ready():
	$HpBar.tint_progress = GameData.FRUIT_COLORS[self.fruitEnum]
	$HpBar.updateBar(hp,hpMax)
	pass


func smashed(dps:int) -> int:
	self.hp -= dps
	self._checkDeath()
	$HpBar.updateBar(hp,hpMax)
	self._playHitAnim()
	self._playSound()
	
	#Reset IdleTimer
	$AnimationPlayer.play("INIT")
	$IdleTimer.stop()
	$IdleTimer.wait_time = 3
	$IdleTimer.start()
	
	if self.hp < 0: return self.hp + dps #If hp are negative
	else: return dps
	
	


func _playHitAnim() -> void:
	var beginDuration : float = 0.08
	var endDuration : float = 0.18
	var transBegin = Tween.TRANS_ELASTIC
	var transEnd = Tween.TRANS_LINEAR
	
	$Tween.interpolate_property($Sprites/Sprite,"scale",$Sprites/Sprite.scale,endScale,beginDuration,transBegin)
	$Tween.start(); yield($Tween,"tween_all_completed")
	
	$Tween.interpolate_property($Sprites/Sprite,"scale",endScale,beginScale,endDuration,transEnd)
	$Tween.start(); yield($Tween,"tween_all_completed")
	emit_signal("hitAnimFinished")


#Prevent spawning
var _notDead : bool = true
func _checkDeath() -> void:
	
	if self.hp <= 0 && _notDead:
		self._notDead = false
		self._emitEmptyFruitParticle()
		self.emit_signal("dead")
		self.queue_free()


func _emitEmptyFruitParticle() -> void:
	var emptyFruit : CPUParticles2D = EmptyFruitRes.instance()
	emptyFruit.init(self.emptyFruitTexture)
	emptyFruit.position = to_global(self.position)
	self.particlePlaceholder.add_child(emptyFruit)


func _playSound() -> void:
	randomize()
	var sound : AudioStreamPlayer = $Sounds.get_child(randi()%$Sounds.get_child_count())
	sound.volume_db = -10
	sound.pitch_scale = rand_range(0.7,1)
	sound.play()


func _on_IdleTimer_timeout():
	for _i in range(2):
		$AnimationPlayer.play("Idle")
		yield($AnimationPlayer,"animation_finished")
	$IdleTimer.wait_time = 1
	$IdleTimer.start()


func loadHpFromTempData() -> void:
	self.hp = TemporarySave.pressingWorld[Enums.TEMPORARY_SAVE_PRESSING.FRUIT_PV]
	$HpBar.updateBar(self.hp, self.hpMax)
	
