class Entity
    corners: ->
        [[x, y] for y in ys = [@y, @y + @height - 1]
            for x in xs = [@x, @x + @width - 1]]

    touching-tiles: ->
        [{x, y, tile: @game.level.get-tile x, y} for [x, y] in @corners!]

    clipped: (direction) ->
        tiles = @touching-tiles!

        mapping =
            \up : [0 1]
            \down : [2 3]
            \left : [0 2]
            \right : [1 3]

        return any Tile.is-solid, [tiles[i].tile for i in mapping[direction]]


    on-screen: ->
        x = @x - @game.canvas.scroll
        if x > @game.canvas.width or x + @width < 0
            return false

        if @y > @game.canvas.height or @y + @height < 0
            return false

        return true
