import 'imports.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Europe/Moscow'));

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await notifications.initialize(initializationSettings);

  showNotifications();

  final model = SharedModel();
  await model.loadValues();
  final prefs = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: model),
        Provider<SharedPreferences>.value(value: prefs),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Remind Water',
      theme: theme,
      initialRoute: '/',
      routes: routes,
    );
  }
}
