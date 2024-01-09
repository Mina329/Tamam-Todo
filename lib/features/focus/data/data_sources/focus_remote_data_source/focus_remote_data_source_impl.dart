import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/core/cache/cache_helper.dart';
import 'package:todo/core/cache/cache_keys_values.dart';
import 'package:todo/features/focus/data/data_sources/focus_remote_data_source/focus_remote_data_source.dart';
import 'package:todo/features/focus/data/models/focus_model.dart';

class FocusRemoteDataSourceImpl extends FocusRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  FocusRemoteDataSourceImpl(
      {required this.firestore, required this.firebaseAuth});
  @override
  Future<int> getTimeForToday() async {
    var res = await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('focus')
        .doc('today')
        .get();
    if (res.exists) {
      FocusModel focusModel = FocusModel.fromJson(res.data() ?? {});
      if (focusModel.dateTime.day == DateTime.now().day &&
          focusModel.dateTime.month == DateTime.now().month &&
          focusModel.dateTime.year == DateTime.now().year) {
        await saveTimeLocally(focusModel);
        return focusModel.seconds;
      } else {
        return 0;
      }
    } else {
      return 0;
    }
  }

  Future<void> saveTimeLocally(FocusModel focusModel) async {
    await CacheData.setData(
        key: CacheKeys.kDATE, value: focusModel.dateTime.toIso8601String());
    await CacheData.setData(key: CacheKeys.kSECONDS, value: focusModel.seconds);
  }

  @override
  Future<void> addTimeForToday(int seconds) async {
    var res = await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('focus')
        .doc('today')
        .get();
    if (res.exists) {
      FocusModel focusModel = FocusModel.fromJson(res.data() ?? {});
      if (focusModel.dateTime.day == DateTime.now().day &&
          focusModel.dateTime.month == DateTime.now().month &&
          focusModel.dateTime.year == DateTime.now().year) {
        await addTime(seconds + focusModel.seconds);
      } else {
        await addTime(seconds);
      }
    } else {
      await addTime(seconds);
    }
  }

  Future<void> addTime(int seconds) async {
    await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('focus')
        .doc('today')
        .set(
          FocusModel(
                  dateTime: DateTime(DateTime.now().year, DateTime.now().month,
                      DateTime.now().day),
                  seconds: seconds)
              .toJson(),
        );
  }
}
