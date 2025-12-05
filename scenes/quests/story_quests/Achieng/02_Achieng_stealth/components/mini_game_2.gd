extends Node2D

var collected_count: int = 0
const TOTAL_COLLECTIBLES: int = 3
const NEXT_SCENE: String = "res://scenes/quests/story_quests/Achieng/achieng_outro.tscn"


var last_collectible: CollectibleItem = null

func _ready() -> void:
	var collectible_list := get_tree().get_nodes_in_group("collectibles")

	# Store the last collectible BEFORE anything gets deleted
	if collectible_list.size() > 0:
		last_collectible = collectible_list[collectible_list.size() - 1]

	# Connect removal for counting
	for c: Node in collectible_list:
		c.tree_exited.connect(_on_collectible_removed)

func _on_collectible_removed() -> void:
	collected_count += 1

	if collected_count == TOTAL_COLLECTIBLES:
		trigger_switch_on_last_collectible()

func trigger_switch_on_last_collectible() -> void:
	if last_collectible:
		last_collectible.next_scene = NEXT_SCENE
