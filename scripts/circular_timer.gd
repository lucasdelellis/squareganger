extends TextureProgressBar

signal timer_finished

var duration: float = 1.0
var time_elapsed: float = 0.0
var is_running: bool = false

func _ready() -> void:
	fill_mode = FILL_CLOCKWISE
	value = 100

func start_timer(p_duration: float) -> void:
	duration = p_duration
	time_elapsed = 0.0
	is_running = true
	value = 100

func stop_timer() -> void:
	is_running = false

func reset_timer() -> void:
	time_elapsed = 0.0
	value = 100
	is_running = false

func _process(delta: float) -> void:
	if not is_running:
		return
	
	time_elapsed += delta
	var progress = clamp(time_elapsed / duration, 0.0, 1.0)
	value = (1.0 - progress) * 100.0
	
	if progress >= 1.0:
		is_running = false
		timer_finished.emit()
