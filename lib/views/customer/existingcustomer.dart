import 'dart:convert';

import 'package:finance_app/core/APIConfig.dart';
import 'package:finance_app/core/res/AppColor.dart';
import 'package:finance_app/core/widgets/WidgetButton.dart';
import 'package:finance_app/core/widgets/WidgetPopup.dart';
import 'package:finance_app/models/totalemp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class Existingcustomer extends StatefulWidget {
  const Existingcustomer({super.key});

  @override
  _ExistingcustomerState createState() => _ExistingcustomerState();
}

class _ExistingcustomerState extends State<Existingcustomer> {
  List<Totalemp> _items = [];
  int total = 0;
  int active = 0;
  int inactive = 0; // To hold the API data
  String usertoken = '';
  bool isLoading = true;

  Future<void> _Userrihgtsstatus(int creatorid, String status) async {
    final Map<String, dynamic> body = {'status': status, 'user_id': creatorid};
    showProgress(context);

    try {
      final uri = Uri.parse(Apiconfig.totalemp);
      // https://makkalcalendar.mpeoplesnet.com/api/update-user-status

      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      final responseData = json.decode(response.body);

      if (!mounted) return;
      if (response.statusCode == 200) {
        hideProgress(context);
        fetchEmployees();
        _showSuccessSnackBar('User Rights Updated');
      } else {
        String errorMessage = responseData['message'] ?? 'An error occurred';
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showErrorSnackBar(errorMessage);
        });
      }
    } catch (e) {
      print(e);
      _showErrorSnackBar('An error occurred');
    } finally {
      hideProgress(context);
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  Future<void> fetchEmployees() async {
    const baseUrl = Apiconfig.totalemp;
    // https: //makkalcalendar.mpeoplesnet.com/api/list-user

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(baseUrl));
      showProgress(context);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final List<dynamic> totaluserData = responseData['data']['userList'];
        final int activeUser = responseData['data']['active'];
        final int inactiveUser =
            responseData['data']['inactive']; // Get the data from the API
        final int totaluser = responseData['data']['total'];

        print(activeUser);
        if (responseData['data'] != null &&
            responseData['data']['userList'] != null) {
          final List<dynamic> presentUsersData =
              responseData['data']['userList'];
          final List<Totalemp> totalUsers =
              presentUsersData.map((userJson) {
                return Totalemp.fromJson(userJson);
              }).toList();
          print("Present Users: ${totalUsers.length}");
          hideProgress(context);
          setState(() {
            _items = totalUsers;
            total = totaluser;
            inactive = inactiveUser;
            active = activeUser;
            isLoading = false;
          });
          // Process data
        }

        print(totaluserData);
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      hideProgress(context);
    }
  }

  @override
  void initState() {
    super.initState();

    fetchEmployees();
  }

  @override
  Widget build(BuildContext context) {
    BuildContext mainContext = context;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Employee list',
          style: TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     // Action when button is pressed
      //     print("navigate add employee page");
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => Addcustomer(),
      //       ),
      //     );
      //   },
      //   backgroundColor: AppColor.appprimary,

      //   label: Text(
      //     "Add Employee",
      //     style: TextStyle(fontSize: 12, color: Colors.white),
      //   ),
      //   icon: Icon(
      //     Icons.add,
      //     color: Colors.white,
      //   ),
      //   isExtended: true, // Icon inside the button
      //   // Tooltip text on long press
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              height: 150,
              width: screenWidth - 20,
              margin: const EdgeInsets.symmetric(horizontal: 14),
              padding: const EdgeInsets.only(
                top: 16,
                bottom: 16,
                left: 14,
                right: 14,
              ),
              decoration: BoxDecoration(
                color: AppColor.colorGrayLight,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  formattopstatuscircle(
                    context,
                    'assets/images/home/totalemp.png',
                    total.toString(),
                  ),
                  formattopstatuscircle(
                    context,
                    'assets/images/home/activeemp.png',
                    active.toString(),
                  ),
                  formattopstatuscircle(
                    context,
                    'assets/images/home/inactive.png',
                    inactive.toString(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.centerLeft,
              child: Text(
                'Employee list ${_items.length}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),
            isLoading
                ? fullScreenLoader()
                :
                // Show loading while fetching data
                (_items.isEmpty)
                ? Center(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 300,
                    width: 300,
                    decoration: const BoxDecoration(
                      // color: Colors.grey.withOpacity(0.5),
                      // borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            'assets/json/loader.json', // Path to your Lottie file
                            width: 150,
                            height: 150,
                            fit: BoxFit.contain,
                          ),
                          const Text(
                            'No Employees Found',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                : SizedBox(
                  height: MediaQuery.of(context).size.height - 300,
                  width: MediaQuery.of(context).size.height - 35,
                  child: AnimationLimiter(
                    child: ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        final employee = _items[index];
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 350),
                          child: FlipAnimation(
                            child: GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => {}));
                                // Monthlydetails(
                                //     userId: employee.id,
                                //     name: employee.name ??
                                //         "No Name", // Null check for name
                                //     empid: employee
                                //             .empid ??
                                //         "No Emp ID", // Null check for empid
                                //     email: employee
                                //             .email ??
                                //         "No Email", // Null check for email
                                //     mobile: employee
                                //             .mobile ??
                                //         "No Mobile", // Null check for mobile
                                //     role: widget.role,
                                //     imageurl: employee
                                //             .profileImg ??
                                //         "no img")),
                                // );
                              },
                              child: EmployeeCard(
                                context: context,
                                screenWidth: MediaQuery.of(context).size.width,
                                name: employee.name ?? "",
                                profileImg: employee.profileImg ?? "",
                                mobile: employee.mobile ?? "",
                                empId: employee.empid ?? "",
                                email: employee.email ?? "",
                                userId: employee.id ?? 0,
                                userStatus: employee.status ?? 0,
                                onToggle: (id, status) {
                                  _Userrihgtsstatus(id, status);
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}

class EmployeeCard extends StatelessWidget {
  final double screenWidth;
  final String name;
  final String profileImg;
  final String mobile;
  final String empId;
  final String email;
  final int userId;
  final int userStatus;
  final Function(int userId, String status) onToggle;

  const EmployeeCard({
    super.key,
    required this.context,
    required this.screenWidth,
    required this.name,
    required this.profileImg,
    required this.mobile,
    required this.empId,
    required this.email,
    required this.userId,
    required this.userStatus,
    required this.onToggle,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth - 20,
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        border: Border.all(color: const Color(0xFF848C99), width: 1.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Profile Image
          Container(
            width: 60,
            height: 60,
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child:
                (profileImg.isNotEmpty)
                    ? GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                child: Image.network(
                                  profileImg,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/images/home/empavatar.png',
                                      fit: BoxFit.contain,
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(profileImg),
                          ),
                        ),
                      ),
                    )
                    : Image.asset(
                      'assets/images/home/empavatar.png',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
          ),

          // Employee Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 4.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name.isEmpty ? "No name" : name,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Color(0xFF18283F),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    mobile.isEmpty ? "No number" : mobile,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF18283F),
                    ),
                  ),
                  Text(
                    empId.isEmpty ? "No empid" : empId,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF18283F),
                    ),
                  ),
                  Text(
                    email.isEmpty ? "No email" : email,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF18283F),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Toggle Switch
          FlutterSwitch(
            width: 40,
            height: 22,
            padding: 1.5,
            borderRadius: 50.0,
            toggleSize: 16,
            value: userStatus == 1,
            activeColor: Colors.green,
            inactiveColor: Colors.white,
            activeToggleColor: Colors.white,
            inactiveToggleColor: Colors.red,
            toggleColor: Colors.white,
            activeSwitchBorder: Border.all(color: Colors.green, width: 2),
            inactiveSwitchBorder: Border.all(color: Colors.red, width: 2),
            onToggle: (value) {
              final String newStatus = value ? '1' : '0';
              onToggle(userId, newStatus);
            },
          ),
        ],
      ),
    );
  }
}

formattopstatuscircle(BuildContext context, String imgpath, String length) {
  return Expanded(
    child: Column(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Image.asset(imgpath),
        ),
        const SizedBox(height: 10),
        Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
            color: AppColor.colorWhite,
            shape: BoxShape.circle,
          ),
          // padding: EdgeInsets.all(20),
          child: Center(
            child: Text(
              length,
              style: const TextStyle(
                fontSize: 15,
                color: AppColor.colorBlack,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
