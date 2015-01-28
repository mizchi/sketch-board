app = require('app')
BrowserWindow = require('browser-window')

path = require('path')
require('crash-reporter').start()
mainWindow = null
app.on 'window-all-closed', -> app.quit();

app.on 'ready', ->
  app.commandLine.appendSwitch('js-flags', '--harmony')
  mainWindow = new BrowserWindow({width: 1280, height: 800})
  mainWindow.loadUrl(path.join('file://', __dirname, '../public/index.html'))
  mainWindow.on 'closed', ->
    mainWindow = null
