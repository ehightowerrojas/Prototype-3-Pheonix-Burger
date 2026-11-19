extends Sprite2D

var cooldown: int = 0;
var firingCannon: bool = false;
const FIRESPEED: int = 10;
const RESETSPEED: int = 1;
const STARTINGPOS: float = 35.0;
const SHOOTMARGIN: float = 50.0;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(firingCannon)
	if (firingCannon):
		position.y += FIRESPEED;
		if (position.y > SHOOTMARGIN):
			firingCannon = false;
	elif (position.y > STARTINGPOS):
		position.y -= RESETSPEED;

func _input(event):
	if (!firingCannon && position.y <= STARTINGPOS):
		if (Input.is_action_pressed("DemoFire")):
			if (cooldown <= 0 && !firingCannon):
				firingCannon = true;
