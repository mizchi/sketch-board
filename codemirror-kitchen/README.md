# CodeMirror Kitchen

## What's this?

Kitchen to build your own codemirror editor.

## Use

Fork and setup for your use case.

Build

```
$ npm install -g webpack
$ npm install
$ webpack
```

Take it.

```
<script src='/dist/bundle.js'></script>
<script>
window.onload = function(){
  window.createMyEditor(document.body, {});
}
</script>
```

See bundler.js and demo/index.html

## Load by webpack

Need this setting.

```
  module: {
    loaders: [
      { test: /\.coffee$/, loader: "coffee" },
      { test: /\.css$/   , loader: "style!css?root=." }
    ]
  },
```

I recommend bundled file via script.
