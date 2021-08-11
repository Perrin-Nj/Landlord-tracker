import '../../models/monthModels/aprilModel.dart';
import '../tenants_db_helper.dart';

class AprilDb {
  String aprilTable = 'table_April';
  String colId2 = 'idapril';
  String colname = 'nameapr';
  String colMoneyPay = 'moneyPaid';
  String colcompletePay = 'completedPayement';
  String colmoneyToPay = 'moneyToPay';

  AprilDb._();
  static final AprilDb db = AprilDb._();

  Future<List<AprilModel>> getRawPayments() async {
    final db = await RenterDatabase.db.database;

    var payments = await db!.query(aprilTable, columns: [
      colId2,
      colname,
      colMoneyPay,
      colcompletePay,
      colmoneyToPay,
    ]);

    List<AprilModel>? monthlypaymentList = [];

    payments.forEach((py) {
      AprilModel monthpayment = AprilModel.fromMap(py);

      monthlypaymentList.add(monthpayment);
    });

    return monthlypaymentList;
  }

  Future<AprilModel> insert(AprilModel py) async {
    final db = await RenterDatabase.db.database;
    py.idapril = await db!.insert(aprilTable, py.toMap());
    return py;
  }

  Future<int> delete(int id) async {
    final db = await RenterDatabase.db.database;

    return await db!.delete(
      aprilTable,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> update(AprilModel py, int id) async {
    final db = await RenterDatabase.db.database;

    return await db!.update(
      aprilTable,
      py.toMap(),
      where: "id = ?",
      whereArgs: [id],
    );
  }

//List<Payment> pay = [];

  Future close() async => db.close();
}
