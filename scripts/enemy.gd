extends Area2D

signal get_hit(hit_pos)
signal explode(explosion)
signal drop_powerup(powerup_item)

const POWER_UP_DROP_CHANCE = 20
const POWER_UP_ARMOR_DROP_CHANCE = 40

const flare_class = preload("res://scenes/flare.tscn")
const explosion_class = preload("res://scenes/explosion.tscn")
const powerup_armor_class = preload("res://scenes/powerup_armor.tscn")
const powerup_laser_class = preload("res://scenes/powerup_laser.tscn")

export var MAX_ARMOR = 2

export var velocity = Vector2()
export var can_shoot = false

var armor setget set_armor
var screen_size = Vector2()
var half_sprite_height
var half_sprite_width

func _ready():
  randomize()

  screen_size = get_viewport_rect().size

  var texture_size = $sprite.texture.get_size()
  half_sprite_width = texture_size.x / 2
  half_sprite_height = texture_size.y / 2

  armor = MAX_ARMOR

  add_to_group("enemy")

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
  if new_value < 0 or new_value >= MAX_ARMOR:
    return

  armor = new_value

  if armor == 0:
    var explosion = _create_explosion(self.position)
    emit_signal("explode", explosion)

    _drop_powerup(self.position)

    queue_free()

func _create_flare(pos):
  var flare = flare_class.instance()
  flare.init(pos)
  return flare

func _create_explosion(pos):
  var explosion = explosion_class.instance()
  explosion.init(pos)
  return explosion

func _drop_powerup(pos):
  var should_drop = rand_range(0, 100) < POWER_UP_DROP_CHANCE

  if should_drop:
    var powerup_class = powerup_armor_class if rand_range(0, 100) <= POWER_UP_ARMOR_DROP_CHANCE else powerup_laser_class
    var powerup_item = powerup_class.instance()
    powerup_item.start(pos)
    emit_signal("drop_powerup", powerup_item)

func _on_area_entered(area):
  if area.is_in_group("laser"):
    get_hit(area.position)
  elif area.is_in_group("ship"):
    set_armor(0)
