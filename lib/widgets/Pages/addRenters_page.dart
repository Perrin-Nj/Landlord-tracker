import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../helpers/monthHelpers/aprilHelper.dart';
import '../../helpers/monthHelpers/augustHelper.dart';
import '../../helpers/monthHelpers/decemberHelper.dart';
import '../../helpers/monthHelpers/februaryHelper.dart';
import '../../helpers/monthHelpers/januaryHelper.dart';
import '../../helpers/monthHelpers/julyHelper.dart';
import '../../helpers/monthHelpers/juneHelper%20.dart';
import '../../helpers/monthHelpers/marchHelper.dart';
import '../../helpers/monthHelpers/mayHelper.dart';
import '../../helpers/monthHelpers/novemberHelper.dart';
import '../../helpers/monthHelpers/octoberHelper.dart';
import '../../helpers/monthHelpers/septemberHelper.dart';
import '../../helpers/tenants_db_helper.dart';

import '../../models/monthModels/aprilModel.dart';
import '../../models/monthModels/augustModel.dart';
import '../../models/monthModels/decemberModel.dart';
import '../../models/monthModels/februaryModel.dart';
import '../../models/monthModels/januaryModel.dart';
import '../../models/monthModels/julyModel.dart';
import '../../models/monthModels/juneModel%20.dart';
import '../../models/monthModels/marchModel.dart';
import '../../models/monthModels/mayModel.dart';
import '../../models/monthModels/novemberModel.dart';
import '../../models/monthModels/octoberModel.dart';
import '../../models/monthModels/septemberModel.dart';
import '../../models/tenants.dart';

import '../../widgets/Pages/displayrenters.dart';

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
      initialDate: DateTime.now(),
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
                          if (value == null) {
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
                    if (value == null) {
                      return 'Please make sure to enter a valid Last name';
                    }
                    return null;
                  },
                  // focusNode: firstNameFocus,
                ),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  decoration:
                      InputDecoration(labelText: 'Monthly Loan Amount (cfa)'),
                  controller: amtController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null) {
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
                    if (value == null) {
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
                        // JanuaryDb.db.delete(1);
                        // JanuaryDb.db.delete(2);
                        // JanuaryDb.db.delete(3);
                        // JanuaryDb.db.delete(4);
                        // JanuaryDb.db.delete(5);
                        // JanuaryDb.db.delete(6);
                        // JanuaryDb.db.delete(7);

                        // FebruaryDb.db.delete(1);
                        // FebruaryDb.db.delete(2);
                        // FebruaryDb.db.delete(3);
                        // FebruaryDb.db.delete(4);
                        // FebruaryDb.db.delete(5);
                        // FebruaryDb.db.delete(6);
                        // FebruaryDb.db.delete(7);

                        // MarchDb.db.delete(1);
                        // MarchDb.db.delete(2);
                        // MarchDb.db.delete(3);
                        // MarchDb.db.delete(4);
                        // MarchDb.db.delete(5);
                        // MarchDb.db.delete(6);
                        // MarchDb.db.delete(7);

                        // AprilDb.db.delete(1);
                        // AprilDb.db.delete(2);
                        // AprilDb.db.delete(3);
                        // AprilDb.db.delete(4);
                        // AprilDb.db.delete(5);
                        // AprilDb.db.delete(6);
                        // AprilDb.db.delete(7);

                        // AprilDb.db.delete(1);
                        // MayDb.db.delete(2);
                        // MayDb.db.delete(3);
                        // MayDb.db.delete(4);
                        // MayDb.db.delete(5);
                        // MayDb.db.delete(6);
                        // MayDb.db.delete(7);

                        // JuneDb.db.delete(1);
                        // JuneDb.db.delete(2);
                        // JuneDb.db.delete(3);
                        // JuneDb.db.delete(4);
                        // JuneDb.db.delete(5);
                        // JuneDb.db.delete(6);
                        // JuneDb.db.delete(7);

                        // JulyDb.db.delete(1);
                        // JulyDb.db.delete(2);
                        // JulyDb.db.delete(3);
                        // JulyDb.db.delete(4);
                        // JulyDb.db.delete(5);
                        // JulyDb.db.delete(6);
                        // JulyDb.db.delete(7);

                        // AugustDb.db.delete(1);
                        // AugustDb.db.delete(2);
                        // AugustDb.db.delete(3);
                        // AugustDb.db.delete(4);
                        // AugustDb.db.delete(5);
                        // AugustDb.db.delete(6);
                        // AugustDb.db.delete(7);

                        // SeptemberDb.db.delete(1);
                        // SeptemberDb.db.delete(2);
                        // SeptemberDb.db.delete(3);
                        // SeptemberDb.db.delete(4);
                        // SeptemberDb.db.delete(5);
                        // SeptemberDb.db.delete(6);
                        // SeptemberDb.db.delete(7);

                        // OctoberDb.db.delete(1);
                        // OctoberDb.db.delete(2);
                        // OctoberDb.db.delete(3);
                        // OctoberDb.db.delete(4);
                        // OctoberDb.db.delete(5);
                        // OctoberDb.db.delete(6);
                        // OctoberDb.db.delete(7);

                        // NovemberDb.db.delete(1);
                        // NovemberDb.db.delete(2);
                        // NovemberDb.db.delete(3);
                        // NovemberDb.db.delete(4);
                        // NovemberDb.db.delete(5);
                        // NovemberDb.db.delete(6);
                        // NovemberDb.db.delete(7);

                        // DecemberDb.db.delete(1);
                        // DecemberDb.db.delete(2);
                        // DecemberDb.db.delete(3);
                        // DecemberDb.db.delete(4);
                        // DecemberDb.db.delete(5);
                        // DecemberDb.db.delete(6);
                        // DecemberDb.db.delete(7);

                        RenterDatabase.db.insert(
                          new Renter(
                            firstNController.text,
                            lastNController.text,
                            int.parse(amtController.text),
                            selectDate!.toString(), //Entry date
                            null,
                            0,
                            null,
                            0,
                            int.parse(phoneController.text),
                          ),
                        );

                        AprilDb.db.insert(
                          new AprilModel(
                              nameapr: lastNameController.text,
                              moneyPaid: 0,
                              completedPayement: 0,
                              moneyToPay: int.parse(amtController.text),
                              remainder: -1),
                        );
                        AugustDb.db.insert(
                          new AugustModel(
                              name: firstNameController.text,
                              moneyPaid: 0,
                              completedPayement: 0,
                              moneyToPay: int.parse(amtController.text),
                              remainder: -1),
                        );

                        DecemberDb.db.insert(
                          new DecemberModel(
                              name: firstNameController.text,
                              moneyPaid: 0,
                              moneyToPay: int.parse(amtController.text),
                              completedPayement: 0,
                              remainder: -1),
                        );

                        FebruaryDb.db.insert(
                          new FebruaryModel(
                              name: firstNameController.text,
                              moneyPaid: 0,
                              moneyToPay: int.parse(amtController.text),
                              completedPayement: 0,
                              remainder: -1),
                        );
                        JanuaryDb.db.insert(
                          new JanuaryModel(
                              name: firstNameController.text,
                              moneyPaid: 0,
                              moneyToPay: int.parse(amtController.text),
                              completedPayement: 0,
                              remainder: -1),
                        );

                        JulyDb.db.insert(
                          new JulyModel(
                              name: firstNameController.text,
                              moneyToPay: int.parse(amtController.text),
                              moneyPaid: 0,
                              completedPayement: 0,
                              remainder: -1),
                        );

                        JuneDb.db.insert(
                          new JuneModel(
                              name: firstNameController.text,
                              moneyToPay: int.parse(amtController.text),
                              moneyPaid: 0,
                              completedPayement: 0,
                              remainder: -1),
                        );

                        MarchDb.db.insert(
                          new MarchModel(
                              name: firstNameController.text,
                              moneyPaid: 0,
                              moneyToPay: int.parse(amtController.text),
                              completedPayement: 0,
                              remainder: -1),
                        );

                        MayDb.db.insert(
                          new MayModel(
                              name: firstNameController.text,
                              moneyPaid: 0,
                              moneyToPay: int.parse(amtController.text),
                              completedPayement: 0,
                              remainder: -1),
                        );

                        NovemberDb.db.insert(
                          new NovemberModel(
                              name: firstNameController.text,
                              moneyPaid: 0,
                              moneyToPay: int.parse(amtController.text),
                              completedPayement: 0,
                              remainder: -1),
                        );

                        OctoberDb.db.insert(
                          new OctoberModel(
                            name: firstNameController.text,
                            moneyPaid: 0,
                            moneyToPay: int.parse(amtController.text),
                            completedPayement: 0,
                            remainder: -1,
                          ),
                        );

                        SeptemberDb.db.insert(
                          new SeptemberModel(
                              name: firstNameController.text,
                              moneyPaid: 0,
                              moneyToPay: int.parse(amtController.text),
                              completedPayement: 0,
                              remainder: -1),
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
