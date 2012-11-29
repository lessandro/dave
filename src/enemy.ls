class Enemy extends Entity
    (@game, @x, @y, @width = 32, @height = 32) ->
        @dead = false

    tick: ->
        if @game.frame % 100 == 99
            @bullet = new Bullet(@game, @, @x, @y + @height/2, -1)
            @game.level.new-entities.push @bullet

    draw: ->
        @game.canvas.draw-sprite @x, @y, \player0l
