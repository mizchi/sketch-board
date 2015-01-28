cc = require 'change-case'

module.exports = (g, {$1, $2}) ->
  classify = (name) -> cc.pascalCase name
  methodify = (name) -> cc.snakeCase name

  g.addTemplateHelper
    'classify': classify
    'methodify': methodify

  g.gen "index.ts.hbs",      "src/scenes/#{$1}/index.ts"
  g.gen "subscriber.ts.hbs", "src/scenes/#{$1}/subscriber.ts"
  g.gen "aggregator.ts.hbs", "src/scenes/#{$1}/aggregator.ts"
  g.gen "defs.ts.hbs",       "src/scenes/#{$1}/defs.ts"
