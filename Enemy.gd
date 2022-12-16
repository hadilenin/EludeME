extends RigidBody2D


var speed = 200 + (randi() % 100)
var direction = Vector2.ZERO
var moving = false


func _init():
	randomize()

func _ready():
	play_random_animation()


func _physics_process(delta):
	if(moving):
		move(delta)
	


func play_random_animation():
	var animation_list = get_node("AnimatedSprite").frames.get_animation_names()
	$AnimatedSprite.animation = animation_list[randi() % animation_list.size()]
	$AnimatedSprite.play()



func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func move(delta):
	direction = angle_to_unit_vector(self.rotation)
	self.position += direction * delta * speed

func angle_to_unit_vector(angle):
	return Vector2(cos(angle),sin(angle))
	
