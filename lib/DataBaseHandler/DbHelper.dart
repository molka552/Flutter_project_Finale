import 'package:fluterfinale/Model/ComposantModel.dart';
import 'package:fluterfinale/Model/FamilleCom.dart';
import 'package:fluterfinale/Model/UserModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
class DbHelper{
  static final DbHelper _instance = DbHelper.internal();
  factory DbHelper() => _instance;
  DbHelper.internal();
  static Database ?_db;

  Future<Database?> createDatabase() async{
    if(_db != null){
      return _db;
    }
    //define the path to the database
    String path = join(await getDatabasesPath(), 'Gstock.db');
    _db = await openDatabase(path,version: 1,onCreate: (Database db, int v){
      //create all tables
      db.execute("create table user(user_id Text primary key ,user_name Text, email Text, password Text)");
      db.execute("create table famille(id integer primary key autoincrement, nom varchar(50))");
      db.execute("create table composants(id integer primary key autoincrement, nomC varchar(50),nomF varchar(50), qt intege)");
    });
    return _db;
  }
  Future<int> saveData(UserModel user) async {
    Database? db = await createDatabase();
    return db!.insert('user', user.toMap());
  }
  Future<int> saveDataF(FamilleCom fc) async {
    Database? db = await createDatabase();
    return db!.insert('famille', fc.toMap());
  }
  Future<int> saveDataC(CompModel c) async {
    Database? db = await createDatabase();
    return db!.insert('composants',c.toMap());
  }

  Future<UserModel?> getLoginUser(String userId, String password) async {
    var dbClient = await _db;
    var res = await dbClient!.rawQuery("SELECT * FROM user WHERE "
        "user_id = '$userId' AND "
        "password = '$password'");

    if (res.length > 0) {
      return UserModel.fromMap(res.first);
    }
    return null;
  }
  Future<List<Map<String,dynamic>>> allFamille() async{
    Database? db = await createDatabase();
    return await db!.rawQuery("select * from famille");
    //return db!.query('famille');
  }

  Future<List> alluser() async{
    Database? db = await createDatabase();
    //db.rawQuery("select * from courses")
    return db!.query('user');
  }
}
