extends Control

onready var bar1 = get_node("Life/HBoxContainer/Bar1")
onready var bar2 = get_node("Life/HBoxContainer/Bar2")
onready var bar3 = get_node("Life/HBoxContainer/Bar3")
onready var bar4 = get_node("Life/HBoxContainer/Bar4")
onready var bar5 = get_node("Life/HBoxContainer/Bar5")

onready var label = get_node("Pontuation")




func _process(_delta):
	on_Bars_visibility_changed()
	label.text = str(Globals.enemies_count)


func on_Bars_visibility_changed():
	if Globals.health_player == 5:
		bar1.visible = true
		bar2.visible = true
		bar3.visible = true
		bar4.visible = true
		bar5.visible = true
	elif Globals.health_player == 4:
		bar5.visible = false
		bar1.visible = true
		bar2.visible = true
		bar3.visible = true
		bar4.visible = true
	elif Globals.health_player == 3:
		bar4.visible = false
		bar1.visible = true
		bar2.visible = true
		bar3.visible = true
		bar5.visible = false
	elif Globals.health_player == 2:
		bar3.visible = false
		bar1.visible = true
		bar2.visible = true
		bar4.visible = false
		bar5.visible = false
	elif Globals.health_player == 1:
		bar2.visible = false
		bar1.visible = true
		bar3.visible = false
		bar4.visible = false
		bar5.visible = false
	elif Globals.health_player == 0:
		bar1.visible = false
		bar2.visible = false
		bar3.visible = false
		bar4.visible = false
		bar5.visible = false
		

		
