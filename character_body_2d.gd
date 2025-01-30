extends CharacterBody2D

var speed_direction = Vector2()
const MAX_SPEED = 550.0
const SLOWDOWN = 10.0

##Add: Gravity value, on earth, the normal value near surface is 9.81 m/s^2
const GRAVITY = 650

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
#		velocity.x = 0

	if Input.is_action_just_pressed("ui_accept"):
		velocity.y -= JUMP
		
	move_and_slide()

	
	
const JUMP = 250.0
