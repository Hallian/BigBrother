init = (db) ->
  readline = require 'readline'
  vm = require 'vm'
  util = require 'util'
  url = require 'url'

  CoffeeScript = require 'coffee-script'

  stdio = process.openStdin()

  error = (err) ->
    stdio.write err.stack + err.toString() + '\n\n'

  run = (buffer) ->
    try
      coffee = CoffeeScript.compile buffer.toString(), bare: on, globals: on, fileName: 'repl'
      context = 
        ban: (token) ->
          regex = /(?:\d{1,3}\.){3}\d{1,3}/
          if regex.test token
            db.ip[token] = true
          else
            result = url.parse token
            if not result.host
              db.host[token] = true
            else
              db.url[token] = true

          console.log util.inspect(db)
        memory: ->
          process.memoryUsage()
        db: db
        init: ->
          db.ip['192.168.0.1'] = true
        exit: (code) ->
          process.exit code
        fake: (n) ->
          for i in [0...n]
            ip = Math.floor(Math.random() * 255) + '.' + Math.floor(Math.random() * 255) + '.' + Math.floor(Math.random() * 255) + '.' + Math.floor(Math.random() * 255)
            db.ip[ip] = RegExp(ip)
            true
          true
        help: ->
          console.log '''
            > These commands are defined internally.
            
            > ban( [host|ip] )
            > unban( [host|ip] )
            > memory()
          '''

      val = vm.runInNewContext coffee, context

      console.log val if val isnt undefined

    catch err
      error err

    repl.prompt()

  repl = readline.createInterface stdio
  repl.setPrompt 'bb> '
  stdio.on 'data', (buffer) -> repl.write buffer
  repl.on 'close', -> stdio.destroy()
  repl.on 'line', run
  repl.prompt()

exports.init = init