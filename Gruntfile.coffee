#
# * grunt-sitemap
# * https://github.com/realyze/grunt-sitemap
# *
# * Copyright (c) 2013 Tomas Brambora
# * Licensed under the MIT license.
#
"use strict"
module.exports = (grunt) ->

  # Project configuration.
  grunt.initConfig
    jshint:
      all: ["Gruntfile.js", "tasks/*.js", "<%= nodeunit.tests %>"]
      options:
        jshintrc: ".jshintrc"


    # Before generating any new files, remove any previously-created files.
    clean:
      tests: ["tmp"]


    # Configuration to be run (and then tested).
    sitemap:
      all:
        # src: "**/*.jade"
        root: "test/fixtures/content"
        overview: "index"
        dest: "tmp/sitemap.coffee"
        tpl: "test/fixtures/sitemap.coffee.tpl"
        templateUrlPrefix: 'static/src/app/content'
        defaults:
          controller: 'genericController'

    # Unit tests.
    nodeunit:
      tests: ["test/*_test.js"]


  # Actually load this plugin's task(s).
  grunt.loadTasks "tasks"

  # These plugins provide necessary tasks.
  grunt.loadNpmTasks "grunt-contrib-jshint"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-contrib-nodeunit"

  # Whenever the "test" task is run, first clean the "tmp" dir, then run this
  # plugin's task(s), then test the result.
  grunt.registerTask "test", ["clean", "sitemap", "nodeunit"]

  # By default, lint and run all tests.
  grunt.registerTask "default", ["jshint", "test"]
