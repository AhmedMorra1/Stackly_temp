import 'dart:async';
import 'dart:io' as io;
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stackly/models/supplement.dart';
import 'package:stackly/models/serving_time.dart';
import 'package:stackly/models/day.dart';
import 'package:stackly/models/day_details.dart';
import 'package:stackly/services/notifications_helper.dart';

class DBHelper {
  DBHelper._init();
  static final DBHelper instance = DBHelper._init();
  //Database
  static Database? _db;
  static const String db_name = 'supplements.db';
  //Supplements Table
  static const String supplements_table = 'supplements_table';
  static const String id = 'id';
  static const String name = 'name';
  static const String total_count = 'total_count';
  static const String current_count = 'current_count';
  static const String serving_type = 'serving_type';
  static const String serving_size = 'serving_size';
  static const String instructions = 'instructions';
  //static const String refill_alert_count = 'refill_alert_count';
  static const String last_day = 'last_day';
  // Serving Times table
  static const String serving_times_table = 'serving_times_table';
  static const String supplement_id = 'supplement_id';
  static const String serving_time = 'serving_time';
  // days table
  static const String days_table = 'days_table';
  static const String day = 'day';
  // days details table
  static const String days_details_table = 'days_details_table';
  static const String day_id = 'day_id';
  static const String serving_time_id = 'serving_time_id';
  static const String taken = 'taken';

  NotificationsHelper notificationsHelper = NotificationsHelper.instance;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    //get application documents directory
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //get the path of the database
    String path = join(documentsDirectory.path, db_name);
    //open the database
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    //return the database
    return db;
  }

  deleteDb() async {
    //Close the Database
    _db!.close();
    //get application documents directory
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //get the path of the database
    String path = join(documentsDirectory.path, db_name);
    //delete the database
    databaseFactory.deleteDatabase(path);
    //refresh the database
    _db = null;
  }

  //what to do while creating the database
  _onCreate(Database db, int version) async {
    // create supplements table
    await db.execute('''CREATE TABLE $supplements_table 
     ($id INTEGER PRIMARY KEY AUTOINCREMENT,
     $name TEXT NOT NULL,
     $total_count INTEGER NOT NULL,
     $current_count INTEGER NOT NULL,
     $serving_type TEXT NOT NULL,
     $serving_size INTEGER NOT NULL,
     $instructions TEXT NOT NULL,
     $last_day TEXT
    )''');
    // create serving times table
    await db.execute('''CREATE TABLE $serving_times_table 
     ($id INTEGER PRIMARY KEY AUTOINCREMENT,
     $supplement_id INTEGER NOT NULL,
     $serving_time TEXT NOT NULL,
     FOREIGN KEY($supplement_id) REFERENCES $supplements_table($id)
    )''');
    // create days table
    await db.execute('''CREATE TABLE $days_table 
     ($id INTEGER PRIMARY KEY AUTOINCREMENT,
     $day TEXT NOT NULL
    )''');
    // create days details table
    await db.execute('''CREATE TABLE  $days_details_table 
     ($id INTEGER PRIMARY KEY AUTOINCREMENT,
     $day_id INTEGER NOT NULL,
     $supplement_id INTEGER NOT NULL,
     $serving_time_id INTEGER NOT NULL,
     $taken TEXT NOT NULL,
     FOREIGN KEY($day_id) REFERENCES $days_table($id),
     FOREIGN KEY($supplement_id) REFERENCES $supplements_table($id),
     FOREIGN KEY($serving_time_id) REFERENCES $serving_times_table($id)
    )''');
  }

  /// Create
  // add a supplement
  Future<Supplement> insertSupplement(Supplement supplement, Database db) async {
    supplement.id = await db.insert(supplements_table, supplement.toMapDb());
    return supplement;
  }

  // add a serving time
  Future<ServingTime> insertServingTime(ServingTime servingTime, Database db) async {
    servingTime.id = await db.insert(serving_times_table, servingTime.toMap());
    Supplement? supplement = await instance.getSupplement(servingTime.supplement_id!);
    String? name = supplement!.name;
    String? servingType = supplement.servingType;
    int? servingSize = supplement.servingSize;
    String? instructions = supplement.instructions;
    String message = 'Time to take ${servingSize.toString()} $servingType of $name $instructions.';
    NotificationsHelper.showDailyScheduledNotifications(
      servingTime: DateFormat.jm().parse(servingTime.serving_time!),
      id: servingTime.id,
      title: name,
      body: message,
      payload: name,
    );
    return servingTime;
  }

  // add a day
  Future<Day> insertDay(Day day, Database db) async {
    day.id = await db.insert(days_table, day.toMap());
    return day;
  }

  // add day detail
  Future<DayDetails> insertDayDetail(DayDetails dayDetails) async {
    Database? database = await instance.db;
    dayDetails.id = await database!.insert(days_details_table, dayDetails.toMap());
    return dayDetails;
  }

  /// Read
  // Read all Supplements Table
  Future<List<Supplement>?> getSupplements() async {
    Database? database = await instance.db;
    List<Map> maps = await database!.query(
      supplements_table,
    );
    List<Supplement> supplements = maps.map((e) => Supplement.fromMap(e)).toList();
    for (int i = 0; i < supplements.length; i++) {
      var servingTimesList = await getServingTimes(supplements[i].id!);
      supplements[i].servingTimes = servingTimesList!.map((e) => e.serving_time).cast<String>().toList();
    }
    return supplements;
  }

  // Read one Supplement data
  Future<Supplement>? getSupplement(int theSupplementId) async {
    Database? database = await instance.db;
    List<Map> maps = await database!.query(supplements_table, where: '$id = ?', whereArgs: [theSupplementId]);
    Supplement theSupplement = Supplement.fromMap(maps[0]);
    return theSupplement;
  }

  // Read one Serving Time
  Future<ServingTime?> getServingTime(int servingTimeId) async {
    Database? database = await instance.db;
    List<Map> maps = await database!.query(serving_times_table, where: '$id = ?', whereArgs: [servingTimeId]);
    List<ServingTime> servingTimes = maps.map((e) => ServingTime.fromMap(e)).toList();
    return servingTimes[0];
  }

  // Read Serving Times for a supplement
  Future<List<ServingTime>?> getServingTimes(int supplementId) async {
    Database? database = await instance.db;
    List<Map> maps = await database!.query(serving_times_table, where: '$supplement_id = ?', whereArgs: [supplementId]);
    List<ServingTime> servingTimes = maps.map((e) => ServingTime.fromMap(e)).toList();
    return servingTimes;
  }

  // Read Serving Times for a supplement
  Future<List<ServingTime>?> getAllServingTimes(Database db) async {
    List<Map> maps = await db.query(serving_times_table);
    List<ServingTime> servingTimes = maps.map((e) => ServingTime.fromMap(e)).toList();
    return servingTimes;
  }

  // Read Day
  Future<Day?> getDay(String dayDate) async {
    Database? database = await instance.db;
    List<Map> maps = await database!.query(days_table, where: '$day = ?', whereArgs: [dayDate]);
    List<Day> days = maps.map((e) => Day.fromMap(e)).toList();
    return maps.isEmpty ? null : days[0];
  }

  // Read Day Details
  Future<List<DayDetails>?> getDayDetails(Database db, int dayId) async {
    List<Map> maps = await db.query(days_details_table, where: '$day_id = ?', whereArgs: [dayId]);
    List<DayDetails> dayDetails = maps.map((e) => DayDetails.fromMap(e)).toList();
    return dayDetails;
  }

  /// Update
  // Update a supplement
  Future<void> updateSupplement(Supplement supplement) async {
    Database? database = await instance.db;
    await database!.update(supplements_table, supplement.toMapDb(), where: '$id = ?', whereArgs: [supplement.id]);
  }

  // Update a supplement
  Future<void> updateCurrentCount(Supplement supplement) async {
    Database? database = await instance.db;
    await database!.update(supplements_table, supplement.toMapDb(), where: '$id = ?', whereArgs: [supplement.id]);
  }

  // Update a serving time
  Future<int> updateServingTime(Database db, ServingTime servingTime) async {
    return await db.update(serving_times_table, servingTime.toMap(), where: '$id = ?', whereArgs: [servingTime.id]);
  }

  // Update a day
  Future<int> updateDay(Database db, Day day) async {
    return await db.update(days_table, day.toMap(), where: '$id = ?', whereArgs: [day.id]);
  }

  // Update a day details
  Future<int> updateDayDetail(DayDetails dayDetails) async {
    Database? database = await instance.db;
    return await database!.update(days_details_table, dayDetails.toMap(), where: '$id = ?', whereArgs: [dayDetails.id]);
  }

  /// Delete
  // Delete a supplement
  Future<void> deleteSupplement(Supplement supplement) async {
    Database? database = await instance.db;
    List<ServingTime>? servingTimes = await instance.getServingTimes(supplement.id!);
    for (int i = 0; i < servingTimes!.length; i++) {
      NotificationsHelper.cancel(servingTimes[i].id!);
    }
    await database!.delete(serving_times_table, where: '$supplement_id = ?', whereArgs: [supplement.id]);
    await database.delete(supplements_table, where: '$id = ?', whereArgs: [supplement.id]);
    await database.delete(days_details_table, where: '$supplement_id = ?', whereArgs: [supplement.id]);
  }

  // Delete a serving time
  Future<void> deleteServingTime(ServingTime servingTime) async {
    Database? database = await instance.db;
    await database!.delete(serving_times_table, where: '$id = ?', whereArgs: [servingTime.id]);
    await database.delete(days_details_table, where: '$serving_time_id = ?', whereArgs: [servingTime.id]);
    NotificationsHelper.cancel(servingTime.id!);
  }

  // Delete a day
  Future<int> deleteDay(Database db, Day day) async {
    return await db.delete(days_table, where: '$id = ?', whereArgs: [day.id]);
  }

  // Delete a Day Detail
  Future<int> deleteDayDetails(Database db, DayDetails dayDetails) async {
    return await db.delete(days_details_table, where: '$id = ?', whereArgs: [dayDetails.id]);
  }

  // Delete a Day Detail
  Future<int> deleteAllDayDetails() async {
    Database? database = await instance.db;
    return await database!.delete(days_details_table);
  }
}
