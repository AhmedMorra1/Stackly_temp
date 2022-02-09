class DayDetails {
  int? id;
  int? day_id;
  int? supplement_id;
  int? serving_time_id;
  String? taken;

  DayDetails({
    this.id,
    this.day_id,
    this.supplement_id,
    this.serving_time_id,
    this.taken,
  });

  DayDetails.fromMap(Map data){
    id = data['id'];
    day_id = data['day_id'];
    supplement_id = data['supplement_id'];
    serving_time_id = data['serving_time_id'];
    taken = data['taken'];
  }

  Map <String,Object?>toMap(){
    var map =  {
      'day_id':day_id,
      'supplement_id':supplement_id,
      'serving_time_id':serving_time_id,
      'taken':taken,
    };
    // Check if there is and id returned from the database or no
    if(id != null){
      map['id'] = id;
    }
    return map;
  }
}
