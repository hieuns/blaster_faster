extends Node

signal enemy_shoot(laser)
signal enemy_get_hit(flare)
signal enemy_explode(explosion)
signal enemy_drop_powerup(powerup_item)

const enemy_classes = [
  preload("res://scenes/dumb_enemy.tscn"),
  preload("res://scenes/clever_enemy.tscn")
]

var screen_size = Vector2()

func _ready():
  randomize()

  screen_size = get_viewport().get_visible_rect().size

func _spawn():
  var new_enemy = enemy_classes[randi() % enemy_classes.size()].instance()
  add_child(new_enemy)

  new_enemy.connect("get_hit", self, "_on_enemy_get_hit")
  new_enemy.connect("explode", self, "_on_enemy_explode")
  new_enemy.connect("drop_powerup", self, "_on_enemy_drop_powerup")

  if new_enemy.can_shoot:
    new_enemy.connect("shoot", self, "_on_enemy_shoot")

  var enemy_position = Vector2()
  enemy_position.x = rand_range(new_enemy.half_sprite_width, screen_size.x - new_enemy.half_sprite_width)
  enemy_position.y = -new_enemy.half_sprite_height
  new_enemy.start(enemy_position)

func _reset_spawn_timer():
  $enemy_spawn_timer.wait_time = rand_range(0.7, 1.5)
  $enemy_spawn_timer.start()

func _on_enemy_spawn_timer_timeout():
  _spawn()
  _reset_spawn_timer()

func _on_enemy_get_hit(flare):
  emit_signal("enemy_get_hit", flare)

func _on_enemy_explode(explosion):
  emit_signal("enemy_explode", explosion)

func _on_enemy_drop_powerup(powerup_item):
  emit_signal("enemy_drop_powerup", powerup_item)

func _on_enemy_shoot(laser):
  emit_signal("enemy_shoot", laser)
