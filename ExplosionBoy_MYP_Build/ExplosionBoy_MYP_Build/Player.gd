extends KinematicBody2D

const speed = 200
const jumpPower = -200
const Floor = Vector2(0,-1)
var velocity = Vector2()
var gravity = 10
var pressed = false
var explosionPowerX 
var explosionPowerY
const explosionPower = 400

const Explosive = preload("res://Explosive.tscn")

var onGround = false

func _physics_process(delta):
	
	if Input.is_key_pressed(KEY_D):
		velocity.x = speed
	elif Input.is_key_pressed(KEY_A):
		velocity.x = -speed
	else: 
		velocity.x = 0
	if Input.is_key_pressed(KEY_W):
		if onGround == true:
			velocity.y = jumpPower
			onGround = false
	if Input.is_action_just_pressed("pressed_o") && !get_parent().has_node("Explosive"):
		var explosive = Explosive.instance()
		get_parent().add_child(explosive)
		explosive.position = $Position2D.global_position
	if get_parent().has_node("Explosive"):
		var positionOfExplosive = get_parent().get_node("Explosive").get_pos()
		if round(self.position.x) > round(positionOfExplosive.x):
			print("right")
			explosionPowerX = explosionPower
		elif round(self.position.x) < round(positionOfExplosive.x):
			print("left")
			explosionPowerX = -explosionPower
		else:
			explosionPowerX = 0
		if round(self.position.y) < round(positionOfExplosive.y):
			print("up")
			explosionPowerY = -explosionPower
		elif round(self.position.y) > round(positionOfExplosive.y):
			print("down")
			explosionPowerY = explosionPower
		else:
			explosionPowerY = 0
			
	if get_parent().has_node("Explosive") && Input.is_action_just_pressed("pressed_p") && pressed == false:
		get_parent().get_node("Explosive").set_speed(0)
		velocity.y = explosionPowerY
		pressed = true
		var distance = self.position.direction_to(get_parent().get_node("Explosive").get_pos())
		
	if get_parent().has_node("Explosive") && pressed == true:
		velocity.x = explosionPowerX
	if !get_parent().has_node("Explosive"):
		pressed = false
	velocity.y += gravity
	if is_on_floor():
		onGround = true
	else:
		onGround = false
	velocity = move_and_slide(velocity, Floor)
