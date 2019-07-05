extends "res://scripts/powerup.gd"

func _ready():
  add_to_group("powerup_laser")

func _on_area_entered(area):
  queue_free()
