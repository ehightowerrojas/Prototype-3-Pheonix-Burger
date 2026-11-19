extends Sprite2D

var fired: bool = false
const FIRESPEED: int = 5;
const RESETSPEED: int = 1;
const STARTINGPOS: float = 202.0;
const SHOOTMARGIN: float = 210.0;
const SMALLBOLT = preload("res://smallBolt.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (fired):
		position.y += FIRESPEED;
		if (position.y > SHOOTMARGIN):
			fired = false;
	elif (position.y > STARTINGPOS):
		position.y -= RESETSPEED;

func _on_cannon_head_fired() -> void:
	fired = true
	spawn_SmallShot()
	
func spawn_SmallShot() -> void:
	var instance = SMALLBOLT.instantiate()
	instance.z_as_relative = false
	instance.z_index = 8;
	add_child(instance)
