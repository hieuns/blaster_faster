extends Area2D

signal get_hit(hit_pos)
signal explode(explosion)

const flare_class = preload("res://scenes/flare.tscn")
const explosion_class = preload("res://scenes/explosion.tscn")

export var velocity = Vector2()
export var can_shoot = false
export var armor = 2 setget set_armor

var screen_size = Vector2()
var half_sprite_height
var half_sprite_width

func _ready():
  screen_size = get_viewport_rect().size

  var texture_size = $sprite.texture.get_size()
  half_sprite_width = texture_size.x / 2
  half_sprite_height = texture_size.y / 2

func _process(delta):
  translate(velocity * delta)

  if self.position.y - half_sprite_height > screen_size.y:
    queue_free()

func start(pos):
  self.position = pos

func get_hit(pos):
  var flare = _create_flare(pos)
  emit_signal("get_hit", flare)
  set_armor(armor - 1)

func set_armor(new_value):
  armor = new_value
  if armor == 0:
    var explosion = _create_explosion(self.position)
    emit_signal("explode", explosion)
    queue_free()

func _create_flare(pos):
  var flare = flare_class.instance()
  flare.init(pos)
  return flare

func _create_explosion(pos):
  var explosion = explosion_class.instance()
  explosion.init(pos)
  return explosion
