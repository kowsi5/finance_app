import '../core/utils/Support.dart';

class ResultUserInfo {
  int code;
  List<ResUserInfo> data;

  ResultUserInfo({
    required this.code,
    required this.data,
  });

  factory ResultUserInfo.fromJson(Map<String, dynamic> json) => ResultUserInfo(
        code: json["code"],
        data: List<ResUserInfo>.from(
            json["data"].map((x) => ResUserInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ResUserInfo {
  String id;
  String name;
  String email;
  String appName;
  String referalCode;
  String referalUserid;
  String createdAt;
  String updatedAt;
  String referal;
  String mobile;
  String dob;
  String sentSms;
  String onBoarding;
  String smsSentTime;
  String otpVerified;
  String isDeleted;
  String couponExist;
  String stopGetcoupon;
  String gender;
  String relation;
  String aboutYourself;
  String relationDescription;
  String addedBy;
  String userRights;
  String userRole;
  String profileImage;
  String contentRequest;
  String requestedDate;
  String requestFrom;
  String requestApprovedDate;
  String requestApprovedBy;
  String state;
  String district;
  String city;

  ResUserInfo({
    required this.id,
    required this.name,
    required this.email,
    required this.appName,
    required this.referalCode,
    required this.referalUserid,
    required this.createdAt,
    required this.updatedAt,
    required this.referal,
    required this.mobile,
    required this.dob,
    required this.sentSms,
    required this.onBoarding,
    required this.smsSentTime,
    required this.otpVerified,
    required this.isDeleted,
    required this.couponExist,
    required this.stopGetcoupon,
    required this.gender,
    required this.relation,
    required this.aboutYourself,
    required this.relationDescription,
    required this.addedBy,
    required this.userRights,
    required this.userRole,
    required this.profileImage,
    required this.contentRequest,
    required this.requestedDate,
    required this.requestFrom,
    required this.requestApprovedDate,
    required this.requestApprovedBy,
    required this.state,
    required this.district,
    required this.city,
  });

  factory ResUserInfo.fromJson(Map<String, dynamic> json) => ResUserInfo(
        id: formatResponseData(json["id"].toString()),
        name: formatResponseData(json["name"].toString()),
        email: formatResponseData(json["email"].toString()),
        appName: formatResponseData(json["app_name"].toString()),
        referalCode: formatResponseData(json["referal_code"].toString()),
        referalUserid: formatResponseData(json["referal_userid"].toString()),
        createdAt: formatResponseData(json["created_at"].toString()),
        updatedAt: formatResponseData(json["updated_at"].toString()),
        referal: formatResponseData(json["referal"].toString()),
        mobile: formatResponseData(json["mobile"].toString()),
        dob: formatResponseData(json["dob"].toString()),
        sentSms: formatResponseData(json["sent_sms"].toString()),
        onBoarding: formatResponseData(json["on_boarding"].toString()),
        smsSentTime: formatResponseData(json["sms_sent_time"].toString()),
        otpVerified: formatResponseData(json["otp_verified"].toString()),
        isDeleted: formatResponseData(json["isDeleted"].toString()),
        couponExist: formatResponseData(json["coupon_exist"].toString()),
        stopGetcoupon: formatResponseData(json["stop_getcoupon"].toString()),
        gender: formatResponseData(json["gender"].toString()),
        relation: formatResponseData(json["relation"].toString()),
        aboutYourself: formatResponseData(json["about_yourself"].toString()),
        relationDescription:
            formatResponseData(json["relation_description"].toString()),
        addedBy: formatResponseData(json["added_by"].toString()),
        userRights: formatResponseData(json["user_rights"].toString()),
        userRole: formatResponseData(json["user_role"].toString()),
        profileImage: formatResponseData(json["profile_image"].toString()),
        contentRequest: formatResponseData(json["content_request"].toString()),
        requestedDate: formatResponseData(json["requested_date"].toString()),
        requestFrom: formatResponseData(json["request_from"].toString()),
        requestApprovedDate:
            formatResponseData(json["request_approved_date"].toString()),
        requestApprovedBy:
            formatResponseData(json["request_approved_by"].toString()),
        state: formatResponseData(json["state"].toString()),
        district: formatResponseData(json["district"].toString()),
        city: formatResponseData(json["city"].toString()),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "app_name": appName,
        "referal_code": referalCode,
        "referal_userid": referalUserid,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "referal": referal,
        "mobile": mobile,
        "dob": dob,
        "sent_sms": sentSms,
        "on_boarding": onBoarding,
        "sms_sent_time": smsSentTime,
        "otp_verified": otpVerified,
        "isDeleted": isDeleted,
        "coupon_exist": couponExist,
        "stop_getcoupon": stopGetcoupon,
        "gender": gender,
        "relation": relation,
        "about_yourself": aboutYourself,
        "relation_description": relationDescription,
        "added_by": addedBy,
        "user_rights": userRights,
        "user_role": userRole,
        "profile_image": profileImage,
        "content_request": contentRequest,
        "requested_date": requestedDate,
        "request_from": requestFrom,
        "request_approved_date": requestApprovedDate,
        "request_approved_by": requestApprovedBy,
        "state": state,
        "district": district,
        "city": city,
      };
}

