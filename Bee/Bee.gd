extends CharacterBody2D


const SPEED = 3000.0
const JUMP_VELOCITY = -400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var anim = get_node("Container/AnimatedSprite2D")
@onready var container = get_node("Container")
@onready var player = get_node("../Player")

var player_in_sight

#Khi bat dau chay se chay hanh dong idle
func _ready():
	anim.play("Idle")

func _physics_process(delta):
	if player_in_sight:
		#Quai duoi theo nhan vat
		velocity = (player.position - self.position).normalized() * SPEED * delta
		# Huong quay mat khi sang trai hoac phai
		if self.position.x > player.position.x:
			container.scale.x = 1
		elif self.position.x < player.position.x:
			container.scale.x = -1
		move_and_slide()


func _on_area_2d_body_entered(body):
	#kiem tra xem co phai nguoi choi hay ko, neu dung thi choi lai tu dau
	if body.name == "Player":
		get_tree().change_scene_to_file("res://world.tscn")

#Vung quai tim thay nguoi choi
func _on_player_in_sight(body):
	if body.name == "Player":
		player_in_sight = true
