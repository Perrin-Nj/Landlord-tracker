//@dart=2.13

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../widgets/Pages/payment_page.dart';
import 'widgets/bottom_navbar_menu.dart';
import 'widgets/navigation_drawer_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LandLord Tracking',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.blue,
        secondaryHeaderColor: Colors.cyan,
        // ignore: deprecated_member_use
        cursorColor: Colors.limeAccent,
        // ignore: deprecated_member_use
        textSelectionColor: Colors.orangeAccent,
        canvasColor:
            Color.fromRGBO(220, 255, 255, 1), //fromRGBO(220, 255, 255, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              // ignore: deprecated_member_use
              body1: TextStyle(
                color: Color.fromRGBO(98, 100, 103, 1),
              ),
              // ignore: deprecated_member_use
              body2: TextStyle(
                color: Color.fromRGBO(100, 91, 103, 1),
              ),
              // ignore: deprecated_member_use
              title: TextStyle(
                fontSize: 15,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      home: Scaffold(
        body: BottomNavBarMenu(),
      ),
      routes: {
        '/tenants-page': (ctx) => PaymentPage(),
        // '/payment-page': (ctx) => DisplayRenters(),
      },
    );

    //);
    //
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //On tapped on bottom nav bar icons
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          centerTitle: true,
          title: Text(
            'HOMEPAGE',
            style: TextStyle(
              color: Theme.of(context).canvasColor,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            ),
          ),
          //Shaping AppBar
          elevation: 22,
          shadowColor: Theme.of(context).canvasColor,
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
        ),
      ),
      body: Center(child: Text('HELLO ALL AND WELCOME TO LANDLORD DEMO')),
    );
  }
}
