class Player
    constructor: (@game, position) ->
        this.direction = 1
        this.x = position.x * Tile.width
        this.y = position.y * Tile.height
        this.jumping = false

    tick: ->
        keys = this.game.input.keys
        vel = 3.2

        if keys.up.hold
            if not this.jumping and this.canJump()
                this.jumping = true
                this.jumpGoal = this.y - 2 * Tile.height

        if keys.z.pulse
            this.shoot()

        if !this.jumping
            this.y += vel
            this.adjustFall()

        if this.jumping
            this.y -= vel

            if this.y <= this.jumpGoal
                this.jumping = false

            this.adjustJump()

        if keys.right.hold
            this.x += vel
            this.direction = 1
            this.adjustWalk(1)

        if keys.left.hold
            this.x -= vel
            this.direction = -1
            this.adjustWalk(0)

    canJump: ->
        this.y++
        ret = this.clipped 'down'
        this.y--
        ret

    adjustWalk: (right) ->
        if this.clipped (if right then 'right' else 'left')
            if not right
                this.x += Tile.width
            this.x = Tile.width * Math.floor(this.x/Tile.width)

    adjustJump: ->
        if this.clipped 'up'
            this.y += Tile.height
            this.y = Tile.height * Math.floor(this.y/Tile.height)
            this.jumping = false

    adjustFall: ->
        if this.clipped 'down'
            this.y = Tile.height * Math.floor(this.y/Tile.height)

    clipped: (direction) ->
        # check if the player is clipped in a block

        edge = Tile.height - 1
        x1 = x2 = this.x
        y1 = y2 = this.y

        switch direction
            when 'up'
                x2 += edge
            when 'down'
                x2 += edge
                y1 = y2 = y1 + edge
            when 'left'
                y2 += edge
            when 'right'
                x1 = x2 = x1 + edge
                y2 += edge

        tile1 = this.game.level.getTile x1, y1
        tile2 = this.game.level.getTile x2, y2

        tile1 == 'B' or tile2 == 'B'

    shoot: ->
        bullet = new Bullet(this.game, this.x, this.y, this.direction)
        this.game.level.entities.push(bullet)

    jump: ->
        console.log "jumping"

    draw: ->
        this.game.canvas.drawSprite this.x, this.y, 'player'
