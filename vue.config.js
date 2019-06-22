const path = require('path')

module.exports = {
  publicPath: process.env.NODE_ENV === 'production'
  ? '/seal/'
  : '/',
  assetsDir: 'static/',
  outputDir: path.resolve(__dirname, 'dist'),
  runtimeCompiler: true,
  productionSourceMap: false,
  pages: {
    app: {
      entry: 'src/main.js',
      template: 'public/index.html',
      filename: 'index.html'
    }
  },
  css: {
    loaderOptions: {
      sass: {
        // @/ is an alias to src/
        // so this assumes you have a file named `src/variables.scss`
        data: `@import "@/assets/styles/variables.scss";`,
      },
    },
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
