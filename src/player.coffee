class Player extends Entity
    constructor: (@game, position) ->
        this.width = 32
        this.height = 32
        this.direction = 1
        this.x = position.x * Tile.size
        this.y = position.y * Tile.size
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
                this.jumpGoal = this.y - 2 * Tile.size

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
                this.x += Tile.size - 1
            this.x = Tile.size * Math.floor(this.x/Tile.size)
        else
            if this.canJump()
                this.t++

    adjustJump: ->
        if this.clipped 'up'
            this.y += Tile.size
            this.y = Tile.size * Math.floor(this.y/Tile.size)
            this.jumping = false
            this.vely = 0

    adjustFall: ->
        if this.clipped 'down'
            this.y = Tile.size * Math.floor(this.y/Tile.size)

    shoot: ->
        x = if this.direction == 1 then this.x + 32 else this.x
        bullet = new Bullet(this.game, x, this.y+15, this.direction)
        this.game.level.entities.push(bullet)

    draw: ->
        sprite = "player"
        sprite += (Math.floor(this.t / 5)) % 2
        sprite += (if this.direction == 1 then 'r' else 'l')
        this.game.canvas.drawSprite this.x, this.y, sprite
