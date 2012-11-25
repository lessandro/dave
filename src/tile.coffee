class Tile
    @size: 32

    @isSolid: (tile) ->
        return tile in ['B', '+']
