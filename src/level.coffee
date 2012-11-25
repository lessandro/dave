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
        },
        {
            player:
                x: 2
                y: 5

            tiles: [
                "GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG R   GGGG"
                "GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGR    =GG  R  GGG"
                "GBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB         GG   R  R"
                "GD   D    D   D    D    D      D    D    D      D    D              GGGGGGGGG"
                "G                                                           G  G    R        "
                "G+   F   F   FF    F   F   F   FF   F   F  F    FF                  R        "
                "GBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBFF      FFGG      "
                "GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGFF    FFGG       "
                "GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGFFR*FFGG        "
                "GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGFFFFFFFFF"
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
        if j < 0 or j >= this.tiles.length
            return false
        if i < 0 or i >= this.tiles[j].length
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
