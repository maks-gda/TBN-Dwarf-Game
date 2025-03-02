extends HBoxContainer

var run = false;

const CHAR_READ_RATE = 0.05

signal change_avatar
signal change_ready
var current = 0

@onready var textbox = $"."
@onready var start_symbol = $Start
@onready var label = $Label
@onready var end_symbol = $End

enum State {
	READY,
	READING,
	FINISHED
}

var current_state = State.READY
var tween: Tween

var text_queue = []

func _ready():
	print("Starting state: State.READY")
	clear_textbox()
	queue_text(["You have encountered a chunky dwarf!", 0])
	queue_text(["You haven't met that creature before...", 0])
	queue_text(["I am a chunky dwarf!", 1])
	queue_text(["You haven't met ME before...", 1])
	queue_text(["I am MAGNUS", 1])
	queue_text(["Beware, it can bite!", 0])
	queue_text(["I don't btw", 1])
	queue_text(["Choose which action to perform :3", 0])

func _process(_delta):
	if !run:
		return
	match current_state:
		State.READY:
			if len(text_queue):
				display_text()
		State.READING:
			if Input.is_action_just_pressed("ui_accept"):
				tween.kill()
				label.visible_ratio = 1.0
				_on_Tween_completed()
		State.FINISHED:
			if Input.is_action_just_pressed("ui_accept"):
				if len(text_queue):
					change_state(State.READY)
					clear_textbox()
				else:
					emit_signal("change_ready")
					print("emitted signal: change_ready")

func queue_text(next_text):
	text_queue.push_back(next_text)

func clear_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	label.text = ""
	label.visible_ratio = 0.0

	
func display_text():
	var next_state = text_queue.pop_front()
	var next_text = next_state[0]
	var next_animation = next_state[1]
	if next_animation != current:
		current = next_animation
		emit_signal("change_avatar")
		print("emitted")
	start_symbol.text = "*"
	label.text = next_text
	change_state(State.READING)
	tween = create_tween()
	tween.tween_property(label, "visible_ratio", 1, CHAR_READ_RATE * len(next_text)).finished.connect(_on_Tween_completed)
	
func _on_Tween_completed():
	end_symbol.text = "*"
	change_state(State.FINISHED)

func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			print("Changing state to: State.READY")
		State.READING:
			print("Changing state to: State.READING")
		State.FINISHED:
			print("Changing state to: State.FINISHED")
