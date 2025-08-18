import '../imports.dart';
import 'package:timezone/timezone.dart' as tz;

Future<tz.TZDateTime?> getNextNotificationTime() async {
  final possibleTimes = times.map((hour) {
    var time = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour);
    if (hour == 0) time = time.add(const Duration(days: 1));
    if (time.isBefore(now)) time = time.add(const Duration(days: 1));
    return time;
  }).toList();

  possibleTimes.sort((a, b) => a.compareTo(b));
  return possibleTimes.firstWhere((time) => time.isAfter(now));
}

Future<void> showNotifications() async {
  final now = tz.TZDateTime.now(tz.local);

  for (final hour in times){
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    final notificationId = hour;

    await notifications.zonedSchedule(
      notificationId,
      'Пора выпить стакан воды',
      'Нажмите, чтобы добавить ваш результат',
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          channelDescription: 'Water Notifications',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      matchDateTimeComponents: DateTimeComponents.time,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  
}