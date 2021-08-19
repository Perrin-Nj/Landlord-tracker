import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:landlord_tracking/helpers/monthHelpers/aprilHelper.dart';
import 'package:landlord_tracking/helpers/monthHelpers/decemberHelper.dart';
import 'package:landlord_tracking/helpers/monthHelpers/februaryHelper.dart';
import 'package:landlord_tracking/helpers/monthHelpers/januaryHelper.dart';
import 'package:landlord_tracking/helpers/monthHelpers/julyHelper.dart';
import 'package:landlord_tracking/helpers/monthHelpers/juneHelper%20.dart';
import 'package:landlord_tracking/helpers/monthHelpers/marchHelper.dart';
import 'package:landlord_tracking/helpers/monthHelpers/mayHelper.dart';
import 'package:landlord_tracking/helpers/monthHelpers/novemberHelper.dart';
import 'package:landlord_tracking/helpers/monthHelpers/octoberHelper.dart';
import 'package:landlord_tracking/helpers/monthHelpers/septemberHelper.dart';

import 'package:landlord_tracking/helpers/tenants_db_helper.dart';
import 'package:landlord_tracking/models/monthModels/aprilModel.dart';
import 'package:landlord_tracking/models/monthModels/decemberModel.dart';
import 'package:landlord_tracking/models/monthModels/februaryModel.dart';
import 'package:landlord_tracking/models/monthModels/januaryModel.dart';
import 'package:landlord_tracking/models/monthModels/julyModel.dart';
import 'package:landlord_tracking/models/monthModels/juneModel%20.dart';
import 'package:landlord_tracking/models/monthModels/marchModel.dart';
import 'package:landlord_tracking/models/monthModels/mayModel.dart';
import 'package:landlord_tracking/models/monthModels/novemberModel.dart';
import 'package:landlord_tracking/models/monthModels/octoberModel.dart';
import 'package:landlord_tracking/models/monthModels/septemberModel.dart';

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
    final routeArg =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final registeredDate = routeArg['registeredDate'];
    final payedDate = routeArg['payedDate'];
    final phone = routeArg['phoneNumber'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('$name1 $name2'),
      ),
      body: Column(
        children: [
          Card(
            color: Theme.of(context).cardColor,
            child: Column(
              children: [
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
                    const Text(
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
          const MyCustomForm(),
        ],
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
    int phone,
    int aprilRemainder,
    int augustRemainder,
    int decrem,
    int febrem,
    int janrem,
    int julrem,
    int junrem,
    int marrem,
    int mayrem,
    int novrem,
    int octrem,
    int seprem,
    List<bool> listOfCompletionPay,
  ) {
    //switching for completion of payment
    switch (chosenValue) {
      case "april":
        AprilDb.db.update(
            new AprilModel(
              nameapr: name1,
              moneyPaid: newPayment,
              completedPayement:
                  toPay - newPayment == 0 || aprilRemainder - newPayment == 0
                      ? 1
                      : 0,
              moneyToPay: toPay,
              remainder: aprilRemainder == -1
                  ? toPay - newPayment
                  : aprilRemainder - newPayment,
            ),
            id);
        if (toPay - newPayment == 0 || aprilRemainder - newPayment == 0) {
          listOfCompletionPay[3] = true;
        }
        break;
      case "january":
        JanuaryDb.db.update(
            new JanuaryModel(
              name: name1,
              moneyPaid: newPayment,
              completedPayement:
                  toPay - newPayment == 0 || janrem - newPayment == 0 ? 1 : 0,
              moneyToPay: toPay,
              remainder:
                  janrem == -1 ? toPay - newPayment : janrem - newPayment,
            ),
            id);
        if (toPay - newPayment == 0 || janrem - newPayment == 0) {
          listOfCompletionPay[0] = true;
        }
        break;
      case "february":
        FebruaryDb.db.update(
            new FebruaryModel(
              name: name1,
              moneyPaid: newPayment,
              completedPayement:
                  toPay - newPayment == 0 || febrem - newPayment == 0 ? 1 : 0,
              moneyToPay: toPay,
              remainder:
                  febrem == -1 ? toPay - newPayment : febrem - newPayment,
            ),
            id);
        if (toPay - newPayment == 0 || febrem - newPayment == 0) {
          listOfCompletionPay[1] = true;
        }
        break;
      case "march":
        MarchDb.db.update(
            new MarchModel(
              name: name1,
              moneyPaid: newPayment,
              completedPayement:
                  toPay - newPayment == 0 || marrem - newPayment == 0 ? 1 : 0,
              moneyToPay: toPay,
              remainder:
                  marrem == -1 ? toPay - newPayment : marrem - newPayment,
            ),
            id);
        if (toPay - newPayment == 0 || marrem - newPayment == 0) {
          listOfCompletionPay[2] = true;
        }
        break;
      case "may":
        MayDb.db.update(
            new MayModel(
              name: name1,
              moneyPaid: newPayment,
              completedPayement:
                  toPay - newPayment == 0 || mayrem - newPayment == 0 ? 1 : 0,
              moneyToPay: toPay,
              remainder:
                  mayrem == -1 ? toPay - newPayment : mayrem - newPayment,
            ),
            id);
        if (toPay - newPayment == 0 || mayrem - newPayment == 0) {
          listOfCompletionPay[4] = true;
        }
        break;
      case "june":
        JuneDb.db.update(
            new JuneModel(
              name: name1,
              moneyPaid: newPayment,
              completedPayement:
                  toPay - newPayment == 0 || junrem - newPayment == 0 ? 1 : 0,
              moneyToPay: toPay,
              remainder:
                  junrem == -1 ? toPay - newPayment : junrem - newPayment,
            ),
            id);
        if (toPay - newPayment == 0 || junrem - newPayment == 0) {
          listOfCompletionPay[5] = true;
        }
        break;
      case "july":
        JulyDb.db.update(
            new JulyModel(
              name: name1,
              moneyPaid: newPayment,
              completedPayement:
                  toPay - newPayment == 0 || julrem - newPayment == 0 ? 1 : 0,
              moneyToPay: toPay,
              remainder:
                  julrem == -1 ? toPay - newPayment : julrem - newPayment,
            ),
            id);
        if (toPay - newPayment == 0 || julrem - newPayment == 0) {
          listOfCompletionPay[6] = true;
        }
        break;
      case "august":
        JuneDb.db.update(
            new JuneModel(
              name: name1,
              moneyPaid: newPayment,
              completedPayement:
                  toPay - newPayment == 0 || augustRemainder - newPayment == 0
                      ? 1
                      : 0,
              moneyToPay: toPay,
              remainder: augustRemainder == -1
                  ? toPay - newPayment
                  : augustRemainder - newPayment,
            ),
            id);
        if (toPay - newPayment == 0 || augustRemainder - newPayment == 0) {
          listOfCompletionPay[7] = true;
        }
        break;
      case "november":
        NovemberDb.db.update(
            new NovemberModel(
              name: name1,
              moneyPaid: newPayment,
              completedPayement:
                  toPay - newPayment == 0 || novrem - newPayment == 0 ? 1 : 0,
              moneyToPay: toPay,
              remainder:
                  novrem == -1 ? toPay - newPayment : novrem - newPayment,
            ),
            id);
        if (toPay - newPayment == 0 || novrem - newPayment == 0) {
          listOfCompletionPay[10] = true;
        }
        break;
      case "october":
        OctoberDb.db.update(
            new OctoberModel(
              name: name1,
              moneyPaid: newPayment,
              completedPayement:
                  toPay - newPayment == 0 || octrem - newPayment == 0 ? 1 : 0,
              moneyToPay: toPay,
              remainder:
                  octrem == -1 ? toPay - newPayment : octrem - newPayment,
            ),
            id);
        if (toPay - newPayment == 0 || octrem - newPayment == 0) {
          listOfCompletionPay[9] = true;
        }
        break;
      case "september":
        SeptemberDb.db.update(
            new SeptemberModel(
              name: name1,
              moneyPaid: newPayment,
              completedPayement:
                  toPay - newPayment == 0 || seprem - newPayment == 0 ? 1 : 0,
              moneyToPay: toPay,
              remainder:
                  seprem == -1 ? toPay - newPayment : seprem - newPayment,
            ),
            id);
        if (toPay - newPayment == 0 || seprem - newPayment == 0) {
          listOfCompletionPay[8] = true;
        }
        break;
      case "december":
        DecemberDb.db.update(
            new DecemberModel(
              name: name1,
              moneyPaid: newPayment,
              completedPayement:
                  toPay - newPayment == 0 || decrem - newPayment == 0 ? 1 : 0,
              moneyToPay: toPay,
              remainder:
                  decrem == -1 ? toPay - newPayment : decrem - newPayment,
            ),
            id);
        if (toPay - newPayment == 0 || decrem - newPayment == 0) {
          listOfCompletionPay[11] = true;
        }
        break;
      default:
        break;
    }
    RenterDatabase.db.update(
      new Renter(
          name1,
          name2,
          toPay,
          registeredDate,
          selectDate!.toIso8601String(),
          newPayment,
          chosenValue,
          listOfCompletionPay[0] == true &&
                  listOfCompletionPay[1] == true &&
                  listOfCompletionPay[2] == true &&
                  listOfCompletionPay[3] == true &&
                  listOfCompletionPay[4] == true &&
                  listOfCompletionPay[5] == true &&
                  listOfCompletionPay[6] == true &&
                  listOfCompletionPay[7] == true &&
                  listOfCompletionPay[8] == true &&
                  listOfCompletionPay[9] == true &&
                  listOfCompletionPay[10] == true &&
                  listOfCompletionPay[11] == true
              ? 1
              : 0,
          phone),
      id,
    );
  }

  final newPayController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final id = routeArgs['id'];
    final name1 = routeArgs['name1'];
    final name2 = routeArgs['name2'];
    final toPay = routeArgs['toPay'];
    final registeredDate = routeArgs['registeredDate'];

    final phone = routeArgs['phoneNumber'];

    //April
    final aprilRemainder = routeArgs['aprRemainder'];
    //august
    final augustRemainder = routeArgs['augRemainder'];
    //dec
    final decrem = routeArgs['decRemainder'];
    //feb
    final febrem = routeArgs['febRemainder'];
    //jan
    final janrem = routeArgs['janRemainder'];
    //jul
    final julrem = routeArgs['julRemainder'];
    //jun
    final junrem = routeArgs['junRemainder'];
    //mar
    final marrem = routeArgs['marRemainder'];
    //may
    final mayrem = routeArgs['mayRemainder'];
    //nov
    final novrem = routeArgs['novRemainder'];
    //oct
    final octrem = routeArgs['octRemainder'];
    //sep
    final seprem = routeArgs['sepRemainder'];

    List<bool> listOfCompletionPay = [];
    for (int i = 0; i < 13; i++) {
      listOfCompletionPay.add(false);
    }

    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        children: [
          //put month selection...

          //come back here for last payments, should use db
          SizedBox(
            height: 8,
          ),
          Divider(
            color: Colors.green,
            indent: 12,
            height: 12,
            thickness: 8,
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
            height: 12,
            thickness: 8,
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
                            phone,
                            aprilRemainder,
                            augustRemainder,
                            decrem,
                            febrem,
                            janrem,
                            julrem,
                            junrem,
                            marrem,
                            mayrem,
                            novrem,
                            octrem,
                            seprem,
                            listOfCompletionPay,
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
