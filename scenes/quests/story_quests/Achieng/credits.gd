extends Node2D

const MENU_PATH = "res://scenes/menus/title/components/main_menu.tscn"

func return_to_menu() -> void:
 if ResourceLoader.exists(MENU_PATH):
  get_tree().change_scene_to_file(MENU_PATH)
 else:
  print("Error: Main menu not found at ", MENU_PATH)
  # If menu is missing, just quit the game
  get_tree().quit()
