extends KinematicBody2D

var is_dead = false
var velocity = Vector2()
var speed = 10
var hp = 20
const Bubble = preload("res://Bubble.tscn")
export (String, FILE, "*.tscn") var target_stage

func dead():
	is_dead = true
	$CollisionShape2D.disabled = true
	get_parent().get_node("Cup").visible = true
	queue_free()
	$Timer2.start()

func get_pos() -> Vector2:
	return self.position

func _physics_process(delta):
	if is_dead == false:
		var direction = (get_parent().get_node("Player").position - self.global_position).normalized()
		velocity += direction * speed * delta
		velocity = move_and_slide(velocity)
			
func damage(damage):
	hp -= damage
	if hp == 0:
		dead()
	if hp == 10:
		speed = 20
	if hp == 5:
		speed = 60
	$AnimatedSprite3.frame = 20 - hp

func spawnBubble():
	var bubble = Bubble.instance()
	get_parent().add_child(bubble)
	
	var bubble1 = Bubble.instance()
	get_parent().add_child(bubble1)
	
	var bubble2 = Bubble.instance()
	get_parent().add_child(bubble2)
	
	var bubble3 = Bubble.instance()
	get_parent().add_child(bubble3)
	
	bubble.position = $Position2D.global_position
	bubble1.position = $Position2D2.global_position
	bubble2.position = $Position2D3.global_position
	bubble3.position = $Position2D4.global_position

func get_health():
	return hp

func _on_Timer_timeout():
	spawnBubble()


func _on_Timer2_timeout():
	get_tree().change_scene(target_stage)
