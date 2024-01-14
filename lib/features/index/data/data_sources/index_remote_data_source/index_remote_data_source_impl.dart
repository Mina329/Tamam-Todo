import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/core/database/database.dart';
import 'package:todo/core/notifications/local_notification.dart';
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
    scheduleDayTasksNotification(tasks);
    return tasks;
  }

  void scheduleDayTasksNotification(List<TaskEntity> tasks) {
    for (TaskEntity task in tasks) {
      if (task.status == 'pending' && task.utcTime.isAfter(DateTime.now())) {
        LocalNotification.scheduleNotifications(
          id: task.id,
          title: task.name,
          body: task.description,
          scheduleTime: task.utcTime,
        );
      }
    }
  }

  void _parseTasks(
      QuerySnapshot<Object?> querySnapshot, List<TaskEntity> tasks) {
    for (var task in querySnapshot.docs) {
      tasks.add(TaskModel.fromJson(task.data() as Map<String, dynamic>));
    }
  }

  @override
  Future<void> changeTaskStatus(String status, String taskId) async {
    DocumentReference taskRef = firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('tasks')
        .doc(taskId);
    await taskRef.update(
      {
        'status': status,
      },
    );
  }

  @override
  Future<void> deleteTask(String taskId) async {
    await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('tasks')
        .doc(taskId)
        .delete();
  }

  @override
  Future<void> editTask(
      {required TaskEntity oldTask, required TaskEntity newTask}) async {
    DocumentReference taskRef = firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('tasks')
        .doc(oldTask.id);
    await taskRef.update(
      TaskModel.fromEntity(newTask).toJson(),
    );
  }
}
