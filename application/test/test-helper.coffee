# Libraries

global = require 'global'
global.Promise = require 'bluebird'
global.jQuery = require 'jQuery'
global.Overworld = require 'overworld'
global.React = require('react/addons')
global.TestUtils = React.addons.TestUtils
global._ = require('lodash')
global.EventEmitter = require('events').EventEmitter
global.assert = require 'power-assert'
sinon = require 'sinon'
jade = require('react-jade')
cheerio = require 'cheerio'
jsdom = require('jsdom')
MockLocalStorage = require 'mock-localStorage'

# require jade
require.extensions['.jade'] = (module, filename) ->
  module.exports = jade.compileFile(filename)

# test helper
global.$ = (html) -> cheerio.load html

# jsdom
global.stubWindow = ->
  beforeEach ->
    global.window = jsdom.jsdom('<html><body></body></html>').parentWindow
    global.document = window.document
    global.navigator = window.navigator

  afterEach ->
    delete global.window
    delete global.document
    delete global.navigator

beforeEach ->
  @sinon = sinon.sandbox.create()

afterEach ->
  @sinon.restore()

global.FactoryDog = require 'factory-dog'
schema.databases[0].collections.forEach (col) ->
  obj = {}
  for k, v of col.params
    key =
      if k[k.length-1] is '?'
        k[0...k.length-1]
      else
        k
    obj[key] = v

  name =
    if col.name[col.name.length-1] is 's'
      col.name[0...col.name.length-1]
    else
      col.name

  FactoryDog.define name, obj
