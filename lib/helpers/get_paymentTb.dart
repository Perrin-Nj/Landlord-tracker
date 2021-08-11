import 'package:flutter/material.dart';
import '../widgets/Pages/displayrenters.dart';
import '../models/payment.dart';
import './payment_db_helper.dart';

class GetPayment extends StatefulWidget {
  GetPayment({Key? key}) : super(key: key);

  @override
  _GetPaymentState createState() => _GetPaymentState();
}

class _GetPaymentState extends State<GetPayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Payment>>(
        future: PaymentDb.db.getRawPayments(),
        builder: (BuildContext context, AsyncSnapshot<List<Payment>> snapshot) {
          if (snapshot.hasData) {
            List<Payment>? payments = snapshot.data;
            return Container(
              margin: EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color:
                        Theme.of(context).secondaryHeaderColor.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 9,
                    offset: Offset(0, 1),
                    // changes position of shadow
                  ),
                ],
              ),
              height: 400,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: payments!.length,
                itemBuilder: (context, index) {
                  final payment = payments[index];
                  //to load new page when user taps item

                  Navigator.of(context).pushNamed('/payment-page', arguments: {
                    'idPay': payment.id,
                    'namePay': payment.name,
                    'newPay': payment.newPayment,
                    'PayedDatePay': payment.payedDate,
                    'toPay': payment.toPayAmount,
                  });

                  return Container();
                },
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: Text('No Tenants added yet'),
            );
          }
        },
      ),
    );
  }
}
