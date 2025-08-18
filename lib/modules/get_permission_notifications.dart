import '../imports.dart';

Future<void> requestNotificationPermission() async {
  final status = await Permission.notification.request();
  
  if (!status.isGranted) {
    Permission.notification.request();
  }
}