extends Node2D

signal clicked(CameraName)

var selected : bool = false

## Camera name used to select camera
@export var CameraName : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func IsPositionWithinArea(pos : Vector2) -> bool :
	var rawTextureSize = $Black.texture.get_size()
	var size = rawTextureSize * scale
	var fullPosition = position - size/2
	var rect : Rect2 = Rect2(fullPosition, size)
	return rect.has_point(pos)


func Selected():
	$Red.visible = true
	$Black.visible = false
	clicked.emit(CameraName)
	selected = true


func Deselected():
	$Black.visible = true
	$Red.visible = false
	selected = false


func ToggleSelectState(event : InputEvent):
	if event is InputEventMouseButton:
		if event.pressed:
			if selected:
				Deselected()
			else:
				Selected()


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	ToggleSelectState(event)
