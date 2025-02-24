extends Label

var elapsed_time: float = Globals.timers[Globals.current_level]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	elapsed_time += delta
	Globals.timers[Globals.current_level] = elapsed_time
	update_display()

func update_display():
	var minutes = int(elapsed_time) / 60
	var seconds = int(elapsed_time) % 60
	
	self.text = "%02d:%02d" % [minutes, seconds]

func sql_update():
	Sql.insert_time(Globals.player_id, elapsed_time)
