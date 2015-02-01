var webpack = require("webpack");
var path = require('path');

module.exports = {
  entry: './bundler.js',

  output: {
    filename: './dist/bundle.js'
  },

  module: {
    loaders: [
      { test: /\.coffee$/, loader: "coffee" },
      { test: /\.css$/   , loader: "style!css?root=." }
    ]
  },

  resolve: {
    root: [path.join(__dirname, "bower_components")],
    extensions: ["", ".coffee", ".ts", ".js"]
  },

  plugins: [
    new webpack.ResolverPlugin(
      new webpack.ResolverPlugin.DirectoryDescriptionFilePlugin("bower.json", ["main"])
    )
  ]
}
