import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
import 'package:landlord_tracking/models/monthModels/augustModel.dart';
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
import 'package:landlord_tracking/widgets/Pages/addRenters_page.dart';
import 'package:landlord_tracking/widgets/multiMenuItems_ListTenants.dart';
import 'package:landlord_tracking/widgets/singleMenuItem_ListTenants.dart';
import '../../helpers/monthHelpers/aprilHelper.dart';
import '../../helpers/monthHelpers/augustHelper.dart';

import '../dialogs.dart';
import 'Monthly_listofPayment.dart';

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

//April
  int? aprId;
  int? aprMoneypaid;
  int? aprRemain;
  String? aprName;
  int? aprComplete;

//August
  int? augId;
  int? augMoneypaid;
  int? augRemain;
  String? augName;
  int? augComplete;

//dec
  int? decId;
  int? decMoneypaid;
  int? decRemain;
  String? decName;
  int? decComplete;

//feb
  int? febId;
  int? febMoneypaid;
  int? febRemain;
  String? febName;
  int? febComplete;

//jan
  int? janId;
  int? janMoneypaid;
  int? janRemain;
  String? janName;
  int? janComplete;

//jul
  int? julId;
  int? julMoneypaid;
  int? julRemain;
  String? julName;
  int? julComplete;

//jun
  int? junId;
  int? junMoneypaid;
  int? junRemain;
  String? junName;
  int? junComplete;

//mar
  int? marId;
  int? marMoneypaid;
  int? marRemain;
  String? marName;
  int? marComplete;

//may
  int? mayId;
  int? mayMoneypaid;
  int? mayRemain;
  String? mayName;
  int? mayComplete;

//nov
  int? novId;
  int? novMoneypaid;
  int? novRemain;
  String? novName;
  int? novComplete;

//oct
  int? octId;
  int? octMoneypaid;
  int? octRemain;
  String? octName;
  int? octComplete;

//sep
  int? sepId;
  int? sepMoneypaid;
  int? sepRemain;
  String? sepName;
  int? sepComplete;

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

  PopupMenuItem<SingleMenuItem> buildItem(SingleMenuItem item) => PopupMenuItem(
      value: item,
      child: Row(
        children: [
          Icon(item.icon, color: Colors.black, size: 20),
          const SizedBox(width: 12),
          Text(
            item.text,
          ),
        ],
      ));
  void onSelected(BuildContext context, SingleMenuItem item) {
    switch (item) {
      case MenuItems.itemMonthdisplay:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => MonthlyDisplay()));
        break;
      // case MenuItems.itemSearch:
      //   SearchTapped = true;
      //   break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // final route =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // final listOfCompletionPay = route['ListPaymentCompletion'];

    final ScrollController _scrollController = ScrollController();
    return Scaffold(
      appBar: AppBar(
        title: Text('list of tenants'),
        actions: [
          PopupMenuButton<SingleMenuItem>(
              onSelected: (item) => onSelected(context, item),
              itemBuilder: (context) => [
                    ...MenuItems.items.map((buildItem)).toList(),
                  ]),
        ],
      ),
      backgroundColor: Theme.of(context).canvasColor,
      body: Column(
        children: [
          Expanded(
            flex: 120,
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
                    child: Scrollbar(
                      isAlwaysShown: true,
                      showTrackOnHover: true,
                      controller: _scrollController,
                      child: ListView.builder(
                        controller: _scrollController,
                        physics: BouncingScrollPhysics(),
                        itemCount: tenants!.length,
                        itemBuilder: (context, index) {
                          final tenant = tenants[index];
                          //to load new page when user taps item
                          return listOfTenants(
                            context,
                            tenant,
                            tenants,
                            index,
                          );
                        },
                      ),
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
          SizedBox(height: 80),
          //-->April

//---------------------------------------------------------------------------------------------
          Visibility(
            visible: true,
            child: Expanded(
              flex: -10,
              child: FutureBuilder<List<AprilModel>>(
                  future: AprilDb.db.getRawPayments(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<AprilModel>> snaps) {
                    if (snaps.hasData) {
                      List<AprilModel> listData = snaps.data!;
                      return Container(
                        alignment: Alignment.bottomRight,
                        height: 0,
                        width: 0,
                        child: ListView.builder(
                          itemCount: listData.length,
                          itemBuilder: (context, index) {
                            AprilModel data = listData[index];
                            aprId = data.idapril;
                            aprMoneypaid = data.moneyPaid;
                            aprName = data.nameapr;
                            aprComplete = data.completedPayement;
                            aprRemain = data.remainder;
                            return Container(
                              height: 0,
                              width: 0,
                            );
                          },
                        ),
                      );
                    } else {
                      return Container(
                        height: 0,
                        width: 0,
                      );
                    }
                  }),
            ),
          ),

          //-->August
          Visibility(
            visible: true,
            child: Expanded(
              flex: -10,
              child: FutureBuilder<List<AugustModel>>(
                  future: AugustDb.db.getRawPayments(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<AugustModel>> snaps) {
                    if (snaps.hasData) {
                      List<AugustModel> listData = snaps.data!;
                      return Container(
                        alignment: Alignment.bottomRight,
                        height: 0,
                        width: 0,
                        child: ListView.builder(
                          itemCount: listData.length,
                          itemBuilder: (context, index) {
                            AugustModel data = listData[index];
                            augId = data.id;
                            augMoneypaid = data.moneyPaid;
                            augName = data.name;
                            augComplete = data.completedPayement;
                            augRemain = data.remainder;
                            return Container(
                              height: 0,
                              width: 0,
                            );
                          },
                        ),
                      );
                    } else {
                      return Container(
                        height: 0,
                        width: 0,
                      );
                    }
                  }),
            ),
          ),

          //-->dec
          Visibility(
            visible: true,
            child: Expanded(
              flex: -10,
              child: FutureBuilder<List<DecemberModel>>(
                  future: DecemberDb.db.getRawPayments(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<DecemberModel>> snaps) {
                    if (snaps.hasData) {
                      List<DecemberModel> listData = snaps.data!;
                      return Container(
                        alignment: Alignment.bottomRight,
                        height: 0,
                        width: 0,
                        child: ListView.builder(
                          itemCount: listData.length,
                          itemBuilder: (context, index) {
                            DecemberModel data = listData[index];
                            decId = data.id;
                            decMoneypaid = data.moneyPaid;
                            decName = data.name;
                            decComplete = data.completedPayement;
                            decRemain = data.remainder;
                            return Container(
                              height: 0,
                              width: 0,
                            );
                          },
                        ),
                      );
                    } else {
                      return Container(
                        height: 0,
                        width: 0,
                      );
                    }
                  }),
            ),
          ),
          Visibility(
            visible: true,
            child: Expanded(
              flex: -10,
              child: FutureBuilder<List<FebruaryModel>>(
                  future: FebruaryDb.db.getRawPayments(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<FebruaryModel>> snaps) {
                    if (snaps.hasData) {
                      List<FebruaryModel> listData = snaps.data!;
                      return Container(
                        alignment: Alignment.bottomRight,
                        height: 0,
                        width: 0,
                        child: ListView.builder(
                          itemCount: listData.length,
                          itemBuilder: (context, index) {
                            FebruaryModel data = listData[index];
                            febId = data.id;
                            febMoneypaid = data.moneyPaid;
                            febName = data.name;
                            febComplete = data.completedPayement;
                            febRemain = data.remainder;
                            return Container(
                              height: 0,
                              width: 0,
                            );
                          },
                        ),
                      );
                    } else {
                      return Container(
                        height: 0,
                        width: 0,
                      );
                    }
                  }),
            ),
          ),
          Visibility(
            visible: true,
            child: Expanded(
              flex: -10,
              child: FutureBuilder<List<JanuaryModel>>(
                  future: JanuaryDb.db.getRawPayments(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<JanuaryModel>> snaps) {
                    if (snaps.hasData) {
                      List<JanuaryModel> listData = snaps.data!;
                      return Container(
                        alignment: Alignment.bottomRight,
                        height: 0,
                        width: 0,
                        child: ListView.builder(
                          itemCount: listData.length,
                          itemBuilder: (context, index) {
                            JanuaryModel data = listData[index];
                            janId = data.id;
                            janMoneypaid = data.moneyPaid;
                            janName = data.name;
                            janComplete = data.completedPayement;
                            janRemain = data.remainder;
                            return Container(
                              height: 0,
                              width: 0,
                            );
                          },
                        ),
                      );
                    } else {
                      return Container(
                        height: 0,
                        width: 0,
                      );
                    }
                  }),
            ),
          ),
          Visibility(
            visible: true,
            child: Expanded(
              flex: -10,
              child: FutureBuilder<List<JulyModel>>(
                  future: JulyDb.db.getRawPayments(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<JulyModel>> snaps) {
                    if (snaps.hasData) {
                      List<JulyModel> listData = snaps.data!;
                      return Container(
                        alignment: Alignment.bottomRight,
                        height: 0,
                        width: 0,
                        child: ListView.builder(
                          itemCount: listData.length,
                          itemBuilder: (context, index) {
                            JulyModel data = listData[index];
                            julId = data.id;
                            julMoneypaid = data.moneyPaid;
                            julName = data.name;
                            julComplete = data.completedPayement;
                            julRemain = data.remainder;
                            return Container(
                              height: 0,
                              width: 0,
                            );
                          },
                        ),
                      );
                    } else {
                      return Container(
                        height: 0,
                        width: 0,
                      );
                    }
                  }),
            ),
          ),

          Visibility(
            visible: true,
            child: Expanded(
              flex: -10,
              child: FutureBuilder<List<JuneModel>>(
                  future: JuneDb.db.getRawPayments(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<JuneModel>> snaps) {
                    if (snaps.hasData) {
                      List<JuneModel> listData = snaps.data!;
                      return Container(
                        alignment: Alignment.bottomRight,
                        height: 0,
                        width: 0,
                        child: ListView.builder(
                          itemCount: listData.length,
                          itemBuilder: (context, index) {
                            JuneModel data = listData[index];
                            junId = data.id;
                            junMoneypaid = data.moneyPaid;
                            junName = data.name;
                            junComplete = data.completedPayement;
                            junRemain = data.remainder;
                            return Container(
                              height: 0,
                              width: 0,
                            );
                          },
                        ),
                      );
                    } else {
                      return Container(
                        height: 0,
                        width: 0,
                      );
                    }
                  }),
            ),
          ),
          Visibility(
            visible: true,
            child: Expanded(
              flex: -10,
              child: FutureBuilder<List<MarchModel>>(
                  future: MarchDb.db.getRawPayments(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<MarchModel>> snaps) {
                    if (snaps.hasData) {
                      List<MarchModel> listData = snaps.data!;
                      return Container(
                        alignment: Alignment.bottomRight,
                        height: 0,
                        width: 0,
                        child: ListView.builder(
                          itemCount: listData.length,
                          itemBuilder: (context, index) {
                            MarchModel data = listData[index];
                            marId = data.id;
                            marMoneypaid = data.moneyPaid;
                            marName = data.name;
                            marComplete = data.completedPayement;
                            marRemain = data.remainder;
                            return Container(
                              height: 0,
                              width: 0,
                            );
                          },
                        ),
                      );
                    } else {
                      return Container(
                        height: 0,
                        width: 0,
                      );
                    }
                  }),
            ),
          ),
          Visibility(
            visible: true,
            child: Expanded(
              flex: -10,
              child: FutureBuilder<List<MayModel>>(
                  future: MayDb.db.getRawPayments(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<MayModel>> snaps) {
                    if (snaps.hasData) {
                      List<MayModel> listData = snaps.data!;
                      return Container(
                        alignment: Alignment.bottomRight,
                        height: 0,
                        width: 0,
                        child: ListView.builder(
                          itemCount: listData.length,
                          itemBuilder: (context, index) {
                            MayModel data = listData[index];
                            mayId = data.id;
                            mayMoneypaid = data.moneyPaid;
                            mayName = data.name;
                            mayComplete = data.completedPayement;
                            mayRemain = data.remainder;
                            return Container(
                              height: 0,
                              width: 0,
                            );
                          },
                        ),
                      );
                    } else {
                      return Container(
                        height: 0,
                        width: 0,
                      );
                    }
                  }),
            ),
          ),
          Visibility(
            visible: true,
            child: Expanded(
              flex: -10,
              child: FutureBuilder<List<NovemberModel>>(
                  future: NovemberDb.db.getRawPayments(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<NovemberModel>> snaps) {
                    if (snaps.hasData) {
                      List<NovemberModel> listData = snaps.data!;
                      return Container(
                        alignment: Alignment.bottomRight,
                        height: 0,
                        width: 0,
                        child: ListView.builder(
                          itemCount: listData.length,
                          itemBuilder: (context, index) {
                            NovemberModel data = listData[index];
                            novId = data.id;
                            novMoneypaid = data.moneyPaid;
                            novName = data.name;
                            novComplete = data.completedPayement;
                            novRemain = data.remainder;
                            return Container(
                              height: 0,
                              width: 0,
                            );
                          },
                        ),
                      );
                    } else {
                      return Container(
                        height: 0,
                        width: 0,
                      );
                    }
                  }),
            ),
          ),
          Visibility(
            visible: true,
            child: Expanded(
              flex: -10,
              child: FutureBuilder<List<OctoberModel>>(
                  future: OctoberDb.db.getRawPayments(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<OctoberModel>> snaps) {
                    if (snaps.hasData) {
                      List<OctoberModel> listData = snaps.data!;
                      return Container(
                        alignment: Alignment.bottomRight,
                        height: 0,
                        width: 0,
                        child: ListView.builder(
                          itemCount: listData.length,
                          itemBuilder: (context, index) {
                            OctoberModel data = listData[index];
                            octId = data.id;
                            octMoneypaid = data.moneyPaid;
                            octName = data.name;
                            octComplete = data.completedPayement;
                            octRemain = data.remainder;
                            return Container(
                              height: 0,
                              width: 0,
                            );
                          },
                        ),
                      );
                    } else {
                      return Container(
                        height: 0,
                        width: 0,
                      );
                    }
                  }),
            ),
          ),
          Visibility(
            visible: true,
            child: Expanded(
              flex: -10,
              child: FutureBuilder<List<SeptemberModel>>(
                  future: SeptemberDb.db.getRawPayments(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<SeptemberModel>> snaps) {
                    if (snaps.hasData) {
                      List<SeptemberModel> listData = snaps.data!;
                      return Container(
                        alignment: Alignment.bottomRight,
                        height: 0,
                        width: 0,
                        child: ListView.builder(
                          itemCount: listData.length,
                          itemBuilder: (context, index) {
                            SeptemberModel data = listData[index];
                            sepId = data.id;
                            sepMoneypaid = data.moneyPaid;
                            sepName = data.name;
                            sepComplete = data.completedPayement;
                            sepRemain = data.remainder;
                            return Container(
                              height: 0,
                              width: 0,
                            );
                          },
                        ),
                      );
                    } else {
                      return Container(
                        height: 0,
                        width: 0,
                      );
                    }
                  }),
            ),
          ),
        ],
        //---------------------------------------------------------------------------------------------GETTING DATA FROM DIFFERENT TABLES----------------------------------------------------------------------------------
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
              'phoneNumber': tenant.PhoneNumber,

              //April
              'aprilTenantid2': aprId,
              'aprilMoneyPaid': aprMoneypaid,
              'aprilTenantName': aprName,
              'aprilCompletePaid': aprComplete,
              'aprRemainder': aprRemain,

              //august
              'augTenantid2': augId,
              'augMoneyPaid': augMoneypaid,
              'augTenantName': augName,
              'augCompletePaid': augComplete,
              'augRemainder': augRemain,

              //dec
              'decTenantid2': decId,
              'decMoneyPaid': decMoneypaid,
              'decTenantName': decName,
              'decCompletePaid': decComplete,
              'decRemainder': decRemain,

              //feb
              'febTenantid2': febId,
              'febMoneyPaid': febMoneypaid,
              'febTenantName': febName,
              'febCompletePaid': febComplete,
              'febRemainder': febRemain,

              //jan
              'janTenantid2': janId,
              'janMoneyPaid': janMoneypaid,
              'janTenantName': janName,
              'janCompletePaid': janComplete,
              'janRemainder': janRemain,

              //jul
              'julTenantid2': julId,
              'julMoneyPaid': julMoneypaid,
              'julTenantName': julName,
              'julCompletePaid': julComplete,
              'julRemainder': julRemain,

              //jun
              'junTenantid2': junId,
              'junMoneyPaid': junMoneypaid,
              'junTenantName': junName,
              'junCompletePaid': junComplete,
              'junRemainder': junRemain,

              //mar
              'marTenantid2': marId,
              'marMoneyPaid': marMoneypaid,
              'marTenantName': marName,
              'marCompletePaid': marComplete,
              'marRemainder': marRemain,

              //may
              'mayTenantid2': mayId,
              'mayMoneyPaid': mayMoneypaid,
              'mayTenantName': mayName,
              'mayCompletePaid': mayComplete,
              'mayRemainder': mayRemain,

              //nov
              'novTenantid2': novId,
              'novMoneyPaid': novMoneypaid,
              'novTenantName': novName,
              'novCompletePaid': novComplete,
              'novRemainder': novRemain,

              //oct
              'octTenantid2': octId,
              'octMoneyPaid': octMoneypaid,
              'octTenantName': octName,
              'octCompletePaid': octComplete,
              'octRemainder': octRemain,

              //sep
              'sepTenantid2': sepId,
              'sepMoneyPaid': sepMoneypaid,
              'sepTenantName': sepName,
              'sepCompletePaid': sepComplete,
              'sepRemainder': sepRemain,
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
//  tenant.monthlyRemainder! > 0 &&
//                                 tenant.monthlyRemainder! < tenant.toPayAmount!
//                             ? Container(
//                                 child: Text(
//                                   tenant.monthlyRemainder == -1
//                                       ? tenant.toPayAmount.toString()
//                                       : tenant.monthlyRemainder.toString(),
//                                   style: TextStyle(
//                                     fontFamily: 'RobotoCondensed',
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                 ),
//                                 decoration: BoxDecoration(
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.red.withOpacity(0.5),
//                                       spreadRadius: 5,
//                                       blurRadius: 7,
//                                       offset: Offset(
//                                           0, 1), // changes position of shadow
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             : Container(
//                                 child: Text(
//                                   '${tenant.monthlyRemainder == -1 ? tenant.toPayAmount.toString() : tenant.monthlyRemainder.toString()} cfa',
//                                   style: TextStyle(
//                                     fontFamily: 'RobotoCondensed',
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w700,
//                                   ),
//                                 ),
//                                 decoration: BoxDecoration(
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.green.withOpacity(0.5),
//                                       spreadRadius: 5,
//                                       blurRadius: 7,
//                                       offset: Offset(
//                                           0, 1), // changes position of shadow
//                                     ),
//                                   ],
//                                 ),
//                               ),
