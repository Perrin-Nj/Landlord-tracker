//@dart=2.13

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:landlord_tracking/main.dart';
import 'package:landlord_tracking/widgets/Pages/addRenters_page.dart';
import 'package:landlord_tracking/widgets/Pages/displayrenters.dart';
import 'package:landlord_tracking/widgets/Pages/settingspage.dart';

class BottomNavBarMenu extends StatefulWidget {
  @override
  _BottomNavBarMenuState createState() => _BottomNavBarMenuState();
}

class _BottomNavBarMenuState extends State<BottomNavBarMenu> {
  int _pageIndex = 0;

  final MyHomePage _homePage = MyHomePage();
  final AddRenter _addRenter = new AddRenter();
  final DisplayRenters _displayRenters = new DisplayRenters();
  final Settings _settings = new Settings();
// ignore: non_constant_identifier_names
  Widget _ShowPage = new MyHomePage(); //initialize showPage

  Widget? onTapped(int page) {
    switch (page) {
      case 0:
        return _homePage;
      case 1:
        return _addRenter;
      case 2:
        return _displayRenters;
      case 3:
        return _settings;
      default:
        return _homePage;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: _pageIndex,
        color: Colors.white,
        backgroundColor: Theme.of(context).canvasColor,
        buttonBackgroundColor: Theme.of(context).primaryColor,
        height: 70,
        //we can change animation duration as well...

        items: [
          Icon(
            Icons.houseboat_rounded,
            size: 20,
            color: Colors.cyan,
          ),
          Icon(
            Icons.person_add_alt_1_sharp,
            size: 20,
            color: Colors.cyan,
          ),
          Icon(
            Icons.people_rounded,
            size: 20,
            color: Colors.cyan,
          ),
          Icon(
            Icons.settings,
            size: 20,
            color: Colors.cyan,
          ),
        ],
        onTap: (tappedIndex) {
          setState(() {
            _ShowPage = onTapped(tappedIndex)!;
          });
        },
        animationCurve: Curves.easeInOutQuint,
      ),
      body: Container(
        child: _ShowPage,
        color: Colors.lightBlue,
      ),
    );
  }
}
