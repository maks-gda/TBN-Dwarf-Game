extends TextureRect

var run = false;

const CHAR_READ_RATE = 0.05

signal change_to_dialogue

@onready var textbox = $Textbox
@onready var start_symbol = $Textbox/Start
@onready var label = $Textbox/Label
@onready var end_symbol = $Textbox/End

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
	queue_text(["You have encountered a chunky dwarf!", false])
	queue_text(["You haven't met that creature before...", true])
	queue_text(["Beware, it can bite!", false])
	queue_text(["Choose which action to perform :3", true])

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
	var is_last = next_state[1]
	start_symbol.text = "*"
	label.text = next_text
	change_state(State.READING)
	tween = create_tween()
	tween.tween_property(label, "visible_ratio", 1, CHAR_READ_RATE * len(next_text)).finished.connect(_on_Tween_completed)
	if is_last:
		emit_signal("change_to_dialogue")
		print("emitted")
	
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
