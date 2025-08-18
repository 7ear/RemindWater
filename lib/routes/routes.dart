import '../imports.dart';

final routes = {
  '/': (context) => HomePage(title: 'Remind Water'),
  '/settings': (context) => SettingsPage()
};

void routeToSettings(context){
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => SettingsPage()
    )
  );
}