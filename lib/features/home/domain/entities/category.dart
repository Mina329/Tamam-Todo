
import 'package:hive_flutter/hive_flutter.dart';
part 'category.g.dart';
@HiveType(typeId: 1)
class CategoryEntity extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int iconData;
  @HiveField(3)
  final String color;

  CategoryEntity(
      {required this.id,
      required this.name,
      required this.iconData,
      required this.color});
}
