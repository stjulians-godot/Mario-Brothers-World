extends CharacterBody2D

@onready var destroy_sfx = preload("res://sounds/destroy_sfx.tscn")
@onready var anim: AnimatedSprite2D = $anim
@onready var jump_sound: AudioStreamPlayer = $jump_sound
@onready var collision: CollisionShape2D = $collision

var speed_direction = Vector2()
var MAX_SPEED = 550.0
const SLOWDOWN = 300

##Add: Gravity value, on earth, the normal value near surface is 9.81 m/s^2
const GRAVITY = 1920
const JUMP = 900.0


func _physics_process(delta):
	## Add the gravity to the game cycle
	velocity.y += GRAVITY * delta

	if Input.is_action_pressed("ui_left"):
		speed_direction.x = -1
	elif Input.is_action_pressed("ui_right"):
		speed_direction.x = 1
	else:
		speed_direction.x = 0

	if speed_direction:
		velocity.x = speed_direction.x * MAX_SPEED
	else:
		##Optional: decrease the speed with some slowdown or just set to 0
		velocity.x = move_toward(velocity.x, 0, SLOWDOWN)
		#velocity.x = 0
		
		
	# if jump key is pressed 
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y -= JUMP
		jump_sound.play()


	# handle animations
	if is_on_floor():
		if velocity.x:
			anim.play('walking')
		else:
			if Input.is_action_pressed('ui_down'):
				if anim.animation != "ducking":
					anim.play('ducking')
				
			elif Input.is_action_just_released('ui_down'):
				anim.play('desducking')
				
			else:
				if anim.animation == "desducking":
					await anim.animation_finished
					anim.play('idle')
				else:	
					anim.play('idle')
	else:
		anim.play('jumping')	


	move_and_slide()


func _on_head_collider_body_entered(body):
	if body.has_method("break_sprite"):
		body.hitpoints -= 1
		if body.hitpoints < 0:
			body.break_sprite()
			play_destroy_sfx()
		else:
			body.animation_player.play("hit")
			body.hit_block_sfx.play()
			body.create_coin()	


# Break box sound
func play_destroy_sfx():
	var sound_sfx = destroy_sfx.instantiate()
	get_parent().add_child(sound_sfx)
	sound_sfx.play()
	await sound_sfx.finished
	sound_sfx.queue_free()


func apply_flourwer_power_up():
	self.scale.x *= 2
	self.scale.y *= 2
	MAX_SPEED = 5000
	anim.speed_scale *= 5
	
	
