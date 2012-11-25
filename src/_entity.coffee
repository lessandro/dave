class Entity
    constructor: (@game, @x, @y) ->

    draw: ->

    tick: ->

    clipped: (direction) ->
        # check if the entity is clipped in a block

        edgex = this.width - 1
        edgey = this.height - 1
        x1 = x2 = this.x
        y1 = y2 = this.y

        switch direction
            when 'up'
                x2 += edgex
            when 'down'
                x2 += edgex
                y1 = y2 = y1 + edgey
            when 'left'
                y2 += edgey
            when 'right'
                x1 = x2 = x1 + edgex
                y2 += edgey

        tile1 = this.game.level.getTile x1, y1
        tile2 = this.game.level.getTile x2, y2

        Tile.isSolid(tile1) or Tile.isSolid(tile2)
