changeCase = require 'change-case'
module.exports = (g, {$1}) ->
  g.gen "index.coffee.hbs"    , "src/components/#{$1}/index.coffee"
  g.gen "component.coffee.hbs", "src/components/#{$1}/components/#{$1}.coffee"
  g.gen "style.scss.hbs"      , "src/components/#{$1}/styles/#{$1}.scss"
  g.gen "template.jade.hbs"   , "src/components/#{$1}/templates/#{$1}.jade"
  g.gen "actions.coffee.hbs"  , "src/components/#{$1}/actions.coffee"
