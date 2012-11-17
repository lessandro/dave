class Canvas
    constructor: ->
        canvas = $("canvas").get(0);
        this.ctx = canvas.getContext("2d");

    tiles =
        " ": "rgb(255,255,255)"
        "W": "rgb(0,0,100)"
        "L": "rgb(0,100,0)"
        "G": "rgb(139,69,19)"

    drawTile: (tile, i, j) ->
        x = i * Tile.width
        y = j * Tile.height

        this.ctx.fillStyle = tiles[tile]
        this.ctx.fillRect x, y, Tile.width, Tile.height

    drawSprite: (x, y) ->
        this.ctx.fillStyle = "black"
        this.ctx.beginPath()
        this.ctx.arc x, y, 10, 0, 2 * Math.PI, false
        this.ctx.closePath()
        this.ctx.fill()
