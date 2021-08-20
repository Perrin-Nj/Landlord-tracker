//@dart=2.13

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../widgets/Pages/payment_page.dart';
import 'helpers/tenants_db_helper.dart';
import 'models/tenants.dart';
import 'widgets/bottom_navbar_menu.dart';
import 'widgets/navigation_drawer_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LandLord Tracking',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.blue,
        secondaryHeaderColor: Colors.cyan,
        // ignore: deprecated_member_use
        cursorColor: Colors.limeAccent,
        // ignore: deprecated_member_use
        textSelectionColor: Colors.orangeAccent,
        canvasColor:
            Color.fromRGBO(220, 255, 255, 1), //fromRGBO(220, 255, 255, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              // ignore: deprecated_member_use
              body1: TextStyle(
                color: Color.fromRGBO(98, 100, 103, 1),
              ),
              // ignore: deprecated_member_use
              body2: TextStyle(
                color: Color.fromRGBO(100, 91, 103, 1),
              ),
              // ignore: deprecated_member_use
              title: TextStyle(
                fontSize: 15,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      home: Scaffold(
        body: BottomNavBarMenu(),
      ),
      routes: {
        '/tenants-page': (ctx) => PaymentPage(),
      },
    );

    //);
    //
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();

  //On tapped on bottom nav bar icons
  final columns = [
    'First Name',
    'Last Name',
    'Amount paid (cfa)',
    'Date of previous Payment'
  ];
  List<DataColumn> getColumns(List<String> columns) => columns
      .map((e) => DataColumn(
            label: Text(e),
          ))
      .toList();

  List<DataRow> getRows(List<Renter> tenants) => tenants.map((e) {
        var cells = [];
        e.payedDate != null
            ? cells = [
                e.FirstName,
                e.LastName,
                e.newPayment,
                DateFormat.yMMMMEEEEd().format(DateTime.parse(e.payedDate!))
              ]
            : cells = [
                e.FirstName,
                e.LastName,
                e.newPayment,
                'No payment yet',
              ];
        return DataRow(cells: getCells(cells));
      }).toList();
  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((e) => DataCell(Text('$e '))).toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: AppBar(
          centerTitle: true,
          title: Text(
            'HOMEPAGE',
            style: TextStyle(
              color: Theme.of(context).canvasColor,
              fontFamily: 'RobotoCondensed',
              fontWeight: FontWeight.bold,
            ),
          ),
          //Shaping AppBar
          elevation: 22,
          shadowColor: Theme.of(context).canvasColor,
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Text(
            '\nPREVIOUS TRANSACTIONS',
            style: const TextStyle(
              fontSize: 20.0,
              fontFamily: 'QuickSand',
              fontWeight: FontWeight.w900,
              color: Colors.black54,
            ),
          ),
          Divider(
            indent: 12,
            endIndent: 12,
            color: Colors.blueGrey,
            height: 23,
          ),
          Expanded(
            child: FutureBuilder<List<Renter>>(
                future: RenterDatabase.db.getRenters(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<Renter>> snaps) {
                  if (snaps.hasData) {
                    if (snaps.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snaps.connectionState == ConnectionState.done) {
                      List<Renter> listData = snaps.data!;

                      return SingleChildScrollView(
                        child: Scrollbar(
                          isAlwaysShown: true,
                          showTrackOnHover: true,
                          controller: _scrollController,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            controller: _scrollController,
                            child: DataTable(
                              columns: getColumns(columns),
                              rows: getRows(listData),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        child: Text('Error, Database corrupted!!!!!'),
                      );
                    }
                  } else {
                    return Center(
                      child: Text('No transactions added yet!'),
                    );
                  }
                }),
          ),
          //     SizedBox(height: 10),
          //     Row(
          //       children: [
          //         Text(
          //           '\nOUR SERVICES',
          //           style: const TextStyle(
          //             fontSize: 20.0,
          //   ),          fontFamily: 'QuickSand',
          //             fontWeight: FontWeight.w900,
          //             color: Colors.black54,
          //           ),
          //         ),
          //       ],
          //     ),
          //     Divider(
          //       indent: 12,
          //       endIndent: 12,
          //       color: Colors.grey,
          //       height: 2,
          //     ),
          //     SizedBox(
          //       height: 5,
          //     ),
          //     Column(
          //       mainAxisAlignment: MainAxisAlignment.end,
          //       children: [
          //         const Text('-->Keep Track of tenants'),
          //         SizedBox(
          //           height: 12,
          //         ),
          //         const Text('-->Easy Management of services'),
          //         SizedBox(
          //           height: 12,
          //         ),
          //         const Text('-->Encourage the relationship tenant-landlord'),
          //       ],
          //     ),
        ],
      ),
    );
  }
}
