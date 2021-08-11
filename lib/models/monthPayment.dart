class MonthlyPayment {
  int? id;
  int? januaryPay;
  int? februaryPay;
  int? marchPay;
  int? aprilPay;
  int? mayPay;
  int? junePay;
  int? julyPay;
  int? augustPay;
  int? septemberPay;
  int? octoberPay;
  int? novemberPay;
  int? decemberPay;
  int? yearPayComplete;

  MonthlyPayment(
    this.januaryPay,
    this.februaryPay,
    this.marchPay,
    this.aprilPay,
    this.mayPay,
    this.junePay,
    this.julyPay,
    this.augustPay,
    this.septemberPay,
    this.octoberPay,
    this.novemberPay,
    this.decemberPay,
    this.yearPayComplete,
  );

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['januaryPay'] = januaryPay;
    map['februaryPay'] = februaryPay;
    map['marchPay'] = marchPay;
    map['aprilPay'] = aprilPay;
    map['mayPay'] = mayPay;
    map['junePay'] = junePay;
    map['julyPay'] = julyPay;
    map['augustPay'] = augustPay;
    map['septemberPay'] = septemberPay;
    map['octoberPay'] = octoberPay;
    map['novemberPay'] = novemberPay;
    map['decemberPay'] = decemberPay;
    map['yearPayComplete'] = yearPayComplete;
    return map;
  }

  MonthlyPayment.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    januaryPay = map['januaryPay'];
    februaryPay = map['februaryPay'];
    marchPay = map['marchPay'];
    aprilPay = map['aprilPay'];
    mayPay = map['mayPay'];
    junePay = map['junePay'];
    julyPay = map['julyPay'];
    augustPay = map['augustPay'];
    septemberPay = map['septemberPay'];
    octoberPay = map['octoberPay'];
    novemberPay = map['novemberPay'];
    decemberPay = map['decemberPay'];
    yearPayComplete = map['yearPayComplete'];
  }
}
