class Bullet extends Entity
    constructor: (@game, x, y, @direction) ->
        this.width = 14
        this.height = 6
        this.x = Math.round(x - this.width/2)
        this.y = Math.round(y - this.height/2)
        this.sprite = if this.direction == 1 then 'bulletr' else 'bulletl'

    tick: ->
        vel = 10
        this.x += this.direction * vel

        if this.clipped (if this.direction == 1 then 'right' else 'left')
            this.dead = true

    draw: ->
        this.game.canvas.drawSprite this.x, this.y, this.sprite
