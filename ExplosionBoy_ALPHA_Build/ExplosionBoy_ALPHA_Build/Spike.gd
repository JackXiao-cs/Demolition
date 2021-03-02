extends Area2D

func _on_Spike_body_entered(body):
	get_parent().get_node("Player").damage(2)
