# Globals.gd
extends Node

signal inventory_item_selected(grimoire: Grimoire, slot: int)
signal hotbar_item_replaced(grimoire: Grimoire)
signal hotbar_selected_slot_changed(slot: int)
# Player instance
var player: Node = null
var current_level: int = 0

# Time tracking variables
var level_times: Dictionary = {}  # Stores time spent in each level
var current_level_start_time: int = 0  # Tracks the start time of the current level

# Database path
var db_path: String = "res://P-6_db.db"

# Player name (Dapat Dynamic to na nagpapalit value pag nageenter ng user ng name niya)
var player_name: String = "Player1"

func relay_item_selected(grimoire: Grimoire, slot: int):
	emit_signal("inventory_item_selected", grimoire, slot)

func relay_hotbar_item_replaced(grimoire: Grimoire):
	emit_signal("hotbar_item_replaced", grimoire)

func relay_changed_selected_slot(slot: int):
	emit_signal("hotbar_selected_slot_changed", slot)

# Initialize the database (call this once, e.g., in _ready)
func initializde_database():
	var db = SQLite.new()
	db.path = db_path
	db.open_db()

	# Create a table to store level times if it doesn't exist
	if db.query("""
		CREATE TABLE IF NOT EXISTS level_times (
			session_id INTEGER PRIMARY KEY AUTOINCREMENT,
			level_name TEXT,
			time_spent INTEGER,
			session_date TEXT,
			player_name TEXT
		);
	"""):
		print("Table 'level_times' created or already exists.")
	else:
		print("Failed to create table 'level_times'.")

# Start tracking time for a level
func start_level_timer(level_name: String):
	current_level_start_time = Time.get_ticks_msec()  # Record the start time
	if not level_times.has(level_name):
		level_times[level_name] = 0  # Initialize time for the level if it doesn't exist

# Stop tracking time for a level and save it
func stop_level_timer(level_name: String):
	var time_spent = Time.get_ticks_msec() - current_level_start_time
	level_times[level_name] += time_spent  # Add the time spent to the level's total time

# Save all level times to the database
func save_level_times_to_database():
	var db = SQLite.new()
	db.path = db_path
	db.open_db()

	for level_name in level_times:
		var time_spent = level_times[level_name]
		var current_date = Time.get_datetime_dict_from_system()  # Get the current date and time
		var date_str = "{year}-{month}-{day} {hour}:{minute}:{second}".format({
			year = current_date["year"],
			month = current_date["month"],
			day = current_date["day"],
			hour = current_date["hour"],
			minute = current_date["minute"],
			second = current_date["second"]
		})

		# Insert the data into the database
		if db.query("""
			INSERT INTO level_times (level_name, time_spent, session_date, player_name)
			VALUES ('%s', %d, '%s', '%s');
		""" % [level_name, time_spent, date_str, player_name]):
			print("Inserted data for level: ", level_name, " with time: ", time_spent, " and date: ", date_str)
		else:
			print("Failed to insert data for level: ", level_name)

# Load level times from the database
func load_level_times_from_database():
	var db = SQLite.new()
	db.path = db_path
	db.open_db()

	# Execute the query
	if db.query("SELECT level_name, time_spent, player_name FROM level_times;"):
		print("Query executed successfully. Results:")
		for row in db.query_result:
			var level_name = row["level_name"]
			var time_spent = row["time_spent"]
			var player_name = row["player_name"]
			print("Level: ", level_name, " | Time Spent: ", time_spent, " | Player: ", player_name)
			if level_times.has(level_name):
				level_times[level_name] += time_spent
			else:
				level_times[level_name] = time_spent
	else:
		print("Failed to execute query.")

# Get the total time spent across all levels
func get_total_time():
	var total_time = 0
	for level in level_times:
		total_time += level_times[level]
	return total_time

# Reset level times (e.g., for a new game)
func reset_level_times():
	level_times.clear()
	var db = SQLite.new()
	db.path = db_path
	db.open_db()
	db.query("DELETE FROM level_times;")

# Insert dummy data for testing
func insert_dummy_data():
	var db = SQLite.new()
	db.path = db_path
	db.open_db()

	# Dummy data
	var level_name = "Level1"
	var time_spent = 120000  # 2 minutes in milliseconds
	var current_date = Time.get_datetime_dict_from_system()
	var date_str = "{year}-{month}-{day} {hour}:{minute}:{second}".format({
		year = current_date["year"],
		month = current_date["month"],
		day = current_date["day"],
		hour = current_date["hour"],
		minute = current_date["minute"],
		second = current_date["second"]
	})

	# Insert dummy data into the database
	if db.query("""
		INSERT INTO level_times (level_name, time_spent, session_date, player_name)
		VALUES ('%s', %d, '%s', '%s');
	""" % [level_name, time_spent, date_str, player_name]):
		print("Dummy data inserted successfully.")
	else:
		print("Failed to insert dummy data.")
