extends Node2D

signal weaponChanged(weaponEnum)

export (NodePath) var weaponInterfacePlaceholderPath
export (NodePath) var signalNode
export (NodePath) var worldMusicsPath
export (NodePath) var screenDarkenerPath
#export (NodePath) var fruitManager

var target:Fruit = null

#func init(worldMusicsPath:Node) -> void:
#	self.worldMusicsPath = worldMusicsPath
#	pass

func _ready():
	self.global_position.y = 0
	self.global_position.y += OS.get_screen_size().y /4 + 200
	pass


func getWeapon() -> Weapon:
	for i in self.get_children():
		if i.get_child_count() > 0: return i.get_child(0)
	return null


func changeWeapon(weaponEnum:int) -> void:
	self.get_node(worldMusicsPath).changeVolume(-15)
	self.get_node(self.screenDarkenerPath).changeDark(0)
	
	self._removeWeapon()
	match weaponEnum:
		Enums.WEAPONS.HAMMER:
			
			#HAMMER
			var hammer : Weapon = GameData.WEAPON_SCENES[weaponEnum].instance()
			$HammerPosition.add_child(hammer)
			
			#INTERFACE
			var interface = hammer.weaponInterface.instance()
			get_node(weaponInterfacePlaceholderPath).add_child(interface)
			
			#CONNECTING SIGNALS
			interface.connect("button_down",hammer,"smash")
			hammer.connect("smashed",get_node(signalNode),"_on_Weapon_smashed")
			
			emit_signal("weaponChanged", weaponEnum)
			
		Enums.WEAPONS.LYRE:
			
			#LYRE
			var lyre : Weapon = GameData.WEAPON_SCENES[weaponEnum].instance()
			lyre.init(self.target)
			$LyrePosition.add_child(lyre)
			
			#INTERFACE
			var interface = lyre.weaponInterface.instance()
			interface.init(lyre)
			get_node(weaponInterfacePlaceholderPath).add_child(interface)
			
			#CONNECTING SIGNALS
#			interface.get_node("HBoxContainer/Button1").connect("button_down",lyre,"smashWithBlueNote")
#			interface.get_node("HBoxContainer/Button2").connect("button_down",lyre,"smashWithGreenNote")
#			interface.get_node("HBoxContainer/Button3").connect("button_down",lyre,"smashWithRedNote")
#			interface.get_node("UltiButton").connect("button_down",lyre,"_on_UltiButton_down")
			lyre.connect("smashed",get_node(signalNode),"_on_Weapon_smashed")
			
			emit_signal("weaponChanged", weaponEnum)
			
		Enums.WEAPONS.PISTOL:
			
			#PISTOL
			var pistol : Weapon = GameData.WEAPON_SCENES[weaponEnum].instance()
			pistol.init(self.target, get_node(weaponInterfacePlaceholderPath))
			$PistolPosition.add_child(pistol)
			
			
			#INTERFACE
			var interface = pistol.weaponInterface.instance()
			interface.init(pistol)
			get_node(weaponInterfacePlaceholderPath).add_child(interface)
			
			#CONNECTING SIGNALS
			interface.get_node("Button").connect("button_down",pistol,"smash")
			pistol.connect("smashed",get_node(signalNode),"_on_Weapon_smashed")
			
			emit_signal("weaponChanged", weaponEnum)
			
		Enums.WEAPONS.GUITAR:
			
			#GUITAR
			var guitar:Weapon = GameData.WEAPON_SCENES[weaponEnum].instance()
			guitar.init(self.target, get_node(self.worldMusicsPath), get_node(self.screenDarkenerPath))
			$GuitarPosition.add_child(guitar)
			
			#INTERFACE
			var interface = guitar.weaponInterface.instance()
			interface.init(guitar)
			get_node(weaponInterfacePlaceholderPath).add_child(interface)
			
			#CONNECTING SIGNALS
			interface.connect("buttonPressed",guitar,"smash")
			guitar.connect("smashed",get_node(signalNode),"_on_Weapon_smashed")
	
			emit_signal("weaponChanged", weaponEnum)


func changeTarget(fruit:Fruit):
	self.target = fruit
	for i in self.get_children():
		if i.get_child_count() > 0:
			i.get_child(0).target = fruit


func _removeWeapon():
	for pos in self.get_children():
		for w in pos.get_children():
			w.queue_free()
		
	for i in get_node(self.weaponInterfacePlaceholderPath).get_children():
		i.queue_free()
	pass


func _on_FruitManager_FruitChanged(fruit:Fruit) -> void:
	self.target = fruit
