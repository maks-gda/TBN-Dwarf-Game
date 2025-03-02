extends Control

@onready var narrator: TextureRect = $Narrator
@onready var dialogue: Control = $Dialogue
@onready var actions: HBoxContainer = $Actions
@onready var reactions: TextureRect = $Reactions

var arr

func _ready():
	arr = [narrator, dialogue, actions, reactions]
	hide_all()
	narrator.show()
	actions.show()

func hide_all():
	for elem in arr:
		elem.hide()

func reaction_cycle():
	narrator.hide()
	dialogue.hide()
