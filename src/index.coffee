highland = require "highland"

module.exports =
  class HighlandPagination

    constructor: (@fetcher) ->
      @nextToken = undefined

    stream: ->
      highland (push, next) =>
        @fetcher @nextToken
        .then ({ items, @nextToken }) =>
          push null, item for item in items
          if @nextToken? then next() else push(null, highland.nil)
          return
        .catch (error) -> push error
        
        return
