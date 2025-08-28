// class APIConfig {
//   APIConfig._();

//   static String authToken = "";

//   static const String mediaURL = "https://gsdnutrition.mpeoplesnet.com/api/";
//   // static const String appTerms = "https://mpeoples.in/termsandconditions/";
//   static const String baseImageURL = "https://users.mpdatahub.com/";
//   static const String shareDeepLinkURL = "https://www.readersmenu.com/";
// }

class Apiconfig {
  static const String baseUrl = "https://gsdnutrition.mpeoplesnet.com/api/";

  static const String loginapi = "${baseUrl}login";
  static const String addemployee = "${baseUrl}add-user";
  static const String employeedaily =
  
      "${baseUrl}attendance-report-for-user-day?";
  static const String admindaily = "${baseUrl}report-for-date?";
  static const String checkinemp = "${baseUrl}add-checkin";
  static const String checkoutemp = "${baseUrl}add-checkout";

  static const String getreportmonth =
      "${baseUrl}attendance-report-for-user-month?";
  static const String resetpassword = "${baseUrl}reset-employee-password";
  static const String empstatus = "${baseUrl}update-user-status";
  static const String totalemp = "${baseUrl}list-user";
  static const String getmainbranch = "${baseUrl}list-company";
  static const String getsubbranch =
      "${baseUrl}get-branch-for-company?company_id=";
  static const String getuserbyrole = "${baseUrl}roles";

  static const String addactivity = "${baseUrl}add-activity";
  static const String listactivity = "${baseUrl}list-activity";
  static const String listactivityupdate = "${baseUrl}update-activity-status";
  static const String listuseractivity = "${baseUrl}list-activity-user";

  static const String listuserdropdown = "${baseUrl}list-customers";
  static const String addnewloan = "${baseUrl}addLoan";
  static const String listloans = "${baseUrl}list-loans";
  static const String addloandue = "${baseUrl}add-loan-due";
}
