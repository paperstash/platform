var webpack = require("webpack"),
    path = require("path");

// Our Single-Page Application lives in `spa`. Nothing strange there. However,
// we serve it from an a Elixir-powered web server, which means we have to shove
// it into `apps/paperstash_app/priv/static` to play nice with releases.
var SPA_DIR = path.resolve(__dirname, "spa");
var BUNDLE_DIR = path.resolve(__dirname, "apps/paperstash_app/priv/static");

// CHORE(mtwilliams): Use underscore or dot prefixed variants?
var NODE_DIR = __dirname + '/node_modules';
var BOWER_DIR = __dirname + '/bower_components';

// We'll want to ignore dependencies a lot.
var PACKAGES = /(node_modules|bower_components)/;

// We extract the compiled stylesheets into a seperate bundle. A little cleaner
// that way and it also confers some other minor benefits.
var ExtractTextPlugin = require("extract-text-webpack-plugin");

module.exports = [{
  context: SPA_DIR,
  name: "paperstash",
  entry: "./app.coffee",

  plugins: [
    // TODO(mtwilliams): Respect `NODE_ENV`.
    new webpack.DefinePlugin({
      'process.env': {
        NODE_ENV: '"development"'
      }
    }),

    new webpack.ProvidePlugin({
      $: "jquery",
      jQuery: "jquery",
      "window.jQuery": "jquery"
    }),

    new webpack.ProvidePlugin({
      _: "lodash",
      "window._": "lodash"
    }),

    new ExtractTextPlugin("bundle.css", {
      allChunks: true
    })
  ],

  resolve: {
    root: SPA_DIR,
    modulesDirectories: [SPA_DIR, NODE_DIR, BOWER_DIR],
    alias: {
      // Run of the mill stuff.
      'normalize': NODE_DIR + '/normalize.css/normalize.css',
      'jquery': NODE_DIR + '/jquery/dist/jquery.js',
      'lodash': NODE_DIR + '/lodash/index.js'
    }
  },

  output: {
    // All our assets live under the aptly named `assets` subdirectory.
    path: BUNDLE_DIR + "/assets",
    publicPath: "/assets/",
    filename: "bundle.js"
  },

  module: {
    loaders: [
      // VueJS, baby!
      {test: /\.vue$/, exclude: PACKAGES, loader: "vue-loader"},
      {test: /\.html$/, exclude: PACKAGES, loader: "html-loader"},
      {test: /\.js$/, exclude: PACKAGES, loader: "script-loader"},
      {test: /\.coffee$/, exclude: PACKAGES, loader: "coffee-loader"},
      {test: /\.css$/, exclude: PACKAGES, loader: ExtractTextPlugin.extract("css")},
      {test: /\.scss$/, exclude: PACKAGES, loader: ExtractTextPlugin.extract("css!sass")},

      // TODO(mtwilliams): Inline (smaller) images and fonts.
      {test: /\.(jpe?g|png|gif|svg)/i, loader: "file?name=[path][name].[ext]?[sha1:hash]"},
      {test: /\.(ttf|otf|eot|woff|woff2)/i, loader: "file?name=[path][name].[ext]?[sha1:hash]"},

      // The occasional dependency, like Emoji, includes the odd JSON file.
      {test: /\.json$/, loader: "json-loader"},
    ]
  },

  vue: {
    loaders: {
      // TODO(mtwilliams): Move to Jade.
      html: 'html',
      coffee: 'coffee',
      sass: ExtractTextPlugin.extract("css!sass")
    }
  },

  // OPTIMIZE(mtwilliams): Don't inline sourcemaps?
  devtool: "#inline-source-map"
}];
