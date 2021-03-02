extends Camera2D

func _physics_process(delta):
	$AnimatedSprite.play("Lava")
	var vector = Vector2()
	if get_parent().get_node("Player").position.y < -100 && get_parent().get_node("Player").return_dead()== false  && self.position.y > -1750:
		if get_parent().get_node("Player").position.y < self.position.y:
			vector.y = -4
		else:
			vector.y = -1
		translate(vector)


