require './support/spec_helper'
Person = require '../src/future/person'

describe 'Person', ->

  it 'creates a person', (done) ->
    future = Person.create { name: 'Indiana Jones' }
    future.resolve (err, person) ->
      return done(err) if err?

      expect(person._id).toBeTruthy()
      expect(person.name).toEqual('Indiana Jones')
      done()

