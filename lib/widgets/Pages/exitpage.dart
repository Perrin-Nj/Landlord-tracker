import 'package:flutter/material.dart';

class ExitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      //Homepage should be called here...
      child: Text(
        "EXIT",
        style: TextStyle(
          fontWeight: FontWeight.w900,
          fontSize: 40,
          color: Colors.red,
        ),
      ),
    );
  }
}
