import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/core/database/database.dart';
import 'package:todo/core/utils/functions/save_data.dart';
import 'package:todo/features/home/data/models/task_model.dart/task_model.dart';
import 'package:todo/features/home/domain/entities/task.dart';
import 'package:todo/features/index/data/data_sources/index_remote_data_source/index_remote_data_source.dart';

class IndexRemoteDataSourceImpl extends IndexRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  IndexRemoteDataSourceImpl(
      {required this.firebaseAuth, required this.firestore});

  @override
  Future<List<TaskEntity>> getTasksByDay(DateTime day) async {
    DateTime endDate = day.add(const Duration(days: 1));

    QuerySnapshot querySnapshot = await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('tasks')
        .where('utc_time',
            isGreaterThanOrEqualTo: day.toUtc().toIso8601String())
        .where('utc_time', isLessThan: endDate.toUtc().toIso8601String())
        .get();
    List<TaskEntity> tasks = [];
    _parseTasks(querySnapshot, tasks);
    await saveTasks(tasks, kTasksBox);
    return tasks;
  }

  void _parseTasks(
      QuerySnapshot<Object?> querySnapshot, List<TaskEntity> tasks) {
    for (var task in querySnapshot.docs) {
      tasks.add(TaskModel.fromJson(task.data() as Map<String, dynamic>));
    }
  }
}
