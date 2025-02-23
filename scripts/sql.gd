# Sql.gd
extends Node

var db
var db_path: String = "res://players.db"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	db = SQLite.new()
	db.path = db_path
	db.open_db()
	
	db.query("CREATE TABLE IF NOT EXISTS players (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, level INTEGER, time FLOAT)")
	insert_player("Test")
	get_player_id("Test")
	insert_time(1, 2.3848938)
	get_time(1)


func insert_player(name: String) -> void:
	var query = """INSERT INTO players (name) VALUES ('%s');""" % [name]
	db.query(query)


func insert_time(id: int, time: float) -> void:
	var query = """UPDATE players SET time = %f WHERE id = %d""" % [time, id]
	db.query(query)


func get_player_id(name: String) -> void:
	var query = "SELECT * from players WHERE name = '%s' ORDER BY id DESC LIMIT 1" % name
	db.query(query)
	Globals.player_id = db.get_query_result()[0]['id']


func get_time(id: int) -> float:
	var query = "SELECT time FROM players WHERE id = %d" % [id]
	db.query(query)
	return db.get_query_result()
