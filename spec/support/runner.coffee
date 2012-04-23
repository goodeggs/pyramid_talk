dir = 'jasmine-node/lib/jasmine-node/'
filename =  'jasmine-2.0.0.rc1'

for key, value of require("#{dir}#{filename}")
  global[key] = value

TerminalReporter = require("#{dir}reporter").jasmineNode.TerminalReporter
jasmine.getEnv().addReporter(new TerminalReporter(
  color: true
  onComplete: (runner) ->
      if (runner.results().failedCount > 0)
        process.once 'exit', ->
          process.exit(1)
))

process.nextTick ->
  jasmine.getEnv().execute()
