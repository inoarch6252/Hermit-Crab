extends Node

@export var player: CharacterBody2D

@export var Camera_Zone1: PhantomCamera2D
@export var Camera_Zone2: PhantomCamera2D
@export var Camera_Zone3: PhantomCamera2D
@export var Camera_Zone4: PhantomCamera2D

var current_camera_zone: int = 0


func update_current_zone(body, zone_a, zone_b):
	if body == player:
		match current_camera_zone:
			zone_a: 
				current_camera_zone = zone_b
			zone_b:
				current_camera_zone = zone_a
		update_camera() 

func update_camera():
	print("Camera Zone: ", current_camera_zone)

func _on_zone_01_body_entered(body: Node2D):
	update_current_zone(body, 0, 1)

func _on_zone_02_body_entered(body: Node2D):
	update_current_zone(body, 1, 2)

func _on_zone_23_body_entered(body: Node2D):
	update_current_zone(body, 2, 3)

func _on_zone_34_body_entered(body: Node2D):
	update_current_zone(body, 3, 4)
