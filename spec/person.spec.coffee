require './support/spec_helper'
Person = require '../src/pyramid/person.js'
# launchctl stop org.mongodb.mongod
# Person = require '../src/pyramid/person_handle_errors'
# launchctl start org.mongodb.mongod
# Person = require '../src/named_functions/person'
# Person = require '../src/pyramid/person.coffee'
# Person = require '../src/async/person'

describe 'Person', ->

  it 'creates a person', (done) ->
    Person.create { name: 'Indiana Jones' }, (err, person) ->
      return done(err) if err?

      expect(person._id).toBeTruthy()
      expect(person.name).toEqual('Indiana Jones')
      done()

