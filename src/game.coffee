class Game
    constructor: ->
        #this[fn] = _.bind f, this for fn, f of this when typeof f == 'function'

        this.input = new Input()
        this.canvas = new Canvas()
        this.nextLevel = true
        this.currentLevel = -1

    run: ->
        console.log "running"

        step = _.bind this.step, this
        window.setInterval step, 1000 / 30 # fixed fps

    step: ->
        this.tick()
        this.draw()

    tick: ->
        if this.nextLevel
            this.nextLevel = false
            this.currentLevel++

            if this.currentLevel >= Level.maps.length
                this.currentLevel = 0

            this.level = new Level(this, this.currentLevel)

        this.input.tick()
        this.level.tick()
        
    draw: ->
        this.level.draw()

    @main: ->
        game = new Game()
        game.run()
