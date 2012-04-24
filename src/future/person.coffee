{ Db, Server } = require('mongodb')

db = new Db('pyramid_of_doom', new Server("127.0.0.1", 27017, {}))

class Future
  resolve: (callback) ->
    @callback = callback

  return: (value) ->
    @callback(null, value)

  error: (err) ->
    @callback(err)


module.exports =
  create: (data) ->
    future = new Future()

    db.open (err, client) ->
      return future.error(err) if err?

      client.collection "people", (err, collection) ->
        return future.error(err) if err?

        collection.insert data, safe:true, (err, result) ->
          return future.error(err) if err?

          future.return(result[0])
          client.close()

    return future

