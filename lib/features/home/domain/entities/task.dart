import 'package:todo/features/home/domain/entities/category.dart';

class Task {
  final String id;
  final String name;
  final String description;
  final CategoryData category;
  final int priority;
  final DateTime utcTime;
  final String status;

  Task(
      {required this.id,
      required this.name,
      required this.description,
      required this.category,
      required this.priority,
      required this.utcTime,
      required this.status});
}
