class Player
    constructor: (@game, position) ->
        this.direction = 1
        this.x = position.x * Tile.width
        this.y = position.y * Tile.height
        this.jumping = false
        this.t = 0

    tick: ->
        keys = this.game.input.keys
        vel = 3.2

        if keys.up.hold
            if not this.jumping and this.canJump()
                this.t = 5
                this.jumping = true
                this.vely = vel
                this.jumpGoal = this.y - 2 * Tile.height

        if keys.z.pulse
            this.shoot()

        if !this.jumping and !this.canJump()
            this.y += this.vely
            this.vely += 0.4
            if this.vely >= vel
                this.vely = vel
            this.adjustFall()

        if this.jumping
            this.y -= this.vely
            this.vely -= 0.05

            if this.y <= this.jumpGoal
                this.y = this.jumpGoal
                this.jumping = false
                this.vely = 0

            this.adjustJump()

        if keys.right.hold
            this.x += vel
            this.direction = 1
            this.adjustWalk('right')


        if keys.left.hold
            this.x -= vel
            this.direction = -1
            this.adjustWalk('left')

    canJump: ->
        this.y++
        ret = this.clipped 'down'
        this.y--
        ret

    adjustWalk: (direction) ->
        if this.clipped direction
            if direction == 'left'
                this.x += Tile.width - 1
            this.x = Tile.width * Math.floor(this.x/Tile.width)
        else
            if this.canJump()
                this.t++

    adjustJump: ->
        if this.clipped 'up'
            this.y += Tile.height
            this.y = Tile.height * Math.floor(this.y/Tile.height)
            this.jumping = false
            this.vely = 0

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
        x = if this.direction == 1 then this.x + 32 else this.x
        bullet = new Bullet(this.game, x, this.y+15, this.direction)
        this.game.level.entities.push(bullet)

    jump: ->
        console.log "jumping"

    draw: ->
        sprite = "player"
        sprite += (Math.floor(this.t / 5)) % 2
        sprite += (if this.direction == 1 then 'r' else 'l')
        this.game.canvas.drawSprite this.x, this.y, sprite
