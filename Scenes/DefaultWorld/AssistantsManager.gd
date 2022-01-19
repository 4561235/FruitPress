extends Node2D

export (NodePath) var weaponInterfacePlaceholderPath
export (NodePath) var fruitManagerPath

onready var weaponInterface:Control = get_node(weaponInterfacePlaceholderPath)
onready var fruitManager:Node2D = get_node(fruitManagerPath)

func _ready() -> void:
	pass


func _spawnAssistant(assistantEnum:int) -> void:
	match assistantEnum:
		Enums.ASSISTANTS.FOX:
			var fox = load("res://Scenes/DefaultWorld/Assistants/Fox/Fox.tscn").instance()
			fox.init(self.weaponInterface.get_child(0))
			$RightSpawnPos.add_child(fox)


#Maybe pass weapon interface via signal like: _on_WeaponsManager_weaponChanged(weaponEnum:int, interface)
func _on_WeaponsManager_weaponChanged(weaponEnum:int) -> void:
	#Wait interface to spawn
	yield(get_tree().create_timer(0.5),"timeout")
	
	match weaponEnum:
		Enums.WEAPONS.HAMMER:
			self._spawnAssistant(Enums.ASSISTANTS.FOX)
			pass
