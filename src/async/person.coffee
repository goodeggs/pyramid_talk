async = require('async')
{ Db, Server } = require('mongodb')

module.exports = Person =
  create:  (data, callback) ->
    db = new Db('pyramid_of_doom', 
                new Server("127.0.0.1", 27017, {}))
    async.waterfall [
      (next) ->
        db.open next
      (client, next) ->
        client.collection "people", next
      (collection, next) ->
        collection.insert data, safe:true, next
      (result, next) ->
        next(null, result[0])
        db.close()
    ], callback

