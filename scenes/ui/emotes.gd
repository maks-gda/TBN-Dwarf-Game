extends CanvasLayer

@onready var animated_sprite_2d: AnimatedSprite2D = $EmotePlayer
@onready var animated_sprite_2d_creature: AnimatedSprite2D = $EmoteCreature
@onready var emote_timer: Timer = $EmoteTimer
@onready var textbox: HBoxContainer = $UI/Textbox
@onready var actions: HBoxContainer = $UI/Actions
@onready var reactions: TextureRect = $UI/Reactions

var player_emotes: Array = ["emote_1_idle", "emote_2_smile", "emote_3_ear_wave", "emote_4_blink"]
var creature_emotes: Array = ["emote_creature_1_idle"]
var emotes: Array = [player_emotes, creature_emotes]
var sprites: Array
var idx = 0

func _ready() -> void:
	reactions.hide()
	sprites = [animated_sprite_2d, animated_sprite_2d_creature]
	animated_sprite_2d.play("emote_1_idle")
	textbox.change_avatar.connect(on_change_avatar)
	textbox.change_ready.connect(on_change_ready)
	actions.action_pressed.connect(on_action_pressed)

func on_change_avatar() -> void:
	sprites[idx].hide()
	idx =  1 - idx
	sprites[idx].show()
	sprites[idx].play(emotes[idx][0])

func on_change_ready() -> void:
	textbox.run = false
	actions.run = true

func on_action_pressed() -> void:
	if actions.selected == "react_button":
		reactions.show()
		actions.run = false

func _on_emote_timer_timeout() -> void:
	var index = randi_range(0, len(emotes[idx]) - 1)
	var emote = emotes[idx][index]
	sprites[idx].play(emote)
