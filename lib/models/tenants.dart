class Renter {
  int? id;
  // ignore: non_constant_identifier_names
  String? FirstName;
  // ignore: non_constant_identifier_names
  String? LastName;
  // ignore: non_constant_identifier_names
  int? toPayAmount;
  String? date;
  String? payedDate;
  int? newPayment;
  String? newPayMonth; // DateTime.now().month;
  int? completedPayment;
  int? PhoneNumber;

  Renter(
    //this.id,
    this.FirstName,
    this.LastName,
    this.toPayAmount,
    this.date,
    this.payedDate,
    this.newPayment,
    this.newPayMonth,
    this.completedPayment,
    this.PhoneNumber,
  );

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['firstName'] = FirstName;
    map['lastName'] = LastName;
    map['toPayAmount'] = toPayAmount;
    map['date'] = date;
    map['payedDate'] = payedDate;
    map['newPayment'] = newPayment;
    map['newPayMonth'] = newPayMonth;
    map['completedPayment'] = completedPayment;
    map['PhoneNumber'] = PhoneNumber;
    return map;
  }

  Renter.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    FirstName = map['firstName'];
    LastName = map['lastName'];
    toPayAmount = map['toPayAmount'];
    date = map['date'];
    payedDate = map['payedDate'];
    newPayment = map['newPayment'];
    newPayMonth = map['newPayMonth'];
    completedPayment = map['completedPayment'];
    PhoneNumber = map['PhoneNumber'];
  }
}
