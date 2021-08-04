import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:landlord_tracking/helpers/tenants_db_helper.dart';

import 'package:landlord_tracking/widgets/Pages/displayrenters.dart';
import '../../models/tenants.dart';

class AddRenter extends StatefulWidget {
  @override
  _AddRenterState createState() => _AddRenterState();

  // ignore: non_constant_identifier_names
}

class _AddRenterState extends State<AddRenter> {
  //RenterDatabase? databaseHelper;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final amountController = TextEditingController();
  final dateSelectedController = TextEditingController();
  DateTime? selectedDat;

  Renter? renterList;
  int count = 0;

  // ignore: non_constant_identifier_names
  void ShowDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.red,
          fontFamily: 'DancingScript',
          fontSize: 21,
          fontWeight: FontWeight.w400,
        ),
      ),
      content: Text(message),
    );
    showDialog(
      barrierColor: Color.fromRGBO(234, 43, 134, 0.1),
      context: context,
      builder: (_) => alertDialog,
    );
  }

  void submitData() {
    final enteredFname = firstNameController.text;
    final enteredLname = lastNameController.text;
    final enteredAmount = amountController.text;
    if (enteredFname.isEmpty || enteredLname.isEmpty)
      return ShowDialog('Unfilled data',
          'Please, make sure to fill Last name and First Name');
    if (enteredAmount.toLowerCase().contains(RegExp(r'[A-Z]'), 1)) {
      return ShowDialog('Invalid Amount', 'The amount should be a number');
    }
    if (selectedDat == null) {
      return ShowDialog('Unable to get the date', 'Please, select a date');
    }
  }

  void showDatepicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime(2020),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDat = pickedDate;
      });
    });
  }

  SingleChildScrollView AddTenantForm(
    BuildContext context,
    FocusScopeNode currentFocus,
    TextEditingController firstNController,
    TextEditingController lastNController,
    TextEditingController amtController,
    TextEditingController dateSelectedController,
    DateTime? selectDate,
  ) {
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Card(
          elevation: 5,
          color: Colors.white,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'First Name'),
                  controller: firstNController,
                  keyboardType: TextInputType.name,
                  // focusNode: firstNameFocus,
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Last Name'),
                  controller: lastNController,
                  keyboardType: TextInputType.name,
                  // focusNode: firstNameFocus,
                ),
                TextField(
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(labelText: 'Monthly Loan Amount'),
                  controller: amtController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => {
                    !currentFocus.hasPrimaryFocus
                        ? currentFocus.unfocus()
                        : currentFocus.hasFocus
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  //date selection
                  children: [
                    // TextField(
                    //   controller: dateSelectedController,
                    //   enabled: false,
                    // ),
                    // selectDate == null ?
                    //   dateSelectedController.text  = "No date selected!!" : DateFormat.yMEd().format(selectDate),

                    Text(
                      selectDate == null
                          ? 'No date selected!!'
                          : DateFormat.yMEd().format(selectDate),
                      style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      onPressed: () => showDatepicker(),
                      child: Text(selectDate == null
                          ? 'Pick a date'
                          : 'Change the date'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        selectDate = null;
                        //selectDate!.toIso8601String();

                        setState(() {
                          firstNController.clear();
                          lastNController.clear();
                          amtController.clear();
                          selectDate = null;
                        });
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) {
                          return AddRenter();
                        }));
                      },
                      child: const Text(
                        'Cancel   ',
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
                      width: 60,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        //print(DateTime.now());
                        RenterDatabase.db.insert(
                          new Renter(
                            firstNController.text,
                            lastNController.text,
                            int.parse(amtController.text),
                            selectDate.toString(),
                          ),
                        );
                        selectDate = null;
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) {
                            return AddRenter();
                          }),
                        );
                        setState(() {
                          firstNController.clear();
                          lastNController.clear();
                          amtController.clear();
                          selectDate = null;
                        });
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                      },
                      child: const Text(
                        'Save               ',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Tenant'),
      ),
      body: AddTenantForm(
          context,
          currentFocus,
          firstNameController,
          lastNameController,
          amountController,
          dateSelectedController,
          selectedDat),
    );
  }

  // ignore: non_constant_identifier_names

}
