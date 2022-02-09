import 'package:sqflite/sqflite.dart';
import 'package:stackly/models/day.dart';
import 'package:stackly/models/day_details.dart';
import 'package:stackly/models/serving_time.dart';
import 'package:stackly/models/supplement.dart';
import 'package:stackly/services/db_helper.dart';

class SupsRepository{
  SupsRepository({ this.today});

  String? today;

  DBHelper dbHelper = DBHelper.instance;

  // get the database
  Future<Database?> _getDatabase()  async {
    return  await dbHelper.db;
  }

  Future<Day> getDay() async {
    Database? db = await _getDatabase();
    Day? day = await dbHelper.getDay(today!);
    if (day != null){
      return day;
    }else{
      day = await dbHelper.insertDay(Day(day: today), db!);
    }
    return day;
  }
  //Todo do something when there are no supplements in the database yet
  Future<List<DayDetails>?> getDayDetails() async {
    Database? db = await _getDatabase();
    Day? day = await getDay();
    List<DayDetails>? allDayDetails = await dbHelper.getDayDetails(db!, day.id!);
    if (allDayDetails!.isEmpty){
      List<ServingTime>? servingTimes = await dbHelper.getAllServingTimes(db);
      for (int i = 0 ; i< servingTimes!.length ; i++){
        DayDetails theDayDetail = DayDetails(day_id: day.id,supplement_id: servingTimes[i].supplement_id,serving_time_id:servingTimes[i].id,taken: 'false' );
        await dbHelper.insertDayDetail(theDayDetail);
      }
      allDayDetails = await dbHelper.getDayDetails(db, day.id!);
    }
    return allDayDetails;
  }

  Future<Supplement?> getSupplement(int supplementId) async {
    Supplement? supplement = await dbHelper.getSupplement(supplementId);
    return supplement;
  }
  Future<ServingTime?> getServingTime(int servingTimeId) async {
    ServingTime? servingTime = await dbHelper.getServingTime(servingTimeId);
    return servingTime;
  }

  Future<List<Map>> getSpecifics() async {
    List<DayDetails>? dayDetailsList = await getDayDetails();
    List<Map> specifics=[];
    for (int i = 0; i < dayDetailsList!.length ; i++){
      Supplement? supplement = await getSupplement(dayDetailsList[i].supplement_id!);
      ServingTime? servingTime = await getServingTime(dayDetailsList[i].serving_time_id!);
      specifics.add({
        'servingTime':servingTime!.serving_time,
        'supplementName':supplement!.name,
        'supplementServingSize':supplement.servingSize,
        'supplementServingType':supplement.servingType,
        'supplementInstructions':supplement.instructions,
        ... dayDetailsList[i].toMap()
      });
    }
    return specifics;
  }

  Future<List<Supplement>> getSupplements() async {
    List<Supplement> supplements = (await DBHelper.instance.getSupplements())!;
    supplements.sort((a, b) => a.name!.compareTo(b.name!));
    return supplements;
  }
}