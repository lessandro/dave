class Bullet
    constructor: (@game, @x, @y, @direction) ->
    	this.max = this.x + 700 * this.direction
    	this.sprite = if this.direction == 1 then 'bulletr' else 'bulletl'

    tick: ->
    	vel = 10
    	this.x += this.direction * vel
    	if (this.max - this.x) * this.direction < 0
    		this.dead = true

    draw: ->
    	this.game.canvas.drawSprite this.x, this.y, this.sprite
