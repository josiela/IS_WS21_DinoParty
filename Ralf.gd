extends KinematicBody2D

# Vars about Life 
var lifespan = 1


 #  Vars about movement
onready var leftWallRaycast = $LefttRaycast2
onready var rightWallRaycast= $RightRaycast
var isOnWall : bool=false
var direction= 1
var wallJumpForce=500
var justWallJumped= false
var wall_slide_speed= 10
var wall_slide_gravity = 10

var movement= Vector2(300,0)
const jumpforce= -1200


# Vars about physics
var gravity= 90


func _physics_process(delta):


	movement = move_and_slide(movement, Vector2.UP)
	movement.y = movement.y + gravity
	
	
			
	#about wallsliding and jumping and walljumping
	if Input.is_action_just_pressed("jump"):
		if(is_on_floor()):
			movement.y= jumpforce
			print("jumped")
			
		if(isOnWall):
			
			movement.y= jumpforce
			print("Wall Jump BAM")
			if (direction==1):
				$Sprite.flip_h=true
				movement.x=-wallJumpForce
			if (direction==-1):
				$Sprite.flip_h=false
				movement.x=wallJumpForce
			direction*=-1
				
	if (is_on_wall() and !is_on_floor()):
		isOnWall=true
		print("aaa")
		
	if (is_on_floor()):
		isOnWall=false
		
	if (is_on_floor() && direction==-1):
		movement.x=300
		$Sprite.flip_h=false
		
	
	
	
	
	
	

