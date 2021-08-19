import 'package:flutter/material.dart';

import '../../helpers/tenants_db_helper.dart';
import '../../models/tenants.dart';

Widget showBottomSheetEditTenant(
  BuildContext ctx,
  Renter tenant,
  TextEditingController firstNController,
  TextEditingController lastNController,
  TextEditingController amtController,
  TextEditingController phoneController,
  DateTime? selectedDate,
  Function? setState,
  Function? showdatepicker,
) {
  return showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return SingleChildScrollView(
          child: Card(
            elevation: 5,
            color: Colors.white,
            child: Container(
              height: 900,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'First Name'),
                    controller: firstNController,
                    keyboardType: TextInputType.name,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Last Name'),
                    controller: lastNController,
                    keyboardType: TextInputType.name,
                  ),
                  TextField(
                    textInputAction: TextInputAction.done,
                    decoration:
                        InputDecoration(labelText: 'Monthly Loan Amount'),
                    controller: amtController,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //date selection
                    children: [
                      // ignore: deprecated_member_use
                      RaisedButton(
                        onPressed: () =>
                            // to set the selected date to the screen...
                            showdatepicker,
                        child: Text(
                          'Change the date',
                          textAlign: TextAlign.center,
                        ),
                      ),

                      SizedBox(
                        width: 15,
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
                          selectedDate = null;
                          setState!(() {
                            firstNController.clear();
                            lastNController.clear();
                            amtController.clear();
                            phoneController.clear();
                          });
                          Navigator.of(ctx).pop();
                        },
                        child: const Text(
                          'Cancel   ',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w900),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(ctx)
                              .secondaryHeaderColor
                              .withOpacity(0.6), // background
                          onPrimary: Colors.black, // foreground
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          //print(DateTime.now());
                          RenterDatabase.db.update(
                              new Renter(
                                firstNController.text,
                                lastNController.text,
                                int.parse(amtController.text),
                                selectedDate!
                                    .toIso8601String(), //return here to update for the new field
                                "",
                                0,
                                "",
                                0,
                                int.parse(phoneController.text),
                              ),
                              tenant.id!);
                          selectedDate = null;
                          setState!(() {
                            firstNController.clear();
                            lastNController.clear();
                            amtController.clear();
                            phoneController.clear();
                          });
                          Navigator.of(ctx).pop();

                          FocusScopeNode currentFocus = FocusScope.of(ctx);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                        },
                        child: const Text(
                          'Update               ',
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
        );
      }) as Widget;
}
