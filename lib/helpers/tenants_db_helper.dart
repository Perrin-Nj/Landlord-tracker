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
  String monthlyRemainder = 'monthlyRemainder';
  String phoneNumberCol = 'PhoneNumber';

  //table_MonthPayments
  //-April
  String aprilTable = 'table_April';
  String colIdApril = 'idapril';
  String colnameApril = 'nameapr';
  String colMoneyPayApril = 'moneyPaid';
  String colcompletePayApril = 'completedPayement';
  String colmoneyToPayApril = 'moneyToPay';
  //-August
  String augustTable = 'table_August';
  String colIdAugust = 'idaugust';
  String colnameAugust = 'nameaug';
  String colMoneyPayAugust = 'moneyPaid';
  String colcompletePayAugust = 'completedPayement';
  String colmoneyToPayAugust = 'moneyToPay';

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
          "$monthlyRemainder INTEGER,"
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
          "$colmoneyToPayApril INTEGER"
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
          "$colmoneyToPayAugust INTEGER"
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
        monthlyRemainder,
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
