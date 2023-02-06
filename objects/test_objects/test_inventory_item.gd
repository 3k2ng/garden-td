extends Button
var message = "hi"

# Called when the node enters the scene tree for the first time.
func _ready():
	var game = get_node(".")
	var pressed = func spawn():
		print(message)
	
	connect("pressed", pressed)
	print("in")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	print("no")
	pass # Replace with function body.
