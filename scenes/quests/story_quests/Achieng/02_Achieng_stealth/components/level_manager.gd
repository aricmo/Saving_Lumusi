#extends Node2D
#
## typed variables
#var current_thread_index: int = 0
#var threads: Array[CollectibleItem] = []
#
#
#func _ready() -> void:
	#threads = [
		#get_node("../OntheGround/CollectibleItem") as CollectibleItem,
		#get_node("../OntheGround/CollectibleItem2") as CollectibleItem,
		#get_node("../OntheGround/CollectibleItem3") as CollectibleItem
	#]
#
	## initialize: show only the first thread
	#for i: int in range(threads.size()):
		#var t: CollectibleItem = threads[i]
		#t.revealed = (i == current_thread_index)
		#t._update_based_on_revealed()
#
		## connect to dialogue end if available
		#if t.collected_dialogue:
			#t.collected_dialogue.connect(
				#"dialogue_ended",
				#Callable(self, "_on_thread_collected")
			#)
		#else:
			## fallback: detect removal after queue_free
			#t.connect("tree_exited", Callable(self, "_on_thread_collected"))
#
#
#func _on_thread_collected(_arg: Variant = null) -> void:
	#current_thread_index += 1
#
	## if all threads collected → trigger final dialogue
	#if current_thread_index >= threads.size():
		#_all_threads_collected()
		#return
#
	## otherwise reveal the next collectible thread
	#var next_thread: CollectibleItem = threads[current_thread_index]
	#next_thread.reveal()
#
#
#func _all_threads_collected() -> void:
	#var well_done_node: CollectibleItem = get_node_or_null("../OntheGround/WellDoneDialogue") as CollectibleItem
	#if not well_done_node:
		#return
#
	#well_done_node.reveal()
#
	## locate the Player in the scene tree
	#var player: Node = get_tree().get_root().find_node("Player", true, false)
	#if player:
		## simulate interaction so ththe Well Done dialogue triggers immediately
		#well_done_node._on_interacted(player, false)
