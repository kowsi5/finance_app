import 'dart:convert';

Totalemp totalempFromJson(String str) => Totalemp.fromJson(json.decode(str));

String totalempToJson(Totalemp data) => json.encode(data.toJson());

class Totalemp {
  int id;
  String name;
  String email;
  String mobile;
  int status;
  String empid;
  dynamic profileImg;
  CompanyInfo companyInfo;
  List<BranchInfo> branchInfo;
  List<String> roleInfo;

  Totalemp({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.status,
    required this.empid,
    required this.profileImg,
    required this.companyInfo,
    required this.branchInfo,
    required this.roleInfo,
  });

  factory Totalemp.fromJson(Map<String, dynamic> json) => Totalemp(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        status: json["status"],
        empid: json["empid"],
        profileImg: json["profile_img"],
        companyInfo: CompanyInfo.fromJson(json["company_info"]),
        branchInfo: List<BranchInfo>.from(
            json["branch_info"].map((x) => BranchInfo.fromJson(x))),
        roleInfo: List<String>.from(json["role_info"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "mobile": mobile,
        "status": status,
        "empid": empid,
        "profile_img": profileImg,
        "company_info": companyInfo.toJson(),
        "branch_info": List<dynamic>.from(branchInfo.map((x) => x.toJson())),
        "role_info": List<dynamic>.from(roleInfo.map((x) => x)),
      };
}

class BranchInfo {
  int id;
  int companyId;
  String branchName;
  String branchAddress;
  String branchLat;
  String branchLon;
  int status;
  Pivot pivot;

  BranchInfo({
    required this.id,
    required this.companyId,
    required this.branchName,
    required this.branchAddress,
    required this.branchLat,
    required this.branchLon,
    required this.status,
    required this.pivot,
  });

  factory BranchInfo.fromJson(Map<String, dynamic> json) => BranchInfo(
        id: json["id"],
        companyId: json["company_id"],
        branchName: json["branch_name"],
        branchAddress: json["branch_address"],
        branchLat: json["branch_lat"],
        branchLon: json["branch_lon"],
        status: json["status"],
        pivot: Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "branch_name": branchName,
        "branch_address": branchAddress,
        "branch_lat": branchLat,
        "branch_lon": branchLon,
        "status": status,
        "pivot": pivot.toJson(),
      };
}

class Pivot {
  int userId;
  int branchId;

  Pivot({
    required this.userId,
    required this.branchId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        userId: json["user_id"],
        branchId: json["branch_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "branch_id": branchId,
      };
}

class CompanyInfo {
  int id;
  String companyName;
  String companyAddress;
  String companyLat;
  String companyLon;
  int status;

  CompanyInfo({
    required this.id,
    required this.companyName,
    required this.companyAddress,
    required this.companyLat,
    required this.companyLon,
    required this.status,
  });

  factory CompanyInfo.fromJson(Map<String, dynamic> json) => CompanyInfo(
        id: json["id"],
        companyName: json["company_name"],
        companyAddress: json["company_address"],
        companyLat: json["company_lat"],
        companyLon: json["company_lon"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_name": companyName,
        "company_address": companyAddress,
        "company_lat": companyLat,
        "company_lon": companyLon,
        "status": status,
      };
}
