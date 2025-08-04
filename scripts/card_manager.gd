class_name CardManager extends Node2D

var dragged_card: Card
var current_hovered_dish: Dish

func _ready() -> void:
	connect_signals()

func connect_signals() -> void:
	EventBus.connect("hovered_card", on_hovered_card)
	EventBus.connect("unhovered_card", on_unhovered_card)
	EventBus.connect("clicked_card", on_clicked_card)
	EventBus.connect("let_go_card", on_let_go_card)
	EventBus.connect("hovered_dish", on_hovered_dish)
	EventBus.connect("unhovered_dish", on_unhovered_dish)
	
func on_hovered_card(card: Card) -> void:
	var tween = get_tree().create_tween()
	var scaling = Vector2(1.2, 1.2)
	var duration = 0.1
	tween.tween_property(card, "scale", scaling, duration)
	
func on_unhovered_card(card: Card) -> void:
	var tween = get_tree().create_tween()
	var scaling = Vector2(1, 1)
	var duration = 0.1
	tween.tween_property(card, "scale", scaling, duration)
	
func on_hovered_dish(dish: Dish):
	current_hovered_dish = dish

func on_unhovered_dish(dish: Dish) -> void:
	current_hovered_dish = null

func on_clicked_card(card: Card) -> void:
	var tween = get_tree().create_tween().set_parallel(true)
	var rotate = 0
	var scaling = Vector2(1.0, 1.0)
	var duration = 0.1
	tween.tween_property(card, "position", get_global_mouse_position(), 0.1)
	tween.tween_property(card, "rotation", rotate, duration)
	tween.tween_property(card, "scale", scaling, duration)
	await tween.finished
	dragged_card = card

func on_let_go_card(card: Card) -> void:
	if not current_hovered_dish:
		EventBus.emit_signal("return_card_to_player_hand")
	else:
		EventBus.emit_signal("card_used_on_dish", card, current_hovered_dish)
	dragged_card = null

func _process(_delta: float) -> void:
	if dragged_card:
		var global_mouse_pos = get_global_mouse_position()
		dragged_card.position = global_mouse_pos
