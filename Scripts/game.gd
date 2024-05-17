extends Node2D

@export var tileMap: TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	call_deferred("_removeFloorsWithWallsFromNavigation")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _removeFloorsWithWallsFromNavigation():
	var userdWalls = tileMap.get_used_cells(1)
	#var emptyNavPolygon = NavigationPolygon.new()
	var floorsWithWalls: Array[Vector2i] = []
	
	for wall in userdWalls:
		var possibleFloorTile = tileMap.get_cell_tile_data(0, wall)
		
		if possibleFloorTile:
			floorsWithWalls.append(wall)
			
	for coords in floorsWithWalls:
		var floor = tileMap.get_cell_tile_data(0, coords)
		tileMap.set_cell(0, coords, tileMap.tile_set.get_source_id(0), tileMap.get_cell_atlas_coords(0, coords), 1)
		#tileMap.set_cell(1, coords, tileMap.tile_set.get_source_id(0), tileMap.get_cell_atlas_coords(1, coords))
		
	
