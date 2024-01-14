import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:todo/core/database/database.dart';
import 'package:todo/core/notifications/local_notification.dart';
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

  @override
  Future<void> changeTasksToUncompleted() async {
    await addNewUnstoredTasksToDB();
    var box = Hive.box<TaskEntity>(kTasksBox);
    List<TaskEntity> tasksStored = box.values.toList();
    List<TaskEntity> tasksBeforeToday = tasksStored
        .where(
          (task) => task.utcTime.isBefore(
            DateTime(DateTime.now().year, DateTime.now().month,
                DateTime.now().day, 0, 0, 0),
          ),
        )
        .toList();
    for (TaskEntity task in tasksBeforeToday) {
      if (task.status == 'pending') {
        updateTaskStatus(task, tasksStored, box);
      }
    }
  }

  Future<void> updateTaskStatus(
      TaskEntity task, List<TaskEntity> tasksStored, var box) async {
    DocumentReference taskRef = firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('tasks')
        .doc(task.id);
    await taskRef.update(
      {
        'status': 'uncompleted',
      },
    );
    var taskIndex = tasksStored.indexWhere((task) => task.id == task.id);
    if (taskIndex != -1) {
      TaskEntity newTask = TaskEntity(
          id: task.id,
          name: task.name,
          description: task.description,
          category: task.category,
          priority: task.priority,
          utcTime: task.utcTime,
          status: 'uncompleted');
      await box.putAt(taskIndex, newTask);
    }
  }

  Future<void> addNewUnstoredTasksToDB() async {
    QuerySnapshot querySnapshot = await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('tasks')
        .where(
          'utc_time',
          isGreaterThanOrEqualTo: DateTime(DateTime.now().year,
                  DateTime.now().month - 2, DateTime.now().day, 0, 0, 0)
              .toUtc()
              .toIso8601String(),
        )
        .where(
          'utc_time',
          isLessThan: DateTime(DateTime.now().year, DateTime.now().month + 2,
                  DateTime.now().day, 0, 0, 0)
              .toUtc()
              .toIso8601String(),
        )
        .get();
    List<TaskEntity> tasksRetrieved = parseRetrievedTasks(querySnapshot);
    var box = Hive.box<TaskEntity>(kTasksBox);
    List<TaskEntity> tasksStored = box.values.toList();
    List<TaskEntity> newStoredTasks = findNewTasks(tasksRetrieved, tasksStored);
    await saveTasks(newStoredTasks, kTasksBox);
  }

  List<TaskEntity> parseRetrievedTasks(QuerySnapshot<Object?> querySnapshot) {
    List<TaskEntity> tasksRetrieved = [];
    for (var task in querySnapshot.docs) {
      tasksRetrieved
          .add(TaskModel.fromJson(task.data() as Map<String, dynamic>));
    }
    return tasksRetrieved;
  }

  List<TaskEntity> findNewTasks(
      List<TaskEntity> retrievedTasks, List<TaskEntity> storedTasks) {
    Set<String> storedTaskIds =
        Set<String>.from(storedTasks.map((task) => task.id));

    List<TaskEntity> newTasks = retrievedTasks
        .where((task) => !storedTaskIds.contains(task.id))
        .toList();
    for (var task in newTasks) {
      if (task.status == 'pending' && task.utcTime.isAfter(DateTime.now())) {
        LocalNotification.scheduleNotifications(
          id: task.id,
          title: task.name,
          body: task.description,
          scheduleTime: task.utcTime,
        );
      }
    }
    return newTasks;
  }

  @override
  Future<void> deleteOldTasks() async {
    QuerySnapshot querySnapshot = await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('tasks')
        .where(
          'utc_time',
          isLessThanOrEqualTo: DateTime(DateTime.now().year,
                  DateTime.now().month - 2, DateTime.now().day - 1, 0, 0, 0)
              .toUtc()
              .toIso8601String(),
        )
        .get();
    List<TaskEntity> tasksRetrieved = parseRetrievedTasks(querySnapshot);
    await deleteTasks(tasksRetrieved);
  }

  Future<void> deleteTasks(List<TaskEntity> tasks) async {
    for (TaskEntity targetTask in tasks) {
      await firestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('tasks')
          .doc(targetTask.id)
          .delete();
      var box = Hive.box<TaskEntity>(kTasksBox);
      int taskIndex =
          box.values.toList().indexWhere((task) => task.id == targetTask.id);
      if (taskIndex != -1) {
        await box.deleteAt(taskIndex);
      }
    }
  }
}
