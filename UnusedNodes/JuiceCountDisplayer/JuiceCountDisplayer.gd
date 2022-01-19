extends Node2D
class_name JuiceCountDisplayer

var currentFruitEnum = Enums.FRUITS.APPLE

func _ready():
	$Sprite/Label.text = String(GameStats.getTotalJuice(currentFruitEnum)-1)

func init(fruitEnum:int):
	self.changeFruitLogo(fruitEnum)
	

func updateDisplay(value : int, playAnim:bool = true) -> void:
	$Sprite/Label.text = String(value)
	if(playAnim): bumpAnim()

func bumpAnim() -> void:
	var begin : Vector2 = Vector2(1,1)
	var end : Vector2 = Vector2(1.3,1.3)
	var time : float = 0.15
	
	$Tween.interpolate_property($Sprite,"scale",begin,end,time)
	$Tween.start(); yield($Tween,"tween_all_completed")
	$Tween.interpolate_property($Sprite,"scale",end,begin,time)
	$Tween.start(); yield($Tween,"tween_all_completed")

func changeFruitLogo(fruitEnum:int):
	self.currentFruitEnum = fruitEnum
	$Sprite/FruitLogo.texture = GameData.FRUIT_TEXTURES[fruitEnum]
