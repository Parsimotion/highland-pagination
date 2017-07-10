_ = require "lodash"
require "should"

HighlandPagination = require "./index"

PAGE_SIZE = 10

_test = (n) -> ->
  new HighlandPagination _generator _createPages n
    .stream()
    .collect()
    .toPromise(Promise)
    .then (elements) -> elements.length.should.be.eql n

_createPages = (n) ->
  return [[]] if n is 0
  _.chunk _.range(n), PAGE_SIZE

_generator = (pages) -> (page = 0) ->
  nextToken = page + 1 if pages[page + 1]
  Promise.resolve { items: pages[page], nextToken }

describe "Highland-Pagination", ->

  it "returns an empty stream", _test(0)
  it "returns a new stream with the elements of a single page", _test(PAGE_SIZE)
  it "returns a new stream with the elements of multiple pages", _test(PAGE_SIZE + 5)

  it "fail when promise is rejected", ->
    __errorStream = () -> Promise.reject new Error "An error has ocurred"

    new HighlandPagination __errorStream
    .stream()
    .toPromise(Promise)
    .should.be.rejected()
