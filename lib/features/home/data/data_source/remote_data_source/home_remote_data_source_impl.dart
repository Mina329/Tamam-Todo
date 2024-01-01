import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/core/database/database.dart';
import 'package:todo/core/utils/functions/save_data.dart';
import 'package:todo/features/home/data/data_source/remote_data_source/home_remote_data_source.dart';
import 'package:todo/features/home/data/models/category_model/category_model.dart';
import 'package:todo/features/home/data/models/task_model.dart/task_model.dart';
import 'package:todo/features/home/domain/entities/category.dart';
import 'package:todo/features/home/domain/entities/task.dart';

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;
  HomeRemoteDataSourceImpl(
      {required this.firebaseAuth, required this.firestore});
  @override
  Future<void> createCategory(CategoryEntity categoryData) async {
    await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('categories')
        .doc(categoryData.id)
        .set(CategoryModel.fromEntity(categoryData).toJson());
  }

  @override
  Future<void> createTask(TaskEntity task) async {
    await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('tasks')
        .doc(task.id)
        .set(TaskModel.fromEntity(task).toJson());
  }

  @override
  Future<List<CategoryEntity>> getAllCategories() async {
    QuerySnapshot querySnapshot = await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('categories')
        .get();
    List<CategoryEntity> categories = [];
    _parseCategories(querySnapshot, categories);
    await saveCategories(categories, kCategoriesBox);
    return categories;
  }

  void _parseCategories(
      QuerySnapshot<Object?> querySnapshot, List<CategoryEntity> categories) {
    for (var category in querySnapshot.docs) {
      categories
          .add(CategoryModel.fromJson(category.data() as Map<String, dynamic>));
    }
  }

  @override
  Future<void> deleteCategory(String categoryId) async {
    await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('categories')
        .doc(categoryId)
        .delete();
  }
}
