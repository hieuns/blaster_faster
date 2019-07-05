extends "res://scripts/enemy.gd"

signal shoot(laser)

const laser_class = preload("res://scenes/enemy_laser.tscn")

func _ready():
  randomize()

  velocity.x *= [1, -1][randi() % 2]

func _process(delta):
  if self.position.x < half_sprite_width or self.position.x > screen_size.x - half_sprite_width:
    velocity.x *= -1

func shoot():
  var laser = laser_class.instance()
  laser.start($cannon.global_position)
  emit_signal("shoot", laser)

  audio_player.play_sfx("enemy_laser")

func _on_cannon_cooldown_timeout():
  shoot()
