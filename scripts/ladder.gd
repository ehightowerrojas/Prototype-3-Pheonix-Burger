class_name Ladder
extends Area2D
## A ladder the player can use by pressing interact while touching it.
## Below the ladder's middle: moves the player up by climbHeight pixels.
## Above the ladder's middle: moves the player down by climbHeight pixels.
## Needs a CollisionShape2D child covering the ladder from the lower floor
## up to the floor above, so the player touches it from both ends.

@export var climbHeight := 50.0  ## px the player moves up or down

var shape: CollisionShape2D


func _ready() -> void:
	for child in get_children():
		if child is CollisionShape2D:
			shape = child
			break

	body_entered.connect(onBodyEntered)
	body_exited.connect(onBodyExited)


## How far to move a body at playerPosition: negative is up, positive is down.
func getClimbOffset(playerPosition: Vector2) -> float:
	if playerPosition.y < middleY():
		return climbHeight
	return -climbHeight


func middleY() -> float:
	if shape != null:
		return shape.global_position.y
	return global_position.y


func onBodyEntered(body: Node2D) -> void:
	if body.has_method("enterLadder"):
		body.enterLadder(self)


func onBodyExited(body: Node2D) -> void:
	if body.has_method("exitLadder"):
		body.exitLadder(self)
