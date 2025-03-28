extends Area2D


func _on_body_entered(body: Node) -> void:
	
	# applying the power up to mario
	if body.has_method("apply_flourwer_power_up"):
		body.apply_flourwer_power_up()
		
	get_parent().queue_free() # delete the flourwer node and its rigid as well
