import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:todo/core/utils/functions/extensions.dart';

class LocalNotification {
  static Future init() async {
    AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            importance: NotificationImportance.Max,
          )
        ],
        channelGroups: [
          NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group',
          )
        ],
        debug: true);
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications(permissions: [
        NotificationPermission.Alert,
        NotificationPermission.Sound,
        NotificationPermission.Badge,
        NotificationPermission.Vibration,
        NotificationPermission.Light,
        NotificationPermission.CriticalAlert,
        NotificationPermission.FullScreenIntent,
        NotificationPermission.PreciseAlarms,
      ]);
    }
  }

  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {}

  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {}

  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {}

  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {}

  static Future<void> scheduleNotifications({
    required String id,
    String? title,
    String? body,
    required DateTime scheduleTime,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id.generateId(),
        channelKey: 'basic_channel',
        title: title,
        body: body,
        category: NotificationCategory.Reminder,
        badge: 1,
        wakeUpScreen: true,
      ),
      schedule: NotificationCalendar(
        year: scheduleTime.year,
        month: scheduleTime.month,
        day: scheduleTime.day,
        hour: scheduleTime.hour,
        minute: scheduleTime.minute,
        preciseAlarm: true,
        allowWhileIdle: true,
      ),
    );
  }

  static void cancelNotification(String id) async {
    await AwesomeNotifications().cancel(id.generateId());
  }

  static void cancelAllNotification() async {
    await AwesomeNotifications().cancelAll();
  }
}
