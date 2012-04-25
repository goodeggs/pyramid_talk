{ Db, Server } = require('mongodb')
fibrous = require 'fibrous'

module.exports = Person =
  create:  fibrous (data) ->
    server = new Server("127.0.0.1", 27017, {})
    db = new Db('pyramid_of_doom', server)
    client = fibrous.wait(db.future.open())
    # OR client = db.sync.open()
    collection = client.sync.collection "people"
    result = collection.sync.insert data, safe:true
    client.future.close()
    return result[0]

