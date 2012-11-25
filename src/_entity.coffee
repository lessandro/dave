class Entity
    constructor: (@game, @x, @y) ->

    draw: ->

    tick: ->

    touchingTiles: ->
        level = this.game.level
        getTile = (x, y) ->
            tile: level.getTile x, y
            x: x
            y: y

        xs = [this.x, this.x + this.width - 1]
        ys = [this.y, this.y + this.height - 1]

        return (getTile x, y for x in xs for y in ys)

    clipped: (direction) ->
        tiles = this.touchingTiles()

        map =
            'up': [tiles[0][0].tile, tiles[0][1].tile]
            'down': [tiles[1][0].tile, tiles[1][1].tile]
            'left': [tiles[0][0].tile, tiles[1][0].tile]
            'right': [tiles[0][1].tile, tiles[1][1].tile]

        return _.any _.map map[direction], Tile.isSolid
