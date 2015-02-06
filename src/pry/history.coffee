class History

  constructor: () ->
    @hist = []

  push: (line)->
    @hist.push [line, false]

module.exports = History

