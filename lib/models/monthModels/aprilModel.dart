class AprilModel {
  int? idapril;
  String? nameapr;
  int? moneyPaid;
  int? completedPayement;
  int? moneyToPay;

  AprilModel({
    required this.idapril,
    required this.nameapr,
    required this.moneyPaid,
    required this.completedPayement,
    required this.moneyToPay,
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (idapril != null) {
      map['idapril'] = idapril;
    }
    map['nameapr'] = nameapr;
    map['moneyPaid'] = moneyPaid;
    map['completedPayement'] = completedPayement;
    map['moneyToPay'] = moneyToPay;
    return map;
  }

  AprilModel.fromMap(Map<String, dynamic> map) {
    idapril = map['idapril'];
    nameapr = map['name'];
    moneyPaid = map['moneyPaid'];
    completedPayement = map['completedPayement'];
    moneyToPay = map['moneyToPay'];
  }
}
