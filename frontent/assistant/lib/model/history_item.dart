import 'package:assistant/utils/enums.dart';

class HistoryItem {
  final int _activityId;
  final String _activityName;
  final ActivityType _activityType;
  final DateTime _date;

  int get id => _activityId;
  String get name => _activityName;
  ActivityType get type => _activityType;
  DateTime get date => _date;

  HistoryItem({
    required int activityId,
    required String activityName,
    required ActivityType activityType,
    required DateTime date,
  })  : _activityId = activityId,
        _activityName = activityName,
        _activityType = activityType,
        _date = date;

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      activityId: json['activity_id'],
      activityName: json['activity_name'],
      activityType: ActivityType.values[json['activity_type'] - 1],
      date: DateTime.parse(json['date']),
    );
  }
}
