var mongodb = require('mongodb');
var Db = mongodb.Db,
    Server = mongodb.Server;

module.exports = {
  create: function (data, callback) {
    var db = new Db('pyramid_of_doom', 
                    new Server("127.0.0.1", 27017, {}));
    db.open(getCollection);

    function getCollection (err, client) {
      if (err) return callback(err);
      client.collection("people", insertPerson);
    }

    function insertPerson (err, collection) {
      if (err) return callback(err);
      collection.insert(data, {safe:true}, handleResult);
    }

    function handleResult (err, result) {
      if (err) return callback(err);
      callback(null, result[0]);
      db.close();
    }
  }
};

