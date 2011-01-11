    _____________        ________             ___________              
    ___  __ )__(_)______ ___  __ )______________  /___  /______________
    __  __  |_  /__  __ `/_  __  |_  ___/  __ \  __/_  __ \  _ \_  ___/
    _  /_/ /_  / _  /_/ /_  /_/ /_  /   / /_/ / /_ _  / / /  __/  /    
    /_____/ /_/  _\__, / /_____/ /_/    \____/\__/ /_/ /_/\___//_/     
                 /____/                                                

# BigBrother

## A logging HTTP proxy written in node.js, Redis and MongoDB

### Up and running

First, install redis...
    
    brew install redis
    
You'll want to have redis running before you try the proxy...

    redis-server
    
Now for the main course: the proxy itself...

    coffee proxy.coffee

The proxy will now be running on port 8080. BigBrother will happily bind to another port; simply pass it as the first argument to the program.

    coffee proxy.coffee 1337

You should point your client (browser, reverse-proxy) at BigBrother via its network preferences.
Be aware that some browsers utilise system-wide proxy settings of the underlaying OS.

By default, BigBrother is extremely permissive and will allow all sorts of nasty traffic to pass.
This is easily changed using the REPL prompt made available to you once BigBrother starts up.
Filters can easily be hacked into BigBrother by modifying proxy.coffee appropriately.

### REPL
`ban IP|hostname|URI` - bans an IP, hostname or URI

`memory` - displays memory usage

`exit` - exits gracefully

`help` - shows this list of commands and their descriptions