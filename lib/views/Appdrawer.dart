import 'package:finance_app/core/res/AppColor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatefulWidget {
  final int userId;
  final String? name;
  final String? imageurl;
  final String? role;
  final DateTime? selectedDate;

  const AppDrawer(
      {super.key,
      required this.userId,
      this.name,
      this.imageurl,
      this.role,
      this.selectedDate});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

List<bool> isDroppedList = [
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false
];

class _AppDrawerState extends State<AppDrawer> {
  bool isadmin = false;

  @override
  void initState() {
    super.initState();
    print(widget.role);

    
  }

  Future<bool?> confirmLogout(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              // height: 150,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(colors: [
                AppColor.appprimary,
                AppColor.colorViolet,
                AppColor.appbackground
              ])
                  // color: Colors.deepPurple,
                  ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15),
                    Container(
                      height: 75,
                      width: 75,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          shape: BoxShape.circle,
                          color: Colors.white,
                          image: const DecorationImage(
                              image: AssetImage(
                            'assets/images/home/person.png',
                          ))),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'MPeoples Business Solutions',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                    
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    
                    drawermodelMenu(
                        icon: "assets/images/login/logout.png",
                        title: "logout",
                        MenuOnTap1: () async {
                          bool? shouldLogout = await confirmLogout(context);
                          if (shouldLogout == true) {
                            await logout(
                                context); // <-- Call your logout function here
                          }
                        }),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

// drawer widget
  Widget drawerMenu(
      {required int index,
      required String icon,
      required String icon2,
      required String icon3,
      required String title,
      required String subMenuTitle1,
      required String subMenuTitle2,
      required Function() subMenuOnTap1,
      required Function() subMenuOnTap2}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            setState(() {
              if (isDroppedList[index]) {
                isDroppedList[index] = false;
              } else {
                isDroppedList = List<bool>.filled(isDroppedList.length, false);
                isDroppedList[index] = true;
              }
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Image.asset(icon, height: 30, width: 30),
                  ),
                  Text(title, style: const TextStyle(fontSize: 16)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 18),
                child: Icon(
                  isDroppedList[index]
                      ? Icons.arrow_drop_up_outlined
                      : Icons.arrow_drop_down_outlined,
                ),
              )
            ],
          ),
        ),
        isDroppedList[index]
            ? Padding(
                padding: const EdgeInsets.only(left: 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          subMenuOnTap1();
                          setState(() {
                            isDroppedList =
                                List<bool>.filled(isDroppedList.length, false);
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                width: 40,
                                height: 30,
                                padding: const EdgeInsets.all(2),
                               
                                child: Image.asset(icon2)),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                subMenuTitle1,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          subMenuOnTap2();
                          setState(() {
                            isDroppedList =
                                List<bool>.filled(isDroppedList.length, false);
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                width: 40,
                                height: 30,
                                padding: const EdgeInsets.all(2),
                                
                                child: Image.asset(icon3)),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                subMenuTitle2,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox.shrink(),
        const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(
              color: Colors.grey,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            )),
      ],
    );
  }
}

Widget drawermodelMenu({
  required String icon,
  required String title,
  required Function() MenuOnTap1,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          MenuOnTap1();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Image.asset(icon, height: 30, width: 30),
                ),
                Text(title, style: const TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
      const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Divider(
            color: Colors.grey,
            thickness: 1,
            indent: 0,
            endIndent: 0,
          )),
    ],
  );
}
