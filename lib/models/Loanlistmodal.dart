class Loanlistmodal {
  int? id;
  String? loanType;
  int? customerId;
  int? createdBy;
  int? loanAmount;
  int? loanTenure;
  dynamic tenureType;
  int? dailyEmi;
  int? weeklyEmi;
  int? monthlyEmi;
  DateTime? loanGivenDate;
  String? comments;
  Approveduser? customer;
  Approveduser? approveduser;
  List<LoanDue>? loandues;

  Loanlistmodal({
    this.id,
    this.loanType,
    this.customerId,
    this.createdBy,
    this.loanAmount,
    this.loanTenure,
    this.tenureType,
    this.dailyEmi,
    this.weeklyEmi,
    this.monthlyEmi,
    this.loanGivenDate,
    this.comments,
    this.customer,
    this.approveduser,
    this.loandues,
  });

  factory Loanlistmodal.fromJson(Map<String, dynamic> json) => Loanlistmodal(
        id: json["id"],
        loanType: json["loan_type"],
        customerId: json["customer_id"],
        createdBy: json["created_by"],
        loanAmount: json["loan_amount"],
        loanTenure: json["loan_tenure"],
        tenureType: json["tenure_type"],
        dailyEmi: json["daily_emi"],
        weeklyEmi: json["weekly_emi"],
        monthlyEmi: json["monthly_emi"],
        loanGivenDate: json["loan_given_date"] != null
            ? DateTime.tryParse(json["loan_given_date"])
            : null,
        comments: json["comments"],
        customer: json["customer"] != null
            ? Approveduser.fromJson(json["customer"])
            : null,
        approveduser: json["approveduser"] != null
            ? Approveduser.fromJson(json["approveduser"])
            : null,
        loandues: json["loandues"] != null
            ? List<LoanDue>.from(
                json["loandues"].map((x) => LoanDue.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "loan_type": loanType,
        "customer_id": customerId,
        "created_by": createdBy,
        "loan_amount": loanAmount,
        "loan_tenure": loanTenure,
        "tenure_type": tenureType,
        "daily_emi": dailyEmi,
        "weekly_emi": weeklyEmi,
        "monthly_emi": monthlyEmi,
        "loan_given_date":
            loanGivenDate?.toIso8601String(),
        "comments": comments,
        "customer": customer?.toJson(),
        "approveduser": approveduser?.toJson(),
        "loandues": loandues?.map((x) => x.toJson()).toList() ?? [],
      };
}

class Approveduser {
  int? id;
  String? empid;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  String? mobile;
  dynamic adharnumber;
  String? profileImg;
  String? address;
  int? companyId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? status;
  String? fullImgPath;

  Approveduser({
    this.id,
    this.empid,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.mobile,
    this.adharnumber,
    this.profileImg,
    this.address,
    this.companyId,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.fullImgPath,
  });

  factory Approveduser.fromJson(Map<String, dynamic> json) => Approveduser(
        id: json["id"],
        empid: json["empid"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        mobile: json["mobile"],
        adharnumber: json["adharnumber"],
        profileImg: json["profile_img"],
        address: json["address"],
        companyId: json["company_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
        fullImgPath: json["FullImgPath"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "empid": empid,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "mobile": mobile,
        "adharnumber": adharnumber,
        "profile_img": profileImg,
        "address": address,
        "company_id": companyId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "status": status,
        "FullImgPath": fullImgPath,
      };
}

class LoanDue {
  int? id;
  int? loanId;
  int? amountCollected;
  int? collectedBy;
  int? customerId;
  DateTime? collectedDate;
  String? comments;
  String? paymentMode;

  LoanDue({
    this.id,
    this.loanId,
    this.amountCollected,
    this.collectedBy,
    this.customerId,
    this.collectedDate,
    this.comments,
    this.paymentMode,
  });

  factory LoanDue.fromJson(Map<String, dynamic> json) => LoanDue(
        id: json["id"],
        loanId: json["loan_id"],
        amountCollected: json["amount_collected"],
        collectedBy: json["collected_by"],
        customerId: json["customer_id"],
        collectedDate: json["collected_date"] != null
            ? DateTime.tryParse(json["collected_date"])
            : null,
        comments: json["comments"],
        paymentMode: json["payment_mode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "loan_id": loanId,
        "amount_collected": amountCollected,
        "collected_by": collectedBy,
        "customer_id": customerId,
        "collected_date":
            collectedDate?.toIso8601String(),
        "comments": comments,
        "payment_mode": paymentMode,
      };
}
