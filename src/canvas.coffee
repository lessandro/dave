class Canvas
    constructor: ->
        canvas = $("canvas").get(0)
        this.ctx = canvas.getContext("2d")

    tiles =
        "B": "red"
        "G": "brown"
        " ": "black"
        "*": "yellow"
        "D": "blue"
        "P": "purple"
        "R": "red"
        "+": "gray"
        "=": "brown"

    drawTile: (tile, i, j) ->
        x = i * Tile.width
        y = j * Tile.height

        this.ctx.fillStyle = tiles[tile]
        this.ctx.fillRect x, y, Tile.width, Tile.height

    drawSprite: (x, y, type) ->
        radius = if type == 'player' then 16 else 4
        this.ctx.fillStyle = "green"
        this.ctx.beginPath()
        this.ctx.arc x+Tile.width/2, y+Tile.height/2, radius, 0, 2 * Math.PI, false
        this.ctx.closePath()
        this.ctx.fill()
