extends Node2D


const HAND_SIZE = 5
const CARD_SCENE_PATH = "res://scenes/card.tscn"

var cards_in_hand = []

var SCREEN_WIDTH
var SCREEN_HEIGHT

var CARD_INITIAL_POS

const PI = 3.1415
const CARD_DEGREES = 7
const HAND_CENTER_DEGREES = 270
const HAND_RADIUS = 800
const HAND_CENTER_VERTICAL_OFFSET = 700
var HAND_CENTER

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SCREEN_WIDTH = get_viewport().size[0] 
	SCREEN_HEIGHT = get_viewport().size[1]
	CARD_INITIAL_POS = Vector2(120, SCREEN_HEIGHT - 130)
	HAND_CENTER = Vector2(SCREEN_WIDTH/2, SCREEN_HEIGHT+HAND_CENTER_VERTICAL_OFFSET)
	
	var card_scene = preload(CARD_SCENE_PATH)
	for i in range(HAND_SIZE):
		var new_card = card_scene.instantiate()
		
		var card_data = {
			"title": "knife", 
			"description": "stab someone", 
			"cost": 0
		}
		new_card.initialize(card_data)
		new_card.position = CARD_INITIAL_POS
		
		$"../Cards".add_child(new_card)
		
		await get_tree().create_timer(0.3).timeout
		
		add_card_to_hand(new_card)

func add_card_to_hand(card):
	cards_in_hand.append(card)
	update_card_positions()

func update_card_positions():
	for i in range(cards_in_hand.size()):
		var total_degrees = (cards_in_hand.size() - 1) * CARD_DEGREES
		var degrees_from_center = i * CARD_DEGREES - total_degrees / 2
		var new_position = polar_to_cartesian(HAND_CENTER_DEGREES + degrees_from_center)
		var new_rotation = float(degrees_from_center)/360 * 2*PI
		var card = cards_in_hand[i]
		card.position_in_hand = new_position
		card.rotation_in_hand = new_rotation
		CardManager.animate_card_movement(card, new_position, new_rotation)

func polar_to_cartesian(theta):
	var x = HAND_RADIUS * cos(float(theta)/360 * 2*PI)
	var y = HAND_RADIUS * sin(float(theta)/360 * 2*PI)
	return HAND_CENTER + Vector2(x, y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
