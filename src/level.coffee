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
                x: 1
                y: 8

            tiles: [
                "BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB      "
                "BR     D            P         BB               =BB      "
                "B                       BBBBB BB BBBBBBBBBBBBBBBBB      "
                "B-  -        -         BB     BB     B                  "
                "B       ---   B       BB  BBBBBBBBB  B                  "
                "B --     B   *B ----- B  BB PB    B  B                  "
                "B        B -  B       B B    B  B B BB                  "
                "B   --- RB    B DDDDD B B BB B BB    B                  "
                "B        BD  -B       B   BP   PB  BPB                  "
                "BBBFFFFFFBFFFFBWWWWWWWBBBBBBBBBBBBBBBBFFFFFFFFFFFFFFFFFF"
            ]
        }
    ]

    constructor: (@game, n) ->
        this.start = Level.maps[n].player
        this.tiles = _.clone Level.maps[n].tiles
        this.entities = []

        this.player = new Player(this.game, this.start)
        this.entities.push this.player

    getCoords: (x, y) ->
        i = Math.floor(x/Tile.size)
        j = Math.floor(y/Tile.size)
        return [i, j]        

    inBounds: (i, j) ->
        if i < 0 or i >= this.tiles[0].length
            return false
        if j < 0 or j >= this.tiles.length
            return false
        return true

    getTile: (x, y) ->
        [i, j] = this.getCoords x, y

        unless this.inBounds i, j
            return ' '

        return this.tiles[j][i]

    clearTile: (x, y) ->
        [i, j] = this.getCoords x, y

        if this.inBounds i, j
            line = this.tiles[j]
            this.tiles[j] = line[0..(i-1)] + ' ' + line[(i+1)..]

    tick: ->
        dead = []
        for entity in this.entities
            entity.tick()
            if entity.dead
                dead.push(entity)

        this.entities = _.difference this.entities, dead

    draw: ->
        w = 18 * Tile.size
        dx = Math.floor(this.player.x / w) * w
        this.game.canvas.setScroll dx

        for line, j in this.tiles
            for tile, i in line
                this.drawTile tile, i, j

        for entity in this.entities
            entity.draw()

    drawTile: (tile, i, j) ->
        this.game.canvas.drawTile tile, i, j
