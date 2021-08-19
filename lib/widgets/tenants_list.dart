// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:intl/intl.dart';
// import 'package:landlord_tracking/widgets/Pages/edit_tenant.dart';
// import '../models/monthModels/aprilModel.dart';
// import '../models/monthModels/augustModel.dart';
// import '../models/tenants.dart';
// import '../helpers/tenants_db_helper.dart';
// import 'dialogs.dart';

// class TenantsList extends StatefulWidget {
//   TenantsList({Key? key}) : super(key: key);

//   @override
//   _TenantsListState createState() => _TenantsListState();
// }

// class _TenantsListState extends State<TenantsList> {
//   static DateTime? selectedDate;

//   //for getting data from monthDb
//   List<AprilModel> aprilListData = [];
//   List<AugustModel> augustListData = [];

//   AprilModel? aprilData;
//   AugustModel? augustData;
//   int? aprId;
//   int? aprMoneypaid;
//   String? aprName;
//   int? aprComplete;

//   final firstNController = TextEditingController();
//   final lastNController = TextEditingController();
//   final amtController = TextEditingController();
//   final phoneController = TextEditingController();

//   void showDatepicker() {
//     showDatePicker(
//       context: context,
//       initialDate: DateTime(2021),
//       firstDate: DateTime(2021),
//       lastDate: DateTime.now(),
//     ).then((pickedDate) {
//       if (pickedDate == null) {
//         return;
//       }
//       setState(() {
//         selectedDate = pickedDate;
//       });
//     });
//   }

//   void showBottomSheetEditTenant(
//     BuildContext ctx,
//     Renter tenant,
//     FocusScopeNode currentFocus,
//     DateTime? selectDate,
//   ) {
//     showModalBottomSheet(
//         context: ctx,
//         builder: (_) {
//           return SingleChildScrollView(
//             child: Card(
//               elevation: 5,
//               color: Colors.white,
//               child: Container(
//                 height: 900,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     TextField(
//                       decoration: InputDecoration(labelText: 'First Name'),
//                       controller: firstNController,
//                       keyboardType: TextInputType.name,
//                     ),
//                     TextField(
//                       decoration: InputDecoration(labelText: 'Last Name'),
//                       controller: lastNController,
//                       keyboardType: TextInputType.name,
//                     ),
//                     TextField(
//                       textInputAction: TextInputAction.done,
//                       decoration:
//                           InputDecoration(labelText: 'Monthly Loan Amount'),
//                       controller: amtController,
//                       keyboardType: TextInputType.number,
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       //date selection
//                       children: [
//                         // ignore: deprecated_member_use
//                         RaisedButton(
//                           onPressed: () => showDatepicker(),
//                           child: Text(
//                             selectDate == null
//                                 ? 'Pick a date'
//                                 : 'Change the date',
//                             textAlign: TextAlign.center,
//                           ),
//                         ),

//                         SizedBox(
//                           width: 15,
//                         ),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         ElevatedButton(
//                           onPressed: () {
//                             selectedDate = null;
//                             setState(() {
//                               firstNController.clear();
//                               lastNController.clear();
//                               amtController.clear();
//                               phoneController.clear();
//                             });
//                             Navigator.of(context).pop();
//                           },
//                           child: const Text(
//                             'Cancel   ',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(fontWeight: FontWeight.w900),
//                           ),
//                           style: ElevatedButton.styleFrom(
//                             primary: Theme.of(context)
//                                 .secondaryHeaderColor
//                                 .withOpacity(0.6), // background
//                             onPrimary: Colors.black, // foreground
//                           ),
//                         ),
//                         SizedBox(
//                           width: 40,
//                         ),
//                         ElevatedButton(
//                           onPressed: () async {
//                             //print(DateTime.now());
//                             selectDate != null
//                                 ? RenterDatabase.db.update(
//                                     new Renter(
//                                       firstNController.text,
//                                       lastNController.text,
//                                       int.parse(amtController.text),
//                                       selectDate
//                                           .toString(), //return here to update for the new field
//                                       "",
//                                       0,
//                                       "",
//                                       0,
//                                       int.parse(phoneController.text),
//                                     ),
//                                     tenant.id!)
//                                 : RenterDatabase.db.update(
//                                     new Renter(
//                                       firstNController.text,
//                                       lastNController.text,
//                                       int.parse(amtController.text),
//                                       tenant.date
//                                           .toString(), //return here to update for the new field
//                                       "",
//                                       0,
//                                       "",
//                                       0,
//                                       int.parse(phoneController.text),
//                                     ),
//                                     tenant.id!);
//                             setState(() {
//                               firstNController.clear();
//                               lastNController.clear();
//                               amtController.clear();
//                               phoneController.clear();
//                             });
//                             Navigator.of(context).pop();

//                             FocusScopeNode currentFocus =
//                                 FocusScope.of(context);
//                             if (!currentFocus.hasPrimaryFocus) {
//                               currentFocus.unfocus();
//                             }
//                           },
//                           child: const Text(
//                             'Update               ',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(fontWeight: FontWeight.w900),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final ScrollController _scrollController = ScrollController();
//     return Expanded(
//       child: FutureBuilder<List<Renter>>(
//         future: RenterDatabase.db.getRenters(),
//         builder: (BuildContext context, AsyncSnapshot<List<Renter>> snapshot) {
//           if (snapshot.hasData) {
//             List<Renter>? tenants = snapshot.data;
//             return Container(
//               height: 400,
//               margin: EdgeInsets.symmetric(
//                 vertical: 12,
//               ),
//               decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                     color:
//                         Theme.of(context).secondaryHeaderColor.withOpacity(0.2),
//                     spreadRadius: 2,
//                     blurRadius: 9,
//                     offset: Offset(0, 1),
//                     // changes position of shadow
//                   ),
//                 ],
//               ),
//               padding: EdgeInsets.symmetric(vertical: 10),
//               child: Scrollbar(
//                 isAlwaysShown: true,
//                 showTrackOnHover: true,
//                 controller: _scrollController,
//                 child: ListView.builder(
//                   controller: _scrollController,
//                   physics: BouncingScrollPhysics(),
//                   itemCount: tenants!.length,
//                   itemBuilder: (context, index) {
//                     final tenant = tenants[index];
//                     //to load new page when user taps item
//                     return SizedBox(
//                       child: InkWell(
//                         onTap: () {
//                           Navigator.of(context).pushNamed(
//                             '/tenants-page',
//                             arguments: {
//                               'id': tenant.id,
//                               'name1': tenant.LastName,
//                               'name2': tenant.FirstName,
//                               'toPay': tenant.toPayAmount,
//                               'registeredDate': tenant.date,
//                               'payedDate': tenant.payedDate,
//                               'newPayment': tenant.newPayment,
//                               'newPayMonth': tenant.newPayMonth,
//                               'monthRemainder': tenant.completedPayment,
//                               'phoneNumber': tenant.PhoneNumber,

//                               //April
//                               'aprilTenantid2': aprId,
//                               'aprilMoneyPaid': aprMoneypaid,
//                               'aprilTenantName': aprName,
//                               'aprilCompletePaid': aprComplete,
//                             },
//                           );
//                         },
//                         //how to know it corresponds to a specific data & ID
//                         splashColor: Theme.of(context).secondaryHeaderColor,
//                         child: Slidable(
//                           actionPane: SlidableDrawerActionPane(),
//                           secondaryActions: [
//                             IconSlideAction(
//                               caption: 'Edit',
//                               color: Colors.blue,
//                               icon: Icons.edit,
//                               onTap: () {
//                                 firstNController.text = tenant.FirstName!;
//                                 lastNController.text = tenant.LastName!;
//                                 amtController.text =
//                                     tenant.toPayAmount.toString();
//                                 phoneController.text =
//                                     tenant.PhoneNumber.toString();
//                                 selectedDate = DateTime.parse(tenant.date!);
//                                 FocusScopeNode currentFocus =
//                                     FocusScope.of(context);
//                                 showBottomSheetEditTenant(
//                                   context,
//                                   tenant,
//                                   currentFocus,
//                                   selectedDate,
//                                 );

//                                 //look for method
//                               },
//                             ),
//                             IconSlideAction(
//                                 caption: 'Delete',
//                                 color: Colors.red,
//                                 icon: Icons.delete,
//                                 onTap: () async {
//                                   final action = await Dialogs.yesCancelDialog(
//                                     context,
//                                     'Confirmation',
//                                     'Do you really want to delete tenant: \n name: _${tenant.FirstName}_ \n id: _${tenant.id}_ ?',
//                                   );
//                                   if (action == DialogAction.yes) {
//                                     RenterDatabase.db.delete(tenant.id!).then(
//                                           (_) => setState(() {
//                                             tenants.removeAt(index);
//                                           }),
//                                         );
//                                   }
//                                 }),
//                             IconSlideAction(
//                               caption: 'Close',
//                               color: Colors.cyan,
//                               icon: Icons.cancel,
//                               onTap: () {
//                                 //print(toPay);
//                               },
//                             ),
//                           ],
//                           // actionExtentRatio: 1 / 5,
//                           child: Card(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15.0),
//                             ),
//                             child: Column(
//                               children: [
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Container(
//                                       margin:
//                                           EdgeInsets.symmetric(horizontal: 10),
//                                       // decoration: BoxDecoration(boxShadow: ),
//                                       child: Text(
//                                         '${tenant.FirstName!} ${tenant.LastName!}: ',
//                                         style: TextStyle(
//                                             fontFamily: 'RobotoCondensed',
//                                             fontSize: 22,
//                                             fontWeight: FontWeight.w900),
//                                       ),
//                                     ),
//                                     Container(
//                                       decoration: BoxDecoration(
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.grey.withOpacity(0.5),
//                                             spreadRadius: 5,
//                                             blurRadius: 7,
//                                             offset: Offset(0,
//                                                 3), // changes position of shadow
//                                           ),
//                                         ],
//                                       ),
//                                       child: Text(
//                                         '${tenant.toPayAmount.toString()}',
//                                         style: TextStyle(
//                                             fontFamily: 'RobotoCondensed',
//                                             fontSize: 15,
//                                             fontWeight: FontWeight.w700,
//                                             color: Theme.of(context)
//                                                 .secondaryHeaderColor),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 const Divider(
//                                   height: 10,
//                                   thickness: 2,
//                                   indent: 10,
//                                   endIndent: 20,
//                                 ),
//                                 SizedBox(
//                                   height: 8,
//                                 ),
//                                 Column(
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Text(
//                                           '   Last Pay: ',
//                                           style: TextStyle(
//                                             fontFamily: 'DancingScript',
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.w900,
//                                           ),
//                                         ),
//                                         Text(
//                                           tenant.payedDate != null
//                                               ? '${DateFormat.yMEd().format(DateTime.parse(tenant.payedDate!))}'
//                                               : '${DateFormat.yMMMMEEEEd().format(DateTime.parse(tenant.date!))}',
//                                           style: TextStyle(
//                                               fontFamily: 'RobotoCondensed',
//                                               fontSize: 18,
//                                               fontWeight: FontWeight.w200,
//                                               color: Theme.of(context)
//                                                   .primaryColor),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: 9,
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           '   Remaining:   ',
//                                           style: TextStyle(
//                                             fontFamily: 'DancingScript',
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.w900,
//                                           ), //change the remaining by implementing the adding a payment part
//                                         ),
//                                         tenant.monthlyRemainder! > 0 &&
//                                                 tenant.monthlyRemainder! <
//                                                     tenant.toPayAmount!
//                                             ? Container(
//                                                 child: Text(
//                                                   tenant.monthlyRemainder == 00
//                                                       ? tenant.toPayAmount
//                                                           .toString()
//                                                       : tenant.monthlyRemainder
//                                                           .toString(),
//                                                   style: TextStyle(
//                                                     fontFamily:
//                                                         'RobotoCondensed',
//                                                     fontSize: 14,
//                                                     fontWeight: FontWeight.w700,
//                                                   ),
//                                                 ),
//                                                 decoration: BoxDecoration(
//                                                   boxShadow: [
//                                                     BoxShadow(
//                                                       color: Colors.red
//                                                           .withOpacity(0.5),
//                                                       spreadRadius: 5,
//                                                       blurRadius: 7,
//                                                       offset: Offset(0,
//                                                           1), // changes position of shadow
//                                                     ),
//                                                   ],
//                                                 ),
//                                               )
//                                             : Container(
//                                                 child: Text(
//                                                   '${tenant.monthlyRemainder == 00 ? tenant.toPayAmount.toString() : tenant.monthlyRemainder.toString()} cfa',
//                                                   style: TextStyle(
//                                                     fontFamily:
//                                                         'RobotoCondensed',
//                                                     fontSize: 14,
//                                                     fontWeight: FontWeight.w700,
//                                                   ),
//                                                 ),
//                                                 decoration: BoxDecoration(
//                                                   boxShadow: [
//                                                     BoxShadow(
//                                                       color: Colors.green
//                                                           .withOpacity(0.5),
//                                                       spreadRadius: 5,
//                                                       blurRadius: 7,
//                                                       offset: Offset(0,
//                                                           1), // changes position of shadow
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             );
//           } else if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else {
//             return Center(
//               child: Text('No Tenants added yet'),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
