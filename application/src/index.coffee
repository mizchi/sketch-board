require './setup/extensions'
require '../../codemirror-kitchen/dist/bundle.js'

global.app = new Overworld.Portal
app.link 'main', require './scenes/main'
window.addEventListener 'load', ->
  app.mount document.body
  app.transition('main', {})
