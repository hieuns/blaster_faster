extends Node

func _on_ship_shoot(laser, flare):
  add_child(laser)
  add_child(flare)

func _on_enemy_spawner_enemy_shoot(laser):
  add_child(laser)

func _on_ship_get_hit(flare):
  add_child(flare)

func _on_enemy_spawner_enemy_get_hit(flare):
  add_child(flare)

func _on_ship_explode(explosion):
  add_child(explosion)

func _on_enemy_spawner_enemy_explode(explosion):
  add_child(explosion)
