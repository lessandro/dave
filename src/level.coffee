class Level
    @maps: [
        {
            player:
                x: 2
                y: 8

            tiles: [
                "BBBBBBBBBBBBBBBBBBBG"
                "BP               RBG"
                "B  D   D   *   D  BG"
                "B  B   B   B   B  BG"
                "BD   D   D   D   DBG"
                "BB   B   B   B   BBG"
                "BD     D          BG"
                "B   BBBB   BBBBBB BG"
                "B+         B=     BG"
                "BBBBBBBBBBBBBBBBBBBG"
            ]
        },
        {
            player:
                x: 2
                y: 8

            tiles: [
                "BBBBBBBBBBBBBBBBBBBG"
                "BP               RBG"
                "B  D   D   *   D  BG"
                "B  B   B   B   B  BG"
                "BD   D   D   D   DBG"
                "BB   B   B   B   BBG"
                "BD     D          BG"
                "B   BBBB   BBBBBB BG"
                "B+         B=     BG"
                "BBBBBBBBBBBBBBBBBBBG"
            ]
        }
    ]

    constructor: (@game, n) ->
        this.map = Level.maps[n]
        this.entities = []
        this.tiles = []

        this.player = new Player(this.game, this.map.player)
        this.entities.push this.player

    getCoords: (x, y) ->
        i = Math.floor(x/Tile.size)
        j = Math.floor(y/Tile.size)
        return [i, j]        

    inBounds: (i, j) ->
        if i < 0 or i >= this.map.tiles[0].length
            return false
        if j < 0 or j >= this.map.tiles.length
            return false
        return true

    getTile: (x, y) ->
        [i, j] = this.getCoords x, y

        unless this.inBounds i, j
            return ' '

        return this.map.tiles[j][i]

    clearTile: (x, y) ->
        [i, j] = this.getCoords x, y

        if this.inBounds i, j
            line = this.map.tiles[j]
            this.map.tiles[j] = line[0..(i-1)] + ' ' + line[(i+1)..]

    tick: ->
        dead = []
        for entity in this.entities
            entity.tick()
            if entity.dead
                dead.push(entity)

        this.entities = _.difference this.entities, dead

    draw: ->
        for line, j in this.map.tiles
            for tile, i in line
                this.drawTile tile, i, j

        for entity in this.entities
            entity.draw()

    drawTile: (tile, i, j) ->
        this.game.canvas.drawTile tile, i, j
