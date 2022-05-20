extends Control

onready var label = get_node("Text")

func _ready():
	label.text = "VOCÊ VENCEU!!\n" + str(Globals.enemies_count)
	Globals.enemies_count = 0


func play():
	var _change_scene = get_tree().change_scene("res://scenes/management/level.tscn")
	Globals.bunny_is_alive = true
	Globals.health_player = 5


func quit():
	var _change_scene = get_tree().change_scene("res://scenes/management/menu.tscn")
