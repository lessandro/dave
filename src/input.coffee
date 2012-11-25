class Input
    keymap =
        37: "left"
        38: "up"
        39: "right"
        40: "down"
        90: "z"

    constructor: ->
        this.clear()

        handler = _.bind this.handler, this

        # assign handler
        $(document.body)
            .on("keydown", handler)
            .on("keyup", handler)

    handler: (e) ->
        key = keymap[e.which]
        return true unless key

        if e.type is "keydown"
            # disable keydown repeat
            unless this.pressed[key]
                this.pressed[key] = true
                this.down[key] = true

        if e.type is "keyup"
            this.pressed[key] = false
            this.up[key] = true
        
        # prevent default
        false

    tick: ->
        for code, key of keymap
            up = this.up[key]
            dn = this.down[key]

            this.keys[key].pulse = dn

            if dn and up # frame pulse
                this.keys[key].hold = true
                this.down[key] = false

            else if dn and not up # pressed
                this.keys[key].hold = true
                this.down[key] = false

            else if not dn and up # released
                this.keys[key].hold = false
                this.up[key] = false

    clear: ->
        this.down = {}
        this.up = {}
        this.pressed = {}
        this.keys = {}

        for code, key of keymap
            this.keys[key] =
                hold: false
                pulse: false
