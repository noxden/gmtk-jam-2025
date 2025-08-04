class_name PlayerHand extends Node2D


const CARD_SCENE_PATH = "res://scenes/card.tscn"

var cards_in_hand: Array[Card] = []

var SCREEN_WIDTH: int
var SCREEN_HEIGHT: int

var CARD_INITIAL_POS: Vector2

const CARD_DEGREES = 10
const HAND_CENTER_DEGREES = 270
const HAND_RADIUS = 800
const HAND_CENTER_VERTICAL_OFFSET = 600
var HAND_CENTER: Vector2

func _ready() -> void:
	EventBus.connect("return_card_to_player_hand", on_return_card_to_player_hand)
	initialize_on_screen_positions()
	fill_hand()

func initialize_on_screen_positions() -> void:
	SCREEN_WIDTH = get_viewport().size[0] 
	SCREEN_HEIGHT = get_viewport().size[1]
	CARD_INITIAL_POS = Vector2(120, SCREEN_HEIGHT - 130)
	HAND_CENTER = Vector2(SCREEN_WIDTH/2, SCREEN_HEIGHT+HAND_CENTER_VERTICAL_OFFSET)

func fill_hand() -> void:
	var card_scene = preload(CARD_SCENE_PATH)
	
	await $"../Deck".ready
	
	for i in range(GameState.hand_size):
		var new_card = card_scene.instantiate()
		
		var card_data = $"../Deck".get_card()
		new_card.initialize(card_data)
		new_card.position = CARD_INITIAL_POS
		
		add_child(new_card)
		add_card_to_hand(new_card)
		await get_tree().create_timer(0.3).timeout

func add_card_to_hand(card: Card) -> void:
	cards_in_hand.append(card)
	update_card_positions()

func update_card_positions() -> void:
	for i in range(cards_in_hand.size()):
		var total_degrees = (cards_in_hand.size() - 1) * CARD_DEGREES
		var degrees_from_center = i * CARD_DEGREES - total_degrees / 2
		var new_position = polar_to_cartesian(HAND_CENTER_DEGREES + degrees_from_center)
		new_position += HAND_CENTER
		var new_rotation = float(degrees_from_center)/360 * 2*PI
		var card = cards_in_hand[i]
		animate_card_movement(card, new_position, new_rotation)

func animate_card_movement(card: Card, destination: Vector2, new_rotation: float) -> void:
	var tween = get_tree().create_tween().set_parallel(true)
	var duration = 0.1
	tween.tween_property(card, "position", destination, 0.1)
	tween.tween_property(card, "rotation", new_rotation, 0.1)

func polar_to_cartesian(theta: int) -> Vector2:
	var x = HAND_RADIUS * cos(float(theta)/360 * 2*PI)
	var y = HAND_RADIUS * sin(float(theta)/360 * 2*PI)
	return Vector2(x, y)

func on_return_card_to_player_hand() -> void:
	update_card_positions()
