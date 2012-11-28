class Player extends Entity
    (@game, position) ->
        @width = 28
        @height = 32
        @direction = 1
        @x = position.x * Tile.size
        @y = position.y * Tile.size
        @vely = 0
        @jumping = false
        @t = 0

    tick: ->
        keys = @game.input.keys
        vel = 4

        if keys.up.hold
            if not @jumping and @canJump!
                @t = 5
                @jumping = true
                @vely = vel
                @jumpGoal = @y - 2 * Tile.size

        if keys.z.pulse
            @shoot!

        if !@jumping and !@canJump!
            @y += @vely
            @vely += 0.2
            if @vely >= vel
                @vely = vel
            @adjustFall!

        if @jumping
            @y -= @vely
            @vely -= 0.01

            if @y <= @jumpGoal
                @y = @jumpGoal
                @jumping = false
                @vely = 0

            @adjustJump!

        if keys.right.hold
            @x += vel
            @direction = 1
            @adjustWalk 'right'


        if keys.left.hold
            @x -= vel
            @direction = -1
            @adjustWalk 'left'

        @touchTiles!

    canJump: ->
        @y++
        ret = @clipped 'down'
        @y--
        ret

    adjustWalk: (direction) ->
        if @clipped direction
            if direction == 'left'
                @x += @width - 1

            @x = Tile.size * Math.floor @x / Tile.size
            if direction == 'right'
                @x += Tile.size - @width
        else
            if @canJump()
                @t++

    adjustJump: ->
        if @clipped 'up'
            @y += Tile.size
            @y = Tile.size * Math.floor @y / Tile.size
            @jumping = false
            @vely = 0

    adjustFall: ->
        if @clipped 'down'
            @y = Tile.size * Math.floor @y / Tile.size

    shoot: ->
        x = if @direction == 1 then @x + @width else @x
        y = @y + @height / 2
        bullet = new Bullet(@game, x, y, @direction)
        @game.level.entities.push bullet

    draw: ->
        sprite = "player"
        sprite += (Math.floor @t / 5) % 2
        sprite += (if @direction == 1 then 'r' else 'l')
        @game.canvas.drawSprite @x, @y, sprite

    touchTiles: ->
        tiles = _.flatten @touchingTiles!
        for tile in tiles

            if tile.tile == '*'
                @hasTrophy = true

            if tile.tile == '='
                if @hasTrophy
                    @game.nextLevel = true
                    @hasTrophy = false

            if Tile.isLethal tile.tile
                @dead = true
                @game.restart = true

            if Tile.isPickable tile.tile
                @game.level.clearTile tile.x, tile.y

