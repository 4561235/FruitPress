extends Node2D
class_name JuiceBarr

func _ready():
	#INITIALISATION
	$BackgroundOver.rect_size = $Sprite.texture.get_size()
	$BackgroundOver.rect_position = $Sprite.position
	$BackgroundOver.rect_position -= $BackgroundOver.rect_size/2
	
	$BackgroundUnder.rect_size = $Sprite.texture.get_size()
	$BackgroundUnder.rect_position = $Sprite.position
	$BackgroundUnder.rect_position -= $BackgroundUnder.rect_size/2
	
#	self.updateBarr(0,1,false)
#	for i in range(31):
#		yield(get_tree().create_timer(0.1),"timeout")
#		self.updateBarr(i,30)
	pass


func updateBarr(value:float, Maxvalue:float, animation:bool=true) -> void:
	var diffY:float = $BottomPos.position.y - $TopPos.position.y

	var percent:float = round((value / Maxvalue) * 100)
	percent = 100 - percent

	var percentDiffY = diffY - (diffY * (percent/100))
	
	var sizeYBefore = $BackgroundOver.rect_size.y
	$BackgroundOver.rect_size.y = percentDiffY
	var sizeYAfter = $BackgroundOver.rect_size.y
	var sizeDiff = sizeYBefore - sizeYAfter
	
	if animation:
		$Tween.interpolate_property($BackgroundOver,"rect_position",$BackgroundOver.rect_position,Vector2($BackgroundOver.rect_position.x,$BackgroundOver.rect_position.y + sizeDiff),0.1)
		$Tween.start()
#		$BackgroundOver.rect_position.y += sizeDiff
	else:
		$BackgroundOver.rect_position.y += sizeDiff


func changeColor(color:Color) -> void:
	$BackgroundOver.color = color
	pass
