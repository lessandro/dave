class Entity
    kill: ->
        false

    corners: ->
        [[x, y] for y in [@y, @y + @height - 1]
            for x in [@x, @x + @width - 1]]

    touching-tiles: ->
        [{x, y, tile: @game.level.get-tile x, y} for [x, y] in @corners!]

    clipped: (direction) ->
        tiles = @touching-tiles!

        mapping =
            \up : [0 1]
            \down : [2 3]
            \left : [0 2]
            \right : [1 3]
            \all : [0 1 2 3]

        return any Tile.is-solid, [tiles[i].tile for i in mapping[direction]]

    @point-in-rect = ([x, y], rect) ->
        x >= rect.x and x <= rect.x + rect.width and
            y >= rect.y and y <= rect.y + rect.height

    on-screen: ->
        @@point-in-rect [@x, @y], @game.canvas.view

    point-collision: ~>
        @@point-in-rect it, @

    entity-collision: (entity) ->
        (any @point-collision, entity.corners!) or
            (any entity~point-collision, @corners!)
