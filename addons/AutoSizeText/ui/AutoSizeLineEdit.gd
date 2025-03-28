@tool
# # # # # # # # # # # # # # # # # # # # # # # # # # #
# Twister
#
# AutoSize LineEdit.
# # # # # # # # # # # # # # # # # # # # # # # # # # #
class_name AutoSizeLineEdit
extends LineEdit

@export_tool_button("FORCE REFRESH")
var refresh_button: Callable = _on_change_rect

@export_group("Auto Font Size")

## Min text size to reach
@export_range(1, 512)
var min_size: int = 8:
	set(new_min):
		min_size = min(max(1, new_min), max_size)
		if is_node_ready():
			_on_change_rect()

## Max text size to reach
@export_range(1, 512)
var max_size: int = 38:
	set(new_max):
		max_size = max(min_size, min(new_max, 512))
		if is_node_ready():
			_on_change_rect()

# TODO: implement @export_group("Font Step Size")

var _processing_flag: bool = false

func _set(property: StringName, _value: Variant) -> bool:
	if (
		property == &"text"
		or property == &"right_icon"
		or property == &"clear_button_enabled"
		or property == &"placeholder_text"
	):
		_on_change_rect.call_deferred()
		
	return false

func _ready() -> void:
	item_rect_changed.connect(_on_change_rect)
	_on_change_rect.call_deferred()

func _on_change_rect() -> void:
	if _processing_flag:
		return
		
	_processing_flag = true
	
	# Taking custom char offset prevent text clip by rect
	const OFFSET_BY: String = "_"
	
	var font: Font = get(&"theme_override_fonts/font")
	var character_size: int = max_size
	var font_size: Vector2 = Vector2.ZERO
	var offset: float = 0
	
	#region kick_falls
	
	var current_text: String = text
	var use_clear_btn: bool = clear_button_enabled
	
	if current_text.is_empty():
		if placeholder_text.is_empty():
			return
			
		current_text = placeholder_text
		use_clear_btn = false

	if null == font:
		font = get_theme_default_font()

	var right_icon_size: float = 0.0
	
	if null != right_icon:
		# Assume native size
		right_icon_size = right_icon.get_size().x
		
	if use_clear_btn:
		var _clear: Texture2D = get(&"theme_override_icons/clear")
		if null == _clear:
			_clear = get_theme_icon(&"clear")
		if _clear is Texture2D:
			right_icon_size += (_clear as Texture2D).get_size().x
		
	#endregion

	font_size = font.get_string_size(
		current_text,
		alignment, 
		-1,
		character_size,
		TextServer.JUSTIFICATION_NONE,
		TextServer.DIRECTION_AUTO,
		TextServer.ORIENTATION_HORIZONTAL
	)
	font_size.x += right_icon_size

	offset = (font.get_string_size(
		OFFSET_BY,
		alignment,
		-1,
		character_size,
		TextServer.JUSTIFICATION_NONE,
		TextServer.DIRECTION_AUTO,
		TextServer.ORIENTATION_HORIZONTAL
	)).x
	
	while size.x - offset < font_size.x:
		character_size = character_size - 1

		if character_size < min_size:
			character_size = min_size
			break

		font_size = font.get_string_size(
			current_text,
			alignment,
			-1,
			character_size,
			TextServer.JUSTIFICATION_NONE,
			TextServer.DIRECTION_AUTO,
			TextServer.ORIENTATION_HORIZONTAL
		)
		font_size.x += right_icon_size
		
		offset = (font.get_string_size(
			OFFSET_BY,
			alignment,
			-1,
			character_size,
			TextServer.JUSTIFICATION_NONE,
			TextServer.DIRECTION_AUTO,
			TextServer.ORIENTATION_HORIZONTAL
		)).x

	set(&"theme_override_font_sizes/font_size", character_size)
	set_deferred(&"_processing_flag", false)
