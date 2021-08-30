extends Node

func fetch_skill_damage(skill_name):
	var damage = ServerData.skill_data[skill_name].Damage
	return damage
