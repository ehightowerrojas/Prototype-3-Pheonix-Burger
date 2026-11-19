extends Sprite2D

const BOLTSPEED: int = 100;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	z_index = 0
	position.y -= BOLTSPEED * delta
	if (position.y <= -100):
		queue_free()
	if (flip_h):
		flip_h = false
	else:
		flip_h = true
