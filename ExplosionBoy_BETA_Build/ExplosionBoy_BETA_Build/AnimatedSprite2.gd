extends AnimatedSprite
func _physics_process(delta):
	self.frame = 10 - get_parent().get_health()
