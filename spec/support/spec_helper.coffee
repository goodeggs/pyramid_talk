process.env.NODE_ENV ?= 'test'

require './runner' unless jasmine?
require 'fibrous/lib/jasmine_spec_helper'
Future = require 'fibrous/node_modules/fibers/future'

jasmine.Spy::andCallback = (err, result) ->
  @andCallFake (args...) ->
    cb = args.pop()
    process.nextTick ->
      cb(err, result)

# Keep track of all logged futures so that we can wait for them, before finishing a test and resetting the context
pendingLoggedFutures = []

originalAndLogResults = Future::andLogResults
Future::andLogResults = (args...) ->
  pendingLoggedFutures.push(@)
  originalAndLogResults.apply(@, args)

GLOBAL.waitForLoggedFutures = ->
  while future = pendingLoggedFutures.shift()
    try
      fibrous.wait(future)
    catch err
      err.message ?= ''
      err.message += " [failed the spec due to an error in Future#andLogResults]"
      jasmine.getEnv().currentSpec.fail(err)

jasmine.DEFAULT_TIMEOUT_INTERVAL = 3000

# server.coffee handles this differently; in the test suite, fail the current spec
process.on 'uncaughtException', (err) ->
  if jasmine.getEnv().currentSpec?
    err.message ?= ''
    err.message += " [failed the spec due to uncaughtException]"
    jasmine.getEnv().currentSpec.fail(err)
  else
    console.error 'uncaughtException', err?.stack or err

beforeEach ->
  # If the test is timed out, we need to ensure the pending futures are reset (to avoid timing out subsequent tests)
  pendingLoggedFutures = []

afterEach ->
  waitForLoggedFutures()

