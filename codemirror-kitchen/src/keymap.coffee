# KeyMap
require 'codemirror/keymap/sublime.js'
require 'codemirror/keymap/vim.js'
require 'codemirror/keymap/emacs.js'

module.exports = extraKeys =
  'Ctrl-S': =>
    console.log 'ctrl-s'
