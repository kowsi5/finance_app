import 'dart:ui';
// import 'dart:mirrors';
// import 'package:reflectable/reflectable.dart';
import 'package:finance_app/models/ResultUserInfo.dart';
import '../../models/MenuList.dart';

class Constants {
  Constants._();

  static String versionCode = "1.2.7";
  static int versionId = 27;
  static bool isProfileCalled = false;
  static bool isLoggedIn = false;

  static bool showSplash = false;
  static bool isProgressShowing = false;

  static String galleryCategory = "266";
  static String templeCategory = "266";
  static String specialInfoCategory = "268";
  static String whatsappCategory = "269";
  static String anmekaPathivuCategory = "269";

  static String lottieSuccess = "Success";
  static String lottieAlert = "Alert";
  static String lottieMaintenance = "Maintenance";
  static String lottieError = "Error";
  static String lottieNoInternet = "NoInternet";

  static String strUserToken = "";
  static String strUserId = "";
  static String strUserName = "";
  static String strUserImage = "";
  static String strMobileNumber = "";
  static String strEmailAddress = "";
  static String strDOB = "";
  static String strReferralCode = "";
  static String strCouponExist = "";
  static String strIsDeleted = "";
  static String strUserRights = "";
  static String strContentRequest = "";
  static String strRoleId = "";

  static String notificationType = "";
  static String notificationId = "";
  static String notificationImage = "";
  static String notificationContent = "";
  static String fcmToken = "";

  static ResUserInfo userInfo = ResUserInfo(
      id: "",
      name: "",
      email: "",
      appName: "",
      referalCode: "",
      referalUserid: "",
      createdAt: "",
      updatedAt: "",
      referal: "",
      mobile: "",
      dob: "",
      sentSms: "",
      onBoarding: "",
      smsSentTime: "",
      otpVerified: "",
      isDeleted: "",
      couponExist: "",
      stopGetcoupon: "",
      gender: "",
      relation: "",
      aboutYourself: "",
      relationDescription: "",
      addedBy: "",
      userRights: "",
      userRole: "",
      profileImage: "",
      contentRequest: "",
      requestedDate: "",
      requestFrom: "",
      requestApprovedDate: "",
      requestApprovedBy: "",
      state: "",
      district: "",
      city: "");

  static String serviceTypeJosiyar = "1";
  static String serviceTypeManaiyadiSasthiram = "2";
  static String serviceTypeIyer = "3";
  static String serviceTypeKurukal = "4";

  // static ResSettings settingInfo = ResSettings();

  static var faceBoolURL =
      "https://www.facebook.com/people/%E0%AE%AE%E0%AE%95%E0%AF%8D%E0%AE%95%E0%AE%B3%E0%AF%8D-%E0%AE%A8%E0%AE%BE%E0%AE%9F%E0%AF%8D%E0%AE%95%E0%AE%BE%E0%AE%9F%E0%AF%8D%E0%AE%9F%E0%AE%BF/61563438916723/";
  static var instagramURL =
      "https://www.instagram.com/makkal_calendar/?igsh=bzRsZ2dvMndqenUw";
  static var playStoreURL =
      "http://play.google.com/store/apps/details?id=com.makkal.calendar";
  static var youtubeUrl = "https://youtube.com/@makkalnaatkaati?feature=shared";

  // static List<MonthElement> calendarData = [];
  // static List<ResiDatum> rasiDatum = [];
  // static List<MonthModel> MonthPickerData = [
  //   MonthModel(id: 0, tmMonth: 'ஜனவரி', enMonth: 'Jan'),
  //   MonthModel(id: 1, tmMonth: 'பிப்ரவரி', enMonth: 'Feb'),
  //   MonthModel(id: 2, tmMonth: 'மார்ச்', enMonth: 'Mar'),
  //   MonthModel(id: 3, tmMonth: 'ஏப்ரல்', enMonth: 'Apr'),
  //   MonthModel(id: 4, tmMonth: 'மே', enMonth: 'May'),
  //   MonthModel(id: 5, tmMonth: 'ஜூன்', enMonth: 'Jun'),
  //   MonthModel(id: 6, tmMonth: 'ஜூலை', enMonth: 'Jul'),
  //   MonthModel(id: 7, tmMonth: 'ஆகஸ்ட்', enMonth: 'Aug'),
  //   MonthModel(id: 8, tmMonth: 'செப்டம்பர்', enMonth: 'Sep'),
  //   MonthModel(id: 9, tmMonth: 'அக்டோபர்', enMonth: 'Oct'),
  //   MonthModel(id: 10, tmMonth: 'நவம்பர்', enMonth: 'Nov'),
  //   MonthModel(id: 11, tmMonth: 'டிசம்பர்', enMonth: 'Dec')
  // ];

  static List<String> daysName = [
    "Sun",
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat"
  ];
  static List<String> enMonthName = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  static List<String> tmMonthName = [
    'ஜனவரி',
    'பிப்ரவரி',
    'மார்ச்',
    'ஏப்ரல்',
    'மே',
    'ஜூன்',
    'ஜூலை',
    'ஆகஸ்ட்',
    'செப்டம்பர்',
    'அக்டோபர்',
    'நவம்பர்',
    'டிசம்பர்'
  ];

  static Map<String, String> monthNameMapping = {
    "Jan": "ஜனவரி",
    "Feb": "பிப்ரவரி",
    "Mar": "மார்ச்",
    "Apr": "ஏப்ரல்",
    "May": "மே",
    "Jun": "ஜூன்",
    "Jul": "ஜூலை",
    "Aug": "ஆகஸ்ட்",
    "Sep": "செப்டம்பர்",
    "Oct": "அக்டோபர்",
    "Nov": "நவம்பர்",
    "Dec": "டிசம்பர்",
  };

  static Map<String, String> monthNameMapNumber = {
    "Jan": "01",
    "Feb": "02",
    "Mar": "03",
    "Apr": "04",
    "May": "05",
    "Jun": "06",
    "Jul": "07",
    "Aug": "08",
    "Sep": "09",
    "Oct": "10",
    "Nov": "11",
    "Dec": "12",
  };

  static List listColors = [
    const Color(0xFFFACC7F),
    const Color(0xFFA5D6A7),
    const Color(0xFFEE9A9A),
    const Color(0xFFB0BEC5),
    const Color(0xFFCF93D9),
    const Color(0xFFFFD8B1),
    const Color(0xFFFCF59D),
    const Color(0xFFA8EFFD),
    const Color(0xFFFC9DA5),
    const Color(0xFFE0D986),
    const Color(0xFFB4F8C7),
    const Color(0xFFFACC7F),
    const Color(0xFFA5D6A7),
    const Color(0xFFEE9A9A),
    const Color(0xFFB0BEC5),
    const Color(0xFFCF93D9),
    const Color(0xFFFFD8B1),
    const Color(0xFFFCF59D),
    const Color(0xFFA8EFFD),
    const Color(0xFFFC9DA5),
    const Color(0xFFE0D986),
    const Color(0xFFB4F8C7),
    const Color(0xFFFACC7F),
    const Color(0xFFA5D6A7),
    const Color(0xFFEE9A9A),
    const Color(0xFFB0BEC5),
    const Color(0xFFCF93D9),
    const Color(0xFFFFD8B1),
    const Color(0xFFFCF59D),
    const Color(0xFFA8EFFD),
    const Color(0xFFFC9DA5),
    const Color(0xFFE0D986),
    const Color(0xFFB4F8C7),
    const Color(0xFF80B5FF),
  ];

  static List<Menu> listCityMenus = [
    Menu(
        title: "சேலம்",
        image: "assets/images/cities/salem.png",
        object: "salem"),
    Menu(
        title: "கோயம்புத்தூர்",
        image: "assets/images/cities/coimbatore.png",
        object: "coimbatore"),
    Menu(
        title: "சென்னை",
        image: "assets/images/cities/chennai.png",
        object: "chennai"),
    Menu(
        title: "நாமக்கல்",
        image: "assets/images/cities/namakkal.png",
        object: "namakkal"),
    Menu(
        title: "திருப்பூர்",
        image: "assets/images/cities/tiruppur.png",
        object: "tiruppur"),
    Menu(
        title: "கிருஷ்ணகிரி",
        image: "assets/images/cities/krishnagiri.png",
        object: "krishnagiri"),
    Menu(
        title: "திருநெல்வேலி",
        image: "assets/images/cities/tirunelveli.png",
        object: "tirunelveli"),
    Menu(
        title: "தென்காசி",
        image: "assets/images/cities/tenkasi.png",
        object: "tenkasi"),
    Menu(
        title: "கன்னியாகுமரி",
        image: "assets/images/cities/kanyakumari.png",
        object: "kanyakumari"),
    Menu(
        title: "மதுரை",
        image: "assets/images/cities/madurai.png",
        object: "madurai"),
    Menu(
        title: "விருதுநகர்",
        image: "assets/images/cities/virudhunagar.png",
        object: "virudhunagar"),
    Menu(
        title: "தர்மபுரி",
        image: "assets/images/cities/dharmapuri.png",
        object: "dharmapuri"),
    Menu(
        title: "புதுக்கோட்டை",
        image: "assets/images/cities/pudukkottai.png",
        object: "pudukkottai"),
    Menu(
        title: "காஞ்சிபுரம்",
        image: "assets/images/cities/kanchipuram.png",
        object: "kanchipuram"),
    Menu(
        title: "செங்கல்பட்டு",
        image: "assets/images/cities/chengalpattu.png",
        object: "chengalpattu"),
    Menu(
        title: "திருவள்ளூர்",
        image: "assets/images/cities/thiruvallur.png",
        object: "thiruvallur"),
    Menu(
        title: "திருவண்ணாமலை",
        image: "assets/images/cities/thiruvannamalai.png",
        object: "thiruvannamalai"),
    Menu(
        title: "வேலூர்",
        image: "assets/images/cities/vellore.png",
        object: "vellore"),
    Menu(
        title: "விழுப்புரம்",
        image: "assets/images/cities/viluppuram.png",
        object: "viluppuram"),
    Menu(
        title: "திருப்பத்தூர்",
        image: "assets/images/cities/tirupattur.png",
        object: "tirupattur"),
    Menu(
        title: "அரியலூர்",
        image: "assets/images/cities/ariyalur.png",
        object: "ariyalur"),
    Menu(
        title: "கடலூர்",
        image: "assets/images/cities/cuddalore.png",
        object: "cuddalore"),
    Menu(
        title: "மயிலாடுதுறை",
        image: "assets/images/cities/mayiladuthurai.png",
        object: "mayiladuthurai"),
    Menu(
        title: "பெரம்பலூர்",
        image: "assets/images/cities/perambalur.png",
        object: "perambalur"),
    Menu(
        title: "தஞ்சாவூர்",
        image: "assets/images/cities/thanjavur.png",
        object: "thanjavur"),
    Menu(
        title: "திருவாரூர்",
        image: "assets/images/cities/thiruvarur.png",
        object: "thiruvarur"),
    Menu(
        title: "திண்டுக்கல்",
        image: "assets/images/cities/dindigul.png",
        object: "dindigul"),
    Menu(
        title: "திருச்சி",
        image: "assets/images/cities/trichy.png",
        object: "trichy"),
    Menu(
        title: "சிவகங்கை",
        image: "assets/images/cities/sivaganga.png",
        object: "sivaganga"),
    Menu(
        title: "தேனி",
        image: "assets/images/cities/theni.png",
        object: "theni"),
    Menu(
        title: "கரூர்",
        image: "assets/images/cities/karur.png",
        object: "karur"),
    Menu(
        title: "நாகப்பட்டினம்",
        image: "assets/images/cities/nagapattinam.png",
        object: "nagapattinam"),
    Menu(
        title: "ராமநாதபுரம்",
        image: "assets/images/cities/ramanathapuram.png",
        object: "ramanathapuram"),
    Menu(
        title: "நீலகிரி",
        image: "assets/images/cities/nilgiris.png",
        object: "nilgiris"),
    Menu(
        title: "ஈரோடு",
        image: "assets/images/cities/erode.png",
        object: "erode"),
    Menu(
        title: "தூத்துக்குடி",
        image: "assets/images/cities/thoothukudi.png",
        object: "thoothukudi"),
    Menu(
        title: "இராணிப்பேட்டை",
        image: "assets/images/cities/ranipet.png",
        object: "ranipet"),
    Menu(
        title: "கள்ளக்குறிச்சி",
        image: "assets/images/cities/kallakurichi.png",
        object: "kallakurichi"),
  ];

  static List<Menu> listTab1 = [];
  static List<Menu> listTab2 = [];
  static List<Menu> listTab3 = [];
  static List<Menu> listTab4 = [];
  static List<Menu> listTab5 = [];
  static List<Menu> listTab6 = [];
  static List<Menu> listTab7 = [];
  static List<Menu> listTab8 = [];
  static List<Menu> listTab9 = [];
  static List<Menu> listTab10 = [];
  static List<Menu> listTab11 = [];
  static List<Menu> listTab12 = [];
  static List<Menu> listTab13 = [];
  static List<Menu> listTab14 = [];
  static List<Menu> listTab15 = [];
  static List<Menu> listTab16 = [];
}
