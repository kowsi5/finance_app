// To parse this JSON data, do
//
//     final mothlyreport = mothlyreportFromJson(jsonString);

import 'dart:convert';

Mothlyreport mothlyreportFromJson(String str) =>
    Mothlyreport.fromJson(json.decode(str));

String mothlyreportToJson(Mothlyreport data) => json.encode(data.toJson());

class Mothlyreport {
  int id;
  String name;
  String mobile;
  String empid;
  List<Attendance> attendances;

  Mothlyreport({
    required this.id,
    required this.name,
    required this.mobile,
    required this.empid,
    required this.attendances,
  });

  factory Mothlyreport.fromJson(Map<String, dynamic> json) => Mothlyreport(
        id: json["id"],
        name: json["name"],
        mobile: json["mobile"],
        empid: json["empid"],
        attendances: List<Attendance>.from(
            json["attendances"].map((x) => Attendance.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobile": mobile,
        "empid": empid,
        "attendances": List<dynamic>.from(attendances.map((x) => x.toJson())),
      };
}

class Attendance {
  int id;
  int userId;
  int companyId;
  int branchId;
  String checkIn;
  dynamic checkOut;
  DateTime attendanceDate;
  dynamic selfieImg;
  dynamic checkoutSelfieImg;
  dynamic lat;
  dynamic lon;
  dynamic checkoutLat;
  dynamic checkoutLon;
  String autoCheckout;
  String lateCheckin;
  dynamic workedHours;
  dynamic overtimedHours;

  Attendance({
    required this.id,
    required this.userId,
    required this.companyId,
    required this.branchId,
    required this.checkIn,
    required this.checkOut,
    required this.attendanceDate,
    required this.selfieImg,
    required this.checkoutSelfieImg,
    required this.lat,
    required this.lon,
    required this.checkoutLat,
    required this.checkoutLon,
    required this.autoCheckout,
    required this.lateCheckin,
    required this.workedHours,
    required this.overtimedHours,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
        id: json["id"],
        userId: json["user_id"],
        companyId: json["company_id"],
        branchId: json["branch_id"],
        checkIn: json["check_in"],
        checkOut: json["check_out"],
        attendanceDate: DateTime.parse(json["attendance_date"]),
        selfieImg: json["selfie_img"],
        checkoutSelfieImg: json["checkout_selfie_img"],
        lat: json["lat"],
        lon: json["lon"],
        checkoutLat: json["checkout_lat"],
        checkoutLon: json["checkout_lon"],
        autoCheckout: json["auto_checkout"],
        lateCheckin: json["late_checkin"],
        workedHours: json["worked_hours"],
        overtimedHours: json["overtimed_hours"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "company_id": companyId,
        "branch_id": branchId,
        "check_in": checkIn,
        "check_out": checkOut,
        "attendance_date":
            "${attendanceDate.year.toString().padLeft(4, '0')}-${attendanceDate.month.toString().padLeft(2, '0')}-${attendanceDate.day.toString().padLeft(2, '0')}",
        "selfie_img": selfieImg,
        "checkout_selfie_img": checkoutSelfieImg,
        "lat": lat,
        "lon": lon,
        "checkout_lat": checkoutLat,
        "checkout_lon": checkoutLon,
        "auto_checkout": autoCheckout,
        "late_checkin": lateCheckin,
        "worked_hours": workedHours,
        "overtimed_hours": overtimedHours,
      };
}
