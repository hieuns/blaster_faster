extends Node

func _on_ship_shoot(laser, flare):
  add_child(laser)
  add_child(flare)
