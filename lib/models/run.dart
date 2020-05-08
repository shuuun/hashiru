import 'dart:convert';

class Run {
  final int goal;
  final double distance;
  final DateTime day;

  Run({
    this.goal,
    this.distance,
    this.day,
  });

  Run copyWith({
    int goal,
    double distance,
    DateTime day,
  }) {
    return Run(
      goal: goal ?? this.goal,
      distance: distance ?? this.distance,
      day: day ?? this.day,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'goal': goal,
      'distance': distance,
      'day': day?.millisecondsSinceEpoch,
    };
  }

  static Run fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Run(
      goal: map['goal'],
      distance: map['distance'],
      day: DateTime.fromMillisecondsSinceEpoch(map['day']),
    );
  }

  String toJson() => json.encode(toMap());

  static Run fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Run(goal: $goal, distance: $distance, day: $day)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Run &&
      o.goal == goal &&
      o.distance == distance &&
      o.day == day;
  }

  @override
  int get hashCode => goal.hashCode ^ distance.hashCode ^ day.hashCode;
}
