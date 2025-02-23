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


func insert_player(name: String) -> void:
	var query = """INSERT INTO players (name) VALUES ('%s');""" % [name]
	db.query(query)
	

func get_player_id(name: String) -> void:
	var query = "SELECT * from players WHERE id = %d ORDER BY id DESC LIMIT 1"
	db.query(query)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
