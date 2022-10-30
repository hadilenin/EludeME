extends CanvasLayer

signal start_game

func _ready():
	pass

func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func gameOverMessage():
	show_message("Game Over!")
	yield(get_node("MessageTimer"), "timeout")
	$Message.text = "Elude ME!"
	$Message.show() 
	yield(get_tree().create_timer(1),"timeout")
	$StartButton.show()

func update_score_OnLabel(score):
	$ScoreLabel.text = str(score)

func _on_MessageTimer_timeout():
	$Message.hide()



func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")

