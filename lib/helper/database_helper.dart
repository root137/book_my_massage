import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/booking_model.dart';
import '../model/massage_centres_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._getInstance();
  static const int _version = 2;
  static const String _bookingTable = 'bookings';
  static const String _massageTable = 'massage';
  static const String _columnId = 'id';
  static const String _columnDate = 'date';
  static const String _columnTime = 'time';
  static const String massageCenterId = 'id';
  static const String imageUrl = 'imageUrl';
  static const String address = 'address';
  static const String title = 'title';
  static const String phoneNumber = 'phoneNumber';
  static const String bookingCount = 'bookingCount';
  static Database? _database;

  DatabaseHelper._getInstance();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  //initializing the database
  Future<Database> _initDatabase() async {
    // final databasesPath = await getDatabasesPath();
    // if (databasesPath == null) {
    //   throw Exception('Failed to get databases path.');
    // }
    final String path = join(await getDatabasesPath(), 'bookings.db');
    return openDatabase(
      path,
      version: _version,
      onCreate: _onCreate,
    );
  }

  // to create a table
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $_bookingTable (
      $_columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $_columnDate TEXT,
      $_columnTime TEXT
    )
  ''');
    await db.execute('''
    CREATE TABLE $_massageTable (
      $massageCenterId INTEGER PRIMARY KEY,
      $imageUrl TEXT,
      $title TEXT,
      $address TEXT,
      $phoneNumber TEXT,
      $bookingCount INTEGER
    )
  ''');
  }

  //inserting the data
  Future<int> insertBooking(BookingModel booking) async {
    final Database db = await instance.database;
    return await db.insert(_bookingTable, booking.toMap());
  }

  Future<List<BookingModel>> getAllBookings() async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(_bookingTable);
    return List.generate(maps.length, (i) {
      return BookingModel.fromMap(maps[i]);
    });
  }

  Future<List<MassageCentre>> getAllMassages() async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(_massageTable);
    return List.generate(maps.length, (i) {
      return MassageCentre.fromMap(maps[i]);
    });
  }

  // Future<void> saveMassages(List<MassageCentre> massageCentres) async {
  //   final db = await database;
  //   for (var massage in massageCentres) {
  //     await db.insert(_massageTable, massage.toMap());
  //   }
  // }
  Future<void> saveMassages(List<MassageCentre> massageCentres) async {
    final db = await database;
    for (var massage in massageCentres) {
      await db.insert(
        _massageTable,
        massage.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<int?> totalBookings() async {
    final Database db = await instance.database;
    final int? count = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM $_bookingTable'),
    );
    return count;
  }
}
