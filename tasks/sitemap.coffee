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
_ = require 'underscore'
_s = require 'underscore.string'
yfm = require 'yaml-front-matter'

module.exports = (grunt) ->

  grunt.registerMultiTask "sitemap", "Generate a sitemap from jade page front matter (recursively).", ->

    done = @async()

    data = _.defaults @data, {src: '**/*.jade'}

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
          cleanedParts = _.initial parts
        else
          cleanedParts = parts

        metadata = _.defaults matter,
          id: _.last cleanedParts
          url: cleanedParts.join '/'
          title: _s.titleize _.last cleanedParts
          templateUrl: "#{data.templateUrlPrefix}#{parts.join('/')}.html"
          controller: data.defaults.controller
          parent: if cleanedParts.length > 1
            cleanedParts[cleanedParts.length - 2]
          order: 0

        # We don't need the jade contents, we're only interested in the front matter.
        delete metadata.__content

        # Return the metadata.
        metadata
      )

      # Sort the levels by `order` attribute (but keep them together for better
      # readability).
      groups = _.groupBy result, 'parent'
      result = _.chain(result)
        .groupBy('parent')
        .map((group) ->
          _.sortBy group, (item) -> item.order)
        .flatten()
        .value()


      # Check for `id` duplicates. Report error if any found.
      ids = _.pluck result, 'id'
      if _.uniq(ids).length isnt ids.length
        grunt.log.error "duplicate ids detected:", ids.sort()
        return done false

      # Preprocess `tpl` file and copy the result to `dest` file.
      grunt.file.copy data.tpl, data.dest, {
        process: ( contents ) ->
          grunt.template.process contents,
            data: sitemap: JSON.stringify(result, null, 2)
      }
      done()
