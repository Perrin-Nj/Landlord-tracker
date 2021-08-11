import '../helpers/tenants_db_helper.dart';
import '../models/monthPayment.dart';

class MonthPaydb {
  String monthPayTable = 'table_MonthPayments';
  String colId2 = 'id';
  String colJan = 'januaryPay';
  String colfeb = 'februaryPay';
  String colmar = 'marchPay';
  String colapr = 'aprilPay';
  String colmay = 'mayPay';
  String coljun = 'junePay';
  String colJul = 'julyPay';
  String colAug = 'augustPay';
  String colsep = 'septemberPay';
  String coloct = 'octoberPay';
  String colnov = 'novemberPay';
  String coldec = 'decemberPay';
  String yearPayCompletedcol = 'yearPayComplete';

  MonthPaydb._();
  static final MonthPaydb db = MonthPaydb._();

  Future<List<MonthlyPayment>> getRawPayments() async {
    final db = await RenterDatabase.db.database;

    var payments = await db!.query(monthPayTable, columns: [
      colId2,
      colJan,
      colfeb,
      colmar,
      colapr,
      colmay,
      coljun,
      colJul,
      colAug,
      colsep,
      coloct,
      colnov,
      coldec,
      yearPayCompletedcol,
    ]);

    List<MonthlyPayment>? monthlypaymentList = [];

    payments.forEach((py) {
      MonthlyPayment monthpayment = MonthlyPayment.fromMap(py);

      monthlypaymentList.add(monthpayment);
    });

    return monthlypaymentList;
  }

  Future<MonthlyPayment> insert(MonthlyPayment py) async {
    final db = await RenterDatabase.db.database;
    py.id = await db!.insert(monthPayTable, py.toMap());
    return py;
  }

  Future<int> delete(int id) async {
    final db = await RenterDatabase.db.database;

    return await db!.delete(
      monthPayTable,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> update(MonthlyPayment py, int id) async {
    final db = await RenterDatabase.db.database;

    return await db!.update(
      monthPayTable,
      py.toMap(),
      where: "id = ?",
      whereArgs: [id],
    );
  }

//List<Payment> pay = [];

  Future close() async => db.close();
}
