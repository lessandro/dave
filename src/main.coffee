class Main
	run: ->
		console.log "running"
		this.step()

	step: ->
		p = new Player
		p.jump()
