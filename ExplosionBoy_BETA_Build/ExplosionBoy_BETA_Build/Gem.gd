extends Area2D

export (String, FILE, "*.tscn") var target_stage

func _on_Gem_body_entered(body):
	if "Player" in body.name:
		$AudioStreamPlayer2D.play()
		$Timer.start()
		

func _on_Timer_timeout():
	get_tree().change_scene(target_stage)
