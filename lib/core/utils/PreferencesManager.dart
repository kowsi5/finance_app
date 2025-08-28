import 'package:shared_preferences/shared_preferences.dart';

import 'Constants.dart';

class PreferenceManager {
  PreferenceManager._();

  static Future<SharedPreferences> sharedPref = SharedPreferences.getInstance();

  static var PREF_INTRO = "pref_intro";
  static var PREF_TOKEN = "pref_token";
  static var PREF_USERID = "pref_userid";
  static var PREF_USERNAME = "pref_username";
  static var PREF_MOBILENUMBER = "pref_mobilenumber";
  static var PREF_EMAILADDRESS = "pref_emailaddress";
  static var PREF_DOB = "pref_dob";
  static var PREF_REFERAL_CODE = "pref_referal_code";
  static var PREF_COUPON_EXIST = "pref_coupon_exist";
  static var PREF_USER_RIGHT = "pref_user_right";
  static var PREF_CONTENT_REQUEST = "pref_content_request";
  static var PREF_ROLE_ID = "pref_role_id";
  static var PREF_PUSH_NOTIFICATION = "pref_push_notification";
  static var PREF_FCM_TOKEN = "pref_fcm_token";

  static var PREF_NOTIFICATION_TYPE = "notification_type";
  static var PREF_NOTIFICATION_TYPE_ID = "notification_type_id";
  static var PREF_NOTIFICATION_IMAGE = "notification_image";
  static var PREF_NOTIFICATION_CONTENT = "notification_content";

  static getPrefString(String key, String defaultValue) async {
    SharedPreferences prefs = await sharedPref;
    var value = prefs.getString(key);
    if (value == null) {
      return defaultValue;
    } else {
      return value;
    }
  }

  static setPrefString(String key, String value) async {
    SharedPreferences prefs = await sharedPref;
    prefs.setString(key, value);
  }

  static getPrefAccessToken() async {
    SharedPreferences prefs = await sharedPref;
    var value = prefs.getString(PREF_TOKEN);
    if (value == null || value == "") {
      return "";
    } else {
      return "Bearer $value";
    }
  }

  static proceedLogout() async {
    SharedPreferences prefs = await sharedPref;
    prefs.setString(PREF_TOKEN, "");
  }

  static getUserInfo() async {
    SharedPreferences prefs = await sharedPref;

    Constants.strUserToken = prefs.getString(PREF_TOKEN) ?? "";
    if (Constants.strUserToken != "") {
      Constants.strUserId = prefs.getString(PREF_USERID) ?? "";
      Constants.strUserName = prefs.getString(PREF_USERNAME) ?? "";
      Constants.strMobileNumber = prefs.getString(PREF_MOBILENUMBER) ?? "";
      Constants.strEmailAddress = prefs.getString(PREF_EMAILADDRESS) ?? "";
      Constants.strDOB = prefs.getString(PREF_DOB) ?? "";
      Constants.strReferralCode = prefs.getString(PREF_REFERAL_CODE) ?? "";
      Constants.strCouponExist = prefs.getString(PREF_COUPON_EXIST) ?? "";
      Constants.strUserRights = prefs.getString(PREF_USER_RIGHT) ?? "";
      Constants.strContentRequest = prefs.getString(PREF_CONTENT_REQUEST) ?? "";
      Constants.strRoleId = prefs.getString(PREF_ROLE_ID) ?? "";
    }
  }

  static clearUserInfo() async {
    SharedPreferences prefs = await sharedPref;
    prefs.setString(PREF_TOKEN, "");
    prefs.setString(PREF_USERID, "");
    prefs.setString(PREF_USERNAME, "");
    prefs.setString(PREF_MOBILENUMBER, "");
    prefs.setString(PREF_EMAILADDRESS, "");
    prefs.setString(PREF_DOB, "");
    prefs.setString(PREF_REFERAL_CODE, "");
    prefs.setString(PREF_COUPON_EXIST, "");
    prefs.setString(PREF_USER_RIGHT, "");
    prefs.setString(PREF_CONTENT_REQUEST, "");
    prefs.setString(PREF_ROLE_ID, "");
    prefs.setString(PREF_FCM_TOKEN, "");

    Constants.strUserId = "";
    Constants.strUserName = "";
    Constants.strMobileNumber = "";
    Constants.strEmailAddress = "";
    Constants.strDOB = "";
    Constants.strReferralCode = "";
    Constants.strCouponExist = "";
    Constants.strUserRights = "";
    Constants.strContentRequest = "";
    Constants.strRoleId = "";
  }

  static updateUserInfo(
    String strUserID,
    String strUserName,
    String strMobileNumber,
    String strEmailAddress,
    String strDOB,
    String strReferalCode,
    String strCouponExist,
    String strUserRight,
    String strContentRequest,
    String strRoleId,
  ) async {
    SharedPreferences prefs = await sharedPref;

    prefs.setString(PREF_USERID, strUserID);
    prefs.setString(PREF_USERNAME, strUserName);
    prefs.setString(PREF_MOBILENUMBER, strMobileNumber);
    prefs.setString(PREF_EMAILADDRESS, strEmailAddress);
    prefs.setString(PREF_DOB, strDOB);
    prefs.setString(PREF_REFERAL_CODE, strReferalCode);
    prefs.setString(PREF_COUPON_EXIST, strCouponExist);
    prefs.setString(PREF_USER_RIGHT, strUserRight);
    prefs.setString(PREF_CONTENT_REQUEST, strContentRequest);
    prefs.setString(PREF_ROLE_ID, strRoleId);
  }

  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await sharedPref;
    var value = prefs.getString(PREF_TOKEN);
    if (value == null || value == "") {
      return false;
    } else {
      return true;
    }
  }

  static Future<bool> isNotificationEnabled() async {
    SharedPreferences prefs = await sharedPref;
    var value = prefs.getString(PREF_PUSH_NOTIFICATION);
    if (value == null || value == "" || value == "1") {
      return true;
    } else {
      return false;
    }
  }
}
