extends CanvasItemMaterial

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	set_shader_param("fpos", get_parent().get