# highland-pagination

[![NPM version](https://badge.fury.io/js/highland-pagination.png)](http://badge.fury.io/js/highland-pagination)

[Installation instructions](https://github.com/Parsimotion/highland-pagination/wiki/Installation-Instructions)

```CoffeeScript
HighlandPagination = require "highland-pagination"

action = (page = null) -> 
  getPage(page).then (items) -> 
    { items, nextToken } 
 
aHighlandStream = new HighlandPagination(action).stream()

```
