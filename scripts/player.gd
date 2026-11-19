extends CharacterBody2D
## 2D platformer controller for Godot 4: run left/right, fall with gravity,
## and press interact (E) while touching a ladder to teleport to its top.
## Attach to a CharacterBody2D that has a CollisionShape2D child.

@export_group("Run")
@export var maxSpeed := 70.0          ## px/s
@export var groundAcceleration := 1800.0
@export var groundFriction := 2200.0
@export var airAcceleration := 1100.0
@export var airFriction := 500.0

@export_group("Gravity")
@export var gravity := 980.0           ## px/s²
@export var maxFallSpeed := 650.0

@export_group("Input")
@export var leftAction: StringName = &"MoveLeft"
@export var rightAction: StringName = &"MoveRight"
@export var interactAction: StringName = &"interact"

var currentLadder: Ladder = null


func _ready() -> void:
	ensureInteractAction()


func _physics_process(delta: float) -> void:
	if currentLadder != null and Input.is_action_just_pressed("Climb"):
		climb(currentLadder)

	var direction := Input.get_axis(leftAction, rightAction)
	flipSprite(direction)
	applyGravity(delta)
	applyHorizontal(direction, delta)

	move_and_slide()

func flipSprite(direction: float) -> void:
	if direction < 0:
		$Chef.flip_h = true
	elif direction > 0:
		$Chef.flip_h = false

# Called by Ladder when the player starts or stops touching it.
func enterLadder(ladder: Ladder) -> void:
	currentLadder = ladder


func exitLadder(ladder: Ladder) -> void:
	if currentLadder == ladder:
		currentLadder = null


func climb(ladder: Ladder) -> void:
	global_position.y += ladder.getClimbOffset(global_position)
	velocity = Vector2.ZERO
	# currentLadder stays set: the player is still touching the ladder at the
	# other end, so pressing E again goes back the way they came.
	# Stops the sprite from visibly sliding to the new spot if physics interpolation is on.
	reset_physics_interpolation()


func applyGravity(delta: float) -> void:
	velocity.y = minf(velocity.y + gravity * delta, maxFallSpeed)


func applyHorizontal(direction: float, delta: float) -> void:
	var onFloor := is_on_floor()
	var targetSpeed := direction * maxSpeed
	var rate: float

	if direction != 0.0:
		rate = groundAcceleration if onFloor else airAcceleration
		# Turning around feels sluggish without an extra kick.
		if signf(direction) != signf(velocity.x) and velocity.x != 0.0:
			rate += groundFriction if onFloor else airFriction
	else:
		rate = groundFriction if onFloor else airFriction

	velocity.x = move_toward(velocity.x, targetSpeed, rate * delta)


# Binds interact to E if it isn't already in Project Settings > Input Map,
# so the game works without setting it up by hand.
func ensureInteractAction() -> void:
	if InputMap.has_action(interactAction):
		return
	InputMap.add_action(interactAction)
	var key := InputEventKey.new()
	key.physical_keycode = KEY_E
	InputMap.action_add_event(interactAction, key)
