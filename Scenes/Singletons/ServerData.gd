extends Node

var skill_data
var test_data = {
	"Stats": {
		"STR": 10,
		"VIT": 7,
		"DEX": 8,
		"INT": 3,
		"WIS": 6
	}
}

func _ready():
	var skill_data_file = File.new()
	skill_data_file.open("res://Data/SkillData.json", File.READ)
	var skill_data_json = JSON.parse(skill_data_file.get_as_text())
	skill_data_file.close()
	skill_data = skill_data_json.result
