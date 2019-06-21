const path = require('path')

module.exports = {
  assetsDir: 'static/',
  outputDir: path.resolve(__dirname, '../dist'),
  runtimeCompiler: true,
  productionSourceMap: false,
  pages: {
    app: {
      entry: 'src/main.js',
      template: 'public/index.html',
      filename: 'index.html'
    }
  },
  devServer: {
    port: 8080,
    historyApiFallback: {
      rewrites: [
        {
          from: /.*/,
          to: '/index.html'
        }]
    }
  }
}
