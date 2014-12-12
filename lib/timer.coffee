moment = require 'moment'

module.exports = ->
  lastCall = module.exports.lastCall
  module.exports.lastCall = moment()

  if lastCall?
    "+#{ moment().diff lastCall }ms"
  else
    '+0ms'

module.exports.lastCall = null
