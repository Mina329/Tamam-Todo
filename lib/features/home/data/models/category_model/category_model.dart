import 'package:todo/features/home/domain/entities/category.dart';

class CategoryModel extends CategoryEntity {
  final String categoryId;
  @override
  // ignore: overridden_fields
  final String name;
  final int icon;
  final String colorHex;

  CategoryModel({
    required this.categoryId,
    required this.name,
    required this.icon,
    required this.colorHex,
  }) : super(
          id: categoryId,
          name: name,
          iconData: icon,
          color: colorHex,
        );

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json['id'],
      name: json['name'],
      icon: json['icon'],
      colorHex: json['color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': categoryId,
      'name': name,
      'icon': icon,
      'color': color,
    };
  }

  factory CategoryModel.fromEntity(CategoryEntity data) {
    return CategoryModel(
        categoryId: data.id,
        name: data.name,
        icon: data.iconData,
        colorHex: data.color);
  }
}
