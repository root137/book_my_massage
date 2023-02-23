import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/booking_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._getInstance();
  static final int _version = 1;
  static final String _bookingTable = 'bookings';
  static final String _columnId = 'id';
  static final String _columnDate = 'date';
  static final String _columnTime = 'time';
  static Database? _database;

  DatabaseHelper._getInstance();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  //initializing the database
  Future<Database> _initDatabase() async {
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

  Future<int?> totalBookings() async {
    final Database db = await instance.database;
    final int? count = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM $_bookingTable'),
    );
    return count;
  }
}
