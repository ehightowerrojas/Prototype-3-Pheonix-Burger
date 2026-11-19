extends Sprite2D
@export var starting_stage = 0
@export var move_speed = 0.5
var current_stage = 0
var max_stages= 4
var move_amount = 22
var is_moving = false



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_stage = starting_stage # Replace with function body.
	frame = current_stage


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("DemoReload"):
		if current_stage < max_stages and not is_moving:
			move_pillar()
			
func move_pillar():
	is_moving = true
	current_stage += 1
	
	var tween = create_tween()
	tween.tween_property(self, "position:y", position.y - move_amount, move_speed)
	
	await tween.finished
	frame = current_stage
	is_moving = false
