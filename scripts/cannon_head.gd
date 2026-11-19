extends Sprite2D

var cooldown: int = 0;
var firingCannon: bool = false;
const FIRESPEED: int = 10;
const RESETSPEED: int = 1;
const STARTINGPOS: float = 36.0;
const SHOOTMARGIN: float = 50.0;
const BIGBOLT = preload("res://BigBolt.tscn")
signal fired(cannonData)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (firingCannon):
		position.y += FIRESPEED;
		if (position.y > SHOOTMARGIN):
			firingCannon = false;
	elif (position.y > STARTINGPOS):
		position.y -= RESETSPEED;

func _input(event):
	if (!firingCannon && position.y <= STARTINGPOS):
		if (Input.is_action_pressed("DemoFire")):
			spawn_BigShot()
			fired.emit()
			if (cooldown <= 0 && !firingCannon):
				firingCannon = true;
				
func spawn_BigShot() -> void:
	var instance = BIGBOLT.instantiate()
	instance.z_as_relative = false
	instance.z_index = 8;
	add_child(instance)
	


func _on_cannon_pillar_fully_loaded() -> void:
	print("fire from loading")
	if (!firingCannon && position.y <= STARTINGPOS):
		spawn_BigShot()
		fired.emit()
		if (cooldown <= 0 && !firingCannon):
			firingCannon = true;
