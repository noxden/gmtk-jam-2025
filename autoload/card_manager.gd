extends Node2D

signal hovered_card
signal unhovered_card
signal clicked_card
signal let_go_card

var dragged_card: Node2D
var current_hovered_card: Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect_signals()
	pass # Replace with function body.

func connect_signals():
	connect("hovered_card", on_hovered_card)
	connect("unhovered_card", on_unhovered_card)
	connect("clicked_card", on_clicked_card)
	connect("let_go_card", on_let_go_card)
	
func on_hovered_card(card):
	current_hovered_card = card
	var tween = get_tree().create_tween()
	tween.tween_property(card, "scale", Vector2(1.2, 1.2), 0.1)
	
func on_unhovered_card(card):
	current_hovered_card = null
	var tween = get_tree().create_tween()
	tween.tween_property(card, "scale", Vector2(1, 1), 0.1)
	
func on_clicked_card(card):
	dragged_card = card
	var tween = get_tree().create_tween()
	# gets overruled by _process
	# tween.tween_property(card, "position", get_global_mouse_position(), 0.1)
	tween.tween_property(card, "rotation", 0, 0.1)
	tween.tween_property(card, "scale", Vector2(1, 1), 0.1)
	
func on_let_go_card(card):
	animate_card_movement(card, card.position_in_hand, card.rotation_in_hand)
	dragged_card = null

func animate_card_movement(card, destination, new_rotation):
	var tween = get_tree().create_tween()
	tween.tween_property(card, "position", destination, 0.1)
	tween.tween_property(card, "rotation", new_rotation, 0.1)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dragged_card:
		var global_mouse_pos = get_global_mouse_position()
		dragged_card.position = global_mouse_pos
