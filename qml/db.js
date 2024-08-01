.import QtQuick.LocalStorage 2.0 as DB

var state_b = false
var adr = 0
var stantion = [{
                    "name": 'RockFM',
                    "ip": 'http://nashe1.hostingradio.ru/rock-128.mp3'
                }, {
                    "name": 'Relax FM. Jazz',
                    "ip": 'https://pub0202.101.ru:8443/stream/trust/mp3/128/264'
                }, {
                    "name": 'Relax FM. Instrumental',
                    "ip": 'https://pub0202.101.ru:8443/stream/pro/aac/64/28'
                }, {
                    "name": 'North Korean',
                    "ip": 'https://listen7.myradio24.com/69366'
                }]



function connectDB() {
  // connect to the local database
  return DB.LocalStorage.openDatabaseSync(
    "radio",
    "1.0",
    "Radio Database",
    100000
  );
}


function initializeDB() {
    var db = connectDB();
        db.transaction(function (tx) {
        tx.executeSql("CREATE TABLE IF NOT EXISTS radio(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, ip TEXT)");

        var list = tx.executeSql("SELECT * FROM radio");
          if (list.rows.length === 0) {
            initPlaylist();
          }
    })
}


function initPlaylist() {
  var db = connectDB()
  db.transaction(function (tx) {
      for (var i = 0; i < stantion.length; i++) {
          tx.executeSql('INSERT INTO radio (name, ip) values(?, ?)',
                        [stantion[i].name, stantion[i].ip])
      }
   })
}

function readPlaylist() {
    var db = connectDB();
      db.transaction(function (tx) {
        var result = tx.executeSql(
          'SELECT * FROM radio ORDER BY id ASC'
        );
        for (var i = 0; i < result.rows.length; i++) {
            playlist.append({
                    "id": result.rows.item(i).id,
                    "name": result.rows.item(i).name,
                    "ip": result.rows.item(i).ip
                })
           }
      });
}

//Добавить новое значение в БД
function insert(name, ip) {
    var db = connectDB();

    db.transaction(function (tx) {
        tx.executeSql('INSERT INTO radio (name, ip) values(?, ?)', [name, ip])
    })
}

function update(id, name, ip) {
          console.log(id, name, ip);
    var db = connectDB();
      db.transaction(function (tx) {
            tx.executeSql(
                "UPDATE radio SET name=? , ip = ? where id = ?;",
                  [id, name, ip]
                        );

    })
}

function del(id) {
    var db = connectDB();
    db.transaction(function (tx) {
        // Удалить по имени:
        tx.executeSql('DELETE FROM radio WHERE id = ?', [id])
    })
}



function play(ip) {
    mediaPlayer.source = ip
    mediaPlayer.play()
}
