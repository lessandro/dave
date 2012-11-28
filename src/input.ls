class Input
    keymap =
        37: \left
        38: \up
        39: \right
        40: \down
        90: \z

    ->
        @clear!

        handler = _.bind @handler, this

        # assign handler
        $ document.body
            .on \keydown, handler
            .on \keyup, handler

    handler: (e) ->
        key = keymap[e.which]
        return true unless key

        if e.type is \keydown
            # disable keydown repeat
            unless @pressed[key]
                @pressed[key] = true
                @down[key] = true

        if e.type is \keyup
            @pressed[key] = false
            @up[key] = true
        
        # prevent default
        false

    tick: ->
        for code, key of keymap
            up = @up[key]
            dn = @down[key]

            @keys[key].pulse = dn

            if dn and up # frame pulse
                @keys[key].hold = true
                @down[key] = false

            else if dn and not up # pressed
                @keys[key].hold = true
                @down[key] = false

            else if not dn and up # released
                @keys[key].hold = false
                @up[key] = false

    clear: ->
        @down = {}
        @up = {}
        @pressed = {}
        @keys = {}

        for code, key of keymap
            @keys[key] =
                hold: false
                pulse: false
