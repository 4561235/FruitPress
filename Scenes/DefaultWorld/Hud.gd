extends CanvasLayer
class_name DefaultWorldHud

func _ready() -> void:
	#Loading temp data
	$Counter.text = String(TemporarySave.pressingWorld[Enums.TEMPORARY_SAVE_PRESSING.COUNTER])


func updateHud(maxDrops:float, currentDrops:float, smashCount:int, fruit:Fruit) -> void:
	$Counter.text = String(smashCount)
	$JuiceBottleManager.displayBottle(fruit.fruitEnum)


func emitDamageLabel(position:Vector2, damageInfo:float, efficiencyInfo:float) -> void:
	var dmgLabel:DamageLabel = load("res://Scenes/DefaultWorld/Hud/DamageLabel/DamageLabel.tscn").instance()
	var stringInfo:String = String(damageInfo) + " " + "(" + String(efficiencyInfo) + "%" + ")"
	dmgLabel.init(position, Color(1,1,1,1), stringInfo)
	self.add_child(dmgLabel)
	pass


