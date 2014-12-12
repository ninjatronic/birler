moment = require 'moment'


_lastCall = null

module.exports = ->
  lastCall = _lastCall
  _lastCall = moment()

  if lastCall?
    "+#{ moment().diff lastCall }ms"
  else
    '+0ms'
