{ Db, Server } = require('mongodb')

db = new Db('pyramid_of_doom', new Server("127.0.0.1", 27017, {}))

module.exports =
  insertPerson: (data, callback) ->
    db.open (err, client) ->
      client.collection "people", (err, people) ->
        people.insert data, safe:true, (err, result) ->
          callback(null, result[0])
          client.close()

  insertPersonWithErrorHandling:  (data, callback) ->
    db.open (err, client) ->
      return callback(err) if err?
      client.collection "people", (err, people) ->
        return callback(err) if err?
        people.insert data, safe:true, (err, result) ->
          return callback(err) if err?
          callback(null, result[0])
          client.close()

