// Config settings for NODE_ENV=test

exports.config = {
  assets: {
    minify: true,
    cdn: {
      protocol: 'http',
      cnames: ['localhost'],
      pathPrefix: ''
    }
  }
  
};
