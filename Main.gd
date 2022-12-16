extends Node


export(PackedScene) var enemy
var score = 0


func _ready():
	randomize()
	new_game()



func _on_StartTimer_timeout():
	$ScoreTimer.start()
	$SpawnTimer.start()


func _on_ScoreTimer_timeout():
	score += 0.5



func _on_SpawnTimer_timeout():
	spawn_enemy()


func spawn_enemy():
	var enemy_mod = enemy.instance()
	$Path/SpawnPoint.set_offset(randi() + randi())
	enemy_mod.position = $Path/SpawnPoint.position
	enemy_mod.rotation = $Path/SpawnPoint.rotation + PI/2 + rand_range(-PI/4,PI/4)
	enemy_mod.moving = true
	add_child(enemy_mod)


func new_game():
	#$CanvasLayerHUD.show_message("Get Ready!")
	$Player.respawn_player(Vector2(238,346))
	$StartTimer.one_shot = true
	$StartTimer.start()


func game_over():
	#$CanvasLayerHUD.gameOverMessage()
	$ScoreTimer.stop()
	$SpawnTimer.stop()


func _on_Player_hit():
	game_over()
	suspend(1.5)
	new_game()


func suspend(seconds):
	var waiting_time = Timer.new()
	waiting_time.wait_time = seconds
	waiting_time.one_shot = true
	add_child(waiting_time)
	waiting_time.start()
	yield(waiting_time,"timeout")
	waiting_time.stop()
	waiting_time.queue_free()





func _on_CanvasLayerHUD_start_game():
	new_game()
