extends Node2D

signal buffEnded(lyreBuffEnum)

var bottleTexture:Texture = load("res://Scenes/DefaultWorld/Weapons/Lyre/BuffIcon/bottleIcon.png")
var swordTexture:Texture = load("res://Scenes/DefaultWorld/Weapons/Lyre/BuffIcon/swordIcon.png")
var redArrowTexture:Texture = load("res://Scenes/DefaultWorld/Weapons/Lyre/BuffIcon/redArrow.png")

var blueColor:Color = Color("6180f7")
var orangeColor:Color = Color("eec343")
var redColor:Color = Color("fd3b00")


var secondsLeft:int = 0
var lyreBuffEnum:int = -1

var buffTextures = {
	Enums.LYRE_BUFFS_NAME.ATTACK_INCREASED : self.swordTexture,
	Enums.LYRE_BUFFS_NAME.EFFICIENCY_INCREASED : self.bottleTexture,
	#TO CHANGE!
	Enums.LYRE_BUFFS_NAME.BONUS : self.redArrowTexture
}



func _ready():
	self.visible = false
#	self.changeBuff(Enums.LYRE_BUFFS_NAME.ATTACK_INCREASED,5)
#	yield(get_tree().create_timer(6),"timeout")
#	self.changeBuff(Enums.LYRE_BUFFS_NAME.EFFICIENCY_INCREASED,15)
	pass


func changeBuff(lyreBuffEnum:int, seconds:int, buffLevel:int = 1) -> void:
	#End previous buff
	#-1 is the initialisation so no buff is active
	if self.lyreBuffEnum != -1 and lyreBuffEnum != self.lyreBuffEnum:
		emit_signal("buffEnded",self.lyreBuffEnum)
	
	#Start new buff
	self.visible = true
	self.secondsLeft = seconds
	$Label.text = String(seconds)
	$Icon.texture = self.buffTextures[lyreBuffEnum]
	self.lyreBuffEnum = lyreBuffEnum
	
	if buffLevel == 1: $UltiAnim.modulate = self.blueColor
	elif buffLevel == 2: $UltiAnim.modulate = self.orangeColor
	elif buffLevel == 3: $UltiAnim.modulate = self.redColor
	
	$Timer.start()
	pass


func _on_Timer_timeout():
	if self.secondsLeft <= 0:
		self.visible = false
		$Timer.stop()
		emit_signal("buffEnded",self.lyreBuffEnum)
		
	self.secondsLeft -= 1
	$Label.text = String(self.secondsLeft)
	$Timer.start()
	
	pass # Replace with function body.
