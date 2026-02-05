extends Node

func _ready() -> void:
	var combat_scene: PackedScene = preload("res://scenes/Combat.tscn")
	var combat: Node = combat_scene.instantiate()
	add_child(combat)
