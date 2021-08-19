class FebruaryModel {
  int? id;
  String? name;
  int? moneyPaid;
  int? moneyToPay;
  int? completedPayement;
  int? remainder;

  FebruaryModel({
    required this.name,
    required this.moneyPaid,
    required this.moneyToPay,
    required this.completedPayement,
    required this.remainder,
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }

    map['name'] = name;
    map['moneyPaid'] = moneyPaid;
    map['completedPayement'] = completedPayement;
    map['moneyToPay'] = moneyToPay;
    map['remainder'] = remainder;
    return map;
  }

  FebruaryModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    moneyPaid = map['moneyPaid'];
    completedPayement = map['completedPayement'];
    moneyToPay = map['moneyToPay'];
    remainder = map['remainder'];
  }
}
