{
  name: 'BigBrother'
  description: '''A logging, adminstratable HTTP/HTTPS proxy written in node.js, Redis and MongoDB'''
  
  keywords: ['big', 'brother', 'logging', 'proxy', 'secure', 'http', 'https', 'transparent', 'redis', 'mongo']
  
  version: '0.1.0'
  
  author: 'Feisty Studios <bigbrother@feistystudios.com> (http://feistystudios.com/)'
  
  licenses: [
    {
      type: 'FEISTY'
      url: 'http://github.com/feisty/license/raw/master/LICENSE'
    }
  ]
  
  contributors: [
    'Nicholas Kinsey <nicholas.kinsey@feistystudios.com>'
    'Brendan Scarvell <brendan.scarvell@feistystudios.com>'
  ]
  
  repository:
    type: 'git'
    url: 'http://github.com/feisty/BigBrother.git'
    private: 'git@github.com:feisty/BigBrother.git'
    web: 'http://github.com/feisty/BigBrother'
  
  bugs:
    mail: 'bigbrother@feistystudios.com'
    web: 'http://github.com/feisty/BigBrother/issues'
    
  directories:
    lib: './lib'
    doc: './doc'
  
  # bin:
  #   bb: './bin/bb.coffee'
  
  # scripts:
  #   test: 'cake test'
  #   postinstall: 'cake init'
  
  dependencies:
    'coffee-script': '>= 1.0.0'
    'colors': '*'
    'rapid': '*'
  
  engines:
    node: '>= 0.3.5'
}