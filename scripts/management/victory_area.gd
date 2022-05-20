extends Area2D

func on_VictoryArea_entered(body):
	if body is KinematicBody:
		Globals.is_in_the_end = true
		if Globals.atual_level == 1:
			var _reload = get_tree().change_scene("res://scenes/management/level_two.tscn")
		elif Globals.atual_level == 2:
			var _reload = get_tree().change_scene("res://scenes/management/level_three.tscn")
		elif Globals.atual_level == 3:
			var _reload = get_tree().change_scene("res://scenes/management/victory_screen.tscn")

