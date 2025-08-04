class_name Deck extends Node2D

var cards_in_deck: Array[Card]
const CARD_SCENE_PATH = "res://scenes/card.tscn"
const CARD_SCENE = preload(CARD_SCENE_PATH)

var SCREEN_HEIGHT: int
var CARD_INITIAL_POS: Vector2


func _ready() -> void:
	SCREEN_HEIGHT = get_viewport().size[1]
	CARD_INITIAL_POS = Vector2(120, SCREEN_HEIGHT - 130)

	var card_offset = Vector2(0.0, 0.0)
	const card_offset_increment = Vector2(1, 1)
	for card_data in GameState.cards_in_deck:
		var new_card = CARD_SCENE.instantiate()
		new_card.position = CARD_INITIAL_POS + card_offset
		card_offset += card_offset_increment
		new_card.initialize(card_data)
		add_child(new_card)
		cards_in_deck.append(new_card)
	
	cards_in_deck.shuffle()

func get_card():
	var ret = cards_in_deck.pop_front()
	ret.get_node("AnimationPlayer").play("card_flip")
	return ret
