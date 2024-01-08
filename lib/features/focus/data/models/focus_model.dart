class FocusModel {
  final DateTime dateTime;
  final int seconds;

  FocusModel({required this.dateTime, required this.seconds});
  factory FocusModel.fromJson(Map<String, dynamic> json) {
    return FocusModel(
      dateTime: DateTime.parse(json['date']),
      seconds: json['seconds'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'date': dateTime.toIso8601String(),
      'seconds': seconds,
    };
  }
}
