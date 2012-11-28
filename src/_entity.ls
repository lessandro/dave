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

        map =
            \up : [tiles[0+0].tile, tiles[0+1].tile]
            \down : [tiles[2+0].tile, tiles[2+1].tile]
            \left : [tiles[0+0].tile, tiles[2+0].tile]
            \right : [tiles[0+1].tile, tiles[2+1].tile]

        return _.any _.map map[direction], Tile.is-solid
