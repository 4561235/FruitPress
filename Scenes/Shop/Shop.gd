extends Control


func _ready() -> void:
	$AudioPlayer.playMusic()
	
	$AdMob.move_banner(false)
	$AdMob.load_banner()
	$AdMob.show_banner()
	$BackButton.rect_position.y -= 90
	
#	self.margin_bottom = OS.get_screen_size().y
#	self.rect_size.y = OS.get_screen_size().y
	pass # Replace with function body.


func hideAll() -> void:
	$WeaponShop.hide()
	$SellShop.hide()
	$BackButton.hide()


func _on_AdMob_rewarded_video_loaded() -> void:
	$AdMob.show_rewarded_video()
	pass # Replace with function body.


func _on_Shop_tree_exiting() -> void:
	$AdMob.hide_banner()
	pass # Replace with function body.


func _on_Button_pressed() -> void:
	$AdMob.load_rewarded_video()
	pass # Replace with function body.


func _on_WeaponMenu_pressed() -> void:
	$Menu.visible = false
	$WeaponShop.visible = true
	$BackButton.visible = true
	pass # Replace with function body.


func _on_SellButton_pressed() -> void:
	$Menu.visible = false
	$SellShop.visible = true
	$BackButton.visible = true
	pass # Replace with function body.


func _on_BackButton_pressed() -> void:
	$Menu.visible = true
	self.hideAll()
	pass # Replace with function body.

