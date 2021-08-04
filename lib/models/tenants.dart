class Renter {
  int? id;
  // ignore: non_constant_identifier_names
  String? FirstName;
  // ignore: non_constant_identifier_names
  String? LastName;
  // ignore: non_constant_identifier_names
  int? Amount;
  String? date;

  Renter(
    //this.id,
    this.FirstName,
    this.LastName,
    this.Amount,
    this.date,
  );

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['firstName'] = FirstName;
    map['lastName'] = LastName;
    map['amount'] = Amount;
    map['date'] = date;

    return map;
  }

  Renter.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    FirstName = map['firstName'];
    LastName = map['lastName'];
    Amount = map['amount'];
    date = map['date'];
  }
}
