extends Node2D

# PATH to your credits scene (We will create this in Phase 5)
const NEXT_SCENE_PATH: String = "res://scenes/quests/story_quests/Achieng/credits.tscn"

@onready var director: AnimationPlayer = $Director
@onready var narration_label: RichTextLabel = $UI/PanelContainer/StoryLabel
@onready var music_player: AudioStreamPlayer = $MusicPlayer
@onready var ambience_player: AudioStreamPlayer = $AmbiencePlayer
@onready var cheering_player: AudioStreamPlayer = $CheeringSFX
@onready var returned_light: Sprite2D = $Actors/ReturnedLight

# Text from your Design Document
#var story_lines: Dictionary = {
	#0: "With Roha’s help, Achieng retrieved the light source from Ojukwu’s castle, and came back to the tribe in victory.",
	#1: "Everyone praised Achieng for her bravery, courage and wisdom. She would forever be remembered as the saviour of Lumusi.",
	#2: "The light source, back in its home, found its way into its Orb, as the tribe watched in awe.",
	#3: "Finally, Lumusi was in full swing. Laughter and Joy filled the air, as the people danced and sang.",
	#4: "Achieng watched the Orb in the sky and felt she finally understood why they celebrated.",
	#5: "They were light, and light would always shine in the darkness."
#}

func _ready() -> void:
	if returned_light: returned_light.visible = false
	if narration_label: narration_label.text = ""
	
	if director.has_animation("OutroSequence"):
		director.play("OutroSequence")

#func show_line(index: int) -> void:
	#if index in story_lines:
		#narration_label.text = story_lines[index]
		#narration_label.visible_ratio = 1.0 # Shows text instantly to avoid bugs

func end_cutscene() -> void:
	# Fade out all audio
	var tween: Tween = create_tween()
	tween.parallel().tween_property(music_player, "volume_db", -80, 2.0)
	tween.parallel().tween_property(cheering_player, "volume_db", -80, 2.0)
	tween.parallel().tween_property(ambience_player, "volume_db", -80, 2.0)
	
	await tween.finished
	
	if ResourceLoader.exists(NEXT_SCENE_PATH):
		get_tree().change_scene_to_file(NEXT_SCENE_PATH)
