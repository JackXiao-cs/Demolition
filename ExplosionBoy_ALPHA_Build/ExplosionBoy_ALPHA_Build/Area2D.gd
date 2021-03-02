extends Area2D
var velocity = Vector2()
var speed = 200

func _physics_process(delta):
	if get_parent().get_node("Player"):
		var distance = get_parent().get_node("Player").position.distance_to(self.position)
		if distance < 300:
			velocity.y = speed * delta
			translate(velocity)
		else:
			velocity.y = 0

func _on_Area2D_body_entered(body):
	get_parent().get_node("Player").damage(2)
