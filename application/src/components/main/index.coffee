React    = require 'react'
_ = require 'lodash'

template = require './template'
actions  = require './actions'

defaultCoffee = '''
module.exports = React.createClass
  render: ->
    template(this)
'''

defaultJade = '''
h1 Hello
'''

CoffeeScript = require 'coffee-script'
jade = require 'react-jade'

module.exports = React.createClass
  mixins: [Overworld.Emittable, actions]
  componentDidMount: ->
    previewElement = @refs.preview.getDOMNode()
    coffeeElement = @refs.coffee.getDOMNode()
    jadeElement = @refs.jade.getDOMNode()

    update = ->
      coffeeSource = coffeeEditor.getValue()
      jadeSource = jadeEditor.getValue()
      window.__template = jade.compile jadeSource

      js = CoffeeScript.compile(coffeeSource, {bare: true})
        .replace('module.exports', 'window.__reactClass')
        .replace('template', '__template')
      eval(js)
      React.render(React.createFactory(__reactClass)(), previewElement)

    focusCoffee = ->
      coffeeElement.style.height = '80%'
      jadeElement.style.height = '20%'

    coffeeEditor = createMyEditor coffeeElement,
      theme: 'monokai'
      mode: 'coffeescript'
      extraKeys:
        'Tab': ->
          console.log 'tab'
        'Cmd-S': ->
          update()

    coffeeEditor.setValue defaultCoffee

    jadeEditor = createMyEditor jadeElement,
      theme: 'monokai'
      mode: 'jade'
      extraKeys:
        'Tab': ->
          console.log 'tab'
        'Cmd-S': ->
          update()
    jadeEditor.setValue defaultJade

    update()
    focusCoffee()

  render: ->
    template _.extend {}, @, @props, @state
