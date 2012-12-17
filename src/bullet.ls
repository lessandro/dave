class Bullet extends Entity
    (@game, @owner, x, y, @direction, @vel) ->
        @width = 14
        @height = 6
        @x = Math.round x - @width / 2
        @y = Math.round y - @height / 2
        @sprite = if @direction == 1 then \bulletr else \bulletl
        if @direction == -1
            @x -= @width
        @dead = false

    tick: !->
        @x += @direction * @vel

        if @clipped \all or !@on-screen!
            @die!

        for entity in @game.level.entities
            if entity in [@, @owner]
                continue

            if @entity-collision entity
                if entity.kill!
                    @die!

    die: ->
        @dead = true
        @owner.bullet = null

    draw: ->
        @game.canvas.draw-sprite @x, @y, @sprite
