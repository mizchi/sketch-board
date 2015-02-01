React    = require 'react'
_ = require 'lodash'

template = require './template'
actions  = require './actions'

defaultCoffee = '''
module.exports = React.createClass
  getInitialState: ->
    cnt: 0

  componentDidMount: ->
    @intervalId = setInterval =>
      @setState cnt: @state.cnt+1

  componentWillUnmount: ->
    clearInterval(@intervalId)

  render: ->
    template(this)
'''

defaultJade = '''
h1 Timer
span.timer=state.cnt
'''

CoffeeScript = require 'coffee-script'
jade = require 'react-jade'

module.exports = React.createClass
  mixins: [Overworld.Emittable, actions]
  getInitialState: ->
    history: [
      {coffee: defaultCoffee, jade: defaultJade}
    ]
    focus: 0

  onClickSave: ->
    @saveHistory(@coffeeEditor.getValue(), @jadeEditor.getValue())

  onClickClipboard: ->
    require('clipboard').writeText """
    #=========
    # coffee
    #=========
    #{@coffeeEditor.getValue()}

    #=========
    # jade
    #=========
    #{@jadeEditor.getValue()}
    """


  onClickHistory: (ev) ->
    index = parseInt ev.target.dataset.historyIndex
    @useHisotory(index)

  saveHistory: (coffee, jade) ->
    @setState history: [{coffee, jade}].concat @state.history

  useHisotory: (n) ->
    buf = @state.history[n]
    if buf
      @coffeeEditor.setValue buf.coffee
      @jadeEditor.setValue buf.jade
    else
      console.warn "#{n} is not saved"

  update: ->
    previewElement = @refs.preview.getDOMNode()

    coffeeSource = @coffeeEditor.getValue()
    jadeSource = @jadeEditor.getValue()

    window.__template = jade.compile jadeSource
    js = CoffeeScript.compile(coffeeSource, {bare: true})
      .replace('module.exports', 'window.__reactClass')
      .replace('template', '__template')

    eval(js)

    React.render(React.createFactory(__reactClass)(), previewElement)

  componentDidMount: ->
    coffeeElement = @refs.coffee.getDOMNode()
    jadeElement = @refs.jade.getDOMNode()

    self = this
    window.coffeeEditor = @coffeeEditor = createMyEditor coffeeElement,
      theme: 'monokai'
      mode: 'coffeescript'
      tabMode: 'spaces'
      lineNumbers: true
      indentUnit: 2
      tabSize: 2
      indentWithTabs: false
      extraKeys:
        'Ctrl-Tab': ->
          focusJade()
        'Cmd-S': ->
          self.saveHistory(self.coffeeEditor.getValue(), self.jadeEditor.getValue())
        'Ctrl-R': ->
          self.update()
        'Cmd-0': -> self.useHisotory(0)
        'Cmd-1': -> self.useHisotory(1)
        'Cmd-2': -> self.useHisotory(2)
        'Cmd-3': -> self.useHisotory(3)
        'Cmd-4': -> self.useHisotory(4)
        'Cmd-5': -> self.useHisotory(5)

    window.jadeEditor = @jadeEditor = createMyEditor jadeElement,
      theme: 'monokai'
      mode: 'jade'
      tabMode: 'spaces'
      lineNumbers: true
      indentUnit: 2
      tabSize: 2
      indentWithTabs: false
      extraKeys:
        'Ctrl-Tab': ->
          focusCoffee()
        'Cmd-S': ->
          self.saveHistory(self.coffeeEditor.getValue(), self.jadeEditor.getValue())
        'Ctrl-R': ->
          self.update()
        'Cmd-0': -> self.useHisotory(0)
        'Cmd-1': -> self.useHisotory(1)
        'Cmd-2': -> self.useHisotory(2)
        'Cmd-3': -> self.useHisotory(3)
        'Cmd-4': -> self.useHisotory(4)
        'Cmd-5': -> self.useHisotory(5)

    @useHisotory(0)
    @update()
    focusCoffee = ->
      coffeeEditor.focus()
      coffeeEditor.setSize('100%', '600px')
      jadeEditor.setSize('100%', '50px')
    focusJade = ->
      jadeEditor.focus()
      jadeEditor.setSize('100%', '600px')
      coffeeEditor.setSize('100%', '50px')

    jadeEditor.on 'focus', -> focusJade()
    coffeeEditor.on 'focus', -> focusCoffee()

    focusJade()

  render: ->
    template _.extend {}, @, @props, @state
