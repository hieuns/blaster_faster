extends Sprite

func _on_ship_armor_changed(new_armor):
  self.frame = clamp(new_armor, 0, 4)
