extends Control

var currentColor : int = Enums.COLORS.GREEN

func _ready():
	self.changeColor(Enums.COLORS.RED)
	$TextureProgress.value = 0
	$MiddlePos/Label.visible = false
	pass

func _physics_process(_delta):
	self._updateMiddlePos()
	pass

func updateMetter(value : float,Maxvalue : float,anim:bool = false) -> void:
	#Updating Label
	if anim == false:
		$MiddlePos/Label.text = String(value)
		$MiddlePos/Label.visible = true
		$LabelVisibleTimer.start()
	
	#Updating value
	var percent:float = round((value / Maxvalue) * 100)
	if anim: 
		$TextureProgress.value = percent

	$Tween.interpolate_property($TextureProgress,"value",$TextureProgress.value,percent,0.1)
	$Tween.start()


func changeColor(colorEnum:int):
	self.currentColor = colorEnum
	$TextureProgress.texture_progress = GameData.FRUIT_METTER_TEXTURES[colorEnum]
	pass


func _updateMiddlePos() -> void:
	var diffY = $BottomPos.position.y - $TopPos.position.y
	var percentPosY = diffY * ($TextureProgress.value / 100)
	$MiddlePos.position.y = $BottomPos.position.y - percentPosY
	pass


func _on_LabelVisibleTimer_timeout():
	$MiddlePos/Label.visible = false
	pass # Replace with function body.
