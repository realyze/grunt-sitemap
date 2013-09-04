#
# * grunt-sitemap
# * https://github.com/realyze/grunt-sitemap
# *
# * Copyright (c) 2013 Tomas Brambora
# * Licensed under the MIT license.

"use strict"

fs = require 'fs'
glob = require 'glob'
path = require 'path'
CSON = require 'cson'
_ = require 'underscore'
yfm = require 'yaml-front-matter'

module.exports = (grunt) ->

  grunt.registerMultiTask "sitemap", "Generate a sitemap from jade page front matter (recursively).", ->

    done = @async()

    data = @data
    if data.templateUrlPrefix[data.templateUrlPrefix.length-1] isnt '/'
      data.templateUrlPrefix = "#{data.templateUrlPrefix}/"

    glob path.join(@data.root, @data.src), {}, (err, matches) ->
      if err
        return done(false)

      result = _.map(matches, (jadeFile) ->
        matter = yfm.loadFront(jadeFile)

        # Remove the `root` part from the jade file path.
        sitemapPath = jadeFile.substr data.root.length
        if sitemapPath[0] is '/'
          sitemapPath = sitemapPath.substr 1

        # Split the path to parts and remove the file extension.
        parts = sitemapPath.split '/'
        parts[parts.length-1] = path.basename(_.last(parts), '.jade')

        # Account for overview pages (their URLs are special, they don't have
        # the 'overview' part).
        if _.last(parts) == data.overview
          url = _.initial(parts).join '/'
          id = _.initial(parts).join('-')
        else
          url = parts.join '/'
          id = parts.join '-'

        metadata = _.defaults matter,
          id: id
          url: url
          title: _.last(parts)
          templateUrl: "#{data.templateUrlPrefix}#{parts.join('/')}.html"
          controller: data.defaults.controller

        # We don't need the jade contents, we're only interested in the front matter.
        delete metadata.__content

        # Return the metadata.
        metadata
      )

      # Preprocess `tpl` file and copy the result to `dest` file.
      grunt.file.copy data.tpl, data.dest, {
        process: ( contents ) ->
          grunt.template.process contents,
            data: sitemap: CSON.stringifySync result
      }
      done()
