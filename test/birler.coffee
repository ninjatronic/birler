proxyquire = require 'proxyquire'


describe 'birler.js', ->

  imports = {}
  birler = null
  libBirler = { test: 'implementation' }

  before ->
    imports['./lib/birler'] = libBirler

  beforeEach ->
    birler = proxyquire "#{process.cwd()}/birler.js", imports

  it 'should export lib/birler', ->
    birler.should.equal libBirler


describe 'lib/birler', ->

  imports = {}
  birler = null

  beforeEach ->
    birler = proxyquire "#{process.cwd()}/lib/birler", imports

  it 'should exist', ->
    birler.should.exist
