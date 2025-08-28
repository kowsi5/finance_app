class Attendance {
  final int id;
  final int userId;
  final String checkIn;
  final String? checkOut;
  final String attendanceDate;

  Attendance({
    required this.id,
    required this.userId,
    required this.checkIn,
    this.checkOut,
    required this.attendanceDate,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      id: json['id'],
      userId: json['user_id'],
      checkIn: json['check_in'],
      checkOut: json['check_out'],
      attendanceDate: json['attendance_date'],
    );
  }
}

class User {
  final int id;
  final String name;
  final String? mobile;
  final String? empid;
  final List<Attendance> attendances;

  User({
    required this.id,
    required this.name,
    this.mobile,
    this.empid,
    required this.attendances,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    var attendancesList = (json['attendances'] as List)
        .map((attendance) => Attendance.fromJson(attendance))
        .toList();
    return User(
      id: json['id'],
      name: json['name'],
      mobile: json['mobile'],
      empid: json['empid'],
      attendances: attendancesList,
    );
  }
}

class Presentemployee {
  int id;
  String name;
  String mobile;
  dynamic empid;
  List<Attendance> attendances;

  Presentemployee({
    required this.id,
    required this.name,
    required this.mobile,
    required this.empid,
    required this.attendances,
  });

  factory Presentemployee.fromJson(Map<String, dynamic> json) =>
      Presentemployee(
        id: json["id"],
        name: json["name"],
        mobile: json["mobile"],
        empid: json["empid"],
        attendances: List<Attendance>.from(
            json["attendances"].map((x) => Attendance.fromJson(x))),
      );
}

class Attendancecheck {
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

  Attendancecheck({
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

  factory Attendancecheck.fromJson(Map<String, dynamic> json) =>
      Attendancecheck(
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
}

class CategoryModelList {
  String id;
  String name;
  // String image;

  CategoryModelList({
    required this.id,
    required this.name,
    // required this.image,
  });

  factory CategoryModelList.fromJson(Map<String, dynamic> json) =>
      CategoryModelList(
        id: json["id"],
        name: json["name"],
        // image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        // "image": image,
      };
}


