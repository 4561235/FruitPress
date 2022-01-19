extends Node2D
class_name JuiceBottle

var spawnPosition:Vector2
var spriteSpawnOffset:Vector2
var currentDrops:float

func _ready():
	self.spawnPosition = self.position - self.spriteSpawnOffset
	$Tween.interpolate_property(self,"position",self.position,self.position - self.spriteSpawnOffset,0.1)
	$Tween.start()
	pass

func init(spriteSpawnOffset:Vector2):
	self.spriteSpawnOffset = spriteSpawnOffset
	self.position += spriteSpawnOffset
	pass


func updateBarr(currentDrops:float, maxDrops:float, animation:bool=true) -> void:
	self.currentDrops = currentDrops
	
	self.refreshDespawnTime()
	$Tween.interpolate_property(self,"position",self.position,self.spawnPosition,0.1)
	$Tween.start()
	
	var percent:float = round((currentDrops / maxDrops) * 100)
	if !animation: 
		$TextureProgress.value = percent
	else:
		self._playBumpAnimation()
		$Tween.interpolate_property($TextureProgress,"value",$TextureProgress.value,percent,0.1)
		$Tween.start()
	

func changeColor(color:Color) -> void:
	$TextureProgress.tint_progress = color
	pass


func getColor() -> Color:
	return $TextureProgress.tint_progress


func getCurrentDrops() -> float:
	return self.currentDrops


func setJuiceAmount(amount:int) -> void:
	$Label.text = String(amount)


func getJuiceAmount() -> int:
	return int($Label.text)


func changeFruitSprite(fruitEnum:int) -> void:
	$FruitSprite.texture = GameData.FRUIT_TEXTURES[fruitEnum]
	pass


func refreshDespawnTime() -> void:
	$DespawnTimer.stop()
	$DespawnTimer.wait_time = 3
	$DespawnTimer.start()
	pass

func emitBottleGainParticles() -> void:
	var bottleGainAnimation = load("res://Scenes/DefaultWorld/Hud/JuiceBottleManager/JuiceBottle/BottleGainAnimation/BottleGainAnimation.tscn").instance()
	bottleGainAnimation.changeColor($TextureProgress.tint_progress)
	self.add_child(bottleGainAnimation)
	pass

#Play bump animation and sound effect
func _playBumpAnimation() -> void:
	var beginVect:Vector2 = Vector2(1,1)
	var endVect:Vector2 = Vector2(1.1,1.1)
	var time:float = 0.05
	
	#Sound effect
	$AudioStreamPlayer.play()
	
	$Tween.interpolate_property(self,"scale",beginVect,endVect,time)
	$Tween.start(); yield($Tween,"tween_all_completed")

	$Tween.interpolate_property(self,"scale",endVect,beginVect,time)
	$Tween.start()


func _on_DespawnTimer_timeout():
	$Tween.interpolate_property(self,"position",self.position,self.position+self.spriteSpawnOffset,0.06)
	$Tween.start(); yield($Tween,"tween_all_completed")
	self.queue_free()
	pass # Replace with function body.
