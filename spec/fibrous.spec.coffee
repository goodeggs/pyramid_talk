require './support/spec_helper'
fibrous = require 'fibrous'
Person = require '../src/fibrous/person'

describe 'Person', ->

  it 'creates a person', (done) ->
    Person.create { name: 'Indiana Jones' }, (err, person) ->
      return done(err) if err?

      expect(person._id).toBeTruthy()
      expect(person.name).toEqual('Indiana Jones')
      done()

  it 'creates a person with sync', ->
    person = Person.sync.create { name: 'Indiana Jones' }
    expect(person._id).toBeTruthy()
    expect(person.name).toEqual('Indiana Jones')

  it 'creates two in parallel', ->
    people = fibrous.wait [
      Person.future.create { name: 'Indiana Jones' }
      Person.future.create { name: 'Willie Scott' }
    ]
    expect(people.length).toEqual(2)
    expect(people[0].name).toEqual('Indiana Jones')

