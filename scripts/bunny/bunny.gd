extends KinematicBody2D


onready var animation = get_node("AnimationPlayer")

onready var hitbox = get_node("Hitbox")
onready var hitbox_timer = get_node("Hitbox/Timer")

onready var attack_timer = get_node("Timer")

onready var sprite = get_node("Sprite")
onready var spawn = get_node("Spawn")


var armed_sprite = "res://assets/bunny/armed.png"

var armed = false
var can_attack = true

var jump_cont = 0

var velocity: Vector2

export(PackedScene) var projectile
export(PackedScene) var hit_effect
export(PackedScene) var death_effect

export(bool) var attacking

export(float) var attack_cooldown
export(float) var invunerability_time

export(int) var speed
export(int) var jump_speed
export(int) var fall_speed

export(int) var health



func _physics_process(delta):
	move()
	attack()
	velocity.y += fall_speed * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	jump()
	animate()
	if spawn.position.x > 1433:
		Globals.is_in_the_end = true



func change_sprite():
	armed = true
	sprite.texture = load(armed_sprite)

func move():
	var direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = direction * speed

func attack():
	if Input.is_action_just_pressed("attack") and armed and can_attack:
		spawn_projectile()
		attacking = true
		can_attack = false
		set_physics_process(false)
		attack_timer.start(attack_cooldown)

func spawn_projectile():
	var projectile_instance = projectile.instance()
	if sprite.flip_h:
		projectile_instance.direction = -1
	projectile_instance.global_position = spawn.global_position
	get_tree().root.call_deferred("add_child", projectile_instance)

func update_health(body):
	hitbox.set_deferred("monitoring", false)
	hitbox_timer.start(invunerability_time)
	Globals.health_player -= body.damage
	if Globals.health_player <= 0:
		spawn_effect(death_effect)
		var _reload = get_tree().change_scene("res://scenes/management/game_over.tscn")
		Globals.bunny_is_alive = false
	else:
		spawn_effect(hit_effect)

func spawn_effect(target_effect):
	var effect = target_effect.instance()
	effect.global_position = global_position
	get_tree().root.call_deferred("add_child", effect)

func jump():
	if is_on_floor():
		jump_cont = 0
	if Input.is_action_just_pressed("ui_select") and jump_cont <2 :
		velocity.y = jump_speed
		jump_cont += 1
	
func animate():
	verify_direction()
	if attacking:
		animation.play("fire")
	elif velocity.y != 0 and not attacking:
		animation.play("jump")
	elif velocity.x != 0 and not attacking:
		animation.play("run")
	elif not attacking:
		animation.play("idle")

func verify_direction():
	if velocity.x > 0:
		sprite.flip_h = false
		spawn.position = Vector2(7, 3)
	elif velocity.x < 0:
		sprite.flip_h = true
		spawn.position = Vector2(-7, 3)


func on_attack_timeout():
	can_attack = true


func on_hit_timeout():
	hitbox.set_deferred("monitoring", true)


func on_body_entered(body):
	if Globals.is_in_the_end == true and body is KinematicBody2D:
		Globals.is_in_the_end = false
		if Globals.atual_level == 1:
			var _reload = get_tree().change_scene("res://scenes/management/level_two.tscn")
		elif Globals.atual_level == 2:
			Globals.health_player = 5
			var _reload = get_tree().change_scene("res://scenes/management/level_three.tscn")
		elif Globals.atual_level == 3:
			var _reload = get_tree().change_scene("res://scenes/management/victory_screen.tscn")
	elif Globals.is_in_the_end == false and body is KinematicBody2D:
		var _reload = get_tree().change_scene("res://scenes/management/game_over.tscn")
		Globals.bunny_is_alive = false

