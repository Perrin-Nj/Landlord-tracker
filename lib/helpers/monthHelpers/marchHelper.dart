import '../../models/monthModels/marchModel.dart';
import '../tenants_db_helper.dart';

class MarchDb {
  String aprilTable = 'table_March';
  String colId2 = 'id';
  String colname = 'name';
  String colMoneyPay = 'moneyPaid';
  String colcompletePay = 'completedPayement';
  String colmoneyToPay = 'moneyToPay';
  String colRemainder = 'remainder';

  MarchDb._();
  static final MarchDb db = MarchDb._();

  Future<List<MarchModel>> getRawPayments() async {
    final db = await RenterDatabase.db.database;

    var payments = await db!.query(aprilTable, columns: [
      colId2,
      colname,
      colMoneyPay,
      colcompletePay,
      colmoneyToPay,
      colRemainder,
    ]);

    List<MarchModel>? monthlypaymentList = [];

    payments.forEach((py) {
      MarchModel monthpayment = MarchModel.fromMap(py);

      monthlypaymentList.add(monthpayment);
    });

    return monthlypaymentList;
  }

  Future<MarchModel> insert(MarchModel py) async {
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

  Future<int> update(MarchModel py, int id) async {
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
