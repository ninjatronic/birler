proxyquire = require 'proxyquire'
sinon = require 'sinon'
should = require('chai').should()


describe 'lib/timer', ->

  imports = {}
  timer = null

  now = null
  diff = null
  lastCall = null

  before ->
    imports['moment'] = sinon.stub()
    now = new Date()
    diff = new String 'diff'
    lastCall = new String 'lastCall'

  beforeEach ->
    imports['moment'].returns now
    now.diff = sinon.stub()
    now.diff
      .withArgs lastCall
      .returns diff

    timer = proxyquire "#{process.cwd()}/lib/timer", imports

  it 'should exist', ->
    timer.should.exist

  describe 'lastCall', ->

    it 'should not exist', ->
      should.not.exist timer.lastCall

  describe 'when called', ->

    result = null

    beforeEach ->
      result = timer()

    describe 'when lastCall doesn\'t exist', ->

      _lastCall = null

      before ->
        _lastCall = timer.lastCall
        timer.lastCall = null

      after ->
        timer.lastCall = _lastCall
        _lastCall = null

      it 'should return \'+0ms\'', ->
        result.should.equal '+0ms'

      it 'should set lastCall to now', ->
        timer.lastCall.should.equal now

    describe 'when lastCall does exist', ->

      _lastCall = null

      before ->
        _lastCall = timer.lastCall
        timer.lastCall = lastCall

      after ->
        timer.lastCall = _lastCall
        _lastCall = null

      xit 'should return \'+diffms\'', -> #todo fix this test
        result.should.equal '+diffms'

      it 'should set lastCall to now', ->
        timer.lastCall.should.equal now
