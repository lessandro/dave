class Enemy extends Entity
    (@game, @x, @y, @width = 32, @height = 32) ->
        @dead = false
        @direction = 1

    tick: ->
        @direction = if @game.level.player.x < @x then -1 else 1
        @shoot 6

    draw: ->
        sprite = \player0
        sprite += (if @direction == 1 then \r else \l)
        @game.canvas.draw-sprite @x, @y, sprite

    kill: ->
        @dead = true
