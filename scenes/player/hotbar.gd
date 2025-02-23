extends Node
class_name Hotbar

@export var hotbar: Array[Grimoire] = [null, null, null]
@export var max_size := 3
@export var selected_slot := -1

var hotbar_keys = {
	"hotbar_1": 0,
	"hotbar_2": 1,
	"hotbar_3": 2
}

signal item_replaced(grimoire: Grimoire)
signal change_selected_slot(slot: int)
signal item_slot_replaced(grimoire: Grimoire, slot: int)

var use_time
var item_scene
var is_holding: bool
var has_played_open

func _ready() -> void:
	Globals.inventory_item_selected.connect(equip_item)
	item_replaced.connect(Globals.relay_hotbar_item_replaced)
	change_selected_slot.connect(Globals.relay_changed_selected_slot)
	item_slot_replaced.connect(Globals.relay_item_slot_replaced)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("use_item"):
		Globals.player.toggle_movement()
		handle_press()
	elif event.is_action_released("use_item"):
		Globals.player.toggle_movement()
		handle_release()

	if event.is_action_pressed("reverse_effect") and hotbar[selected_slot].toggleable:
		hotbar[selected_slot].toggle()

	for key in hotbar_keys.keys():
		if event.is_action_released(key):
			validate_slot(hotbar_keys[key])

func validate_slot(new_slot):
	if hotbar[new_slot] == null:
		return
	if selected_slot != new_slot and hotbar[new_slot] != null and hotbar[selected_slot] != null:
		hotbar[selected_slot].clear(Globals.player)
		
	if hotbar[new_slot] != null and hotbar[new_slot].activate_on_equip:
		hotbar[new_slot].activate(Globals.player)

	if item_scene != null:
		Globals.player.remove_child(item_scene)
		
	select_slot(new_slot)
	
	if  hotbar[selected_slot].scene != null:
		item_scene  = hotbar[selected_slot].scene.instantiate()
		Globals.player.add_child(item_scene)
		#item_scene.play_sequence()

func _process(delta: float) -> void:
	if is_holding:
		use_time += delta
		if not has_played_open:
			has_played_open = true
			item_scene.get_grimoire().play("open")
			await item_scene.get_grimoire().animation_finished
			item_scene.get_grimoire().play("idle")

func handle_press():
	if hotbar[selected_slot] == null:
		return
	if hotbar[selected_slot].use_type == Grimoire.UseType.HOLD:
		use_time = 0
		is_holding = true
	elif hotbar[selected_slot].use_type == Grimoire.UseType.PRESS:
		pass

func handle_release():
	if hotbar[selected_slot] == null:
		return
	if hotbar[selected_slot].use_type == Grimoire.UseType.HOLD:
		is_holding = false
		hotbar[selected_slot].use(Globals.player, use_time)
		has_played_open = false
		item_scene.get_grimoire().play("close")
	elif hotbar[selected_slot].use_type == Grimoire.UseType.PRESS:
		hotbar[selected_slot].use(Globals.player)

func equip_item(item: Grimoire, slot: int):
	if slot > max_size:
		push_error("Invalid slot")
		return
	if hotbar[slot] != null and hotbar.has(item) and hotbar[slot] != item:
		emit_signal("item_slot_replaced", hotbar[slot], hotbar.find(item))
		var temp_grimoire = hotbar[slot]
		hotbar[hotbar.find(item)] = temp_grimoire
	elif hotbar[slot] != null:
		emit_signal("item_replaced", hotbar[slot])
	elif hotbar[slot] == null and hotbar.has(item):
		emit_signal("item_slot_replaced", null, hotbar.find(item))
		hotbar[hotbar.find(item)] = null
	
	hotbar[slot] = item
	if hotbar[selected_slot] == null:
		validate_slot(slot)
	

func select_slot(slot: int):
	if slot > max_size - 1:
		push_error("Selected slot out of bounds")
		return
  
	selected_slot = slot
	emit_signal("change_selected_slot", selected_slot)
