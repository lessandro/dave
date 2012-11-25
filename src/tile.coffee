class Tile
    @size: 32

    @isSolid: (tile) ->
        return tile in ['B', 'G', '+', '-']

    @isPickable: (tile) ->
        return tile in ['*', 'P', 'D', 'R']

    @isLethal: (tile) ->
        return tile in ['W', 'F']
