extends HBoxContainer

var run = false

signal action_pressed

@onready var react_button: Button = $ReactButton
@onready var gift_button: Button = $GiftButton
@onready var fight_button: Button = $FightButton
@onready var run_button: Button = $RunButton

@onready var react_active: TextureRect = $ReactButton/React_active
@onready var gift_active: TextureRect = $GiftButton/Gift_active
@onready var fight_active: TextureRect = $FightButton/Fight_active
@onready var run_active: TextureRect = $RunButton/Run_active

var buttons
var buttons_names
var active_textures

var selected

func _ready() -> void:
	buttons = [react_button, gift_button, fight_button, run_button]
	buttons_names = ["react_button", "gift_button", "fight_button", "run_button"]
	active_textures = [react_active, gift_active, fight_active, run_active]
	for i in range(len(buttons)):
		active_textures[i].visible = false

func _process(_delta: float) -> void:
	if !run:
		return
	for i in range(len(buttons)):
		if !buttons[i].is_hovered() and selected != buttons_names[i]:
			active_textures[i].visible = false
		else:
			active_textures[i].visible = true

func _on_react_button_pressed() -> void:
	if run:
		print("react pressed")
		selected = "react_button"
		emit_signal("action_pressed")

func _on_gift_button_pressed() -> void:
	if run:
		print("gift pressed")
		selected = "gift_button"

func _on_fight_button_pressed() -> void:
	if run:
		print("fight pressed")
		selected = "fight_button"

func _on_run_button_pressed() -> void:
	if run:
		print("run pressed")
		selected = "run_button"
