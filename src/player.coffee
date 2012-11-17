class Player
    constructor: (@game, position) ->
        this.x = position.x * Tile.width
        this.y = position.y * Tile.height

    tick: ->
        keys = this.game.input.keys
        vel = 2

        if keys.right
            this.x += vel
        if keys.left
            this.x -= vel
        if keys.up
            this.y -= vel
        if keys.down
            this.y += vel

        if keys.z
            this.shoot()

    shoot: ->
        alert "pew!"

    jump: ->
        console.log "jumping"

    draw: ->
        this.game.canvas.drawSprite this.x, this.y
