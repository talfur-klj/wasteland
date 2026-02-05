extends Control

const HAND_SIZE := 5
const STARTING_AP := 3

@onready var player_hp_label: Label = $"TopBar/PlayerHPLabel"
@onready var player_block_label: Label = $"TopBar/PlayerBlockLabel"
@onready var enemy_hp_label: Label = $"EnemyPanel/EnemyHPLabel"
@onready var enemy_intent_label: Label = $"EnemyPanel/EnemyIntentLabel"
@onready var ap_label: Label = $"TopBar/APLabel"
@onready var status_label: Label = $"StatusLabel"
@onready var hand_container: HBoxContainer = $"HandContainer"
@onready var draw_pile_label: Label = $"TopBar/DrawPileLabel"
@onready var discard_pile_label: Label = $"TopBar/DiscardPileLabel"
@onready var end_turn_button: Button = $"BottomBar/EndTurnButton"
@onready var new_run_button: Button = $"BottomBar/NewRunButton"

var player_hp := 50
var player_max_hp := 50
var player_block := 0
var enemy_hp := 35
var enemy_block := 0
var enemy_pattern := [
	{"intent": "defend", "value": 10},
	{"intent": "attack", "value": 12},
	{"intent": "attack", "value": 12}
]
var enemy_turn_index := 0
var action_points := STARTING_AP
var run_over := false

var draw_pile: Array[Dictionary] = []
var discard_pile: Array[Dictionary] = []
var hand: Array[Dictionary] = []

func _ready() -> void:
	end_turn_button.pressed.connect(_on_end_turn_pressed)
	new_run_button.pressed.connect(_on_new_run_pressed)
	_setup_new_combat()

func _setup_new_combat() -> void:
	player_hp = player_max_hp
	player_block = 0
	enemy_hp = 35
	enemy_block = 0
	enemy_turn_index = 0
	action_points = STARTING_AP
	run_over = false
	status_label.text = "Play cards to defeat the Security Bot."
	new_run_button.visible = false
	_build_starting_deck()
	_draw_cards(HAND_SIZE)
	_update_ui()

func _build_starting_deck() -> void:
	draw_pile.clear()
	discard_pile.clear()
	hand.clear()

	for i in 4:
		draw_pile.append(_make_card("Rusty Pipe", 1, "attack", 6))
	for i in 4:
		draw_pile.append(_make_card("Scrap Shield", 1, "block", 5))
	draw_pile.append(_make_card("Shove", 1, "attack", 4))
	draw_pile.append(_make_card("Duck & Cover", 1, "block_draw", 3))
	_shuffle_draw_pile()

func _make_card(card_name: String, cost: int, card_type: String, value: int) -> Dictionary:
	return {
		"name": card_name,
		"cost": cost,
		"type": card_type,
		"value": value
	}

func _shuffle_draw_pile() -> void:
	draw_pile.shuffle()

func _draw_cards(amount: int) -> void:
	for i in amount:
		if draw_pile.is_empty():
			if discard_pile.is_empty():
				break
			draw_pile = discard_pile.duplicate()
			discard_pile.clear()
			_shuffle_draw_pile()
		hand.append(draw_pile.pop_back())

func _on_card_pressed(card_index: int) -> void:
	if run_over:
		return
	if card_index < 0 or card_index >= hand.size():
		return

	var card: Dictionary = hand[card_index]
	if action_points < card["cost"]:
		status_label.text = "Not enough AP for %s." % card["name"]
		return

	action_points -= card["cost"]
	_play_card(card)
	discard_pile.append(card)
	hand.remove_at(card_index)

	if enemy_hp <= 0:
		_enemy_defeated()
		return

	_update_ui()

func _play_card(card: Dictionary) -> void:
	match card["type"]:
		"attack":
			_deal_damage_to_enemy(card["value"])
			status_label.text = "%s deals %d damage." % [card["name"], card["value"]]
		"block":
			player_block += card["value"]
			status_label.text = "%s grants %d block." % [card["name"], card["value"]]
		"block_draw":
			player_block += card["value"]
			_draw_cards(1)
			status_label.text = "%s grants %d block and draws 1." % [card["name"], card["value"]]

func _deal_damage_to_enemy(amount: int) -> void:
	if enemy_block > 0:
		var blocked := min(enemy_block, amount)
		enemy_block -= blocked
		amount -= blocked
	if amount > 0:
		enemy_hp = max(enemy_hp - amount, 0)

func _on_end_turn_pressed() -> void:
	if run_over:
		return

	_discard_hand()
	player_block = 0
	_enemy_take_turn()

	if run_over:
		_update_ui()
		return

	action_points = STARTING_AP
	_draw_cards(HAND_SIZE)
	_update_ui()

func _discard_hand() -> void:
	for card in hand:
		discard_pile.append(card)
	hand.clear()

func _enemy_take_turn() -> void:
	var intent: Dictionary = enemy_pattern[enemy_turn_index]
	enemy_turn_index = (enemy_turn_index + 1) % enemy_pattern.size()

	if intent["intent"] == "attack":
		var damage: int = intent["value"]
		var blocked := min(player_block, damage)
		player_block -= blocked
		damage -= blocked
		if damage > 0:
			player_hp = max(player_hp - damage, 0)
		status_label.text = "Enemy attacks for %d." % intent["value"]
	elif intent["intent"] == "defend":
		enemy_block += intent["value"]
		status_label.text = "Enemy gains %d block." % intent["value"]

	if player_hp <= 0:
		run_over = true
		status_label.text = "You died in the bunker."
		new_run_button.visible = true

func _enemy_defeated() -> void:
	run_over = true
	status_label.text = "Enemy defeated! Vertical slice complete."
	new_run_button.visible = true
	_discard_hand()

func _on_new_run_pressed() -> void:
	_setup_new_combat()

func _update_ui() -> void:
	player_hp_label.text = "HP: %d / %d" % [player_hp, player_max_hp]
	player_block_label.text = "Block: %d" % player_block
	enemy_hp_label.text = "Enemy HP: %d" % enemy_hp
	ap_label.text = "AP: %d" % action_points
	draw_pile_label.text = "Draw: %d" % draw_pile.size()
	discard_pile_label.text = "Discard: %d" % discard_pile.size()

	if run_over:
		enemy_intent_label.text = "Intent: --"
	else:
		var next_intent: Dictionary = enemy_pattern[enemy_turn_index]
		enemy_intent_label.text = "Intent: %s %d" % [next_intent["intent"].capitalize(), next_intent["value"]]

	for child in hand_container.get_children():
		child.queue_free()

	for idx in hand.size():
		var card: Dictionary = hand[idx]
		var card_button := Button.new()
		card_button.custom_minimum_size = Vector2(200, 120)
		card_button.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		card_button.text = "%s\nCost: %d\n%s" % [card["name"], card["cost"], _card_description(card)]
		card_button.disabled = run_over
		card_button.pressed.connect(_on_card_pressed.bind(idx))
		hand_container.add_child(card_button)

func _card_description(card: Dictionary) -> String:
	match card["type"]:
		"attack":
			return "Deal %d damage" % card["value"]
		"block":
			return "Gain %d block" % card["value"]
		"block_draw":
			return "Gain %d block, draw 1" % card["value"]
		_:
			return ""
