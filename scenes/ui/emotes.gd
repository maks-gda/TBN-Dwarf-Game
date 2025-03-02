extends Control

@onready var animated_sprite_2d: AnimatedSprite2D = $PlayerEmote
@onready var animated_sprite_2d_creature: AnimatedSprite2D = $CreatureEmote
@onready var emote_timer: Timer = $EmoteTimer

@onready var textbox: HBoxContainer = $"../Textbox"

var player_emotes: Array = ["emote_1_idle", "emote_2_smile", "emote_3_ear_wave", "emote_4_blink"]
var creature_emotes: Array = ["emote_creature_1_idle"]
var emotes: Array = [player_emotes, creature_emotes]
var sprites: Array
var idx = 0

func _ready() -> void:
	sprites = [animated_sprite_2d, animated_sprite_2d_creature]
	animated_sprite_2d.play("emote_1_idle")
	textbox.change_avatar.connect(on_change_avatar)
	print("bombo")
	
func on_change_avatar() -> void:
	sprites[idx].hide()
	idx =  1 - idx
	sprites[idx].show()
	sprites[idx].play(emotes[idx][0])

func _on_emote_timer_timeout() -> void:
	var index = randi_range(0, len(emotes[idx]) - 1)
	var emote = emotes[idx][index]
	sprites[idx].play(emote)
