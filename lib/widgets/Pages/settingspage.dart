import 'package:flutter/material.dart';
import 'package:landlord_tracking/widgets/Pages/settingsController.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Settings",
            themeMode: themeProvider.themeMode,
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
            home: SettingsController(),
          );
        },
      );
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: ColorScheme.dark(),
    primaryColor: Colors.black,
    accentColor: Colors.blue,
    secondaryHeaderColor: Colors.purple,
    // ignore: deprecated_member_use
    cursorColor: Colors.limeAccent,
    // ignore: deprecated_member_use
    textSelectionColor: Colors.orangeAccent,
    canvasColor: Color.fromRGBO(220, 255, 255, 1),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(),
    primaryColor: Colors.indigo,
    accentColor: Colors.blue,
    secondaryHeaderColor: Colors.brown,
    // ignore: deprecated_member_use
    cursorColor: Colors.limeAccent,
    // ignore: deprecated_member_use
    textSelectionColor: Colors.orangeAccent,
    canvasColor: Color.fromRGBO(220, 2, 200, 1),
  );
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get islightMode => themeMode == ThemeMode.light;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}
