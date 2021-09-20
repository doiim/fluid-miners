module.exports = {
    chainWebpack: config => config.resolve.symlinks(false),
    runtimeCompiler: true,
    publicPath: process.env.NODE_ENV === 'production'
      ? '/fluid-miners/'
      : '/'
  }
  