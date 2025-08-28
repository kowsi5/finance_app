import 'dart:io';

import 'package:finance_app/Providers/BaseProvider.dart';
import 'package:finance_app/core/res/AppColor.dart';
import 'package:finance_app/core/widgets/WidgetSupport.dart';
import 'package:finance_app/onboard/checkpinscreen.dart';
import 'package:finance_app/onboard/loginscreen.dart';
// import 'package:finance_app/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (context) => BaseProvider(context, "", "")),
    ],
    child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      title: 'Finance',
      color: AppColor.colorTFFFocus,
      supportedLocales: const [
        Locale('en', ''),
        Locale('ta', ''),
      ],
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 227, 23, 193),
        checkboxTheme: CheckboxThemeData(
            visualDensity: zeroVisualDensity(),
            fillColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.selected)) {
                return const Color.fromARGB(255, 230, 37, 188);
              }
              return AppColor.colorWhite;
            }),
            checkColor: MaterialStateProperty.resolveWith((states) {
              return AppColor.colorWhite;
            })),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return AppColor.appprimary;
            }
            return AppColor.colorGray;
          }),
          visualDensity: zeroVisualDensity(),
        ),
        useMaterial3: true,
      ),
      home: const AuthCheck(),
    ),
  ));
}

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  bool locationvar = false;
  bool userAvailable = false;
  bool _isInitialized = false;

  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    initializeApp();
  }

  Future<void> initializeApp() async {
    await _getCurrentUser();
    setState(() {
      _isInitialized = true;
    });
  }

  Future<void> _getCurrentUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      if (sharedPreferences.getString('') != "") {
        print(sharedPreferences.getBool('isLoggedIn'));
        setState(() {
          isLoggedIn = sharedPreferences.getBool('isLoggedIn') ?? false;
          // User.employeeId = sharedPreferences.getString('employeeId')!;
        });
      }
    } catch (e) {
      setState(() {
        userAvailable = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return isLoggedIn ? const MpinScreen() : const Loginscreen();
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return
//   }
// }
