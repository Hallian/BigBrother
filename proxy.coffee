http = require 'http'
sys = require 'sys'
fs = require 'fs'
url = require 'url'
vm = require 'vm'
util = require 'util'

colors = require 'colors'

{Hit} = require './hit'

#process.on 'uncaughtException', (e) ->
#  console.dir e

port = process.argv[2] or 8080

db = ip: new Object, host: new Object, url: new Object

process.stdin.write fs.readFileSync('BANNER', 'utf8').bold, ->
  server = http.createServer (request, response) ->
    save = -> true

    hit = new Hit
      date: new Date
      method: request.method
      url: request.url
      host: url.parse(request.url).hostname
      ip: request.connection.remoteAddress
      status: 'init'

    hit.save save

    timeout = setTimeout((->
      console.log "[Timeout]".red + ' ' + "#{request.connection.remoteAddress} #{request.method} #{request.url}"
      response.writeHead 404 #ToDo: Add correct HTTP error code 'timeout' 
      response.end()
      hit.status = 'timeout'
      hit.save save
    ), 30 * 1000)

    deny = (reason) ->
      console.log "[Denied]".red + ' ' + "[#{reason}]".red + ' ' + "#{request.connection.remoteAddress} #{request.method} #{request.url}"
      response.writeHead 403
      response.end()
      hit.status = reason
      hit.save save
      clearTimeout timeout

    # NODE this is where one would apply filters

    if db.ip[request.connection.remoteAddress]
      deny 'ip'
      return

    for host, regex of db.host
      if RegExp(host).test request.url
        deny 'host'
        return

    console.log "#{request.connection.remoteAddress} #{request.method} #{request.url}"
    proxy = http.createClient url.parse(request.url).port || 80, request.headers.host
    proxy_request = proxy.request request.method, request.url, request.headers
    proxy_request.addListener 'response', (proxy_response) ->
      proxy_response.addListener 'data', (chunk) ->
        # NOTE this is where one would capture raw response content
        response.write chunk, 'binary'
    
      proxy_response.addListener 'end', ->
        response.end()
    
      response.writeHead proxy_response.statusCode, proxy_response.headers
      hit.status = 'success'
      hit.save save
      clearTimeout timeout
 
    request.addListener 'data', (chunk) ->
      proxy_request.write chunk, 'binary'

    request.addListener 'end', ->
      proxy_request.end()

  server.listen port

  console.log "BigBrother listening on #{port}...".cyan

  repl = require './repl'
  repl.init db