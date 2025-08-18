import '../imports.dart';
import 'package:timezone/timezone.dart' as tz;

bool isAnimating = false;
bool flag = false;

double tempValue = 0.0;
double totalWaterValue = 0.0;
double targetWaterValue = 2.5;
double changedWaterValue = 0.3;

late AnimationController controller;
late Animation<double> animation;

final FlutterLocalNotificationsPlugin notifications = FlutterLocalNotificationsPlugin();
final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
final timeFormatter = DateFormat('HH:mm');
const AndroidInitializationSettings android = AndroidInitializationSettings('@mipmap/ic_launcher');
final InitializationSettings initializationSettings = InitializationSettings(android: android);

final TextEditingController controllerFieldTargetWater = TextEditingController();
final TextEditingController controllerFieldChangedWater = TextEditingController();

const times = [8, 10, 12, 14, 16, 18, 20, 22];