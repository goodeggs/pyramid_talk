{ Db, Server } = require('mongodb')

db = new Db('pyramid_of_doom', new Server("127.0.0.1", 27017, {}))

module.exports =
  create:  (data, callback) ->
    db.open (err, client) ->
      return callback(err) if err?

      client.collection "people", (err, collection) ->
        return callback(err) if err?

        collection.insert data, safe:true, (err, result) ->
          return callback(err) if err?

          callback(null, result[0])
          client.close()

