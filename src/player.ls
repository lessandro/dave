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
        @has-jetpack = false
        @has-gun = false
        @has-trophy = false

    tick: ->
        keys = @game.input.keys
        vel = 4

        if @using-jetpack
            if keys.up.hold
                @y -= vel
                @adjust-jump!

            if keys.down.hold
                @y += vel
                @adjust-fall!
        else
            if keys.up.hold
                if not @jumping and @can-jump!
                    @t = 5
                    @jumping = true
                    @vely = vel
                    @jump-goal = @y - 2 * Tile.size

            if !@jumping and !@can-jump! # falling!
                @y += @vely
                @vely += 0.2
                @vely >?= vel/3
                @vely <?= vel
                @adjust-fall!

            if @jumping
                @y -= @vely
                @vely -= 0.01

                if @y <= @jump-goal
                    @y = @jump-goal
                    @jumping = false
                    @vely = 0

                @adjust-jump!

        if keys.right.hold
            @x += vel
            @direction = 1
            @adjust-walk \right


        if keys.left.hold
            @x -= vel
            @direction = -1
            @adjust-walk \left

        if keys.z.pulse
            @shoot!

        if keys.x.pulse
            if @has-jetpack
                @using-jetpack = !@using-jetpack
                
            if @using-jetpack
                @jumping = false

        @touch-tiles!

    can-jump: ->
        @y++
        ret = @clipped \down
        @y--
        ret

    adjust-walk: (direction) ->
        if @clipped direction
            if direction == \left
                @x += @width - 1

            @x = Tile.size * Math.floor @x / Tile.size
            if direction == \right
                @x += Tile.size - @width
        else
            if @canJump()
                @t++

    adjust-jump: ->
        if @clipped \up
            @y += Tile.size
            @y = Tile.size * Math.floor @y / Tile.size
            @jumping = false
            @vely = 0

    adjust-fall: ->
        if @clipped \down
            @y = Tile.size * Math.floor @y / Tile.size

    shoot: ->
        x = if @direction == 1 then @x + @width else @x
        y = @y + @height / 2
        bullet = new Bullet(@game, x, y, @direction)
        @game.level.entities.push bullet

    draw: ->
        sprite = \player
        sprite += (Math.floor @t / 5) % 2
        sprite += (if @direction == 1 then \r else \l)
        @game.canvas.draw-sprite @x, @y, sprite

    touch-tiles: ->
        for tile in @touching-tiles!

            if tile.tile == \*
                @has-trophy = true

            if tile.tile == \=
                if @has-trophy
                    @game.next-level = true
                    @has-trophy = false

            if tile.tile == \J
                @has-jetpack = true

            if Tile.is-lethal tile.tile
                @dead = true
                @game.restart = true

            if Tile.is-pickable tile.tile
                @game.level.clear-tile tile.x, tile.y
