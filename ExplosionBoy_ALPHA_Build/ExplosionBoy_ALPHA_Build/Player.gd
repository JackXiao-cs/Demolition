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
var hp = 10
var damageToBoss = 1

var is_dead = false

const Explosive = preload("res://Explosive.tscn")

var onGround = false

func get_pos() -> Vector2:
	return self.position

func _physics_process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
	
	if is_dead == false:
		if Input.is_key_pressed(KEY_D):
			velocity.x = speed
			$AnimatedSprite.play("Run")
			$AnimatedSprite.flip_h = false
		elif Input.is_key_pressed(KEY_A):
			$AnimatedSprite.play("Run")
			$AnimatedSprite.flip_h = true
			velocity.x = -speed
		else: 
			velocity.x = 0
			if is_on_floor() == true:
				$AnimatedSprite.play("Idle")
		if Input.is_key_pressed(KEY_W):
			if onGround == true:
				velocity.y = jumpPower
				onGround = false
		if Input.is_action_just_pressed("pressed_o") && !get_parent().has_node("Explosive"):
			$AnimatedSprite.play("Plant")
			var explosive = Explosive.instance()
			get_parent().add_child(explosive)
			explosive.position = $Position2D.global_position
		if get_parent().has_node("Explosive"):
			var positionOfExplosive = get_parent().get_node("Explosive").get_pos()
			if round(self.position.x) > round(positionOfExplosive.x):
				explosionPowerX = explosionPower
			elif round(self.position.x) < round(positionOfExplosive.x):
				explosionPowerX = -explosionPower
			else:
				explosionPowerX = 0
			if round(self.position.y) < round(positionOfExplosive.y):
				explosionPowerY = -explosionPower
			elif round(self.position.y) > round(positionOfExplosive.y):
				explosionPowerY = explosionPower
			else:
				explosionPowerY = 0
				
		if get_parent().has_node("Explosive") && Input.is_action_just_pressed("pressed_p") && pressed == false:
			$AudioStreamPlayer2D.play()
			get_parent().get_node("Explosive").set_speed(0)
			velocity.y = explosionPowerY
			pressed = true
			var distance = self.position.direction_to(get_parent().get_node("Explosive").get_pos())
			get_parent().get_node("ScreenShake").screen_shake(1,10,100)
			if get_parent().get_node("Boss"):
				if get_parent().get_node("Explosive").position.distance_to(get_parent().get_node("Boss").position) < 200:
					get_parent().get_node("Boss").damage(damageToBoss)
			
		if get_parent().has_node("Explosive") && pressed == true:
			velocity.x = explosionPowerX
		if !get_parent().has_node("Explosive"):
			pressed = false
			
		velocity.y += gravity
		
		if is_on_floor():
			onGround = true
		else:
			onGround = false
			if velocity.y < 0:
				$AnimatedSprite.play("Jump")
			else:
				$AnimatedSprite.play("Fall")
		velocity = move_and_slide(velocity, Floor)
		
		if get_parent().get_node("Camera2D").position.y + 140 < self.position.y && get_parent().name != "Boss":
			dead()
		
func dead():
	is_dead = true
	velocity = Vector2(0,0)
	$AnimatedSprite.play("Dead")
	$CollisionShape2D.disabled = true
	get_tree().reload_current_scene()

func damage(damage):
	hp -= damage
	print(hp)
	if hp <= 0:
		dead()
	
func return_dead() -> bool:
	return is_dead
	
func get_health():
	return hp
	
