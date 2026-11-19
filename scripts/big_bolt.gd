extends Sprite2D

const BOLTSPEED: int = 100;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	z_index = 0
	position.y -= BOLTSPEED * delta
	if (position.y <= -70):
		queue_free()
