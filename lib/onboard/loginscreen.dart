import 'dart:convert';

import 'package:finance_app/core/APIConfig.dart';
import 'package:finance_app/core/res/AppColor.dart';
import 'package:finance_app/core/res/AppStyle.dart';
import 'package:finance_app/core/widgets/WidgetButton.dart';
import 'package:finance_app/core/widgets/WidgetPopup.dart';
import 'package:finance_app/onboard/setpinscreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  _LoginscreenState createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  late final TextEditingController _idController = TextEditingController();
  late final TextEditingController _passwordController = TextEditingController();
  late final TextEditingController _agentIdcontroller = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
  String mobile = '';
  bool existingUser = true;
  bool isLoading = true;

  Future<void> loginuser(BuildContext context) async {
    if (!_loginFormKey.currentState!.validate()) return;
    final empid = _idController.text;
    final password = _passwordController.text;

    final url = Uri.parse(Apiconfig.loginapi);
    final Map<String, dynamic> requestBody = {
      "email": empid,
      "password": password,
    };

    showProgress(context);
    try {
      // Send the POST request
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: json.encode(requestBody),
      );

      // Handle the response
      if (response.statusCode == 200) {
        final responseBody = jsonDecode(response.body);

        String token = responseBody['data']['token'];
        String name = responseBody['data']['name'];
        int userid = responseBody['data']['user_id'] as int;
        List<dynamic> roles = responseBody['data']['role'];
        dynamic profileImg = responseBody['data']['profileimg'];
        String role = roles.isNotEmpty ? roles[0] : 'Unknown';
        print(role);
        final prefs = await SharedPreferences.getInstance();

        setState(() {
          isLoading = false;
        });

        await prefs.setString('token', token);
        await prefs.setString('name', name);
        if (profileImg != null) {
          await prefs.setString('profileImg', profileImg);
        }

        await prefs.setString('roles', role);
        print('Saved roles: $role');
        // if (role == 'Admin') {
        //   await getAdminFCMToken(userid);
        // }
        // if (role == 'Employee') {
        //   await getemployeeFCMToken(userid);
        // }
        // Store list as JSON string
        await prefs.setBool('isLoggedIn', true);
        // await prefs.setInt('userid', userid);
        await prefs.setInt('user_id', userid);
        print('Saved User ID: $userid');

        print("Login successful: $responseBody");
        hideProgress(context);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login successful!")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SetPinScreen()),
        );

        // Navigate to the next screen or handle login success
      } else {
        print("Login failed: ${response.body}");
        hideProgress(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid Employee ID or Password")),
        );
      }
    } catch (error) {
      print("Error during login: $error");
      hideProgress(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("An error occurred. Please try again.")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    BuildContext buildContext = context;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: AppColor.appbackground,
        body: Padding(
          padding: const EdgeInsets.all(1.0),
          child: SingleChildScrollView(
            child: SizedBox(
              height: screenHeight,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    Image.asset(
                      "assets/images/login/login.png",
                      height: 300,
                      width: 300,
                    ),
                    const SizedBox(height: 10),
                    Container(
                        // height: 450,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            // borderRadius: BorderRadius.only(
                            //   topLeft: Radius.circular(20),
                            //   topRight: Radius.circular(20),
                            // ),
                            border: Border.all(
                              color: AppColor.appprimary,
                              width: 1,
                            ),
                            color: AppColor.colorwhite),
                           
                        child: Form(
                          key: _loginFormKey,
                         
                          child: Column(
                            
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Center(
                                child: Text(
                                  "User Detail",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 20),
                              buildInputField(
                                  "Login Id",
                                  "Enter Login ID",
                                  _idController,
                                  (value) => value!.isEmpty
                                      ? "Login ID is required"
                                      : null),
                              buildInputField(
                                "Login Password",
                                "Login Password",
                                _passwordController,
                                (value) => value!.length < 6
                                    ? "Password must be at least 6 characters"
                                    : null,
                                isPassword: true,
                              ),
                              // buildInputField(
                              //     "Agent ID",
                              //     "Enter Agent ID",
                              //     _agentIdcontroller,
                              //     (value) => value!.isEmpty
                              //         ? "Agent ID is required"
                              //         : null),
                              const SizedBox(height: 20),
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 20),
                                // width: screenwidth / 1.5,
                                child: Center(
                                  child: primaryButton(
                                    context: context,
                                    strButtonName: 'Login',
                                    callback: () {
                                      if (!_loginFormKey.currentState!
                                          .validate()) {
                                      } else {
                                        loginuser(context);
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))
                  ]),
            ),
          ),
        ));
  }
}

Widget buildInputField(String label, String hint,
    TextEditingController controller, String? Function(String?)? validator,
    {bool isPassword = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppStyle.textStyleSemiBold.copyWith(
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.black38),
              filled: true,
              fillColor: AppColor.appbackground,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none,
              ),
            ),
            validator: validator),
      ],
    ),
  );
}
