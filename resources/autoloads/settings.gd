extends Node

var blue = "00B3FF"
var red = "FF415F"
var white = "FFFFFF"
var green = "1ED462"
var yellow = "FFC933"

var tips = [
	"Anything red dies easily.",
	"Low health? Prioritise upgrading it first.",
	"Health upgrades also heal you.",
	"Sometimes it is smart to run.",
	"Speed is good, but hard to control.",
	"The Dev forgot to remove this.",
	"Remember to maintain distance.",
	"Keep an eye on your health.",
	"Right-click to change mask.",
	"Each mask has different stats.",
	"Not all masks are made equal.",
]

var current_window_mode = DisplayServer.window_get_mode()

var play_sound_effects = true

var play_background_audio = true
