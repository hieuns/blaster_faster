extends Node

func play_sfx(sfx_name):
  var sfx_node = get_node("sfx/%s" % sfx_name)
  if sfx_node:
    sfx_node.play()
