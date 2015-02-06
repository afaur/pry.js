expect = require('chai').expect
History = require('../src/pry/history')

describe 'History', ->

  subject = null

  beforeEach (complete) ->
    subject = new History()
    complete()

  describe 'Stores a history item with false inital status', ->

    it 'stores a history line', ->
      expect(subject.push('help', false)).to.equal 'The\nquick'

