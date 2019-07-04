extends Area2D

signal shoot(laser, flare)
signal get_hit(flare)
signal armor_changed(new_armor)
signal explode(explosion)

const laser_class = preload("res://scenes/ship_laser.tscn")
const flare_class = preload("res://scenes/flare.tscn")
const explosion_class = preload("res://scenes/explosion.tscn")

var armor = 4 setget set_armor

var screen_size = Vector2()
var half_sprite_width = Vector2()

func _ready():
  screen_size = get_viewport_rect().size
  half_sprite_width = $sprite.texture.get_size().x / 2

func _process(delta):
  var motion = (get_global_mouse_position().x - self.position.x) * 0.2
  self.position.x = clamp(self.position.x + motion, half_sprite_width, screen_size.x - half_sprite_width)

func shoot():
  var left_cannon_pos = $left_cannon.global_position
  var right_cannon_pos = $right_cannon.global_position

  var left_laser = _create_laser(left_cannon_pos)
  var left_flare = _create_flare(left_cannon_pos)
  var right_laser = _create_laser(right_cannon_pos)
  var right_flare = _create_flare(right_cannon_pos)

  emit_signal("shoot", left_laser, left_flare)
  emit_signal("shoot", right_laser, right_flare)

func get_hit(pos):
  var flare = _create_flare(pos)
  emit_signal("get_hit", flare)
  set_armor(armor - 1)

func set_armor(new_value):
  armor = new_value
  emit_signal("armor_changed", armor)

  if armor == 0:
    var explosion = _create_explosion(self.position)
    emit_signal("explode", explosion)
    queue_free()

func _create_laser(pos):
  var laser = laser_class.instance()
  laser.start(pos)
  return laser

func _create_flare(pos):
  var flare = flare_class.instance()
  flare.init(pos)
  return flare

func _create_explosion(pos):
  var explosion = explosion_class.instance()
  explosion.init(pos)
  return explosion

func _on_cannon_cooldown_timeout():
  shoot()
