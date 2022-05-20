extends Area2D



func on_Plaque_body_entered(body):
	if body is KinematicBody2D:
		Globals.is_in_the_end = true
