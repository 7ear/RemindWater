import '../imports.dart';

final theme = ThemeData(
  useMaterial3: false,
  scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
    centerTitle: true,
    elevation: 0.0,
    color: const Color.fromARGB(0, 0, 0, 0),
    titleTextStyle: GoogleFonts.archivo(
      color: const Color.fromARGB(255, 22, 22, 22),
      fontWeight: FontWeight.w800,
      fontSize: 26,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0.0,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
  ),
  textTheme: TextTheme(
    titleSmall: TextStyle(
      color: const Color.fromARGB(255, 225, 225, 225),
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      color: const Color.fromARGB(74, 22, 22, 22),
      fontSize: 75,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: TextStyle(
      color: const Color.fromARGB(255, 22, 22, 22),
      fontSize: 75,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      color: const Color.fromARGB(255, 0, 60, 255),
      fontSize: 15,
      fontWeight: FontWeight.w400,
    ),
    bodyMedium: TextStyle(
      color: const Color.fromARGB(255, 22, 22, 22),
      fontSize: 23,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(
      color: const Color.fromARGB(255, 255, 255, 255),
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    labelSmall: TextStyle(
      color: const Color.fromARGB(255, 12, 65, 255),
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: TextStyle(
      color: const Color.fromARGB(255, 247, 247, 247),
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    labelLarge: TextStyle(
      color: const Color.fromARGB(255, 255, 255, 255),
      fontSize: 15,
      fontWeight: FontWeight.w400,
    ),
  ),
  listTileTheme: ListTileThemeData(
    minLeadingWidth: 0, 
  ),
);
