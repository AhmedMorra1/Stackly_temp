class ServingTime {
  int? id;
  int? supplement_id;
  String? serving_time;

  ServingTime({
    this.id,
    this.supplement_id,
    this.serving_time,
  });

  ServingTime.fromMap(Map data) {
    id = data['id'];
    supplement_id = data['supplement_id'];
    serving_time = data['serving_time'];
  }

  Map<String,Object?> toMap() {
    var map =  {
      'supplement_id': supplement_id,
      'serving_time': serving_time,
    };
    // Check if there is and id returned from the database or no
    if(id != null){
      map['id'] = id;
    }
    return map;
  }
}
