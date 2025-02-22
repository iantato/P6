extends Node
class_name Hotbar

@export var hotbar: Array[Grimoire] = [null, null, null]
@export var max_size := 3
@export var selected_slot := 0

var hotbar_keys = {
	"hotbar_1": 0,
	"hotbar_2": 1,
	"hotbar_3": 2
}

signal item_replaced(grimoire: Grimoire)
signal change_selected_slot(slot: int)

var use_time
var item_scene
var is_holding: bool

func _ready() -> void:
	Globals.inventory_item_selected.connect(equip_item)
	item_replaced.connect(Globals.relay_hotbar_item_replaced)
	change_selected_slot.connect(Globals.relay_changed_selected_slot)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("use_item"):
		handle_press()
	elif event.is_action_released("use_item"):
		handle_release()

	if event.is_action_pressed("reverse_effect") and hotbar[selected_slot].toggleable:
		hotbar[selected_slot].switch_direction()

	for key in hotbar_keys.keys():
		if event.is_action_released(key):
			var new_slot = hotbar_keys[key]
			if selected_slot != new_slot and hotbar[selected_slot] != null:
				hotbar[selected_slot].clear(Globals.player)
				if item_scene != null:
					Globals.player.remove_child(item_scene)
					select_slot(new_slot)
					item_scene = hotbar[selected_slot].scene.instantiate()
					Globals.player.add_child(item_scene)
					item_scene.play_sequence()

func _process(delta: float) -> void:
	if is_holding:
		use_time += delta

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
	elif hotbar[selected_slot].use_type == Grimoire.UseType.PRESS:
		hotbar[selected_slot].use(Globals.player)

func equip_item(item: Grimoire, slot: int):
	if slot > max_size:
		push_error("Invalid slot")
		return
	if hotbar[slot] != null and hotbar.has(item) and hotbar[slot] != item:
		var temp_grimoire = hotbar[slot]
		hotbar[hotbar.find(item)] = temp_grimoire
	elif hotbar[slot] != null:
		emit_signal("item_replaced", hotbar[slot])
	hotbar[slot] = item

func select_slot(slot: int):
	if slot > max_size - 1:
		push_error("Selected slot out of bounds")
		return
  
	selected_slot = slot
	emit_signal("change_selected_slot", selected_slot)
