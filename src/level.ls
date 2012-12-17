class Level
    @maps = [
        {
            player:
                x: 2
                y: 8

            tiles: [
                'BBBBBBBBBBBBBBBBBBBG'
                'BP               RBG'
                'B  D   D   T   D  BG'
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
                'B --     B   TB ----- B  BB PB    B  B                  '
                'B        B -  B       B B    B  B B BB                  '
                'B   --- RB    B DDDDD B B BB B BB    B                  '
                'B        BD  -B       B   BP   PB  BPB                  '
                'BBBFFFFFFBFFFFBWWWWWWWBBBBBBBBBBBBBBBBFFFFFFFFFFFFFFFFFF        G'
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
                'GD   D    D   Z    D    D      D    D    D      D    D              GGGGGGGGG'
                'G                                                           G  G    R       W'
                'G+   F   F   FF    F   F   F   FF   F   F  F    FF                  R       W'
                'GBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBFF      FFGG     W'
                'GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGFF    FFGG      W'
                'GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGFFJTFFGG       W'
                'GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGFFFFFFFFF'
            ]

            enemies: [
                {
                    x: 37
                    y: 4
                }
                {
                    x: 55
                    y: 4
                }
            ]
        },
        {
            player:
                x: 2
                y: 5

            tiles: [
                'GUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU'
                'GU      TU    D       D    D   D            D  D UR      D   D  D            DU D D  D  D  D  D D DRU'
                'GU  UUUUUU            U              UUU UUUUUUU U  WUUUUUUU        DWUUW U  DU UUUUUUUUUUUUU      =U'
                'GUU   U    UUU UUUU      U   UUUUU            DU    UU   D     UUU UUU  UDU  DU D                UUUU'
                'GU+U     UUU        U        D       U  UD             UUUUUW   U      JUDU  DUUUUUD U UF     U     U'
                'GU UFFUUUU             U  UU         U  UUUUU    UUUUU UR DUWU    U   UUUDU       UU U DUFFFR  FFU  U'
                'GU  UUU      U    U  U    UU    UUU  U           U     UW  DWU    UU UU   U  UUUFRU  U  DUUUU  UUUU U'
                'GU         UUUU   U      UUUU        U  UUUUU U  U UUUUUU UUUU  U              UUUU UU          DU  U'
                'GU        UUUUUU  U     UUUUUU       U                          U      U  U                        UU'
                'GUUUUUUUUUUUUUUUUUUUUUUUUUUUUUFFFFFFFUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUUU'
            ]

            enemies: [
            ]
        },
        {
            player:
                x: 2
                y: 8

            tiles: [
                'G *%%%  *   *      *   *  *   *  *  *   *%%%%% *   * *    GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG GGGG'
                'G %%%%%   *   *  *      *   * *        * %%%%%  * *       GGGGG    D  D  D   P|P   P|P     R    RGGG'
                'G %%%%% *    *  *    *                   %%%%% T      R  RGGG                   %%%    G   G      GG'
                'G %%%%%                                  %%%%%        G  GGG      G             %%%              = G'
                'G* P|P                       P       J    P|P                    GG     GGGG    %%%      G    R    G'
                'G   |                     G  G   P     G   |           G       G GG  D FGGGG     |                 G'
                'G   |     GGG  Z                 G  G    G |                     GGD G  GGGGD    |     G   G       G'
                'G   |     GGG       GGGGG     G           GGG        G      G    GG       F      |   G   G   G     G'
                'G+  |    GGGGG      GGGGG                 GGG            G      RGGWWWGGF   F    |               GGG'
                'GGGGGGGGGGGGGGGGGGGGGGGGGWWWWWWWWWWWWWWWWWGGGGGGGGGGGGGFFFFFFFFFFGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG'
            ]

            enemies: [
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

        if Level.maps[n].enemies
            for enemy in that
                x = enemy.x * Tile.size
                y = enemy.y * Tile.size
                @entities.push new Enemy(@game, x, y)

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
        @entities = filter (-> it.tick!; not it.dead), @entities
        [@entities, @new-entities] = [@entities +++ @new-entities, []]

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
