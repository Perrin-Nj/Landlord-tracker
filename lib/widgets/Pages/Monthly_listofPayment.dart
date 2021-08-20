import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:landlord_tracking/helpers/monthHelpers/aprilHelper.dart';
import 'package:landlord_tracking/helpers/monthHelpers/decemberHelper.dart';
import 'package:landlord_tracking/helpers/monthHelpers/februaryHelper.dart';
import 'package:landlord_tracking/helpers/monthHelpers/julyHelper.dart';
import 'package:landlord_tracking/helpers/monthHelpers/juneHelper%20.dart';
import 'package:landlord_tracking/helpers/monthHelpers/marchHelper.dart';
import 'package:landlord_tracking/helpers/monthHelpers/mayHelper.dart';
import 'package:landlord_tracking/helpers/monthHelpers/novemberHelper.dart';
import 'package:landlord_tracking/helpers/monthHelpers/octoberHelper.dart';
import 'package:landlord_tracking/helpers/monthHelpers/septemberHelper.dart';
import 'package:landlord_tracking/models/monthModels/augustModel.dart';
import 'package:landlord_tracking/models/monthModels/decemberModel.dart';
import 'package:landlord_tracking/models/monthModels/februaryModel.dart';
import 'package:landlord_tracking/models/monthModels/julyModel.dart';
import 'package:landlord_tracking/models/monthModels/juneModel%20.dart';
import 'package:landlord_tracking/models/monthModels/marchModel.dart';
import 'package:landlord_tracking/models/monthModels/mayModel.dart';
import 'package:landlord_tracking/models/monthModels/novemberModel.dart';
import 'package:landlord_tracking/models/monthModels/octoberModel.dart';
import 'package:landlord_tracking/models/monthModels/septemberModel.dart';
import '../../helpers/monthHelpers/augustHelper.dart';
import '../../helpers/monthHelpers/januaryHelper.dart';
import '../../models/monthModels/aprilModel.dart';
import '../../models/monthModels/januaryModel.dart';

class MonthlyDisplay extends StatefulWidget {
  //for getting data from monthDb
  @override
  _MonthlyDisplayState createState() => _MonthlyDisplayState();
}

class _MonthlyDisplayState extends State<MonthlyDisplay> {
  List listMonth = [
    "january",
    "february",
    "march",
    "april",
    "may",
    "june",
    "july",
    "august",
    "september",
    "october",
    "november",
    "december"
  ];

  String? chosenValue;
  int condition = 0;

  _renderWidget() {
    setState(() {});
    switch (condition) {
      case 4:
        return april_listPayment();
      case 1:
        return january_listPayment();
      case 2:
        return february_listPayment();
      case 3:
        return march_listPayment();
      case 5:
        return may_listPayment();
      case 6:
        return june_listPayment();
      case 7:
        return july_listPayment();
      case 8:
        return august_listPayment();
      case 9:
        return september_listPayment();
      case 10:
        return october_listPayment();
      case 11:
        return november_listPayment();
      case 12:
        return december_listPayment();
      default:
        return Container(
          child: Text("Please select a month"),
        );
    }
  }

  // ignore: non_constant_identifier_names
  Visibility january_listPayment() {
    return Visibility(
      visible: true,
      child: Expanded(
        child: FutureBuilder<List<JanuaryModel>>(
          future: JanuaryDb.db.getRawPayments(),
          builder:
              (BuildContext context, AsyncSnapshot<List<JanuaryModel>> snaps) {
            if (snaps.hasData) {
              print("Getting April data");
              List<JanuaryModel>? listData = snaps.data!;
              return Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .secondaryHeaderColor
                          .withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 9,
                      offset: Offset(0, 1),
                      // changes position of shadow
                    ),
                  ],
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listData.length,
                  itemBuilder: (context, index) {
                    final data = listData[index];

                    return Container(
                      child: Card(
                        color: Theme.of(context).canvasColor,
                        child: Column(
                          children: [
                            Text(
                              data.name!,
                              style: TextStyle(
                                fontFamily: 'DancingScript',
                                fontWeight: FontWeight.w900,
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(height: 50),
                            Row(
                              children: [
                                const Text(
                                  'Money to pay:    ',
                                  style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    '${data.moneyToPay.toString()} cfa',
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 25),
                            Row(
                              children: [
                                Text(
                                  'Last paid amount:    ',
                                  style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.cyan.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    '${data.moneyPaid.toString()} cfa',
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 25),
                            Row(
                              children: [
                                Text(
                                  'Remaining:    ',
                                  style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 20,
                                  ),
                                ),
                                data.remainder! == -1
                                    ? Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.red.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0,
                                                  1), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          data.moneyToPay.toString(),
                                          style: TextStyle(
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.w200,
                                            fontSize: 15,
                                          ),
                                        ),
                                      )
                                    : data.remainder == 0
                                        ? Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              data.remainder.toString(),
                                              style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.w200,
                                                fontSize: 15,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.red
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              data.remainder.toString(),
                                              style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.w200,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),

                                //data.remainder! > 0 && data.remainder! < data.moneyToPay! ?
                              ],
                            ),
                            SizedBox(height: 25),
                            const Text(
                              'Status:    ',
                              style: TextStyle(
                                fontFamily: 'DancingScript',
                                fontSize: 20,
                              ),
                            ),
                            data.remainder == 0
                                ? Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.green.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child:
                                        Text('Done paying for $chosenValue '),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.orange.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                        'Still has to pay for $chosenValue '),
                                  )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (snaps.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: Text('No Payment added yet'),
              );
            }
          },
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Visibility february_listPayment() {
    return Visibility(
      visible: true,
      child: Expanded(
        child: FutureBuilder<List<FebruaryModel>>(
          future: FebruaryDb.db.getRawPayments(),
          builder:
              (BuildContext context, AsyncSnapshot<List<FebruaryModel>> snaps) {
            if (snaps.hasData) {
              print("Getting April data");
              List<FebruaryModel>? listData = snaps.data!;
              return Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .secondaryHeaderColor
                          .withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 9,
                      offset: Offset(0, 1),
                      // changes position of shadow
                    ),
                  ],
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listData.length,
                  itemBuilder: (context, index) {
                    final data = listData[index];

                    return Container(
                      child: Card(
                        color: Theme.of(context).canvasColor,
                        child: Column(
                          children: [
                            Text(
                              data.name!,
                              style: TextStyle(
                                fontFamily: 'DancingScript',
                                fontWeight: FontWeight.w900,
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(height: 50),
                            Row(
                              children: [
                                const Text(
                                  'Money to pay:    ',
                                  style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    '${data.moneyToPay.toString()} cfa',
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 25),
                            Row(
                              children: [
                                Text(
                                  'Last paid amount:    ',
                                  style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.cyan.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    '${data.moneyPaid.toString()} cfa',
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 25),
                            Row(
                              children: [
                                Text(
                                  'Remaining:    ',
                                  style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 20,
                                  ),
                                ),
                                data.remainder! == -1
                                    ? Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.red.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0,
                                                  1), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          data.moneyToPay.toString(),
                                          style: TextStyle(
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.w200,
                                            fontSize: 15,
                                          ),
                                        ),
                                      )
                                    : data.remainder == 0
                                        ? Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              data.remainder.toString(),
                                              style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.w200,
                                                fontSize: 15,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.red
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              data.remainder.toString(),
                                              style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.w200,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),

                                //data.remainder! > 0 && data.remainder! < data.moneyToPay! ?
                              ],
                            ),
                            SizedBox(height: 25),
                            const Text(
                              'Status:    ',
                              style: TextStyle(
                                fontFamily: 'DancingScript',
                                fontSize: 20,
                              ),
                            ),
                            data.remainder == 0
                                ? Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.green.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child:
                                        Text('Done paying for $chosenValue '),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.orange.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                        'Still has to pay for $chosenValue '),
                                  )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (snaps.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: Text('No Payment added yet'),
              );
            }
          },
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Visibility march_listPayment() {
    return Visibility(
      visible: true,
      child: Expanded(
        child: FutureBuilder<List<MarchModel>>(
          future: MarchDb.db.getRawPayments(),
          builder:
              (BuildContext context, AsyncSnapshot<List<MarchModel>> snaps) {
            if (snaps.hasData) {
              print("Getting April data");
              List<MarchModel>? listData = snaps.data!;
              return Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .secondaryHeaderColor
                          .withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 9,
                      offset: Offset(0, 1),
                      // changes position of shadow
                    ),
                  ],
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listData.length,
                  itemBuilder: (context, index) {
                    final data = listData[index];

                    return Container(
                      child: Card(
                        color: Theme.of(context).canvasColor,
                        child: Column(
                          children: [
                            Text(
                              data.name!,
                              style: TextStyle(
                                fontFamily: 'DancingScript',
                                fontWeight: FontWeight.w900,
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(height: 50),
                            Row(
                              children: [
                                const Text(
                                  'Money to pay:    ',
                                  style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    '${data.moneyToPay.toString()} cfa',
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 25),
                            Row(
                              children: [
                                Text(
                                  'Last paid amount:    ',
                                  style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.cyan.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    '${data.moneyPaid.toString()} cfa',
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 25),
                            Row(
                              children: [
                                Text(
                                  'Remaining:    ',
                                  style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 20,
                                  ),
                                ),
                                data.remainder! == -1
                                    ? Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.red.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0,
                                                  1), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          data.moneyToPay.toString(),
                                          style: TextStyle(
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.w200,
                                            fontSize: 15,
                                          ),
                                        ),
                                      )
                                    : data.remainder == 0
                                        ? Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              data.remainder.toString(),
                                              style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.w200,
                                                fontSize: 15,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.red
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              data.remainder.toString(),
                                              style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.w200,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),

                                //data.remainder! > 0 && data.remainder! < data.moneyToPay! ?
                              ],
                            ),
                            SizedBox(height: 25),
                            const Text(
                              'Status:    ',
                              style: TextStyle(
                                fontFamily: 'DancingScript',
                                fontSize: 20,
                              ),
                            ),
                            data.remainder == 0
                                ? Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.green.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child:
                                        Text('Done paying for $chosenValue '),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.orange.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                        'Still has to pay for $chosenValue '),
                                  )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (snaps.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: Text('No Payment added yet'),
              );
            }
          },
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Visibility april_listPayment() {
    return Visibility(
      visible: true,
      child: Expanded(
        child: FutureBuilder<List<AprilModel>>(
          future: AprilDb.db.getRawPayments(),
          builder:
              (BuildContext context, AsyncSnapshot<List<AprilModel>> snaps) {
            if (snaps.hasData) {
              print("Getting April data");
              List<AprilModel>? listData = snaps.data!;
              return Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .secondaryHeaderColor
                          .withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 9,
                      offset: Offset(0, 1),
                      // changes position of shadow
                    ),
                  ],
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listData.length,
                  itemBuilder: (context, index) {
                    final data = listData[index];

                    return Container(
                      child: Card(
                        color: Theme.of(context).canvasColor,
                        child: Column(
                          children: [
                            Text(
                              data.nameapr!,
                              style: TextStyle(
                                fontFamily: 'DancingScript',
                                fontWeight: FontWeight.w900,
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(height: 50),
                            Row(
                              children: [
                                const Text(
                                  'Money to pay:    ',
                                  style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    data.moneyToPay.toString(),
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 25),
                            Row(
                              children: [
                                Text(
                                  'Last paid amount:    ',
                                  style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.cyan.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    '${data.moneyPaid.toString()} cfa',
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 25),
                            Row(
                              children: [
                                Text(
                                  'Remaining:    ',
                                  style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 20,
                                  ),
                                ),
                                data.remainder! == -1
                                    ? Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0,
                                                  1), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          '${data.moneyToPay.toString()} cfa',
                                          style: TextStyle(
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.w200,
                                            fontSize: 15,
                                          ),
                                        ),
                                      )
                                    : data.remainder == 0
                                        ? Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              '${data.remainder.toString()} cfa',
                                              style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.w200,
                                                fontSize: 15,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.red
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              '${data.remainder.toString()}',
                                              style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.w200,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),

                                //data.remainder! > 0 && data.remainder! < data.moneyToPay! ?
                              ],
                            ),
                            SizedBox(height: 25),
                            const Text(
                              'Status:    ',
                              style: TextStyle(
                                fontFamily: 'DancingScript',
                                fontSize: 20,
                              ),
                            ),
                            data.remainder == 0
                                ? Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.green.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child:
                                        Text('Done paying for $chosenValue '),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.orange.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                        'Still has to pay for $chosenValue '),
                                  )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (snaps.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: Text('No Payment added yet'),
              );
            }
          },
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Visibility may_listPayment() {
    return Visibility(
      visible: true,
      child: Expanded(
        child: FutureBuilder<List<MayModel>>(
          future: MayDb.db.getRawPayments(),
          builder: (BuildContext context, AsyncSnapshot<List<MayModel>> snaps) {
            if (snaps.hasData) {
              print("Getting April data");
              List<MayModel>? listData = snaps.data!;
              return Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .secondaryHeaderColor
                          .withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 9,
                      offset: Offset(0, 1),
                      // changes position of shadow
                    ),
                  ],
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listData.length,
                  itemBuilder: (context, index) {
                    final data = listData[index];

                    return Container(
                      child: Card(
                        color: Theme.of(context).canvasColor,
                        child: Column(
                          children: [
                            Text(
                              data.name!,
                              style: TextStyle(
                                fontFamily: 'DancingScript',
                                fontWeight: FontWeight.w900,
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(height: 50),
                            Row(
                              children: [
                                const Text(
                                  'Money to pay:    ',
                                  style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    '${data.moneyToPay.toString()} cfa',
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 25),
                            Row(
                              children: [
                                Text(
                                  'Last paid amount:    ',
                                  style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.cyan.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    '${data.moneyPaid.toString()} cfa',
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 25),
                            Row(
                              children: [
                                Text(
                                  'Remaining:    ',
                                  style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 20,
                                  ),
                                ),
                                data.remainder! == -1
                                    ? Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.red.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0,
                                                  1), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          data.moneyToPay.toString(),
                                          style: TextStyle(
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.w200,
                                            fontSize: 15,
                                          ),
                                        ),
                                      )
                                    : data.remainder == 0
                                        ? Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              data.remainder.toString(),
                                              style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.w200,
                                                fontSize: 15,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.red
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              data.remainder.toString(),
                                              style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.w200,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),

                                //data.remainder! > 0 && data.remainder! < data.moneyToPay! ?
                              ],
                            ),
                            SizedBox(height: 25),
                            const Text(
                              'Status:    ',
                              style: TextStyle(
                                fontFamily: 'DancingScript',
                                fontSize: 20,
                              ),
                            ),
                            data.remainder == 0
                                ? Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.green.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child:
                                        Text('Done paying for $chosenValue '),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.orange.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                        'Still has to pay for $chosenValue '),
                                  )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (snaps.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: Text('No Payment added yet'),
              );
            }
          },
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Visibility june_listPayment() {
    return Visibility(
      visible: true,
      child: Expanded(
        child: FutureBuilder<List<JuneModel>>(
          future: JuneDb.db.getRawPayments(),
          builder:
              (BuildContext context, AsyncSnapshot<List<JuneModel>> snaps) {
            if (snaps.hasData) {
              print("Getting April data");
              List<JuneModel>? listData = snaps.data!;
              return Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .secondaryHeaderColor
                          .withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 9,
                      offset: Offset(0, 1),
                      // changes position of shadow
                    ),
                  ],
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listData.length,
                  itemBuilder: (context, index) {
                    final data = listData[index];

                    return Container(
                      child: Card(
                        color: Theme.of(context).canvasColor,
                        child: Column(
                          children: [
                            Text(
                              data.name!,
                              style: TextStyle(
                                fontFamily: 'DancingScript',
                                fontWeight: FontWeight.w900,
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(height: 50),
                            Row(
                              children: [
                                const Text(
                                  'Money to pay:    ',
                                  style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    '${data.moneyToPay.toString()} cfa',
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 25),
                            Row(
                              children: [
                                Text(
                                  'Last paid amount:    ',
                                  style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.cyan.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    '${data.moneyPaid.toString()} cfa',
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 25),
                            Row(
                              children: [
                                Text(
                                  'Remaining:    ',
                                  style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 20,
                                  ),
                                ),
                                data.remainder! == -1
                                    ? Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.red.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0,
                                                  1), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          data.moneyToPay.toString(),
                                          style: TextStyle(
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.w200,
                                            fontSize: 15,
                                          ),
                                        ),
                                      )
                                    : data.remainder == 0
                                        ? Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              data.remainder.toString(),
                                              style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.w200,
                                                fontSize: 15,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.red
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              data.remainder.toString(),
                                              style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.w200,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),

                                //data.remainder! > 0 && data.remainder! < data.moneyToPay! ?
                              ],
                            ),
                            SizedBox(height: 25),
                            const Text(
                              'Status:    ',
                              style: TextStyle(
                                fontFamily: 'DancingScript',
                                fontSize: 20,
                              ),
                            ),
                            data.remainder == 0
                                ? Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.green.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child:
                                        Text('Done paying for $chosenValue '),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.orange.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                        'Still has to pay for $chosenValue '),
                                  )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (snaps.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: Text('No Payment added yet'),
              );
            }
          },
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Visibility july_listPayment() {
    return Visibility(
      visible: true,
      child: Expanded(
        child: FutureBuilder<List<JulyModel>>(
          future: JulyDb.db.getRawPayments(),
          builder:
              (BuildContext context, AsyncSnapshot<List<JulyModel>> snaps) {
            if (snaps.hasData) {
              print("Getting April data");
              List<JulyModel>? listData = snaps.data!;
              return Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .secondaryHeaderColor
                          .withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 9,
                      offset: Offset(0, 1),
                      // changes position of shadow
                    ),
                  ],
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listData.length,
                  itemBuilder: (context, index) {
                    final data = listData[index];

                    return Container(
                      child: Card(
                        color: Theme.of(context).canvasColor,
                        child: Column(
                          children: [
                            Text(
                              data.name!,
                              style: TextStyle(
                                fontFamily: 'DancingScript',
                                fontWeight: FontWeight.w900,
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(height: 50),
                            Row(
                              children: [
                                const Text(
                                  'Money to pay:    ',
                                  style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    '${data.moneyToPay.toString()} cfa',
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 25),
                            Row(
                              children: [
                                Text(
                                  'Last paid amount:    ',
                                  style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.cyan.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    data.moneyPaid.toString(),
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 25),
                            Row(
                              children: [
                                Text(
                                  'Remaining:    ',
                                  style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 20,
                                  ),
                                ),
                                data.remainder! == -1
                                    ? Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.red.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0,
                                                  1), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          data.moneyToPay.toString(),
                                          style: TextStyle(
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.w200,
                                            fontSize: 15,
                                          ),
                                        ),
                                      )
                                    : data.remainder == 0
                                        ? Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              data.remainder.toString(),
                                              style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.w200,
                                                fontSize: 15,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.red
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              data.remainder.toString(),
                                              style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.w200,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),

                                //data.remainder! > 0 && data.remainder! < data.moneyToPay! ?
                              ],
                            ),
                            SizedBox(height: 25),
                            const Text(
                              'Status:    ',
                              style: TextStyle(
                                fontFamily: 'DancingScript',
                                fontSize: 20,
                              ),
                            ),
                            data.remainder == 0
                                ? Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.green.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child:
                                        Text('Done paying for $chosenValue '),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.orange.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                        'Still has to pay for $chosenValue '),
                                  )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (snaps.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: Text('No Payment added yet'),
              );
            }
          },
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Visibility august_listPayment() {
    return Visibility(
      visible: true,
      child: Expanded(
        child: FutureBuilder<List<AugustModel>>(
          future: AugustDb.db.getRawPayments(),
          builder:
              (BuildContext context, AsyncSnapshot<List<AugustModel>> snaps) {
            if (snaps.hasData) {
              print("Getting aug data");
              List<AugustModel>? listData = snaps.data!;
              return Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .secondaryHeaderColor
                          .withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 9,
                      offset: Offset(0, 1),
                      // changes position of shadow
                    ),
                  ],
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listData.length,
                  itemBuilder: (context, index) {
                    final data = listData[index];

                    return Container(
                      child: Card(
                        color: Theme.of(context).canvasColor,
                        child: Column(
                          children: [
                            Text(
                              data.name!,
                              style: TextStyle(
                                fontFamily: 'DancingScript',
                                fontWeight: FontWeight.w900,
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(height: 50),
                            Row(
                              children: [
                                const Text(
                                  'Money to pay:    ',
                                  style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    '${data.moneyToPay.toString()} cfa',
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 25),
                            Row(
                              children: [
                                Text(
                                  'Last paid amount:    ',
                                  style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.cyan.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    '${data.moneyPaid.toString()} cfa',
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 25),
                            Row(
                              children: [
                                Text(
                                  'Remaining:    ',
                                  style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 20,
                                  ),
                                ),
                                data.remainder! == -1
                                    ? Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.red.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0,
                                                  1), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          data.moneyToPay.toString(),
                                          style: TextStyle(
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.w200,
                                            fontSize: 15,
                                          ),
                                        ),
                                      )
                                    : data.remainder == 0
                                        ? Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              data.remainder.toString(),
                                              style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.w200,
                                                fontSize: 15,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.red
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              data.remainder.toString(),
                                              style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.w200,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),

                                //data.remainder! > 0 && data.remainder! < data.moneyToPay! ?
                              ],
                            ),
                            SizedBox(height: 25),
                            const Text(
                              'Status:    ',
                              style: TextStyle(
                                fontFamily: 'DancingScript',
                                fontSize: 20,
                              ),
                            ),
                            data.remainder == 0
                                ? Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.green.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child:
                                        Text('Done paying for $chosenValue '),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.orange.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                        'Still has to pay for $chosenValue '),
                                  )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (snaps.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: Text('No Payment added yet'),
              );
            }
          },
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Visibility september_listPayment() {
    return Visibility(
      visible: true,
      child: Expanded(
        child: FutureBuilder<List<SeptemberModel>>(
          future: SeptemberDb.db.getRawPayments(),
          builder: (BuildContext context,
              AsyncSnapshot<List<SeptemberModel>> snaps) {
            if (snaps.hasData) {
              print("Getting sep data");
              List<SeptemberModel>? listData = snaps.data!;
              return Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .secondaryHeaderColor
                          .withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 9,
                      offset: Offset(0, 1),
                      // changes position of shadow
                    ),
                  ],
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listData.length,
                  itemBuilder: (context, index) {
                    final data = listData[index];

                    return Container(
                      child: Card(
                        color: Theme.of(context).canvasColor,
                        child: Column(
                          children: [
                            Text(
                              data.name!,
                              style: TextStyle(
                                fontFamily: 'DancingScript',
                                fontWeight: FontWeight.w900,
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(height: 50),
                            Row(
                              children: [
                                const Text(
                                  'Money to pay:    ',
                                  style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    '${data.moneyToPay.toString()} cfa',
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 25),
                            Row(
                              children: [
                                Text(
                                  'Last paid amount:    ',
                                  style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.cyan.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    '${data.moneyPaid.toString()} cfa',
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 25),
                            Row(
                              children: [
                                Text(
                                  'Remaining:    ',
                                  style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 20,
                                  ),
                                ),
                                data.remainder! == -1
                                    ? Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.red.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0,
                                                  1), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          data.moneyToPay.toString(),
                                          style: TextStyle(
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.w200,
                                            fontSize: 15,
                                          ),
                                        ),
                                      )
                                    : data.remainder == 0
                                        ? Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              data.remainder.toString(),
                                              style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.w200,
                                                fontSize: 15,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.red
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              data.remainder.toString(),
                                              style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.w200,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),

                                //data.remainder! > 0 && data.remainder! < data.moneyToPay! ?
                              ],
                            ),
                            SizedBox(height: 25),
                            const Text(
                              'Status:    ',
                              style: TextStyle(
                                fontFamily: 'DancingScript',
                                fontSize: 20,
                              ),
                            ),
                            data.remainder == 0
                                ? Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.green.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child:
                                        Text('Done paying for $chosenValue '),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.orange.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                        'Still has to pay for $chosenValue '),
                                  )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (snaps.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: Text('No Payment added yet'),
              );
            }
          },
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Visibility october_listPayment() {
    return Visibility(
      visible: true,
      child: Expanded(
        child: FutureBuilder<List<OctoberModel>>(
          future: OctoberDb.db.getRawPayments(),
          builder:
              (BuildContext context, AsyncSnapshot<List<OctoberModel>> snaps) {
            if (snaps.hasData) {
              print("Getting oct data");
              List<OctoberModel>? listData = snaps.data!;
              return Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .secondaryHeaderColor
                          .withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 9,
                      offset: Offset(0, 1),
                      // changes position of shadow
                    ),
                  ],
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listData.length,
                  itemBuilder: (context, index) {
                    final data = listData[index];

                    return Container(
                      child: Card(
                        color: Theme.of(context).canvasColor,
                        child: Column(
                          children: [
                            Text(
                              data.name!,
                              style: TextStyle(
                                fontFamily: 'DancingScript',
                                fontWeight: FontWeight.w900,
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(height: 50),
                            Row(
                              children: [
                                const Text(
                                  'Money to pay:    ',
                                  style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    '${data.moneyToPay.toString()} cfa',
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 25),
                            Row(
                              children: [
                                Text(
                                  'Last paid amount:    ',
                                  style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.cyan.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    '${data.moneyPaid.toString()} cfa',
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 25),
                            Row(
                              children: [
                                Text(
                                  'Remaining:    ',
                                  style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 20,
                                  ),
                                ),
                                data.remainder! == -1
                                    ? Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.red.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0,
                                                  1), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          data.moneyToPay.toString(),
                                          style: TextStyle(
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.w200,
                                            fontSize: 15,
                                          ),
                                        ),
                                      )
                                    : data.remainder == 0
                                        ? Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              data.remainder.toString(),
                                              style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.w200,
                                                fontSize: 15,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.red
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              data.remainder.toString(),
                                              style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.w200,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),

                                //data.remainder! > 0 && data.remainder! < data.moneyToPay! ?
                              ],
                            ),
                            SizedBox(height: 25),
                            const Text(
                              'Status:    ',
                              style: TextStyle(
                                fontFamily: 'DancingScript',
                                fontSize: 20,
                              ),
                            ),
                            data.remainder == 0
                                ? Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.green.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child:
                                        Text('Done paying for $chosenValue '),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.orange.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                        'Still has to pay for $chosenValue '),
                                  )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (snaps.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: Text('No Payment added yet'),
              );
            }
          },
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Visibility november_listPayment() {
    return Visibility(
      visible: true,
      child: Expanded(
        child: FutureBuilder<List<NovemberModel>>(
          future: NovemberDb.db.getRawPayments(),
          builder:
              (BuildContext context, AsyncSnapshot<List<NovemberModel>> snaps) {
            if (snaps.hasData) {
              print("Getting november data");
              List<NovemberModel>? listData = snaps.data!;
              return Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .secondaryHeaderColor
                          .withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 9,
                      offset: Offset(0, 1),
                      // changes position of shadow
                    ),
                  ],
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listData.length,
                  itemBuilder: (context, index) {
                    final data = listData[index];

                    return Container(
                      child: Card(
                        color: Theme.of(context).canvasColor,
                        child: Column(
                          children: [
                            Text(
                              data.name!,
                              style: TextStyle(
                                fontFamily: 'DancingScript',
                                fontWeight: FontWeight.w900,
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(height: 50),
                            Row(
                              children: [
                                const Text(
                                  'Money to pay:    ',
                                  style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    '${data.moneyToPay.toString()} cfa',
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 25),
                            Row(
                              children: [
                                Text(
                                  'Last paid amount:    ',
                                  style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.cyan.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    '${data.moneyPaid.toString()} cfa',
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 25),
                            Row(
                              children: [
                                Text(
                                  'Remaining:    ',
                                  style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 20,
                                  ),
                                ),
                                data.remainder! == -1
                                    ? Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.red.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0,
                                                  1), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          data.moneyToPay.toString(),
                                          style: TextStyle(
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.w200,
                                            fontSize: 15,
                                          ),
                                        ),
                                      )
                                    : data.remainder == 0
                                        ? Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              data.remainder.toString(),
                                              style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.w200,
                                                fontSize: 15,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.red
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              data.remainder.toString(),
                                              style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.w200,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),

                                //data.remainder! > 0 && data.remainder! < data.moneyToPay! ?
                              ],
                            ),
                            SizedBox(height: 25),
                            const Text(
                              'Status:    ',
                              style: TextStyle(
                                fontFamily: 'DancingScript',
                                fontSize: 20,
                              ),
                            ),
                            data.remainder == 0
                                ? Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.green.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child:
                                        Text('Done paying for $chosenValue '),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.orange.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                        'Still has to pay for $chosenValue '),
                                  )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (snaps.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: Text('No Payment added yet'),
              );
            }
          },
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Visibility december_listPayment() {
    return Visibility(
      visible: true,
      child: Expanded(
        child: FutureBuilder<List<DecemberModel>>(
          future: DecemberDb.db.getRawPayments(),
          builder:
              (BuildContext context, AsyncSnapshot<List<DecemberModel>> snaps) {
            if (snaps.hasData) {
              print("Getting december data");
              List<DecemberModel>? listData = snaps.data!;
              return Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .secondaryHeaderColor
                          .withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 9,
                      offset: Offset(0, 1),
                      // changes position of shadow
                    ),
                  ],
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listData.length,
                  itemBuilder: (context, index) {
                    final data = listData[index];

                    return Container(
                      child: Card(
                        color: Theme.of(context).canvasColor,
                        child: Column(
                          children: [
                            Text(
                              data.name!,
                              style: TextStyle(
                                fontFamily: 'DancingScript',
                                fontWeight: FontWeight.w900,
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(height: 50),
                            Row(
                              children: [
                                const Text(
                                  'Money to pay:    ',
                                  style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    data.moneyToPay.toString(),
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 25),
                            Row(
                              children: [
                                Text(
                                  'Last paid amount:    ',
                                  style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 20,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.cyan.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    '${data.moneyPaid.toString()} cfa',
                                    style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 25),
                            Row(
                              children: [
                                Text(
                                  'Remaining:    ',
                                  style: TextStyle(
                                    fontFamily: 'DancingScript',
                                    fontSize: 20,
                                  ),
                                ),
                                data.remainder! == -1
                                    ? Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.red.withOpacity(0.5),
                                              spreadRadius: 5,
                                              blurRadius: 7,
                                              offset: Offset(0,
                                                  1), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          data.moneyToPay.toString(),
                                          style: TextStyle(
                                            fontFamily: 'Raleway',
                                            fontWeight: FontWeight.w200,
                                            fontSize: 15,
                                          ),
                                        ),
                                      )
                                    : data.remainder == 0
                                        ? Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              data.remainder.toString(),
                                              style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.w200,
                                                fontSize: 15,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.red
                                                      .withOpacity(0.5),
                                                  spreadRadius: 5,
                                                  blurRadius: 7,
                                                  offset: Offset(0,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              data.remainder.toString(),
                                              style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontWeight: FontWeight.w200,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),

                                //data.remainder! > 0 && data.remainder! < data.moneyToPay! ?
                              ],
                            ),
                            SizedBox(height: 25),
                            const Text(
                              'Status:    ',
                              style: TextStyle(
                                fontFamily: 'DancingScript',
                                fontSize: 20,
                              ),
                            ),
                            data.remainder == 0
                                ? Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.green.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child:
                                        Text('Done paying for $chosenValue '),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.orange.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(0,
                                              1), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Text(
                                        'Still has to pay for $chosenValue '),
                                  )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (snaps.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: Text('No Payment added yet'),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List monthly'),
      ),
      body: Column(
        children: [
          Visibility(
            visible: false,
            child: Expanded(
              child: FutureBuilder<List<AprilModel>>(
                future: AprilDb.db.getRawPayments(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<AprilModel>> snaps) {
                  if (snaps.hasData) {
                    print("Getting April data");
                    List<AprilModel>? aprilListData = snaps.data!;
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context)
                                .secondaryHeaderColor
                                .withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 9,
                            offset: Offset(0, 1),
                            // changes position of shadow
                          ),
                        ],
                      ),
                      child: Card(
                        color: Colors.yellow,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: aprilListData.length,
                          itemBuilder: (context, index) {
                            final aprilData = aprilListData[index];

                            return Container(
                              height: 2,
                              width: 50,
                              child: Card(
                                color: Colors.red,
                                child: Container(child: Text("data")),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  } else if (snaps.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Center(
                      child: Text('No Tenants added yet'),
                    );
                  }
                },
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              child: DropdownButton(
                //dropdownColor: Colors.grey,
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 35,

                isExpanded: true,
                hint: Text('Select the Month'),
                value: chosenValue,
                onChanged: (newVal) {
                  switch (newVal) {
                    case "january":
                      setState(() {
                        condition = 1;
                      });

                      break;
                    case "february":
                      setState(() {
                        condition = 2;
                      });

                      break;
                    case "march":
                      setState(() {
                        condition = 3;
                      });
                      break;
                    case "april":
                      setState(() {
                        condition = 4;
                      });
                      break;
                    case "may":
                      setState(() {
                        condition = 5;
                      });
                      break;
                    case "june":
                      setState(() {
                        condition = 5;
                      });
                      break;
                    case "july":
                      break;
                    case "august":
                      break;
                    case "september":
                      break;
                    case "october":
                      break;
                    case "november":
                      break;
                    case "december":
                      break;
                    default:
                      chosenValue = "Pick a month";
                      break;
                  }
                  setState(() {
                    chosenValue = newVal as String?;
                  });
                  setState(() {});
                },
                items: listMonth.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  );
                }).toList(),
              ),
            ),
          ),
          Container(
            child: _renderWidget(),
          ),
        ],
      ),
    );
  }
}
