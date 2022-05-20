extends Control



func play():
	var _change_scene = get_tree().change_scene("res://scenes/management/level.tscn")
	Globals.bunny_is_alive = true
	Globals.health_player = 5


func quit():
	get_tree().quit()
