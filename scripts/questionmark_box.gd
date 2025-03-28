extends StaticBody2D

@onready var anim: AnimatedSprite2D = $anim
@onready var empty_block: Sprite2D = $empty_block
@onready var spawn_marker: Marker2D = $spawn_marker
@onready var area_2d: Area2D = $Area2D

const power_up = preload("res://prefabs/flourwer_rigid.tscn")
var impulse = -600


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "head_collider":
		anim.stop()
		empty_block.show()
		area_2d.queue_free() # that way the box spawns the power-up only once 
		
		var new_power_up = power_up.instantiate()
		get_parent().call_deferred('add_child', new_power_up)
		new_power_up.global_position = spawn_marker.global_position
		new_power_up.apply_impulse(Vector2(0,impulse))
		new_power_up.set_collision_mask_value(4, true) # only if you want it to stay on top of the crate
