console = require 'console'
config = require './config'
labels = require './labels'


module.exports = (level, label, args...) ->

  levelColor = config.levels[level].color

  if label?
    labelColor = labels[label].color
    console.log level[levelColor], label[labelColor], args...

  else
    console.log level[levelColor], args...
