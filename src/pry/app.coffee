SyncPrompt = require('./sync_prompt')
Output = require('./output/local_output')
commands = require('./commands')

class App

  _commands: []

  constructor: (@scope) ->
    @hist   = new History()
    @output = new Output()
    @prompt = new SyncPrompt({
      typeahead: @typeahead
    })
    @prompt.on('data', @find_command)

  commands: ->
    if @_commands.length is 0
      @_commands.push new command({@output, @scope, @hist}) for i,command of commands
    @_commands

  typeahead: (input = '') =>
    items = []
    for command in @commands()
      items = items.concat(command.typeahead(input))
    if input
      items = items.filter (item) ->
        item.indexOf(input) is 0
    [items, input]

  find_command: (input, chain) =>
    @hist.push input.trim()
    for command in @commands()
      if match = command.match(input.trim())
        args = String(match[1]).trim().split(' ')
        return command.execute.call command, args, chain
    false

  open: ->
    @prompt.type('whereami')
    @prompt.open()

module.exports = App
