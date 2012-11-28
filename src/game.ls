class Game
    ->
        @input = new Input()
        @canvas = new Canvas()
        @restart = true
        @currentLevel = 0

    run: ->
        console.log "running"

        window.setInterval @step, 1000 / 30 # fixed fps

    step: ~>
        @tick!
        @draw!

    tick: ->
        if @nextLevel
            @currentLevel++

            if @currentLevel >= Level.maps.length
                @currentLevel = 0

        if @restart or @nextLevel        
            @nextLevel = false
            @restart = false
            @level = new Level(this, @currentLevel)
            @input.clear!

        @input.tick!
        @level.tick!
        
    draw: ->
        @level.draw!

    @main = ->
        game = new Game()
        game.run!
