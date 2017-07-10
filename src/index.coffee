highland = require "highland"

module.exports =
  class HighlandPagination

    constructor: (@fetcher) ->

    stream: ->
      __doSomething = (continuation) =>
        highland (push, next) =>
          @fetcher continuation
          .then ({ items, nextToken }) =>
            push null, item for item in items
            if nextToken?
              next __doSomething nextToken
            else
              push null, highland.nil
            
            null
          .catch (error) => push error

      __doSomething()
