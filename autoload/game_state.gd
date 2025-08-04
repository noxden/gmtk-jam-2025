extends Node

var hand_size = 5

var cards_in_deck = []

func _ready():
	for i in range(3):
		cards_in_deck.append(Cards.CARDS["knife"])
	cards_in_deck.append(Cards.CARDS["rice"])
	cards_in_deck.append(Cards.CARDS["cucumber"])
