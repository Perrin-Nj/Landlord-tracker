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
  String colAmount = 'amount';
  String colDate = 'date';

  //table_payment
  String paymentTable = 'table_pay';
  String colName = 'name';
  String colToPayAmount = 'toPayAmount';
  String colNewPayment = 'newPayment';
  String colpDate = 'payedDate';

  String monthPayTable = 'Month_table_pay';
  String coName = 'name';
  String colnewPayMonth = 'newPayMonth';
  String colmoneyPaid = 'moneyPaid';
  String monthlyRemainder = 'monthlyRemainder';

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
          "$colAmount INTEGER,"
          "$colDate TEXT"
          ")",
        );

        await database.execute(
          "CREATE TABLE $paymentTable ("
          "$colId INTEGER PRIMARY KEY,"
          "$colName TEXT,"
          "$colToPayAmount INTEGER,"
          "$colpDate TEXT,"
          "$colNewPayment TEXT"
          ")",
        );

        await database.execute(
          "CREATE TABLE $monthPayTable ("
          "$colId INTEGER PRIMARY KEY,"
          "$coName TEXT,"
          "$colnewPayMonth INTEGER,"
          "$colmoneyPaid INTEGER,"
          "$monthlyRemainder INTEGER"
          ")",
        );
      },
    );
  }

  Future<List<Renter>> getRenters() async {
    final db = await database;

    var tenants = await db!.query(rentersTable,
        columns: [colId, colfName, colLName, colAmount, colDate]);

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
