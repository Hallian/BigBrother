rapid = require 'rapid'

exports.Hit = rapid.model 'hit',
  date:
    type: 'string'
    required: true
  host:
    type: 'string'
    required: true
  ip:
    type: 'string'
    required: true
  url:
    type: 'string'
    required: true
  method:
    type: 'string'
    required: true
  status:
    type: 'string'
    required: true