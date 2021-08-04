class MonthlyPayment {
  int? id;
  String? name;
  int? newPayMonth; // DateTime.now().month;
  int? moneyPaid;
  int? monthlyRemainder;

  MonthlyPayment(
    this.name,
    this.newPayMonth,
    this.moneyPaid,
    this.monthlyRemainder,
  );

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['name'] = name;
    map['newPayMonth'] = newPayMonth;
    map['moneyPaid'] = moneyPaid;
    map['monthlyRemainder'] = monthlyRemainder;
    return map;
  }

  MonthlyPayment.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    newPayMonth = map['newPayMonth'];
    moneyPaid = map['moneyPaid'];
    monthlyRemainder = map['monthlyRemainder'];
  }
}
