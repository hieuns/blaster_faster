extends Node

const dumb_enemy_class = preload("res://scenes/dumb_enemy.tscn")

var screen_size = Vector2()

func _ready():
  randomize()

  screen_size = get_viewport().get_visible_rect().size

func spawn():
  var new_enemy = dumb_enemy_class.instance()
  add_child(new_enemy)

  var enemy_position = Vector2()
  enemy_position.x = rand_range(new_enemy.half_sprite_width, screen_size.x - new_enemy.half_sprite_width)
  enemy_position.y = -new_enemy.half_sprite_height
  new_enemy.start(enemy_position)

func reset_dumb_timer():
  $dumb_enemy_spawn_timer.wait_time = rand_range(0.7, 1.5)
  $dumb_enemy_spawn_timer.start()

func _on_dumb_enemy_spawn_timer_timeout():
  spawn()
  reset_dumb_timer()
