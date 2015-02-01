# External
CodeMirror = require 'codemirror/lib/codemirror.js'

require './requirements/plugins'
require './requirements/modes'
require './requirements/themes'
require './requirements/styles'

# Style
require './editor.css'

extend = require 'extend'
defaultOptions = require './default-options'

module.exports = (container, options) ->
  if (typeof container) is 'string'
    container = document.querySelector container

  textarea = document.createElement('textarea')
  container.appendChild(textarea)
  options = extend defaultOptions, options
  CodeMirror.fromTextArea textarea, options
