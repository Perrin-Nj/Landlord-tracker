import '../../models/monthModels/octoberModel.dart';
import '../tenants_db_helper.dart';

class OctoberDb {
  String aprilTable = 'table_October';
  String colId2 = 'id';
  String colname = 'name';
  String colMoneyPay = 'moneyPaid';
  String colcompletePay = 'completedPayement';
  String colmoneyToPay = 'moneyToPay';
  String colRemainder = 'remainder';

  OctoberDb._();
  static final OctoberDb db = OctoberDb._();

  Future<List<OctoberModel>> getRawPayments() async {
    final db = await RenterDatabase.db.database;

    var payments = await db!.query(aprilTable, columns: [
      colId2,
      colname,
      colMoneyPay,
      colcompletePay,
      colmoneyToPay,
      colRemainder,
    ]);

    List<OctoberModel>? monthlypaymentList = [];

    payments.forEach((py) {
      OctoberModel monthpayment = OctoberModel.fromMap(py);

      monthlypaymentList.add(monthpayment);
    });

    return monthlypaymentList;
  }

  Future<OctoberModel> insert(OctoberModel py) async {
    final db = await RenterDatabase.db.database;
    py.id = await db!.insert(aprilTable, py.toMap());
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

  Future<int> update(OctoberModel py, int id) async {
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
