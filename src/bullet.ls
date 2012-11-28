class Bullet extends Entity
    (@game, x, y, @direction) ->
        @width = 14
        @height = 6
        @x = Math.round(x - @width/2)
        @y = Math.round(y - @height/2)
        @sprite = if @direction == 1 then 'bulletr' else 'bulletl'

    tick: ->
        vel = 10
        @x += @direction * vel

        if @clipped (if @direction == 1 then 'right' else 'left')
            @dead = true

    draw: ->
        @game.canvas.drawSprite @x, @y, @sprite
