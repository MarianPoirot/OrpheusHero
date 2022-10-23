extends Area2D

#A modifier

const TARGET_Y = 565
const SPAWN_Y = -16
const DIST_TO_TARGET = TARGET_Y - SPAWN_Y

const LEFT_LANE_SPAWN = Vector2(329, SPAWN_Y)
const MID_LEFT_LANE_SPAWN = Vector2(423, SPAWN_Y)
const CENTRE_LANE_SPAWN = Vector2(515, SPAWN_Y)
const MID_RIGHT_LANE_SPAWN = Vector2(607, SPAWN_Y)
const RIGHT_LANE_SPAWN = Vector2(700, SPAWN_Y)

var speed = 0
var hit = false

func _ready():
	pass


func _physics_process(delta):
	if !hit:
		position.y += speed * delta
		if position.y > 600:
			queue_free()
			get_parent().reset_combo()
	else:
		$Node2D.position.y -= speed * delta


func initialize(lane):
	if lane == 0:
		$AnimatedSprite.frame = 0
		position = LEFT_LANE_SPAWN
	elif lane == 1:
		$AnimatedSprite.frame = 1
		position = MID_LEFT_LANE_SPAWN
	elif lane == 2:
		$AnimatedSprite.frame = 2
		position = CENTRE_LANE_SPAWN
	elif lane == 3:
		$AnimatedSprite.frame = 3
		position = MID_RIGHT_LANE_SPAWN
	elif lane == 4:
		$AnimatedSprite.frame = 4
		position = RIGHT_LANE_SPAWN
	else:
		printerr("Invalid lane set for note: " + str(lane))
		return
	
	speed = DIST_TO_TARGET / 2.0


func destroy(score):
	$CPUParticles2D.emitting = true
	$AnimatedSprite.visible = false
	$Timer.start()
	hit = true
	if score == 4:
		$Node2D/Label.text = "Τέλειο"
		$Node2D/Label.modulate = Color("8465ec")
	elif score == 3:
		$Node2D/Label.text = "Μεγάλη"
		$Node2D/Label.modulate = Color("a32858")
	elif score == 2:
		$Node2D/Label.text = "Καλή"
		$Node2D/Label.modulate = Color("ea6262")
	elif score == 1:
		$Node2D/Label.text = "Εντάξει"
		$Node2D/Label.modulate = Color("fcef8d")


func _on_Timer_timeout():
	queue_free()
