import '../helpers/tenants_db_helper.dart';
import '../models/payment.dart';

class PaymentDb {
  String paymentTable = 'table_pay';
  String colId = 'id';
  String colName = 'name';
  String colToPayAmount = 'toPayAmount';
  String colDate = 'payedDate';
  String colNewPayment = 'newPayment';

  PaymentDb._();
  static final PaymentDb db = PaymentDb._();

  Future<List<Payment>> getRawPayments() async {
    final db = await RenterDatabase.db.database;

    var payments = await db!.query(paymentTable,
        columns: [colId, colName, colToPayAmount, colDate]);

    List<Payment>? paymentList = [];

    payments.forEach((py) {
      Payment payment = Payment.fromMap(py);

      paymentList.add(payment);
    });

    return paymentList;
  }

  Future<Payment> insert(Payment py) async {
    final db = await RenterDatabase.db.database;
    py.id = await db!.insert(paymentTable, py.toMap());
    return py;
  }

  Future<int> delete(int id) async {
    final db = await RenterDatabase.db.database;

    return await db!.delete(
      paymentTable,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> update(Payment py, int id) async {
    final db = await RenterDatabase.db.database;

    return await db!.update(
      paymentTable,
      py.toMap(),
      where: "id = ?",
      whereArgs: [id],
    );
  }

//List<Payment> pay = [];

  Future close() async => db.close();
}
