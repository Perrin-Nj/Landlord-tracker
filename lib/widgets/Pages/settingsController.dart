import 'package:flutter/material.dart';
import 'package:landlord_tracking/widgets/Pages/settingspage.dart';
import 'package:provider/provider.dart';

class SettingsController extends StatefulWidget {
  const SettingsController({Key? key}) : super(key: key);

  @override
  _SettingsControllerState createState() => _SettingsControllerState();
}

class _SettingsControllerState extends State<SettingsController> {
  List listCurrencies = [
    "\$",
    "cfa",
    "naira",
    "¥",
    "£",
    "€ ",
  ];
  String? currencyValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan.withGreen(5),
          elevation: 23,
          title: Text(
            'Settings page',
            style: TextStyle(color: Colors.cyan),
          ),
        ),
        body: Column(children: [
          Row(children: [
            Text(
              'Light & Dark Theme     ',
              style: TextStyle(
                fontFamily: 'QuickSand',
                fontSize: 22,
              ),
            ),
            ChangeThemeButtonWidget(),
          ]),
          // Divider(
          //   height: 50,
          // ),
          // Row(
          //   children: [
          //     Text(
          //       'Select your Currency',
          //       style: TextStyle(
          //         fontFamily: 'QuickSand',
          //         fontSize: 22,
          //       ),
          //     ),
          //      DropdownButton(
          //     //dropdownColor: Colors.grey,
          //     icon: Icon(Icons.arrow_drop_down),
          //     iconSize: 35,

          //     isExpanded: true,
          //     hint: Text(
          //       'Select the Month',
          //       style: TextStyle(
          //           fontFamily: 'DancingScript',
          //           fontWeight: FontWeight.w800,
          //           fontSize: 22,
          //           color: Theme.of(context).primaryColor),
          //     ),
          //     value: currencyValue,
          //     onChanged: (newVal) {
          //       setState(() {
          //         currencyValue = newVal as String?;
          //       });
          //     },
          //     items: listCurrencies.map((e) {
          //       return DropdownMenuItem(
          //         value: e,
          //         child: Text(
          //           e,
          //           style: TextStyle(
          //               fontFamily: 'DancingScript',
          //               fontWeight: FontWeight.w800,
          //               fontSize: 22,
          //               color: Colors.black87),
          //         ),
          //       );
          //     }).toList(),
          //   ),
          //   ],
          // ),
          //   ],
          // ),
        ]));
  }
}

class ChangeThemeButtonWidget extends StatelessWidget {
  const ChangeThemeButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Switch.adaptive(
        value: themeProvider.islightMode,
        onChanged: (value) {
          final provider = Provider.of<ThemeProvider>(
            context,
            listen: false,
          );
          provider.toggleTheme(value);
        });
  }
}
