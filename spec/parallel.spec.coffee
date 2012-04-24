require './support/spec_helper'
async = require 'async'
Person = require '../src/async/person'

describe 'async', ->

  it 'creates two people', (done) ->
    async.parallel [
      (cb) ->
        Person.create { name: 'Indiana Jones' }, cb
      (cb) ->
        Person.create { name: 'Willie Scott' }, cb
    ], (err, results) ->
      return done(err) if err?
      expect(results.length).toEqual(2)
      done()

