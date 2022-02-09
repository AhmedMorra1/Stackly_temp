class Day {
  int? id;
  String? day;

  Day({
    this.id,
    this.day,
  });

  Day.fromMap(Map data) {
    id = data['id'];
    day = data['day'];
  }

  Map<String,Object?> toMap() {
    Map<String,Object?> map = {
      'day': day,
    };
    // Check if there is and id returned from the database or no
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}
