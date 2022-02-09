class Supplement {
  int? id;
  String? name;
  int? totalCount;
  int? currentCount;
  String? servingType;
  int? servingSize;
  List<String>? servingTimes;
  String? instructions;
  // int? refill_alert_count;
  String? lastDay;

  Supplement({
    this.id,
    required this.name,
    required this.totalCount,
    required this.currentCount,
    required this.servingType,
    required this.servingSize,
    required this.servingTimes,
    required this.instructions,
    // required this.refill_alert_count,
    this.lastDay,
  });

  Map<String, Object?> toMap() {
    var map = {
      'name': name,
      'total_count': totalCount,
      'current_count': currentCount,
      'serving_type': servingType,
      'serving_size': servingSize,
      'serving_times': servingTimes,
      'instructions': instructions,
      // 'refill_alert_count':refill_alert_count,
      'last_day': lastDay,
    };
    // Check if there is and id returned from the database or no
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Map<String, Object?> toMapDb() {
    var map = {
      'name': name,
      'total_count': totalCount,
      'current_count': currentCount,
      'serving_type': servingType,
      'serving_size': servingSize,
      'instructions': instructions,
      // 'refill_alert_count':refill_alert_count,
      'last_day': lastDay,
    };
    // Check if there is and id returned from the database or no
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  Supplement.fromMap(Map map) {
    id = map['id'];
    name = map['name'];
    totalCount = map['total_count'];
    currentCount = map['current_count'];
    servingType = map['serving_type'];
    servingSize = map['serving_size'];
    servingTimes = map['serving_times'];
    instructions = map['instructions'];
    //refill_alert_count = map['refill_alert_count'];
    lastDay = map['lastDay'];
  }

  Supplement copyWith({
    int? id,
    String? name,
    int? totalCount,
    int? currentCount,
    String? servingType,
    int? servingSize,
    List<String>? servingTimes,
    String? instructions,
    // int? refill_alert_count;
    String? lastDay,
  }) {
    return Supplement(
      id: id ?? this.id,
      name: name ?? this.name,
      totalCount: totalCount ?? this.totalCount,
      currentCount: currentCount ?? this.currentCount,
      servingType: servingType ?? this.servingType,
      servingSize: servingSize ?? this.servingSize,
      servingTimes: servingTimes ?? this.servingTimes,
      instructions: instructions ?? this.instructions,
      lastDay: lastDay ?? this.lastDay,
    );
  }

  Supplement.initial(){
    name = '';
    totalCount = 0;
    currentCount = 0;
    servingType = 'Capsules';
    servingSize = 0;
    servingTimes = [];
    instructions = 'With Food';
  }
}
