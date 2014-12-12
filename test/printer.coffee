proxyquire = require 'proxyquire'
sinon = require 'sinon'
moment = require 'moment'


describe 'lib/printer', ->

  imports = {}
  printer = null
  config = null

  before ->
    config = require "#{process.cwd()}/lib/config"
    imports['console'] = { log: sinon.spy() }
    imports['bluebird'] = { resolve: sinon.stub() }
    imports['./labels'] = {}

  beforeEach ->
    imports['./config'] = config
    printer = proxyquire "#{process.cwd()}/lib/printer", imports

  afterEach ->
    imports['console'].log.reset()

  it 'should exist', ->
    printer.should.exist

  describe 'when invoked', ->

    level = null
    label = null
    
    levelColor = null
    labelColor = null

    timestamp = null
    timestampShown = null
    timestampColor = null
    
    diff = null
    diffShown = null
    diffColor = null
    
    passedArgs = null
    args = null

    before ->
      imports['moment'] = sinon.stub()
      imports['./timer'] = sinon.stub()

      level = new String 'myLevel'
      levelColor = 'myColor'

      args = [
        'string'
        123
        true
        { an : 'object' }
        ['an', 'array']
        -> console.log 'a function'
      ]

    beforeEach ->
      timestamp = moment()
      timestamp.format = sinon.stub()
      timestamp.format
        .withArgs config.timestamps.format
        .returns timestamp

      diff = new String 'diff'
      imports['./timer'].returns diff

      config.levels[level] = { color: levelColor }
      imports['./labels'][label] = { color: labelColor }
      config.timestamps = { shown: timestampShown, color: timestampColor }
      config.diffs = { shown: diffShown, color: diffColor }
      imports['moment'].returns timestamp

      level?[levelColor] = "#{ level }.#{ levelColor }"
      label?[labelColor] = "#{ level }.#{ labelColor }"
      diff?[diffColor] = "#{ diff }.#{ diffColor }"
      timestamp?[timestampColor] = "#{ timestamp }.#{ timestampColor }"

      printer level, label, args...
      passedArgs = imports['console'].log.getCall(0).args

    afterEach ->
      passedArgs = null
      imports['moment'].reset()

    after ->
      delete config.levels[level]

    describe 'when timestamps and diffs are both shown', ->

      before ->
        timestampShown = true
        timestampColor = 'timestampColor'
        diffShown = true
        diffColor = 'diffColor'

      after ->
        timestampShown = null
        timestampColor = null
        diffShown = null
        diffColor = null

      it 'should call console.log once', ->
        imports['console'].log.should.have.been.calledOnce

      it 'should pass the colored level as the first argument', ->
        passedArgs[0].should.equal level[levelColor]

      describe 'with a label', ->

        before ->
          label = new String 'myLabel'
          labelColor = 'myColor'

        after ->
          label = null
          labelColor = null

        it 'should pass the colored label as the second argument', ->
          passedArgs[1].should.equal label[labelColor]

        it 'should pass the colored timestamp as the third argument', ->
          passedArgs[2].should.equal timestamp[timestampColor]

        it 'should pass the colored diff as the fourth argument', ->
          passedArgs[3].should.equal diff[diffColor]

        it 'should pass on the rest of the arguments unmolested', ->
          for arg, index in args
            do (arg, index) ->
              return if index < 4
              passedArgs[index]
                .should.equal args[index - 4]

      describe 'with no label', ->

        it 'should pass the colored timestamp as the second argument', ->
          passedArgs[1].should.equal timestamp[timestampColor]

        it 'should pass the colored diff as the third argument', ->
          passedArgs[2].should.equal diff[diffColor]

        it 'should pass on the rest of the arguments unmolested', ->
          for arg, index in args
            do (arg, index) ->
              return if index < 3
              passedArgs[index]
                .should.equal args[index - 3]

    describe 'when timestamps are shown and diffs are not shown', ->

      before ->
        timestampShown = true
        timestampColor = 'timestampColor'
        diffShown = false

      after ->
        timestampShown = null
        timestampColor = null
        diffShown = null

      it 'should call console.log once', ->
        imports['console'].log.should.have.been.calledOnce

      it 'should pass the colored level as the first argument', ->
        passedArgs[0].should.equal level[levelColor]

      describe 'with a label', ->

        before ->
          label = new String 'myLabel'
          labelColor = 'myColor'

        after ->
          label = null
          labelColor = null

        it 'should pass the colored label as the second argument', ->
          passedArgs[1].should.equal label[labelColor]

        it 'should pass the colored timestamp as the third argument', ->
          passedArgs[2].should.equal timestamp[timestampColor]

        it 'should pass on the rest of the arguments unmolested', ->
          for arg, index in args
            do (arg, index) ->
              return if index < 3
              passedArgs[index]
                .should.equal args[index - 3]

      describe 'with no label', ->

        it 'should pass the colored timestamp as the second argument', ->
          passedArgs[1].should.equal timestamp[timestampColor]

        it 'should pass on the rest of the arguments unmolested', ->
          for arg, index in args
            do (arg, index) ->
              return if index < 2
              passedArgs[index]
                .should.equal args[index - 2]

    describe 'when timestamps are not shown and diffs are shown', ->

      before ->
        timestampShown = false
        diffShown = true
        diffColor = 'diffColor'

      after ->
        timestampShown = null
        diffShown = null
        diffColor = null

      it 'should call console.log once', ->
        imports['console'].log.should.have.been.calledOnce

      it 'should pass the colored level as the first argument', ->
        passedArgs[0].should.equal level[levelColor]

      describe 'with a label', ->

        before ->
          label = new String 'myLabel'
          labelColor = 'myColor'

        after ->
          label = null
          labelColor = null

        it 'should pass the colored label as the second argument', ->
          passedArgs[1].should.equal label[labelColor]

        it 'should pass the colored diff as the fourth argument', ->
          passedArgs[2].should.equal diff[diffColor]

        it 'should pass on the rest of the arguments unmolested', ->
          for arg, index in args
            do (arg, index) ->
              return if index < 3
              passedArgs[index]
                .should.equal args[index - 3]

      describe 'with no label', ->

        it 'should pass the colored diff as the third argument', ->
          passedArgs[1].should.equal diff[diffColor]

        it 'should pass on the rest of the arguments unmolested', ->
          for arg, index in args
            do (arg, index) ->
              return if index < 2
              passedArgs[index]
                .should.equal args[index - 2]

    describe 'when neither timestamps nor diffs are shown', ->

      before ->
        timestampShown = false
        diffShown = false

      after ->
        timestampShown = null
        timestampColor = null
        diffShown = null

      it 'should call console.log once', ->
        imports['console'].log.should.have.been.calledOnce

      it 'should pass the colored level as the first argument', ->
        passedArgs[0].should.equal level[levelColor]

      describe 'with a label', ->

        before ->
          label = new String 'myLabel'
          labelColor = 'myColor'

        after ->
          label = null
          labelColor = null

        it 'should pass the colored label as the second argument', ->
          passedArgs[1].should.equal label[labelColor]

        it 'should pass on the rest of the arguments unmolested', ->
          for arg, index in args
            do (arg, index) ->
              return if index < 2
              passedArgs[index]
                .should.equal args[index - 2]

      describe 'with no label', ->

        it 'should pass on the rest of the arguments unmolested', ->
          for arg, index in args
            do (arg, index) ->
              return if index < 1
              passedArgs[index]
                .should.equal args[index - 1]
