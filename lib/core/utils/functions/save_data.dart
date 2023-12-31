import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/features/home/domain/entities/category.dart';

Future<void> saveCategories(List<CategoryData> items, String boxName) async {
  var box = Hive.box<CategoryData>(boxName);
  await box.addAll(items);
}
