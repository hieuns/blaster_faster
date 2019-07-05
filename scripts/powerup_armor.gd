extends "res://scripts/powerup.gd"

func _on_powerup_armor_area_entered(area):
  area.armor += 1
  queue_free()
