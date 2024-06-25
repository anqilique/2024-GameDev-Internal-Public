extends Node
class_name HurtboxComponent

@export var health_component : HealthComponent

func damage(attack: Attack):
	if health_component and health_component.health > 0:
		health_component.damage(attack)
