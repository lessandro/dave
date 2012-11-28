{spawn, exec} = require \child_process
watchr = require \watchr

run = (cmd, silent = true) ->
    exec cmd, [], (error, stdout, stderr) ->
        return if silent
        console.error stderr if stderr
        console.log stdout if stdout

build = ->
    run 'lsc -bco tmp src/*.ls', false
    run 'cat src/*.ls | lsc -sbc > dave.js'

task \build \build build

task \watch \watch ->
    watchr.watch {
        path: \src
        listener: (e, file) ->
            build if /\.ls$/.test file
    }
