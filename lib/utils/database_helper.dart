import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sugarcanaphids01/models/treatment_record.dart';


class DatabaseHelper {

  static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database

  String treatmentRecordTable = 'treatment_Record_table';
  String colId = 'id';
  String colTitle = 'title';
  String colResult = 'result';
  String colStops = 'stops';
  String colDate = 'date';

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {

    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'treatment_record.db';

    // Open/create the database at a given path
    var treatmentRecordDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return treatmentRecordDatabase;
  }

  void _createDb(Database db, int newVersion) async {

    await db.execute('CREATE TABLE $treatmentRecordTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
        '$colResult TEXT, $colStops INTEGER, $colDate TEXT)');
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getTreatmentRecordMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(treatmentRecordTable);
    return result;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertTreatmentRecord(Treatment_Record treatmentRecord) async {
    Database db = await this.database;
    var result = await db.insert(treatmentRecordTable, treatmentRecord.toMap());
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateTreatmentRecord(Treatment_Record treatmentRecord) async {
    var db = await this.database;
    var result = await db.update(treatmentRecordTable, treatmentRecord.toMap(), where: '$colId = ?', whereArgs: [treatmentRecord.id]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteTreatmentRecord(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $treatmentRecordTable WHERE $colId = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $treatmentRecordTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<Treatment_Record>> getTreatmentRecordList() async {

    var treatmentRecordMapList = await getTreatmentRecordMapList(); // Get 'Map List' from database
    int count = treatmentRecordMapList.length;         // Count the number of map entries in db table

    List<Treatment_Record> treatmentRecordList = List<Treatment_Record>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      treatmentRecordList.add(Treatment_Record.fromMapObject(treatmentRecordMapList[i]));
    }

    return treatmentRecordList;
  }

}