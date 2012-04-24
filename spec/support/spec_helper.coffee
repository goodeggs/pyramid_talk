process.env.NODE_ENV ?= 'test'

require './runner' unless jasmine?
require 'fibrous/lib/jasmine_spec_helper'

jasmine.DEFAULT_TIMEOUT_INTERVAL = 3000

