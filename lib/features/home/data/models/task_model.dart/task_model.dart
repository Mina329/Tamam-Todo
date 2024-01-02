import 'package:todo/features/home/data/models/category_model/category_model.dart';
import 'package:todo/features/home/domain/entities/task.dart';

class TaskModel extends TaskEntity {
  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final CategoryModel category;
  @override
  final int priority;
  @override
  final DateTime utcTime;
  @override
  final String status;

  TaskModel({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.priority,
    required this.utcTime,
    required this.status,
  }) : super(
            id: id,
            name: name,
            description: description,
            category: category,
            priority: priority,
            utcTime: utcTime,
            status: status);

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      category: CategoryModel.fromJson(json['category']),
      priority: json['priority'],
      utcTime: DateTime.parse(json['utc_time']).toLocal(),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category.toJson(),
      'priority': priority,
      'utc_time': utcTime.toUtc().toIso8601String(),
      'status': status,
    };
  }

  factory TaskModel.fromEntity(TaskEntity data) {
    return TaskModel(
      id: data.id,
      name: data.name,
      description: data.description,
      category: CategoryModel.fromEntity(data.category),
      priority: data.priority,
      utcTime: data.utcTime,
      status: data.status,
    );
  }
}
