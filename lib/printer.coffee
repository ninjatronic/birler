console = require 'console'
moment = require 'moment'

config = require './config'
labels = require './labels'
timer = require './timer'

_lastCall = null

module.exports = (level, label, args...) ->

  now = moment()

  parts = []

  levelConfig = config.levels[level]
  levelColor = levelConfig.color
  parts.push level[levelColor]

  if label?
    labelConfig = labels[label]
    labelColor = labelConfig.color
    parts.push label[labelColor]

  if config.timestamps.shown
    timestamp = now.format config.timestamps.format
    timestampColor = config.timestamps.color
    parts.push timestamp[timestampColor]

  if config.diffs.shown
    diff = timer()
    diffColor = config.diffs.color
    parts.push diff[diffColor]

  parts.push(arg) for arg in args

  console.log parts...

  _lastCall = now
