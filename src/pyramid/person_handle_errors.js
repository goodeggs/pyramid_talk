var mongodb = require('mongodb');
var Db = mongodb.Db,
    Server = mongodb.Server;

var db = new Db('pyramid_of_doom', new Server("127.0.0.1", 27017, {}));

module.exports = {

  create: function(data, callback) {
    db.open(function(err, client) {
      if (err != null) return callback(err);

      client.collection("people", function(err, collection) {
        if (err != null) return callback(err);

        collection.insert(data, {safe: true}, function(err, result) {
          if (err != null) return callback(err);

          callback(null, result[0]);
          client.close();
        });
      });
    });
  }

};

