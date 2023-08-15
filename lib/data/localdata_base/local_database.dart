import 'package:my_locatiion/data/model/my_location.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDataBase {
  static final LocalDataBase getInstance = LocalDataBase._();
  LocalDataBase._();
  factory LocalDataBase() {
    return getInstance;
  }
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB("user_addresses.db");
      return _database!;
    }
  }

  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const addressTEXT = "TEXT";
    const createdTEXT = "TEXT";
    const longitudeREAL = "REAL";
    const latitudeREAL = "REAL";
    await db.execute("""
CREATE TABLE ${UserlLocationFilds.locationTable}(
${UserlLocationFilds.Id} $idType,
${UserlLocationFilds.lat} $latitudeREAL,
${UserlLocationFilds.long} $longitudeREAL,
${UserlLocationFilds.address} $addressTEXT,
${UserlLocationFilds.created} $createdTEXT
)
""");
  }

  ///---------------------------data base-----------------------------------
  static Future<UserLocation> inserLocation(UserLocation userLocation) async {
    final db = await getInstance.database;
    final int userId = await db.insert(
        UserlLocationFilds.locationTable, userLocation.toJson());
    return userLocation.copyWith(Id: userId);
  }

  static Future<List<UserLocation>> getLocation() async {
    List<UserLocation> allLocation = [];
    final db = await getInstance.database;
    allLocation = (await db.query(UserlLocationFilds.locationTable))
        .map((e) => UserLocation.fromjson(e))
        .toList();
    return allLocation;
  }

  static deleteLocation(int id) async {
    final db = await getInstance.database;
    db.delete(UserlLocationFilds.locationTable,
        where: "id=?", whereArgs: [id]);
  }

  static deleteAllLocation() async {
    final db = await getInstance.database;
    db.delete(
      UserlLocationFilds.locationTable,
       where: "${UserlLocationFilds.Id}",
    );
  }
  static updateAddresses(UserLocation userAddress) async {
    final db = await getInstance.database;
    db.update(UserlLocationFilds.locationTable, userAddress.toJson());
  }
}
