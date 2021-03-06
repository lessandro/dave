class Sprite
    @size = 16

    (i, j, @sw = 16, @sh = 16) ->
        @sx = i * 16
        @sy = j * 16
        @dw = @sw * (Tile.size / Sprite.size)
        @dh = @sh * (Tile.size / Sprite.size)

        unless Sprite.image
            Sprite.image = new Image()
            Sprite.image.src = \img/images.png

    draw: (ctx, x, y) ->
        ctx.draw-image Sprite.image, @sx, @sy, @sw, @sh, x, y, @dw, @dh
