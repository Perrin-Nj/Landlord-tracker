class JulyModel {
  int? id;
  String? name;
  int? moneyPaid;
  int? completedPayement;

  JulyModel({
    required this.id,
    required this.name,
    required this.moneyPaid,
    required this.completedPayement,
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['name'] = name;
    map['moneyPaid'] = moneyPaid;
    map['completedPayement'] = completedPayement;
    return map;
  }

  JulyModel.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    moneyPaid = map['moneyPaid'];
    completedPayement = map['completedPayement'];
  }
}
