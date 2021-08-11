import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:landlord_tracking/helpers/monthHelpers/aprilHelper.dart';
import 'package:landlord_tracking/helpers/monthly_payment_dbHelper.dart';
import 'package:landlord_tracking/helpers/tenants_db_helper.dart';
import 'package:landlord_tracking/models/monthModels/aprilModel.dart';
import 'package:landlord_tracking/models/monthModels/augustModel.dart';
import 'package:landlord_tracking/models/monthPayment.dart';
import 'package:landlord_tracking/models/tenants.dart';
import 'package:landlord_tracking/widgets/Pages/addRenters_page.dart';
import '../../helpers/monthHelpers/aprilHelper.dart';
import '../../helpers/monthHelpers/augustHelper.dart';

import '../dialogs.dart';

enum SlidableAction { Edit, Delete }
bool tappedOnTenantConfirm = false;

class DisplayRenters extends StatefulWidget {
  @override
  _DisplayRentersState createState() => _DisplayRentersState();
}

class _DisplayRentersState extends State<DisplayRenters> {
  late List<Renter> renters;

  bool isLoading = false;
  late final Function(SlidableAction action) onDismissed;

  final firstNController = TextEditingController();
  final lastNController = TextEditingController();
  final amtController = TextEditingController();
  final phoneController = TextEditingController();
  static DateTime? selectedDate;

  void showDatepicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime(2021),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  //for getting data from monthDb
  List<AprilModel> aprilListData = [];
  List<AugustModel> augustListData = [];

  AprilModel? aprilData;
  AugustModel? augustData;
  int? aprId;
  int? aprMoneypaid;
  String? aprName;
  int? aprComplete;

  bool changeDateclicked = false;
  void showBottomSheetEditTenant(
    BuildContext ctx,
    Renter tenant,
    FocusScopeNode currentFocus,
  ) {
    showModalBottomSheet(
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
                    onSubmitted: (_) => {
                      !currentFocus.hasPrimaryFocus
                          ? currentFocus.unfocus()
                          : currentFocus.hasFocus
                    },
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
                            showDatepicker(),
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
                          setState(() {
                            firstNController.clear();
                            lastNController.clear();
                            amtController.clear();
                            phoneController.clear();
                          });
                          Navigator.of(context).pop();
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
                          setState(() {
                            firstNController.clear();
                            lastNController.clear();
                            amtController.clear();
                            phoneController.clear();
                          });
                          Navigator.of(context).pop();

                          FocusScopeNode currentFocus = FocusScope.of(context);
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('list of tenants'),
      ),
      backgroundColor: Theme.of(context).canvasColor,
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Renter>>(
              future: RenterDatabase.db.getRenters(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Renter>> snapshot) {
                if (snapshot.hasData) {
                  List<Renter>? tenants = snapshot.data;
                  return Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 12,
                    ),
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
                    height: 400,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: tenants!.length,
                      itemBuilder: (context, index) {
                        final tenant = tenants[index];
                        //to load new page when user taps item
                        return listOfTenants(context, tenant, tenants, index);
                      },
                    ),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
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
          //Get Records from Months table
          //-->April
          Expanded(
            child: FutureBuilder<List<AprilModel>>(
                future: AprilDb.db.getRawPayments(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<AprilModel>> snaps) {
                  if (snaps.hasData) {
                    List<AprilModel> aprilListData = snaps.data!;
                    return Container(
                      height: 1,
                      width: 1,
                      child: ListView.builder(
                        itemCount: aprilListData.length,
                        itemBuilder: (context, index) {
                          AprilModel aprilData = aprilListData[index];
                          aprId = aprilData.idapril;
                          aprMoneypaid = aprilData.moneyPaid;
                          aprName = aprilData.nameapr;
                          aprComplete = aprilData.completedPayement;
                          return Center();
                        },
                      ),
                    );
                  } else {
                    return Center();
                  }
                }),
          ),

          //-->August
          Expanded(
            child: FutureBuilder<List<AugustModel>>(
                future: AugustDb.db.getRawPayments(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<AugustModel>> snaps) {
                  if (snaps.hasData) {
                    augustListData = snaps.data!;
                    return Container(
                        height: 1,
                        width: 1,
                        child: ListView.builder(
                          itemCount: augustListData.length,
                          itemBuilder: (context, index) {
                            augustData = augustListData[index];
                            return SizedBox();
                          },
                        ));
                  } else {
                    return Center();
                  }
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) {
                return AddRenter();
              },
            ),
          );
        },
      ),
    );
  }

  Widget listOfTenants(
    BuildContext context,
    Renter tenant,
    List<Renter> tenants,
    int index,
  ) {
    return SizedBox(
      child: InkWell(
        onTap: () {
          tappedOnTenantConfirm = true;
          aprilData = new AprilModel(
            idapril: 2,
            nameapr: "name",
            moneyPaid: 1500,
            completedPayement: 1,
            moneyToPay: 5000,
          );

          AprilDb.db.insert(
            new AprilModel(
              idapril: 1,
              nameapr: "e",
              moneyPaid: 12003,
              completedPayement: 1,
              moneyToPay: 30000,
            ),
          );

          Navigator.of(context).pushNamed(
            '/tenants-page',
            arguments: {
              'id': tenant.id,
              'name1': tenant.LastName,
              'name2': tenant.FirstName,
              'toPay': tenant.toPayAmount,
              'registeredDate': tenant.date,
              'payedDate': tenant.payedDate,
              'newPayment': tenant.newPayment,
              'newPayMonth': tenant.newPayMonth,
              'monthRemainder': tenant.monthlyRemainder,
              'phoneNumber': tenant.PhoneNumber,

              //April
              'aprilTenantid2': aprId,
              'aprilMoneyPaid': aprMoneypaid,
              'aprilTenantName': aprName,
              'aprilCompletePaid': aprComplete,

              //August
              // 'augustTenantid2': augustData.id,
              // 'augustMoneyPaid': augustData.moneyPaid,
              // 'augustTenantName': augustData.name,
              // 'augustCompletePaid': augustData.completedPayement,
            },
          );
        },
        //how to know it corresponds to a specific data & ID
        splashColor: Theme.of(context).secondaryHeaderColor,
        child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          secondaryActions: [
            IconSlideAction(
              caption: 'Edit',
              color: Colors.blue,
              icon: Icons.edit,
              onTap: () {
                firstNController.text = tenant.FirstName!;
                lastNController.text = tenant.LastName!;
                amtController.text = tenant.toPayAmount.toString();
                phoneController.text = tenant.PhoneNumber.toString();
                selectedDate = DateTime.parse(tenant.date!);
                FocusScopeNode currentFocus = FocusScope.of(context);
                showBottomSheetEditTenant(context, tenant, currentFocus);
              },
            ),
            IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () async {
                  final action = await Dialogs.yesCancelDialog(
                    context,
                    'Confirmation',
                    'Do you really want to delete tenant: \n name: _${tenant.FirstName}_ \n id: _${tenant.id}_ ?',
                  );
                  if (action == DialogAction.yes) {
                    RenterDatabase.db.delete(tenant.id!).then(
                          (_) => setState(() {
                            tenants.removeAt(index);
                          }),
                        );
                  }
                }),
            IconSlideAction(
              caption: 'Close',
              color: Colors.cyan,
              icon: Icons.cancel,
              onTap: () {
                //print(toPay);
              },
            ),
          ],
          // actionExtentRatio: 1 / 5,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      // decoration: BoxDecoration(boxShadow: ),
                      child: Text(
                        '${tenant.FirstName!} ${tenant.LastName!}: ',
                        style: TextStyle(
                            fontFamily: 'RobotoCondensed',
                            fontSize: 22,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Text(
                        '${tenant.toPayAmount.toString()}',
                        style: TextStyle(
                            fontFamily: 'RobotoCondensed',
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).secondaryHeaderColor),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 10,
                  thickness: 2,
                  indent: 10,
                  endIndent: 20,
                ),
                SizedBox(
                  height: 8,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          '   Last Pay: ',
                          style: TextStyle(
                            fontFamily: 'DancingScript',
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          tenant.payedDate != null
                              ? '${DateFormat.yMMMMEEEEd().format(DateTime.parse(tenant.payedDate!))}'
                              : '${DateFormat.yMMMMEEEEd().format(DateTime.parse(tenant.date!))}',
                          style: TextStyle(
                              fontFamily: 'RobotoCondensed',
                              fontSize: 18,
                              fontWeight: FontWeight.w200,
                              color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    Row(
                      children: [
                        Text(
                          '   Remaining:   ',
                          style: TextStyle(
                            fontFamily: 'DancingScript',
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ), //change the remaining by implementing the adding a payment part
                        ),
                        tenant.monthlyRemainder! > 0 &&
                                tenant.monthlyRemainder! < tenant.toPayAmount!
                            ? Container(
                                child: Text(
                                  tenant.monthlyRemainder == 00
                                      ? tenant.toPayAmount.toString()
                                      : tenant.monthlyRemainder.toString(),
                                  style: TextStyle(
                                    fontFamily: 'RobotoCondensed',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.red.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 1), // changes position of shadow
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                child: Text(
                                  '${tenant.monthlyRemainder == 00 ? tenant.toPayAmount.toString() : tenant.monthlyRemainder.toString()} cfa',
                                  style: TextStyle(
                                    fontFamily: 'RobotoCondensed',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.green.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 1), // changes position of shadow
                                    ),
                                  ],
                                ),
                              ),
                      ],
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
}
