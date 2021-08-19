import '../../models/monthModels/decemberModel.dart';
import '../tenants_db_helper.dart';

class DecemberDb {
  String augustTable = 'table_December';
  String colId2 = 'id';
  String colname = 'name';
  String colMoneyPay = 'moneyPaid';
  String colcompletePay = 'completedPayement';
  String colmoneyToPay = 'moneyToPay';
  String colRemainder = 'remainder';

  DecemberDb._();
  static final DecemberDb db = DecemberDb._();

  Future<List<DecemberModel>> getRawPayments() async {
    final db = await RenterDatabase.db.database;

    var payments = await db!.query(augustTable, columns: [
      colId2,
      colname,
      colMoneyPay,
      colcompletePay,
      colmoneyToPay,
      colRemainder,
    ]);

    List<DecemberModel>? monthlypaymentList = [];

    payments.forEach((py) {
      DecemberModel monthpayment = DecemberModel.fromMap(py);
      monthlypaymentList.add(monthpayment);
    });

    return monthlypaymentList;
  }

  Future<DecemberModel> insert(DecemberModel py) async {
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

  Future<int> update(DecemberModel py, int id) async {
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
