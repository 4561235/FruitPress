extends Node2D

export (NodePath) var worldMusicsPath

#COUNTING
var smashCount : int = 0
var timeBetweenSpawns : float = 0.5

func _ready():
	#$WeaponsManager.init(get_node(self.worldMusicsPath))
	$FruitManager.spawnFruit(Enums.FRUITS.APPLE)
	self.loadFromTempData()
	

func _physics_process(_delta):
	$ParallaxBackground.scroll_offset += Vector2(0,-3)


func _on_Weapon_smashed(weapon:Weapon, attackBuff:AttackBuff):
	var fruit:Fruit = $FruitManager.getFruit()
	if fruit == null: return
	
	#Vibration test
	#Input.vibrate_handheld(70)
	
	var maxDrops = GameStats.getMaxDrops(fruit.fruitEnum)
	var currentDrops = GameStats.getCurrentDrops(fruit.fruitEnum)
	var totalJuice = GameStats.getTotalJuice(fruit.fruitEnum)
	
	self.smashCount += 1 #Smash counting
	var dpsCalc:float = weapon.dps + (attackBuff.buffInfo[Enums.BUFF_PROPERTY.ATTACK]/100 * weapon.dps)

	var juiceGained:float = fruit.smashed(dpsCalc)
	
#	print("Juice: ",juiceGained)

	#Adding juice efficiency from buff
	var bonusBuffJuice = (attackBuff.buffInfo[Enums.BUFF_PROPERTY.EFFICIENCY]/100 * juiceGained)
	juiceGained += bonusBuffJuice
	
	var bonusEfficiencyJuice = (juiceGained * (weapon.efficiencyPercentage / 100))
	juiceGained += bonusEfficiencyJuice
	
	currentDrops += juiceGained
	GameStats.setCurrentDrops(fruit.fruitEnum,currentDrops)
	
#	print("DPS: ",weapon.dps)
	
#	print("Bonus Buff Juice: ",bonusBuffJuice)
#	print("Bonus Efficiency Juice: ",bonusEfficiencyJuice)
#	print("Total: ", (juiceGained * (weapon.efficiencyPercentage / 100)) + juiceGained)
#	print("----------\n")

	$Hud.emitDamageLabel(fruit.global_position, dpsCalc, weapon.efficiencyPercentage + attackBuff.buffInfo[Enums.BUFF_PROPERTY.EFFICIENCY])
	
	while currentDrops > maxDrops - 1:
		#Gain one juice
		currentDrops = currentDrops - maxDrops
		GameStats.setCurrentDrops(fruit.fruitEnum, currentDrops)
		totalJuice += 1
		GameStats.setTotalJuice(fruit.fruitEnum, totalJuice)
		

	$Hud.updateHud(maxDrops, currentDrops, self.smashCount, fruit)
	$Hud/JuiceDropsManager.emitDrops(fruit.fruitEnum, fruit.global_position, juiceGained)


#FRUIT SIGNALS
func _on_Fruit_dead():
	#SPAWN TIME
	yield(get_tree().create_timer(self.timeBetweenSpawns), "timeout")
	
	#INSTANCING
	var fruit:Fruit = $FruitManager.spawnFruit($Hud/FruitBar.getFruit(1))
	$Hud/FruitBar.deleteFruit(1)
	$Hud/FruitBar.addFruit(Enums.FRUITS.values()[randi() % len(Enums.FRUITS)])
	
	#INITING FRUIT
#	fruit.init($ParticlesPlaceholder.get_path())
#	fruit.connect("dead",self,"_on_Fruit_dead")
#	$FruitManager.changeFruit(fruit)
	
	#UPDATING HUD
	var maxDrops = GameStats.getMaxDrops(fruit.fruitEnum)
	var currentDrops = GameStats.getCurrentDrops(fruit.fruitEnum)
	$Hud.updateHud(maxDrops, currentDrops, self.smashCount, fruit)


var weaponChangeQueue = [Enums.WEAPONS.LYRE, Enums.WEAPONS.HAMMER, Enums.WEAPONS.PISTOL, Enums.WEAPONS.GUITAR]
var weaponChangeIndex = 0
func _on_ChangeWeaponButton_button_down():
	$WeaponsManager.changeWeapon(weaponChangeQueue[weaponChangeIndex])
	weaponChangeIndex += 1
	if weaponChangeIndex == len(weaponChangeQueue): weaponChangeIndex = 0


func _on_AutoAtack_pressed():
	if $TestingTimer.autostart: 
		$TestingTimer.autostart = false
		$TestingTimer.stop()
	else:
		$TestingTimer.autostart = true
		$TestingTimer.start()
	pass # Replace with function body.


func _on_TestingTimer_timeout():
	$WeaponsManager.getWeapon().smash()


func _on_DefaultWorld_tree_exiting() -> void:
	TemporarySave.pressingWorld[Enums.TEMPORARY_SAVE_PRESSING.COUNTER] = self.smashCount
	TemporarySave.pressingWorld[Enums.TEMPORARY_SAVE_PRESSING.FRUIT_ENUM] = $FruitManager.getFruit().fruitEnum
	TemporarySave.pressingWorld[Enums.TEMPORARY_SAVE_PRESSING.FRUIT_PV] = $FruitManager.getFruit().hp
	TemporarySave.pressingWorld[Enums.TEMPORARY_SAVE_PRESSING.WEAPON] = $WeaponsManager.getWeapon().weaponEnum
	TemporarySave.pressingWorld[Enums.TEMPORARY_SAVE_PRESSING.FRUIT_BAR_ARRAY] = $Hud/FruitBar.fruitArray
	TemporarySave.pressingWorld[Enums.TEMPORARY_SAVE_PRESSING.BACKGROUND_COLOR_FAZE] = $Backgrounds/ColourfullBackground.faze


func loadFromTempData() -> void:
	#Loading temp data
	#Counter
	self.smashCount = TemporarySave.pressingWorld[Enums.TEMPORARY_SAVE_PRESSING.COUNTER]
	#Fruit
	if TemporarySave.pressingWorld[Enums.TEMPORARY_SAVE_PRESSING.FRUIT_ENUM] != null:
		var fruit:Fruit = $FruitManager.spawnFruit(TemporarySave.pressingWorld[Enums.TEMPORARY_SAVE_PRESSING.FRUIT_ENUM], true)
		
		#UPDATING HUD
		var maxDrops = GameStats.getMaxDrops(fruit.fruitEnum)
		var currentDrops = GameStats.getCurrentDrops(fruit.fruitEnum)
		$Hud.updateHud(maxDrops, currentDrops, self.smashCount, fruit)
	#Weapon
	if TemporarySave.pressingWorld[Enums.TEMPORARY_SAVE_PRESSING.WEAPON] != null:
		$WeaponsManager.changeWeapon(TemporarySave.pressingWorld[Enums.TEMPORARY_SAVE_PRESSING.WEAPON])
	else:
		#If temporary save not found
		$WeaponsManager.changeWeapon(Enums.WEAPONS.HAMMER)
	
	if TemporarySave.pressingWorld[Enums.TEMPORARY_SAVE_PRESSING.FRUIT_BAR_ARRAY] != null:
		for fruitEnum in TemporarySave.pressingWorld[Enums.TEMPORARY_SAVE_PRESSING.FRUIT_BAR_ARRAY]:
			$Hud/FruitBar.addFruit(fruitEnum)
	else:
		#Filling fruit bar with random fruits
		for _i in range(4):
			$Hud/FruitBar.addFruit(Enums.FRUITS.values()[randi() % len(Enums.FRUITS)])
