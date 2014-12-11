module.exports = (grunt) ->

  grunt.loadNpmTasks 'grunt-mocha-test'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.initConfig

    mochaTest:
      test:
        options:
          reporter: 'spec'
          require: 'coffee-script/register'
          clearRequireCache: true
        src:[
          'test/**/*.coffee'
        ]

    coffeelint:
      files: [
          'test/**/*.coffee'
          'lib/**/*.coffee'
        ]

    watch:
      src:
        options: spawn: false
        files: [
          'test/**/*.coffee'
          'lib/**/*.coffee'
        ]
        tasks: ['coffeelint:files', 'mochaTest']

  grunt.registerTask 'test', ['coffeelint:files', 'mochaTest']
  grunt.registerTask 'default', ['watch']
  