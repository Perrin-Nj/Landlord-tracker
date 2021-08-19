class AprilModel {
  int? idapril;
  String? nameapr;
  int? moneyPaid;
  int? completedPayement;
  int? moneyToPay;
  int? remainder;

  AprilModel({
    //required this.idapril,
    required this.nameapr,
    required this.moneyPaid,
    required this.completedPayement,
    required this.moneyToPay,
    required this.remainder,
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (idapril != null) {
      map['idapril'] = idapril;
    }
    map['name'] = nameapr;
    map['moneyPaid'] = moneyPaid;
    map['completedPayement'] = completedPayement;
    map['moneyToPay'] = moneyToPay;
    map['remainder'] = remainder;
    return map;
  }

  AprilModel.fromMap(Map<String, dynamic> map) {
    idapril = map['id'];
    nameapr = map['name'];
    moneyPaid = map['moneyPaid'];
    completedPayement = map['completedPayement'];
    moneyToPay = map['moneyToPay'];
    remainder = map['remainder'];
  }
}
