extends Area2D


func _on_Sign_body_entered(body):
	if "Player" in body.name:
		$Sprite2.visible = true
	else:
		$Sprite2.visible = false
	
