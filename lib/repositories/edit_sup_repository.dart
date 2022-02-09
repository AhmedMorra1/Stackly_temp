import 'package:sqflite/sqflite.dart';
import 'package:stackly/models/day.dart';
import 'package:stackly/models/day_details.dart';
import 'package:stackly/models/serving_time.dart';
import 'package:stackly/models/supplement.dart';
import 'package:stackly/services/db_helper.dart';

class EditSupRepository{

  EditSupRepository({ required this.supplement,});

  Supplement supplement;

  DBHelper dbHelper = DBHelper.instance;
  // get the database
  Future<Database?> _getDatabase() async {
    return  await dbHelper.db;
  }

  // add to the database
  Future<void> updateOldSupplement() async {
    await dbHelper.updateSupplement(supplement,);
    updateServingTimes(supplement.id);
    updateSupplementList();
  }

  Future<void> updateServingTimes(int? supplementId) async {
    Database? db = await _getDatabase();
    // insert serving times
    List<String> servingTimes = supplement.servingTimes!;
    List<ServingTime>? servingTimesList = await dbHelper.getServingTimes(supplement.id!);
    List<String?> servingTimesListStrings = servingTimesList!.map((e) => e.serving_time).toList();
    for (var i=0;i<servingTimes.length;i++) {
      if (!servingTimesListStrings.contains(servingTimes[i])){
        ServingTime servingTime = await dbHelper.insertServingTime(ServingTime(supplement_id: supplement.id,serving_time: servingTimes[i]), db!);
        // add new day detail
        Day? today = await dbHelper.getDay(DateTime.now().toString().substring(0,10));
        await dbHelper.insertDayDetail(DayDetails(supplement_id: supplement.id,serving_time_id: servingTime.id,day_id: today!.id,taken: 'false'));
      }
    }
    for (var i=0;i<servingTimesListStrings.length;i++) {
      if (!servingTimes.contains(servingTimesListStrings[i])){
        await dbHelper.deleteServingTime(servingTimesList[i] );
      }
    }
  }

  Future<List<Supplement>?> updateSupplementList() async {
    return await dbHelper.getSupplements();
  }

  Future<void> deleteSupplement() async {
    await dbHelper.deleteSupplement(supplement);
  }
}