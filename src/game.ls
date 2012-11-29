class Game
    ->
        @input = new Input()
        @canvas = new Canvas()
        @restart = true
        @current-level = 2

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

        @input.tick!
        @level.tick!
        
    draw: ->
        @canvas.clear!
        @level.draw!

    @main = ->
        game = new Game()
        game.run!
