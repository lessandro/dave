class Player
	constructor: ->
		this.x = 0
		this.y = 0

	move: ->

	input: (keys) ->
		this.jump() if keys.up

	tick: ->

	shoot: ->

	jump: ->
		console.log "jumping"

	draw: ->
