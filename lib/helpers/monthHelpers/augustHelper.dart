import '../../models/monthModels/augustModel.dart';
import '../tenants_db_helper.dart';

class AugustDb {
  String augustTable = 'table_August';
  String colId2 = 'idaugust';
  String colname = 'nameaug';
  String colMoneyPay = 'moneyPaid';
  String colcompletePay = 'completedPayement';
  String colmoneyToPay = 'moneyToPay';

  AugustDb._();
  static final AugustDb db = AugustDb._();

  Future<List<AugustModel>> getRawPayments() async {
    final db = await RenterDatabase.db.database;

    var payments = await db!.query(augustTable, columns: [
      colId2,
      colname,
      colMoneyPay,
      colcompletePay,
      colmoneyToPay,
    ]);

    List<AugustModel>? monthlypaymentList = [];

    payments.forEach((py) {
      AugustModel monthpayment = AugustModel.fromMap(py);
      monthlypaymentList.add(monthpayment);
    });

    return monthlypaymentList;
  }

  Future<AugustModel> insert(AugustModel py) async {
    final db = await RenterDatabase.db.database;
    py.id = await db!.insert(augustTable, py.toMap());
    return py;
  }

  Future<int> delete(int id) async {
    final db = await RenterDatabase.db.database;

    return await db!.delete(
      augustTable,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> update(AugustModel py, int id) async {
    final db = await RenterDatabase.db.database;

    return await db!.update(
      augustTable,
      py.toMap(),
      where: "id = ?",
      whereArgs: [id],
    );
  }

//List<Payment> pay = [];

  Future close() async => db.close();
}
