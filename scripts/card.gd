class_name Card extends Node2D

var cost: int
var position_in_hand
var rotation_in_hand

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func initialize(parameters: Dictionary) -> Card:
	cost = parameters["cost"]
	var title_node = find_child("Title")
	var description_node = find_child("Description")
	title_node.text = parameters["title"]
	description_node.text = parameters["description"]
	
	return self	

func _on_area_2d_mouse_entered():
	CardManager.emit_signal("hovered_card", self)

func _on_area_2d_mouse_exited():
	CardManager.emit_signal("unhovered_card", self)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.is_pressed():
			CardManager.emit_signal("clicked_card", self)
		else:
			CardManager.emit_signal("let_go_card", self)
	pass # Replace with function body.
