import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/features/home/domain/entities/category.dart';

Future<void> saveCategories(List<CategoryEntity> items, String boxName) async {
  var box = Hive.box<CategoryEntity>(boxName);
  await box.addAll(items);
}
