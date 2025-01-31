extends Control

#@onready var stars : Label =$HFlowContainer/Stars
@onready var money : Label =$HFlowContainer/VBoxContainer/Panel/HBoxContainer/Money
@onready var events : VBoxContainer = $HFlowContainer/VBoxContainer/Events

@onready var event_card = preload("res://scenes/ui/event_card.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	Stats.stats_changed.connect(on_stats_changed)
	EventManager.event_list_added.connect(on_event_list_added)
	EventManager.event_list_removed.connect(on_event_list_removed)
	on_stats_changed()

func on_event_list_added(room_id,event_info):
	var event_card_new : EventCard = event_card.instantiate()
	event_card_new.event_info = event_info
	event_card_new.room_id = room_id
	events.add_child(event_card_new)
	pass
func on_event_list_removed(room_id,event_info):
	for event_card in events.get_children():
		if event_card.room_id == room_id:
			event_card.delete()
			return
			

func on_stats_changed():
	var num = Stats.stars
	for star in $HFlowContainer/Stars.get_children():
		if num == 0: 
			if star.animation != "0": star.play("0")
		else: 
			if star.animation != "2": star.play("1")
			#if star.animation == "0": star.play("1")
			num -= 1
	money.text = str(Stats.money)

func add_event_card(event_info):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
