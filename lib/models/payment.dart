class Payment {
  int? id;
  String? name; // name of the person paying
  int? toPayAmount;
  String? payedDate;
  int? newPayment;

  Payment(
    this.name,
    this.toPayAmount,
    this.payedDate,
    this.newPayment,
  );

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['name'] = name;
    map['toPayAmount'] = toPayAmount;
    map['payedDate'] = payedDate;
    map['newPayment'] = newPayment;
    return map;
  }

  Payment.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    toPayAmount = map['toPayAmount'];
    payedDate = map['payedDate'];
    newPayment = map['newPayment'];
  }
}
