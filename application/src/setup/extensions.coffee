# Exposed libraries to global
global = require 'global'
global.Promise = require 'bluebird'
global.jQuery = require 'jQuery'
global.Overworld = require 'overworld'
global.React = require 'react'
global._ = require 'lodash'
shell = require 'shell'

# require jade
jade = require('react-jade')
require.extensions['.jade'] = (module, filename) ->
  module.exports = jade.compileFile(filename)

# Hack `a` tag
jQuery ->
  jQuery('body').on 'click', 'a', (ev) ->
    ev.preventDefault()
    link = ev.target.href
    shell.openExternal link

window.onunhandledrejection = (e) ->
  console.error e

window.onerror = (e) ->
  console.error e
