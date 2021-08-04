import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:landlord_tracking/helpers/monthly_payment_dbHelper.dart';
import 'package:landlord_tracking/models/monthPayment.dart';
import 'package:landlord_tracking/models/payment.dart';

import '../../helpers/payment_db_helper.dart';
import '../../helpers/tenants_db_helper.dart';
import '../../models/tenants.dart';
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
    final name = routeArgs['name'];
    final toPay = routeArgs['toPay'];
    final registeredDate = routeArgs['registeredDate'];

    return Scaffold(
      appBar: AppBar(
        title: Text('$name'),
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

  void showDatepicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime(2020),
      firstDate: DateTime(2016),
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

  String? chosenValue;
  int? paymentMonth;
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
      String name, int toPayAmount, String payedDate, int newPayment) {
    PaymentDb.db.insert(new Payment(name, toPayAmount, payedDate, newPayment));
    //we design a dropdownButton to let the user select the month for wich he is paying = newPayMonth

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
        break;
    }

    MonthPaydb.db.insert(
      new MonthlyPayment(
          name, paymentMonth, newPayment, (toPayAmount - newPayment)),
    );
    if (toPayAmount - newPayment > 0) {
      //still have to pay; show a popUp msg asking if he wants to pay again...
    } else if (toPayAmount - newPayment < 0) {
      //extra payment, show error msg
    } else {
      //payment just completed, nothing more for the month;
    }
    //substract addPayment to the remaining payment in the DB;
  }

  final newPayController = TextEditingController();
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final name = routeArgs['name'];
    //final id = routeArgs['id'];
    final int toPay = routeArgs['toPay'];
    //final registeredDate = routeArgs['registeredDate'];

    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Card(
            child: Text(
                'Remaining: $toPay \n Last Pay: (if lastpay from dbPayments is null, then show no last pay, else, show a last pay)'),
          ), //come back here for last payments
          Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Text('Month Picker, for what month are you paying?'),
                Container(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: DropdownButton(
                    //dropdownColor: Colors.grey,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 35,

                    isExpanded: true,
                    hint: Text('Select the Month'),
                    value: chosenValue,
                    onChanged: (newVal) {
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
              ],
            ),
          ),
          SizedBox(
            height: 100, //  change position of card 'addPayment on the screen';
          ),
          Card(
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
                        selectDate = null;
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => DisplayRenters(),
                          ),
                        );
                        setState(() {
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
                            name,
                            toPay,
                            selectDate.toString(),
                            int.parse(newPayController.text),
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
//  return TableCalendar(
//       focusedDay: DateTime.now(),
//       firstDay: DateTime(2021, 1, 1),
//       lastDay: DateTime(2021, 12, 31),
//       headerVisible: false,
//       calendarFormat: CalendarFormat.month,
//     )