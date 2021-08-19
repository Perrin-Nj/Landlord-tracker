import 'package:flutter/material.dart';
import 'singleMenuItem_ListTenants.dart';

class MenuItems {
  static const List<SingleMenuItem> items = [
    itemMonthdisplay,
    //itemSearch,
  ];

  static const itemMonthdisplay = SingleMenuItem(
    text: 'Monthly list of tenants',
    icon: Icons.list_outlined,
  );

  // static const itemSearch = SingleMenuItem(
  //   text: 'Search',
  //   icon: Icons.search,
  // );
}
