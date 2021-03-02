extends Area2D
var velocity = Vector2()
var speed = 300
func _physics_process(delta):
	velocity.y = speed * delta
	translate(velocity)

func _on_Explosive_body_entered(body):
	speed = 0
	$Timer.start()
	
func _on_Timer_timeout():
	queue_free()
	
func get_pos() -> Vector2:
	return self.global_position

func set_speed(speed):
	self.speed = speed
	$Timer.start()
