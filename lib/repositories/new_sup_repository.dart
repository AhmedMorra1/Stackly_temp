import 'package:sqflite/sqflite.dart';
import 'package:stackly/models/day.dart';
import 'package:stackly/models/day_details.dart';
import 'package:stackly/models/serving_time.dart';
import 'package:stackly/models/supplement.dart';
import 'package:stackly/services/db_helper.dart';

class NewSupRepository{
  NewSupRepository({ required this.supplement,});

  Supplement? supplement;

  DBHelper dbHelper = DBHelper.instance;
  // get the database
  Future<Database?> _getDatabase()  async {
    return  await dbHelper.db;
  }

  // add to the database
  Future<Supplement> addNewSupplement() async {
    Database? db = await _getDatabase();
    Supplement theSupplement = await dbHelper.insertSupplement(supplement!, db!);
    addServingTimes(theSupplement.id);
    return theSupplement;
  }

  Future<ServingTime> addServingTimes(int? supplementId) async {
    Database? db = await _getDatabase();
    // insert serving times
    List<String> servingTimes = supplement!.servingTimes!;
    List<ServingTime> servingTimesList = servingTimes.map((e) => ServingTime(serving_time: e,supplement_id: supplementId)).toList();
    for (var i=0;i<servingTimesList.length;i++) {
      // add new serving time
      ServingTime servingTime = await dbHelper.insertServingTime(servingTimesList[i], db!);
      // add new day detail
      Day? today = await dbHelper.getDay(DateTime.now().toString().substring(0,10));
      await dbHelper.insertDayDetail(DayDetails(supplement_id: supplement!.id,serving_time_id: servingTime.id,day_id: today!.id,taken: 'false'));
    }
    return ServingTime();
  }

  Future<List<Supplement>?> newSupplementList() async {

    return await dbHelper.getSupplements();

  }
}