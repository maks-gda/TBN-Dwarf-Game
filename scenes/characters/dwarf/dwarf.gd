extends Node2D

@onready var interactable_component: InteractableComponent = $InteractableComponent
@onready var interactable_label_component: Control = $InteractableLabelComponent

var in_range: bool

func _ready() -> void:
	interactable_component.interactable_activated.connect(on_interactable_activated)
	interactable_component.interactable_deactivated.connect(on_interactable_deactivated)
	interactable_label_component.hide()

func on_interactable_activated() -> void:
	interactable_label_component.show()
	in_range = true
	
func on_interactable_deactivated() -> void:
	interactable_label_component.hide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and in_range:
		get_tree().change_scene_to_file("res://scenes/ui/battle_scene.tscn")
