// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:landlord_tracking/db_helper.dart';
// import 'package:landlord_tracking/models/renters.dart';
// import 'package:landlord_tracking/widgets/Pages/addRenters_page.dart';

// class AddEditRenterPage extends StatefulWidget {
//   final Renter? renter;

//   const AddEditRenterPage({Key? key, this.renter}) : super(key: key);

//   @override
//   _AddEditRenterPageState createState() => _AddEditRenterPageState();
// }

// class _AddEditRenterPageState extends State<AddEditRenterPage> {
//   final _formKey = GlobalKey<FormState>();
//   late String FirstName;
//   late String LastName;
//   late double Amount;
//   late DateTime date;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();

//     FirstName = widget.renter?.FirstName ?? '';
//     Amount = widget.renter?.Amount ?? 0.0;
//     LastName = widget.renter?.LastName ?? '';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [buldButton()],
//       ),
//       body: Form(key: _formKey, child: RenterFormWidget()),
//     );
//   }

//   void addOrUpdate() async {
//     final isValid = _formKey.currentState!.validate();

//     if (isValid) {
//       final isUpdating = widget.renter != null;

//       if (isUpdating) {
//         await updateRenter();
//       } else {
//         await addRenter();
//       }

//       Navigator.of(context).pop();
//     }
//   }

//   Future updateRenter() async {
//     final renter = widget.renter!.copy(
//       FirstName: FirstName,
//       LastName: LastName,
//       Amount: Amount,
//       date: date,
//     );
//     await RenterDatabase.instance.update(renter);
//   }

//   Future addRenter() async {
//     final renter = Renter(
//       FirstName: FirstName,
//       LastName: LastName,
//       Amount: Amount,
//       date: DateTime.now(),
//     );

//     await RenterDatabase.instance.create(renter);
//   }
// }
