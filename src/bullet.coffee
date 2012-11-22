class Bullet
    constructor: (@game, @x, @y, @direction) ->
    	this.max = this.x + 700 * this.direction

    tick: ->
    	vel = 10
    	this.x += this.direction * vel
    	if (this.max - this.x) * this.direction < 0
    		this.dead = true

    draw: ->
    	this.game.canvas.drawSprite this.x, this.y, 'bullet'
