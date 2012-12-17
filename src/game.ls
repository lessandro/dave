class Game
    ->
        @input = new Input()
        @canvas = new Canvas()
        @restart = true
        @current-level = 0

    run: ->
        console.log \running

        window.set-interval @step, 1000 / 30 # fixed fps

    step: ~>
        @tick!
        @draw!

    tick: ->
        if @next-level
            @current-level++

            if @current-level >= Level.maps.length
                @current-level = 0

        if @restart or @next-level        
            @next-level = false
            @restart = false
            @level = new Level(this, @current-level)
            @input.clear!
            @frame = 0

        @input.tick!
        @level.tick!

        @frame++
        
    draw: ->
        @canvas.clear!
        @level.draw!
        @draw-gui!

    draw-gui: ->
        line = "Level: #{@current-level + 1} " +
            "Lives: infinite " +
            "Jetpack: #{@level.player.has-jetpack} " +
            "Gun: #{@level.player.has-gun} " +
            "Trophy: #{@level.player.has-trophy}"
        @canvas.draw-text 10, 342, line

    @main = ->
        game = new Game()
        game.run!
