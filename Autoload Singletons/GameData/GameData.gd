extends Node

var FRUIT_TEXTURES = {
	Enums.FRUITS.APPLE : preload("res://Scenes/DefaultWorld/Fruits/Apple/apple.png"),
	Enums.FRUITS.PLUM : preload("res://Scenes/DefaultWorld/Fruits/Plum/plum.png"),
	Enums.FRUITS.KIWI : preload("res://Scenes/DefaultWorld/Fruits/Kiwi/kiwi.png"),
	Enums.FRUITS.BANANA : preload("res://Scenes/DefaultWorld/Fruits/Banana/banana.png")
}


var FRUIT_COLORS = {
	Enums.FRUITS.APPLE: Color("d40000"),
	Enums.FRUITS.PLUM: Color("3737c8"),
	Enums.FRUITS.KIWI: Color("71c837"),
	Enums.FRUITS.BANANA: Color("ffd42a")
}

var FRUIT_SCENES = {
	Enums.FRUITS.APPLE : preload("res://Scenes/DefaultWorld/Fruits/Apple/Apple.tscn"),
	Enums.FRUITS.PLUM : preload("res://Scenes/DefaultWorld/Fruits/Plum/Plum.tscn"),
	Enums.FRUITS.KIWI : preload("res://Scenes/DefaultWorld/Fruits/Kiwi/Kiwi.tscn"),
	Enums.FRUITS.BANANA : preload("res://Scenes/DefaultWorld/Fruits/Banana/Banana.tscn")
}

var WEAPON_SCENES = {
	Enums.WEAPONS.HAMMER : preload("res://Scenes/DefaultWorld/Weapons/Hammer/Hammer.tscn"),
	Enums.WEAPONS.LYRE : preload("res://Scenes/DefaultWorld/Weapons/Lyre/Lyre.tscn"),
	Enums.WEAPONS.PISTOL : preload("res://Scenes/DefaultWorld/Weapons/Pistol/Pistol.tscn"),
	Enums.WEAPONS.GUITAR : preload("res://Scenes/DefaultWorld/Weapons/Guitar/Guitar.tscn")
}

var LYRE_NOTES_TEXTURES = {
	Enums.LYRE_NOTES.BLUE : preload("res://Scenes/DefaultWorld/Weapons/Lyre/Note/blueNote.png"),
	Enums.LYRE_NOTES.RED : preload("res://Scenes/DefaultWorld/Weapons/Lyre/Note/redNote.png"),
	Enums.LYRE_NOTES.GREEN : preload("res://Scenes/DefaultWorld/Weapons/Lyre/Note/greenNote.png")
}
