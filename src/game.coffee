class Game
    constructor: ->
        #this[fn] = _.bind f, this for fn, f of this when typeof f == 'function'

        this.input = new Input()
        this.canvas = new Canvas()
        this.level = new Level(this, 0)

    run: ->
        console.log "running"

        step = _.bind this.step, this
        window.setInterval step, 100 # fixed at 10fps

    step: ->
        this.tick()
        this.draw()

    tick: ->
        this.input.tick()
        this.level.tick()
        
    draw: ->
        this.level.draw()

    @main: ->
        game = new Game()
        game.run()
