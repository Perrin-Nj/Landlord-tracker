class AugustModel {
  int? id;
  String? name;
  int? moneyPaid;
  int? completedPayement;
  int? moneyToPay;

  AugustModel({
    required this.id,
    required this.name,
    required this.moneyPaid,
    required this.completedPayement,
    required this.moneyToPay,
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
    return map;
  }

  AugustModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    moneyPaid = map['moneyPaid'];
    completedPayement = map['completedPayement'];
    moneyToPay = map['moneyToPay'];
  }
}
