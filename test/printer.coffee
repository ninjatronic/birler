proxyquire = require 'proxyquire'
sinon = require 'sinon'


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
    
    args = null

    before ->
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
      config.levels[level] = { color: levelColor }
      imports['./labels'][label] = { color: labelColor }

      level?[levelColor] = "#{ level }.#{ levelColor }"
      label?[labelColor] = "#{ level }.#{ labelColor }"

      printer level, label, args...

    after ->
      delete config.levels[level]

    describe 'with a label', ->

      before ->
        label = new String 'myLabel'
        labelColor = 'myColor'

      after ->
        label = null
        labelColor = null

      it 'should call console.log once', ->
        imports['console'].log.should.have.been.calledOnce

      it 'should pass the colored level as the first argument', ->
        imports['console'].log.getCall(0).args[0]
          .should.equal level[levelColor]

      it 'should pass the colored label as the second argument', ->
        imports['console'].log.getCall(0).args[1]
          .should.equal label[labelColor]

      it 'should pass on the rest of the arguments unmolested', ->
        for arg, index in args
          do (arg, index) ->
            return if index < 2
            imports['console'].log.getCall(0).args[index]
              .should.equal args[index - 2]

    describe 'with no label', ->

      it 'should call console.log once', ->
        imports['console'].log.should.have.been.calledOnce

      it 'should pass the colored level as the first argument', ->
        imports['console'].log.getCall(0).args[0]
          .should.equal level[levelColor]

      it 'should pass on the rest of the arguments unmolested', ->
        for arg, index in args
          do (arg, index) ->
            return if index < 1
            imports['console'].log.getCall(0).args[index]
              .should.equal args[index - 1]
