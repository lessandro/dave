class Enemy extends Entity
    (@game, enemy) ->
        @width = 32
        @height = 32
        @dead = false
        @direction = 1
        @sprite = enemy.sprite
        @setup-waypoints enemy.waypoints

    setup-waypoints: (waypoints) ->
        @segment-length = 15 # frame ticks
        @waypoint-length = waypoints.length * @segment-length

        @waypoints = [[x * Tile.size, y * Tile.size] for [x, y] in waypoints]
        @waypoints.push @waypoints[0]

        # 0....1....2....0

    interpolate: ([x0, y0], [x1, y1], t) ->
        [dx, dy] = [x1 - x0, y1 - y0]
        return [x0 + dx * t, y0 + dy * t]

    tick: ->
        waypoint-position = (@game.frame % @waypoint-length) / @segment-length
        # ^ number from 0 to waypoint.length
        wp0 = Math.floor waypoint-position
        wp1 = Math.ceil waypoint-position
        t = waypoint-position - wp0
        [@x, @y] = @interpolate @waypoints[wp0], @waypoints[wp1], t

        @direction = if @game.level.player.x < @x then -1 else 1
        if @on-screen! && (@game.frame % 40 == 0)
            @shoot 9

    draw: ->
        sprite = @sprite
        sprite += (if @direction == 1 then \r else \l)
        @game.canvas.draw-sprite @x, @y, sprite

    kill: ->
        @dead = true
