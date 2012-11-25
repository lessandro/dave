class Tile
    @size: 32

    @isSolid: (tile) ->
        return tile in ['B', '+']

    @isPickable: (tile) ->
        return tile in ['*', 'P', 'D', 'R']
