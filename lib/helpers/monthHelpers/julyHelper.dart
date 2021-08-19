import '../../models/monthModels/julyModel.dart';
import '../tenants_db_helper.dart';

class JulyDb {
  String aprilTable = 'table_July';
  String colId2 = 'id';
  String colname = 'name';
  String colMoneyPay = 'moneyPaid';
  String colcompletePay = 'completedPayement';
  String colmoneyToPay = 'moneyToPay';
  String colRemainder = 'remainder';

  JulyDb._();
  static final JulyDb db = JulyDb._();

  Future<List<JulyModel>> getRawPayments() async {
    final db = await RenterDatabase.db.database;

    var payments = await db!.query(aprilTable, columns: [
      colId2,
      colname,
      colMoneyPay,
      colcompletePay,
      colmoneyToPay,
      colRemainder,
    ]);

    List<JulyModel>? monthlypaymentList = [];

    payments.forEach((py) {
      JulyModel monthpayment = JulyModel.fromMap(py);

      monthlypaymentList.add(monthpayment);
    });

    return monthlypaymentList;
  }

  Future<JulyModel> insert(JulyModel py) async {
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

  Future<int> update(JulyModel py, int id) async {
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
