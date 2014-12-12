sinon = require 'sinon'
config = require "#{process.cwd()}/lib/config"

describe 'lib/config', ->

  it 'should exist', ->
    config.should.exist

  it 'should be an object', ->
    config.should.be.a 'object'

  describe 'defaults', ->

    describe 'color', ->

      it 'should be a string', ->
        config.color.should.be.a 'string'

      it 'should be \'white\'', ->
        config.color.should.equal 'white'

    describe 'styles', ->

      it 'should be an array', ->
        config.styles.should.be.a 'array'

      it 'should be empty', ->
        config.styles.should.be.empty

    describe 'levelEnvironmentVariable', ->

      it 'should be a string', ->
        config.levelEnvironmentVariable.should.be.a 'string'

      it 'should be \'LEVEL\'', ->
        config.levelEnvironmentVariable.should.equal 'LEVEL'

    describe 'levels', ->

      it 'should be an object', ->
        config.levels.should.be.a 'object'

      describe 'fatal', ->

        it 'should be an object', ->
          config.levels.fatal.should.be.a 'object'

        describe 'color', ->

          it 'should be a string', ->
            config.levels.fatal.color.should.be.a 'string'

          it 'should be \'red\'', ->
            config.levels.fatal.color.should.equal 'red'

        describe 'styles', ->

          it 'should be an array', ->
            config.levels.fatal.styles.should.be.a 'array'

          it 'should be [\'bold\']', ->
            config.levels.fatal.styles.should.deep.equal ['bold']

        describe 'severity', ->

          it 'should be a number', ->
            config.levels.fatal.severity.should.be.a 'number'

          it 'should be 0', ->
            config.levels.fatal.severity.should.equal 0

      describe 'error', ->

        it 'should be an object', ->
          config.levels.error.should.be.a 'object'

        describe 'color', ->

          it 'should be a string', ->
            config.levels.error.color.should.be.a 'string'

          it 'should be \'red\'', ->
            config.levels.error.color.should.equal 'red'

        describe 'severity', ->

          it 'should be a number', ->
            config.levels.error.severity.should.be.a 'number'

          it 'should be 1', ->
            config.levels.error.severity.should.equal 1

      describe 'warn', ->

        it 'should be an object', ->
          config.levels.warn.should.be.a 'object'

        describe 'color', ->

          it 'should be a string', ->
            config.levels.warn.color.should.be.a 'string'

          it 'should be \'yellow\'', ->
            config.levels.warn.color.should.equal 'yellow'

        describe 'severity', ->

          it 'should be a number', ->
            config.levels.warn.severity.should.be.a 'number'

          it 'should be 2', ->
            config.levels.warn.severity.should.equal 2

      describe 'info', ->

        it 'should be an object', ->
          config.levels.info.should.be.a 'object'

        describe 'color', ->

          it 'should be a string', ->
            config.levels.info.color.should.be.a 'string'

          it 'should be \'cyan\'', ->
            config.levels.info.color.should.equal 'cyan'

        describe 'severity', ->

          it 'should be a number', ->
            config.levels.info.severity.should.be.a 'number'

          it 'should be 3', ->
            config.levels.info.severity.should.equal 3

      describe 'debug', ->

        it 'should be an object', ->
          config.levels.debug.should.be.a 'object'

        describe 'color', ->

          it 'should be a string', ->
            config.levels.debug.color.should.be.a 'string'

          it 'should be \'grey\'', ->
            config.levels.debug.color.should.equal 'grey'

        describe 'severity', ->

          it 'should be a number', ->
            config.levels.debug.severity.should.be.a 'number'

          it 'should be 4', ->
            config.levels.debug.severity.should.equal 4

    describe 'timestamps', ->

      it 'should be an object', ->
        config.timestamps.should.be.a 'object'

      describe 'shown', ->

        it 'should be a boolean', ->
          config.timestamps.shown.should.be.a 'boolean'

        it 'should be true', ->
          config.timestamps.shown.should.equal true

      describe 'color', ->

        it 'should be a string', ->
          config.timestamps.color.should.be.a 'string'

        it 'should be \'grey\'', ->
          config.timestamps.color.should.equal 'grey'

    describe 'diffs', ->

      it 'should be an object', ->
        config.diffs.should.be.a 'object'

      describe 'shown', ->

        it 'should be a boolean', ->
          config.diffs.shown.should.be.a 'boolean'

        it 'should be true', ->
          config.diffs.shown.should.equal true

      describe 'color', ->

        it 'should be a string', ->
          config.diffs.color.should.be.a 'string'

        it 'should be \'cyan\'', ->
          config.diffs.color.should.equal 'cyan'

    describe 'render', ->

      it 'should be an object', ->
        config.render.should.be.a 'object'

      describe 'joiner', ->

        it 'should be a string', ->
          config.render.joiner.should.be.a 'string'

        it 'should be \',\\n  \'', ->
          config.render.joiner.should.equal ',\n  '

      describe 'indent', ->

        it 'should be a string', ->
          config.render.indent.should.be.a 'string'

        it 'should be \'  \'', ->
          config.render.indent.should.equal '  '

      describe 'padJoin', ->

        it 'should be an array', ->
          config.render.padJoin.should.be.a 'array'

        it 'should be [\'\\n  \', \'\\n\']', ->
          config.render.padJoin.should.deep.equal ['\n  ', '\n']
