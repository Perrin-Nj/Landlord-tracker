import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:landlord_tracking/helpers/monthHelpers/aprilHelper.dart';

import 'package:landlord_tracking/helpers/tenants_db_helper.dart';
import 'package:landlord_tracking/models/monthModels/aprilModel.dart';

import 'package:landlord_tracking/models/tenants.dart';

import 'displayrenters.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final name1 = routeArgs['name1'];
    final name2 = routeArgs['name2'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('$name1 $name2'),
      ),
      body: SingleChildScrollView(
        child: const MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  DateTime? selectDate;
  String? chosenValue;
  void showDatepicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime(2021),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectDate = pickedDate;
      });
    });
  }

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

  void savePayment(
    int id,
    String name1,
    String name2,
    int toPay,
    String registeredDate,
    String payedDate,
    int newPayment,
    int payMonth,
    int remainder,
    int phone,
  ) {
    RenterDatabase.db.update(
        new Renter(
            name1,
            name2,
            toPay,
            registeredDate,
            selectDate!.toIso8601String(),
            newPayment,
            '$payMonth ',
            toPay - newPayment,
            phone),
        id);

    if (payMonth == 4) {
      AprilDb.db.insert(
        new AprilModel(
          idapril: id,
          nameapr: name1,
          moneyPaid: newPayment,
          completedPayement: 1,
          moneyToPay: toPay,
        ),
      );
    }
  }

  final newPayController = TextEditingController();
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  int? paymentMonth;
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final id = routeArgs['id'];
    final name1 = routeArgs['name1'];
    final name2 = routeArgs['name2'];
    final toPay = routeArgs['toPay'];
    final registeredDate = routeArgs['registeredDate'];
    final payedDate = routeArgs['payedDate'];
    final newPayment = routeArgs['newPayment'];
    final newPayMonth = routeArgs['newPayMonth'];
    final monthRemainder = routeArgs['monthRemainder'];
    final phone = routeArgs['phoneNumber'];

    //April
    final apriltenantid = routeArgs['aprilTenantid2'];

    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Card(
            color: Theme.of(context).cardColor,
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Remaining:',
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'DancingScript',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 15),
                    monthRemainder > 0 && monthRemainder < toPay
                        ? Container(
                            decoration: BoxDecoration(
                                color: Colors
                                    .red), //if the remaining is less or equal than 0, show green, else, show red... Use db
                            child: Text(
                              ' $monthRemainder',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'DancingScript',
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                color: Colors
                                    .green), //if the remaining is less or equal than 0, show green, else, show red... Use db
                            child: Text(
                              ' $monthRemainder',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'DancingScript',
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          )
                  ],
                ),

                Row(
                  children: [
                    Text(
                      'Last Pay:',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'DancingScript',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 15),
                    Text(
                      payedDate != null
                          ? '${DateFormat.yMMMMEEEEd().format(DateTime.parse(payedDate)).toString()}'
                          : '${DateFormat.yMMMMEEEEd().format(DateTime.parse(registeredDate)).toString()}',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'DancingScript',
                        fontWeight: FontWeight.w300,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Phone Number:',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'DancingScript',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 15),
                    Text(
                      phone.toString(),
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'DancingScript',
                        fontWeight: FontWeight.w300,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ), // //(if lastpay from dbPayments is null, then show no last pay, else, show a last pay)
              ],
            ),
          ),
          //come back here for last payments, should use db
          SizedBox(
            height: 60,
          ),
          Divider(
            color: Colors.green,
            indent: 12,
          ),
          Container(
            child: Text(
              'Add A New Payment',
              style: TextStyle(
                  backgroundColor: Theme.of(context).canvasColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Divider(
            color: Colors.green,
            indent: 12,
          ),
          Container(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white10, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton(
              //dropdownColor: Colors.grey,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 35,

              isExpanded: true,
              hint: Text('Select the Month'),
              value: chosenValue,
              onChanged: (newVal) {
                switch (chosenValue) {
                  case "january":
                    paymentMonth = 1;
                    break;
                  case "february":
                    paymentMonth = 2;
                    break;
                  case "march":
                    paymentMonth = 3;
                    break;
                  case "april":
                    paymentMonth = 4;
                    break;
                  case "may":
                    paymentMonth = 5;
                    break;
                  case "june":
                    paymentMonth = 6;
                    break;
                  case "july":
                    paymentMonth = 7;
                    break;
                  case "august":
                    paymentMonth = 8;
                    break;
                  case "september":
                    paymentMonth = 9;
                    break;
                  case "october":
                    paymentMonth = 10;
                    break;
                  case "november":
                    paymentMonth = 11;
                    break;
                  case "december":
                    paymentMonth = 12;
                    break;
                  default:
                    paymentMonth = 0;
                    chosenValue = "Pick a month";
                    break;
                }
                setState(() {
                  chosenValue = newVal as String?;
                });
              },
              items: listMonth.map((e) {
                return DropdownMenuItem(
                  value: e,
                  child: Text(e),
                );
              }).toList(),
            ),
          ),

          Card(
            color: Theme.of(context).canvasColor,
            elevation: 18,
            shadowColor: Theme.of(context).primaryColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: newPayController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'New Payment'),

                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a payment';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 34,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      Text(
                        selectDate == null
                            ? 'No date selected!!'
                            : DateFormat.yMEd().format(selectDate!),
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      // ignore: deprecated_member_use
                      RaisedButton(
                        onPressed: () => showDatepicker(),
                        child: Text(selectDate == null
                            ? 'pick date of payment'
                            : 'Change the date'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => DisplayRenters(),
                          ),
                        );
                        setState(() {
                          selectDate = null;
                          newPayController.text = "";
                        });
                      },
                      child: const Text(
                        'Cancel      ',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context)
                            .secondaryHeaderColor
                            .withOpacity(0.6), // background
                        onPrimary: Colors.black, // foreground
                      ),
                    ),
                    SizedBox(
                      width: 80,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          savePayment(
                            id,
                            name1,
                            name2,
                            toPay,
                            registeredDate,
                            selectDate!.toIso8601String(),
                            int.parse(newPayController.text),
                            paymentMonth!,
                            monthRemainder,
                            phone,
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.

                        }
                        setState(() {
                          newPayController.text = "";
                        });
                        selectDate =
                            null; //initialize this with a listener so that any change is directly reflected in the entire program
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => DisplayRenters(),
                          ),
                        );
                      },
                      child: const Text(
                        'Add Payment',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
