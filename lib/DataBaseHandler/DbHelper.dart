import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';


class DbHelper {
  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  /********** Tab Admin ******/
  static final tableAdmin = 'admin';

  static final Id = 'admin_id';
  static final Name = 'admin_name';
  static final Email = 'email';
  static final Password = 'password';

  /********** Tab Category ******/

  static final tableCategory = 'category';
  static final CategoryId = 'category_id';
  static final CategoryName = 'category_name';

  /********** Tab Componet ******/
  static final tableComponent = 'component';
  static final ComponentId = 'component_id';
  static final ComponentName = 'component_name';
  static final quantity = 'qte';
  static final cate = 'component_category';

  /********** Tab Member ******/
  static final tableMember = 'member';
  static final MemberId = 'member_id';
  static final MemberName = 'member_name';
  static final MemberLastName = 'member_lname';
  static final MemberPassword = 'mdp';



  DbHelper._privateConstructor();

  static final DbHelper instance = DbHelper._privateConstructor();


  Database? _database = null;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }


  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate,
        onConfigure: _onConfigure);
  }
  Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  /********** Tabs Creation ******/
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableAdmin (
            $Id TEXT PRIMARY KEY,
            $Name TEXT NOT NULL,
            $Email TEXT NOT NULL,
            $Password TEXT NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE $tableCategory (
            $CategoryId TEXT PRIMARY KEY,
            $CategoryName TEXT NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE $tableComponent (
            $ComponentId TEXT PRIMARY KEY,
            $ComponentName TEXT NOT NULL,
            $quantity INTEGER NOT NULL,
            $cate TEXT NOT NULL,
            FOREIGN KEY ($cate) REFERENCES $tableCategory ($CategoryId) ON DELETE NO ACTION ON UPDATE NO ACTION
          )
          ''');




    await db.execute('''
          CREATE TABLE $tableMember (
            $MemberId TEXT PRIMARY KEY,
            $MemberName TEXT NOT NULL,
            $MemberLastName TEXT NOT NULL,
            $MemberPassword TEXT NOT NULL
          )
          ''');
  }


  /********** Admin methods  ******/

  Future<int> insertAdmin(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableAdmin, row);
  }

  Future<List<Map<String, dynamic>>> queryAdmin() async {
    Database db = await instance.database;
    return await db.query(tableAdmin);
  }

  Future<List<Map<String, dynamic>>?>  getAdmin(Map<String, dynamic> row) async {
    Database db = await instance.database;
    String id = row[Id];
    String pwd=row[Password];

    var res = await db.rawQuery("SELECT $Name  FROM $tableAdmin WHERE "
        "$Id ='$id' AND "
        "$Password ='$pwd' ");
    if (res.length>0){
      return res;
    }
    else
      return null;

  }

  /********** Category  methods  ******/

  Future<int> insertCategory(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableCategory, row);
  }



  Future<List<Map<String, dynamic>>> getAllCat() async {
    Database db = await instance.database;
    var res= await db.rawQuery("SELECT $CategoryName FROM $tableCategory");

    return res;

  }

  Future<List<Map<String, dynamic>>?> getIdCategory(String cat) async {
    Database db = await instance.database;
    var res= await db.rawQuery("SELECT $CategoryId FROM $tableCategory WHERE "
        "$CategoryName='$cat'");
    if (res.length>0){
      return res;
    }
    else
      return null;
  }

  /********** Component  methods  ******/

  Future<int> insertComponent(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableComponent, row);
  }

  Future<List<Map<String, dynamic>>> getAllCom() async {
    Database db = await instance.database;
    var res= await db.rawQuery("SELECT $ComponentId , $ComponentName ,$quantity , $CategoryName "
        "FROM $tableComponent INNER JOIN $tableCategory ON $cate = $CategoryId");

    return res;

  }

  Future<List<Map<String, dynamic>>?> getIdComponent(String com) async {
    Database db = await instance.database;
    var res= await db.query(tableComponent,where: 'component_id=?',whereArgs:[com]);
    if (res.length>0){
      return res;
    }
    else
      return null;
  }


  Future<int> deleteComponent(String id) async {
    Database db = await instance.database;
    return await db.delete(tableComponent, where: '$ComponentId = ?', whereArgs: [id]);
  }


  Future<int> updateComponent(Map<String, dynamic> row) async {
    Database db = await instance.database;
    String id = row[ComponentId];
    return await db.update(tableComponent, row, where: '$ComponentId = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>?> searchComponents(String word) async {
    Database db = await instance.database;
    var res= await db.query(tableComponent,where: 'component_name LIKE ?',whereArgs:['%$word%']);
    if (res.length>0){
      return res;
    }
    else
      return null;
  }
}

