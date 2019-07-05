extends "res://scripts/powerup.gd"

func _ready():
  add_to_group("powerup_armor")

func _on_area_entered(area):
  queue_free()
