extends Cinematic


## Dialogue for cinematic scene.
@export var lumusi_dialogue: DialogueResource = preload("res://scenes/quests/story_quests/Achieng/02_Achieng_stealth/components/lumusi-stealth-narration.dialogue")

## Optional animation player, to be used from [member dialogue] (if needed).
@export var animation_player2: AnimationPlayer

## Optional scene to switch to once [member dialogue] is complete.
#@export_file("*.tscn") var next_scene: String

## Optional path inside [member next_scene] where the player should appear.
## If blank, player appears at default position in the scene. If in doubt,
## leave this blank.
#@export var spawn_point_path: String


func _ready() -> void:
	if not GameState.intro_dialogue_shown:
		DialogueManager.show_dialogue_balloon(dialogue, "", [self])
		await DialogueManager.dialogue_ended
		cinematic_finished.emit()
		GameState.intro_dialogue_shown = true

	if next_scene:
		(
			SceneSwitcher
			. change_to_file_with_transition(
				next_scene,
				spawn_point_path,
				Transition.Effect.FADE,
				Transition.Effect.FADE,
			)
		)
