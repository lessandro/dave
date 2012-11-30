class Bullet extends Entity
    (@game, @owner, x, y, @direction) ->
        @width = 14
        @height = 6
        @x = Math.round x - @width / 2
        @y = Math.round y - @height / 2
        @sprite = if @direction == 1 then \bulletr else \bulletl
        @dead = false

    tick: !->
        vel = 10
        @x += @direction * vel

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
