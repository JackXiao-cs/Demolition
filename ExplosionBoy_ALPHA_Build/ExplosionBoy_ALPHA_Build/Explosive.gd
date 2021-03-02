extends Area2D
var velocity = Vector2()
var speed = 300
func _ready():
	$AnimatedSprite.play("BombPlant")

func _physics_process(delta):
	velocity.y = speed * delta
	translate(velocity)

func _on_Explosive_body_entered(body):
	self.speed = 0
	
func _on_Timer_timeout():
	queue_free()
	
func get_pos() -> Vector2:
	return self.global_position

func set_speed(speed):
	self.speed = speed
	$AnimatedSprite.play("Explosion")
	$Timer.start()
			
		
		
