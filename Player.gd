extends Area2D

signal hit

export var speed = 600
var screensize
var velocity = Vector2.ZERO



func _ready():
	screensize = get_viewport_rect().size
	#hide()


func get_direction():
	velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	return velocity


func reposition(deltatime,VC):
	position += VC * deltatime * speed
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	return position


func play_animation():
	if is_moving():
		if velocity.x != 0:
			get_node("AnimatedSprite").animation = "walk"
			get_node("AnimatedSprite").flip_h = velocity.x < 0
		if velocity.y != 0:
			get_node("AnimatedSprite").animation = "up"
			get_node("AnimatedSprite").flip_v = velocity.y > 0
		get_node("AnimatedSprite").play()
	else:
		get_node("AnimatedSprite").stop()


func is_moving():
	return (velocity.length() > 0)


func _process(delta):
	reposition(delta, get_direction())
	play_animation()


func _on_Player_body_entered(body):
	hide()
	get_node("CollisionShape2D").set_deferred("disabled", true)
	emit_signal("hit")
	



func respawn_player(player_pos):
	position = player_pos
	$CollisionShape2D.call_deferred("set", "disabled", false)
	show()

