class Entity
    (@game, @x, @y) ->

    draw: ->

    tick: ->

    touching-tiles: ->
        get-tile = (x, y) ~>
            tile: @game.level.get-tile x, y
            x: x
            y: y

        xs = [@x, @x + @width - 1]
        ys = [@y, @y + @height - 1]

        return [get-tile x, y for y in ys for x in xs]

    clipped: (direction) ->
        tiles = @touching-tiles!

        mapping =
            \up : [0 1]
            \down : [2 3]
            \left : [0 2]
            \right : [1 3]

        tiles = [tiles[i].tile for i in mapping[direction]]

        return any Tile.is-solid, tiles
