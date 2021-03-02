extends RigidBody2D

var speed = 5
var max_speed = 100

func _on_Timer_timeout():
	queue_free()

func _on_RigidBody2D_ready():
	$Timer.start()

func _physics_process(delta):
	var dir = (get_parent().get_node("Player").position - self.position).normalized()
	apply_impulse(Vector2(), dir * speed)
	var bodies = get_colliding_bodies()
	if "Player" in bodies:
		print("in")

func _integrate_forces(state):
	if state.linear_velocity.length()>max_speed:
		state.linear_velocity=state.linear_velocity.normalized()*max_speed


func _on_Bubble_body_entered(body):
	if body.name == "Player":
		get_parent().get_node("Player").damage(1)
		
