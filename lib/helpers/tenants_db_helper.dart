import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import '../models/tenants.dart';

class RenterDatabase {
  //table_Tenant
  String rentersTable = 'table_renters';
  String colId = 'id';
  String colfName = 'firstName';
  String colLName = 'lastName';
  String colDate = 'date';
  String colToPayAmount = 'toPayAmount';
  String colNewPayment = 'newPayment';
  String colpDate = 'payedDate';
  String colnewPayMonth = 'newPayMonth';
  String colmoneyPaid = 'moneyPaid';
  String colCompletePayment = 'CompletedPayment';
  String phoneNumberCol = 'PhoneNumber';

  //table_MonthPayments
  //-April
  String aprilTable = 'table_April';
  String colIdApril = 'id';
  String colnameApril = 'name';
  String colMoneyPayApril = 'moneyPaid';
  String colcompletePayApril = 'completedPayement';
  String colmoneyToPayApril = 'moneyToPay';
  String colRemainderApr = 'remainder';
  //-August
  String augustTable = 'table_August';
  String colIdAugust = 'id';
  String colnameAugust = 'name';
  String colMoneyPayAugust = 'moneyPaid';
  String colcompletePayAugust = 'completedPayement';
  String colmoneyToPayAugust = 'moneyToPay';
  String colRemainderAug = 'remainder';
  //-december
  String decemberTable = 'table_December';
  String colIdDec = 'id';
  String colnameDec = 'name';
  String colMoneyPayDec = 'moneyPaid';
  String colcompletePayDec = 'completedPayement';
  String colmoneyToPayDec = 'moneyToPay';
  String colRemainderDec = 'remainder';
  //-february
  String febTable = 'table_February';
  String colIdfeb = 'id';
  String colnamefeb = 'name';
  String colMoneyPayfeb = 'moneyPaid';
  String colcompletePayfeb = 'completedPayement';
  String colmoneyToPayfeb = 'moneyToPay';
  String colRemainderfeb = 'remainder';
//-january
  String janTable = 'table_January';
  String colIdjan = 'id';
  String colnamejan = 'name';
  String colMoneyPayjan = 'moneyPaid';
  String colcompletePayjan = 'completedPayement';
  String colmoneyToPayjan = 'moneyToPay';
  String colRemainderjan = 'remainder';
  //-July
  String julTable = 'table_July';
  String colIdjul = 'id';
  String colnamejul = 'name';
  String colMoneyPayjul = 'moneyPaid';
  String colcompletePayjul = 'completedPayement';
  String colmoneyToPayjul = 'moneyToPay';
  String colRemainderjul = 'remainder';
  //-June
  String junTable = 'table_June';
  String colIdjun = 'id';
  String colnamejun = 'name';
  String colMoneyPayjun = 'moneyPaid';
  String colcompletePayjun = 'completedPayement';
  String colmoneyToPayjun = 'moneyToPay';
  String colRemainderjun = 'remainder';
  //-march
  String marchTable = 'table_March';
  String colIdmar = 'id';
  String colnamemar = 'name';
  String colMoneyPaymar = 'moneyPaid';
  String colcompletePaymar = 'completedPayement';
  String colmoneyToPaymar = 'moneyToPay';
  String colRemaindermar = 'remainder';
  //-may
  String mayTable = 'table_May';
  String colIdmay = 'id';
  String colnamemay = 'name';
  String colMoneyPaymay = 'moneyPaid';
  String colcompletePaymay = 'completedPayement';
  String colmoneyToPaymay = 'moneyToPay';
  String colRemaindermay = 'remainder';
  //-november
  String novTable = 'table_November';
  String colIdnov = 'id';
  String colnamenov = 'name';
  String colMoneyPaynov = 'moneyPaid';
  String colcompletePaynov = 'completedPayement';
  String colmoneyToPaynov = 'moneyToPay';
  String colRemaindernov = 'remainder';
  //-october
  String octTable = 'table_October';
  String colIdoct = 'id';
  String colnameoct = 'name';
  String colMoneyPayoct = 'moneyPaid';
  String colcompletePayoct = 'completedPayement';
  String colmoneyToPayoct = 'moneyToPay';
  String colRemainderoct = 'remainder';
  //-september
  String septTable = 'table_September';
  String colIdsep = 'id';
  String colnamesep = 'name';
  String colMoneyPaysep = 'moneyPaid';
  String colcompletePaysep = 'completedPayement';
  String colmoneyToPaysep = 'moneyToPay';
  String colRemaindersep = 'remainder';
  RenterDatabase._();
  static final RenterDatabase db = RenterDatabase._();

  Database? _database;

  Future<Database?> get database async {
    print("database getter called");

    if (_database != null) {
      return _database;
    }

    _database = await createDatabase();

    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'TenantsDB.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        print("Creating tables");

        await database.execute(
          "CREATE TABLE $rentersTable ("
          "$colId INTEGER PRIMARY KEY,"
          "$colfName TEXT,"
          "$colLName TEXT,"
          "$colToPayAmount INTEGER,"
          "$colNewPayment INTEGER,"
          "$colDate TEXT,"
          "$colpDate TEXT,"
          "$colnewPayMonth TEXT,"
          "$colmoneyPaid INTEGER,"
          "$colCompletePayment INTEGER,"
          "$phoneNumberCol INTEGER"
          ")",
        );

        //-April
        await database.execute(
          "CREATE TABLE $aprilTable ("
          "$colIdApril INTEGER PRIMARY KEY,"
          "$colnameApril TEXT,"
          "$colMoneyPayApril INTEGER,"
          "$colcompletePayApril INTEGER,"
          "$colmoneyToPayApril INTEGER,"
          "$colRemainderApr INTEGER"
          //will be converted back to bool as: Boolean flag2 = (intValue == 1)? true : false;
          ")",
        );

        //-August
        await database.execute(
          "CREATE TABLE $augustTable ("
          "$colIdAugust INTEGER PRIMARY KEY,"
          "$colnameAugust TEXT,"
          "$colMoneyPayAugust INTEGER,"
          "$colcompletePayAugust INTEGER,"
          "$colmoneyToPayAugust INTEGER,"
          "$colRemainderAug INTEGER"
          //will be converted back to bool as: Boolean flag2 = (intValue == 1)? true : false;
          ")",
        );

        //-dec
        await database.execute(
          "CREATE TABLE $decemberTable ("
          "$colIdDec INTEGER PRIMARY KEY,"
          "$colnameDec TEXT,"
          "$colMoneyPayDec INTEGER,"
          "$colcompletePayDec INTEGER,"
          "$colmoneyToPayDec INTEGER,"
          "$colRemainderDec INTEGER"
          //will be converted back to bool as: Boolean flag2 = (intValue == 1)? true : false;
          ")",
        );

        //-feb
        await database.execute(
          "CREATE TABLE $febTable ("
          "$colIdfeb INTEGER PRIMARY KEY,"
          "$colnamefeb TEXT,"
          "$colMoneyPayfeb INTEGER,"
          "$colcompletePayfeb INTEGER,"
          "$colmoneyToPayfeb INTEGER,"
          "$colRemainderfeb INTEGER"
          //will be converted back to bool as: Boolean flag2 = (intValue == 1)? true : false;
          ")",
        );

        //-jan
        await database.execute(
          "CREATE TABLE $janTable ("
          "$colIdjan INTEGER PRIMARY KEY,"
          "$colnamejan TEXT,"
          "$colMoneyPayjan INTEGER,"
          "$colcompletePayjan INTEGER,"
          "$colmoneyToPayjan INTEGER,"
          "$colRemainderjan INTEGER"
          //will be converted back to bool as: Boolean flag2 = (intValue == 1)? true : false;
          ")",
        );

        //-jul
        await database.execute(
          "CREATE TABLE $julTable ("
          "$colIdjul INTEGER PRIMARY KEY,"
          "$colnamejul TEXT,"
          "$colMoneyPayjul INTEGER,"
          "$colcompletePayjul INTEGER,"
          "$colmoneyToPayjul INTEGER,"
          "$colRemainderjul INTEGER"
          //will be converted back to bool as: Boolean flag2 = (intValue == 1)? true : false;
          ")",
        );

        //-jun
        await database.execute(
          "CREATE TABLE $junTable ("
          "$colIdjun INTEGER PRIMARY KEY,"
          "$colnamejun TEXT,"
          "$colMoneyPayjun INTEGER,"
          "$colcompletePayjun INTEGER,"
          "$colmoneyToPayjun INTEGER,"
          "$colRemainderjun INTEGER"
          //will be converted back to bool as: Boolean flag2 = (intValue == 1)? true : false;
          ")",
        );

        //-march
        await database.execute(
          "CREATE TABLE $marchTable ("
          "$colIdmar INTEGER PRIMARY KEY,"
          "$colnamemar TEXT,"
          "$colMoneyPaymar INTEGER,"
          "$colcompletePaymar INTEGER,"
          "$colmoneyToPaymar INTEGER,"
          "$colRemaindermar INTEGER"
          //will be converted back to bool as: Boolean flag2 = (intValue == 1)? true : false;
          ")",
        );

        //-may
        await database.execute(
          "CREATE TABLE $mayTable ("
          "$colIdmay INTEGER PRIMARY KEY,"
          "$colnamemay TEXT,"
          "$colMoneyPaymay INTEGER,"
          "$colcompletePaymay INTEGER,"
          "$colmoneyToPaymay INTEGER,"
          "$colRemaindermay INTEGER"
          //will be converted back to bool as: Boolean flag2 = (intValue == 1)? true : false;
          ")",
        );

        //-nov
        await database.execute(
          "CREATE TABLE $novTable ("
          "$colIdnov INTEGER PRIMARY KEY,"
          "$colnamenov TEXT,"
          "$colMoneyPaynov INTEGER,"
          "$colcompletePaynov INTEGER,"
          "$colmoneyToPaynov INTEGER,"
          "$colRemaindernov INTEGER"
          //will be converted back to bool as: Boolean flag2 = (intValue == 1)? true : false;
          ")",
        );

        //-nov
        await database.execute(
          "CREATE TABLE $octTable ("
          "$colIdoct INTEGER PRIMARY KEY,"
          "$colnameoct TEXT,"
          "$colMoneyPayoct INTEGER,"
          "$colcompletePayoct INTEGER,"
          "$colmoneyToPayoct INTEGER,"
          "$colRemainderoct INTEGER"
          //will be converted back to bool as: Boolean flag2 = (intValue == 1)? true : false;
          ")",
        );

        //-nov
        await database.execute(
          "CREATE TABLE $septTable ("
          "$colIdsep INTEGER PRIMARY KEY,"
          "$colnamesep TEXT,"
          "$colMoneyPaysep INTEGER,"
          "$colcompletePaysep INTEGER,"
          "$colmoneyToPaysep INTEGER,"
          "$colRemaindersep INTEGER"
          //will be converted back to bool as: Boolean flag2 = (intValue == 1)? true : false;
          ")",
        );
      },
    );
  }

  Future<List<Renter>> getRenters() async {
    final db = await database;

    var tenants = await db!.query(
      rentersTable,
      columns: [
        colId,
        colfName,
        colLName,
        colToPayAmount,
        colNewPayment,
        colDate,
        colpDate,
        colnewPayMonth,
        colmoneyPaid,
        colCompletePayment,
        phoneNumberCol,
      ],
    );

    List<Renter>? renterList = [];

    tenants.forEach((rt) {
      Renter tenant = Renter.fromMap(rt);

      renterList.add(tenant);
    });
    return renterList;
  }

  Future<Renter> insert(Renter rt) async {
    final db = await database;
    rt.id = await db!.insert(rentersTable, rt.toMap());
    return rt;
  }

  Future<int> delete(int id) async {
    final db = await database;

    return await db!.delete(
      rentersTable,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> update(Renter rt, int id) async {
    final db = await database;

    return await db!.update(
      rentersTable,
      rt.toMap(),
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future close() async => db.close();
}
