class Canvas
    constructor: ->
        canvas = $("canvas").get(0)
        this.scroll = 0
        this.ctx = canvas.getContext("2d")
        this.ctx.mozImageSmoothingEnabled = false;
        this.ctx.webkitImageSmoothingEnabled = false;

        this.sprites =
            'player0r': new Sprite(0, 0)
            'player0l': new Sprite(1, 0)
            'player1r': new Sprite(2, 0)
            'player1l': new Sprite(3, 0)
            'bulletr': new Sprite(0, 1, 7, 3)
            'bulletl': new Sprite(1, 1, 7, 3)
            '*': new Sprite(0, 2)
            'P': new Sprite(1, 2)
            'R': new Sprite(2, 2)
            'D': new Sprite(3, 2)
            'B': new Sprite(0, 3)
            'G': new Sprite(1, 3)
            '=': new Sprite(2, 3)
            '+': new Sprite(3, 3)
            'F': new Sprite(4, 3)
            'W': new Sprite(5, 3)
            '-': new Sprite(6, 3)

    setScroll: (dx) ->
        this.scroll = dx

    drawTile: (tile, i, j) ->
        x = i * Tile.size
        y = j * Tile.size

        if this.sprites[tile]
            this.drawSprite x, y, tile
            return

        this.ctx.fillStyle = 'black'
        this.ctx.fillRect x-this.scroll, y, Tile.size, Tile.size

    drawSprite: (x, y, sprite) ->
        this.sprites[sprite].draw(this.ctx, x-this.scroll, y)
