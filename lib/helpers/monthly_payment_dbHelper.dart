import '../helpers/tenants_db_helper.dart';
import '../models/monthPayment.dart';

class MonthPaydb {
  String monthPayTable = 'Month_table_pay';
  String colId = 'id';
  String coName = 'name';
  String colnewPayMonth = 'newPayMonth';
  String colmoneyPaid = 'moneyPaid';
  String monthlyRemainder = 'monthlyRemainder';

  MonthPaydb._();
  static final MonthPaydb db = MonthPaydb._();

  Future<List<MonthlyPayment>> getRawPayments() async {
    final db = await RenterDatabase.db.database;

    var payments = await db!.query(monthPayTable, columns: [
      colId,
      coName,
      colnewPayMonth,
      colmoneyPaid,
      monthlyRemainder
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
