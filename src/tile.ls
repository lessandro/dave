class Tile
    @size = 32

    @is-solid = (tile) ->
        return tile in [\B \G \+ \-]

    @is-pickable = (tile) ->
        return tile in [\* \P \D \R]

    @is-lethal = (tile) ->
        return tile in [\W \F]