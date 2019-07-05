extends "res://scripts/powerup.gd"

func _on_powerup_laser_area_entered(area):
  area.is_double_shooting = true
  queue_free()
