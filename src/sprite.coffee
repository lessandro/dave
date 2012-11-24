class Sprite
    constructor: (i, j, @sw = 16, @sh = 16) ->
        this.sx = i * 16
        this.sy = j * 16
        this.dw = this.sw * 2
        this.dh = this.sh * 2

        unless Sprite.image
            Sprite.image = new Image()
            Sprite.image.src = 'images.png'

    draw: (ctx, x, y) ->
        ctx.drawImage(Sprite.image, this.sx, this.sy, this.sw, this.sh, x, y, this.dw, this.dh)
