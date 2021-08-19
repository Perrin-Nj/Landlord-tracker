import '../../models/monthModels/februaryModel.dart';
import '../tenants_db_helper.dart';

class FebruaryDb {
  String aprilTable = 'table_February';
  String colId2 = 'id';
  String colname = 'name';
  String colMoneyPay = 'moneyPaid';
  String colcompletePay = 'completedPayement';
  String colmoneyToPay = 'moneyToPay';
  String colRemainder = 'remainder';

  FebruaryDb._();
  static final FebruaryDb db = FebruaryDb._();

  Future<List<FebruaryModel>> getRawPayments() async {
    final db = await RenterDatabase.db.database;

    var payments = await db!.query(aprilTable, columns: [
      colId2,
      colname,
      colMoneyPay,
      colcompletePay,
      colmoneyToPay,
      colRemainder,
    ]);

    List<FebruaryModel>? monthlypaymentList = [];

    payments.forEach((py) {
      FebruaryModel monthpayment = FebruaryModel.fromMap(py);

      monthlypaymentList.add(monthpayment);
    });

    return monthlypaymentList;
  }

  Future<FebruaryModel> insert(FebruaryModel py) async {
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

  Future<int> update(FebruaryModel py, int id) async {
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
