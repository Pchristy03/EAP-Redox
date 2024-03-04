extends RigidBody2D
@export var asteroid: PackedScene

var velocity = Vector2.ZERO
var velocity_dir = Vector2.ZERO

const speed = 200

func _ready():
	velocity_dir = Vector2(position.x, position.y + 100) - position
	velocity_dir = velocity_dir.normalized()
	

func _physics_process(_delta):
	linear_velocity = velocity_dir * speed
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_2d_body_entered(body):
	if body.is_in_group("projectiles"):
		body.queue_free()
		body.game_over() 
