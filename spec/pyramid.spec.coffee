require './support/spec_helper'
pyramid = require '../src/pyramid'

describe 'pyramid', ->

  it 'adds a person', (done) ->
    pyramid.insertPerson { name: 'Indiana Jones' }, (err, person) ->
      return done(err) if err?

      expect(person.name).toEqual('Indiana Jones')
      done()

  it 'adds a person with error handling', (done) ->
    pyramid.insertPersonWithErrorHandling { name: 'Indiana Jones' }, (err, person) ->
      return done(err) if err?

      expect(person.name).toEqual('Indiana Jones')
      done()
