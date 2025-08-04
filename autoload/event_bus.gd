extends Node2D

#interactions with cards
signal card_hovered(card: Card)
signal card_unhovered(card: Card)
signal card_clicked(card: Card)
signal card_let_go(card: Card)

#interactions with dishes
signal dish_hovered(dish: Dish)
signal dish_unhovered(dish: Dish)

#interactions for playing cards on dishes
signal card_used_on_dish(card: Card, dish: Dish)

#interactions for picking cards from hand
signal return_card_to_player_hand()
