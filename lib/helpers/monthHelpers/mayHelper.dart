import '../../models/monthModels/mayModel.dart';
import '../tenants_db_helper.dart';

class MayDb {
  String aprilTable = 'table_May';
  String colId2 = 'id';
  String colname = 'name';
  String colMoneyPay = 'moneyPaid';
  String colcompletePay = 'completedPayement';
  String colmoneyToPay = 'moneyToPay';
  String colRemainder = 'remainder';

  MayDb._();
  static final MayDb db = MayDb._();

  Future<List<MayModel>> getRawPayments() async {
    final db = await RenterDatabase.db.database;

    var payments = await db!.query(aprilTable, columns: [
      colId2,
      colname,
      colMoneyPay,
      colcompletePay,
      colmoneyToPay,
      colRemainder,
    ]);

    List<MayModel>? monthlypaymentList = [];

    payments.forEach((py) {
      MayModel monthpayment = MayModel.fromMap(py);

      monthlypaymentList.add(monthpayment);
    });

    return monthlypaymentList;
  }

  Future<MayModel> insert(MayModel py) async {
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

  Future<int> update(MayModel py, int id) async {
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
