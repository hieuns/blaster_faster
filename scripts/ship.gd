extends Area2D

signal shoot(laser, flare)
signal hit_by_laser(flare)
signal hit_by_enemy()
signal armor_changed(new_armor)
signal explode(explosion)

const MAX_ARMOR = 4

const laser_class = preload("res://scenes/ship_laser.tscn")
const flare_class = preload("res://scenes/flare.tscn")
const explosion_class = preload("res://scenes/explosion.tscn")

var armor = MAX_ARMOR setget set_armor
var is_double_shooting = false setget set_double_shooting

var screen_size = Vector2()
var half_sprite_width = Vector2()

func _ready():
  screen_size = get_viewport_rect().size
  half_sprite_width = $sprite.texture.get_size().x / 2

  add_to_group("ship")

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

  if is_double_shooting:
    var second_left_laser = _create_laser(left_cannon_pos)
    var second_left_flare = _create_flare(left_cannon_pos)
    var second_right_laser = _create_laser(right_cannon_pos)
    var second_right_flare = _create_flare(right_cannon_pos)

    second_left_laser.velocity.x = -25
    second_right_laser.velocity.x = 25

    emit_signal("shoot", second_left_laser, second_left_flare)
    emit_signal("shoot", second_right_laser, second_right_flare)

  audio_player.play_sfx("ship_laser")

func hit_by_laser(pos):
  var flare = _create_flare(pos)
  emit_signal("hit_by_laser", flare)
  set_armor(armor - 1)

func hit_by_enemy():
  emit_signal("hit_by_enemy")
  set_armor(armor - 1)

func set_armor(new_value):
  if new_value < 0 or new_value > MAX_ARMOR:
    return

  if new_value < armor:
    audio_player.play_sfx("ship_hit")

  armor = new_value
  emit_signal("armor_changed", armor)

  if armor == 0:
    var explosion = _create_explosion(self.position)
    emit_signal("explode", explosion)
    queue_free()

func set_double_shooting(new_value):
  is_double_shooting = new_value

  if is_double_shooting:
    $double_shooting_timer.start()

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

func _on_double_shooting_timer_timeout():
  is_double_shooting = false

func _on_area_entered(area):
  if area.is_in_group("powerup_armor"):
    set_armor(armor + 1)
    audio_player.play_sfx("powerup")
  elif area.is_in_group("powerup_laser"):
    is_double_shooting = true
    audio_player.play_sfx("powerup")
  elif area.is_in_group("laser"):
    hit_by_laser(area.position)
  elif area.is_in_group("enemy"):
    hit_by_enemy()
