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

  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final amountController = TextEditingController();
  final phoneController = TextEditingController();
  final dateSelectedController = TextEditingController();
  DateTime? selectedDat;

  Renter? renterList;
  int count = 0;

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
        selectedDat = pickedDate;
      });
    });
  }

  SingleChildScrollView addTenantForm(
    BuildContext context,
    FocusScopeNode currentFocus,
    TextEditingController firstNController,
    TextEditingController lastNController,
    TextEditingController amtController,
    TextEditingController dateSelectedController,
    TextEditingController phoneController,
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
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'First Name'),
                        controller: firstNController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.contains(RegExp(r'[0-9]')) ||
                              value.contains(RegExp('&,(,),\$,*,^,+,²,|,'))) {
                            return 'Please make sure to enter a valid First name';
                          }
                          return null;
                        },
                        // focusNode: firstNameFocus,
                      ),
                    ],
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Last Name'),
                  controller: lastNController,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.contains(RegExp(r'[0-9]')) ||
                        value.contains(RegExp('&,(,),\$,*,^,+,²,|,'))) {
                      return 'Please make sure to enter a valid Last name';
                    }
                    return null;
                  },
                  // focusNode: firstNameFocus,
                ),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(labelText: 'Monthly Loan Amount'),
                  controller: amtController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.contains(RegExp(r'[A-Z]'))) {
                      return 'Please enter correct phone number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(labelText: 'Phone number'),
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.contains(RegExp(r'[A-Z]'))) {
                      return 'Please enter correct phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  //date sele
                  //ction

                  children: [
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
                      width: 9,
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
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(
                          () {
                            selectedDat = null;
                            firstNController.clear();
                            lastNController.clear();
                            amtController.clear();
                            phoneController.clear();
                          },
                        );
                        // once submitted, pop the most opened screen and load addrenter()
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) {
                              return DisplayRenters();
                            },
                          ),
                        );
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
                            selectDate!.toString(),
                            null,
                            0,
                            null,
                            00,
                            int.parse(phoneController.text),
                          ),
                        );
                        setState(() {
                          _formKey.currentState!.validate();

                          selectedDat = null;
                          firstNController.clear();
                          lastNController.clear();
                          amtController.clear();
                          phoneController.clear();
                        });
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) {
                            return DisplayRenters();
                          }),
                        );

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
                    )
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
      body: addTenantForm(
        context,
        currentFocus,
        firstNameController,
        lastNameController,
        amountController,
        dateSelectedController,
        phoneController,
        selectedDat,
      ),
    );
  }

  // ignore: non_constant_identifier_names

}
