class Level
    @maps = [
        {
            player:
                x: 2
                y: 8

            tiles: [
                'BBBBBBBBBBBBBBBBBBBG'
                'BP               RBG'
                'B  D   D   *   D  BG'
                'B  B   B   B   B  BG'
                'BD   D   D   D   DBG'
                'BB   B   B   B   BBG'
                'BD     D          BG'
                'B   BBBB   BBBBBB BG'
                'B+         B=     BG'
                'BBBBBBBBBBBBBBBBBBBG'
            ]
        },
        {
            player:
                x: 1
                y: 8

            tiles: [
                'BBBBBBBBBBBBBBBBBBBBBBBBBBBB  BB  BBBBBBBBBBBBBBBB      '
                'BR     D            P         BB               =BB      '
                'B                       BBBBB BB BBBBBBBBBBBBBBBBB      '
                'B-  -        -         BB     BB     B                  '
                'B       ---   B       BB  BBBBBBBBB  B                  '
                'B --     B   *B ----- B  BB PB    B  B                  '
                'B        B -  B       B B    B  B B BB                  '
                'B   --- RB    B DDDDD B B BB B BB    B                  '
                'B        BD  -B       B   BP   PB  BPB                  '
                'BBBFFFFFFBFFFFBWWWWWWWBBBBBBBBBBBBBBBBFFFFFFFFFFFFFFFFFF'
            ]
        },
        {
            player:
                x: 2
                y: 5

            tiles: [
                'GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG R   GGGG'
                'GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGR    =GG  R  GGG'
                'GBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB         GG   R  R'
                'GD   D    D   D    D    D      D    D    D      D    D              GGGGGGGGG'
                'G                                                           G  G    R        '
                'G+   F   F   FF    F   F   F   FF   F   F  F    FF                  R        '
                'GBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBFF      FFGG      '
                'GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGFF    FFGG       '
                'GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGFFJ*FFGG        '
                'GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGFFFFFFFFF'
            ]
        }
    ]

    (@game, n) ->
        @start = Level.maps[n].player
        @tiles = [line[to] for line in Level.maps[n].tiles]
        @entities = []
        @new-entities = []

        @player = new Player(@game, @start)
        @entities.push @player

    get-coords: (x, y) ->
        i = Math.floor x / Tile.size
        j = Math.floor y / Tile.size
        return [i, j]        

    in-bounds: (i, j) ->
        if j < 0 or j >= @tiles.length
            return false
        if i < 0 or i >= @tiles[j].length
            return false
        return true

    get-tile: (x, y) ->
        [i, j] = @get-coords x, y

        unless @in-bounds i, j
            return ' '

        return @tiles[j][i]

    clear-tile: (x, y) ->
        [i, j] = @get-coords x, y

        if @in-bounds i, j
            @tiles[j][i] = ' '

    tick: ->
        alive = []
        for entity in @entities
            entity.tick()
            if !entity.dead
                alive.push(entity)

        @entities = alive +++ @new-entities
        @new-entities = []

    draw: ->
        w = 18 * Tile.size
        dx = (Math.floor @player.x / w) * w
        @game.canvas.set-scroll dx

        for line, j in @tiles
            for tile, i in line
                @draw-tile tile, i, j

        for entity in @entities
            entity.draw()

    draw-tile: (tile, i, j) ->
        @game.canvas.draw-tile tile, i, j
