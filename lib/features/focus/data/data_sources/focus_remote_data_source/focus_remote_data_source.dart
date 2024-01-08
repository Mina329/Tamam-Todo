abstract class FocusRemoteDataSource {
  Future<int> getTimeForToday();
  Future<void> addTimeForToday(int seconds);
}
