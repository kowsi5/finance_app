import 'package:finance_app/core/res/AppColor.dart';
import 'package:finance_app/core/res/AppStyle.dart';
import 'package:finance_app/core/utils/AppNavigator.dart';
import 'package:finance_app/models/MenuList.dart';
import 'package:finance_app/views/Appdrawer.dart';
import 'package:finance_app/views/collections/dailymodule.dart';
import 'package:finance_app/views/enquiry/enquirysection.dart';
import 'package:finance_app/views/managecustomer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<Menu> listMenus = [];
  String? userNmae;
  int fetchuserid = 0;
  String? profileimageurl;

  @override
  void initState() {
    super.initState();
    MenuListloader();
  }

  Future<void> MenuListloader() async {
    // Load the JSON file from assets
    formatMenuList();
  }

  Future<void> getStoredData() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? name = prefs.getString('name');
    dynamic profileimg = prefs.getString('profileImg');
    String? rolesJson = prefs.getString('roles');
    int? userId = prefs.getInt('user_id');
    if (userId != null) {
      print('Retrieved User ID: $userId');
    } else {
      print('No User ID found.');
    }

    print('Fetched pagerole: $rolesJson');
    print('Fetched token: $token');
    print('Fetched name: $name');
    print('Fetched profile image: $profileimg');

    setState(() {
      userNmae = name;
      fetchuserid = userId!;

      profileimageurl = profileimg ?? "noimg";

      // profileimageurl = profileimg ?? "noimg";
    });

    //   }
  }

  formatMenuList() {
    listMenus.add(Menu(
        title: "Daily\nCollections",
        image: "assets/images/home/daily.png",
        object: "daily"));
    listMenus.add(Menu(
        title: "Weekly\nCollections",
        image: "assets/images/home/weekly.png",
        object: "weekly"));
    listMenus.add(Menu(
        title: "Monthly\nCollections",
        image: "assets/images/home/monthly.png",
        object: "monthly"));
    listMenus.add(Menu(
        title: "Magalir\nCollections",
        image: "assets/images/home/women.png",
        object: "womenloan"));
    listMenus.add(Menu(
        title: "Enquiry",
        image: "assets/images/home/enquiry.png",
        object: "enquiry"));
    listMenus.add(Menu(
        title: "Settlement",
        image: "assets/images/home/settlement.png",
        object: "settlement"));
    // listMenus.add(
    //     Menu(title: "", image: "assets/images/home/enquiry.png", object: ""));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Finance App',
          style: AppStyle.txtHeader
              .copyWith(color: AppColor.colorWhite, fontSize: 22),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColor.colorwhite),
      ),
      drawer: const AppDrawer(userId: 0),
      body: SingleChildScrollView(
          child: Column(children: [
        formattop(
            "Kowsi", "83AABBCC", "Erode", "assets/images/home/person.png"),
        // Container(),
        Container(
            // height: 400,
            child: SingleChildScrollView(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: Wrap(
                children: List.generate(listMenus.length, (index) {
              return InkWell(
                  onTap: () {
                    if (listMenus[index].object == "daily") {
                      navigatePush(
                          context, const Dailymodule(collectiontype: "Daily"));
                    } else if (listMenus[index].object == "weekly") {
                      navigatePush(
                          context, (const Dailymodule(collectiontype: "Weekly")));
                    } else if (listMenus[index].object == "monthly") {
                      navigatePush(
                          context, (const Dailymodule(collectiontype: "Monthly")));
                    } else if (listMenus[index].title == "") {
                      navigatePush(context, ());
                    } else if (listMenus[index].title == "") {
                      navigatePush(context, (
                        strName: listMenus[index].title,
                        imgpath: listMenus[index].image,
                        objectName: listMenus[index].object
                      ));
                    } else if (listMenus[index].title == "Enquiry") {
                      navigatePush(context, Enquirysection());
                    }
                  },
                  child: buildGridViewLayout(listMenus[index], screenWidth));
            })),
          ),
        ]))),
        GestureDetector(
          onTap: () {
            navigatePush(context, const Managecustomer());
          },
          child: Container(
            child: Center(
              child: Container(
                  width: (screenWidth) / 2.3,
                  height: 70,
                  // padding: EdgeInsets.all(5),
                  margin: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/home/conback.png'),
                    ),
                    // border: Border.all(color: Color(0xCC5A244D), width: 0.1)
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(5),
                            width: (screenWidth) / 2.5,
                            child: Row(
                              children: [
                                Image.asset("assets/images/home/women.png",
                                    height: 40),
                                const SizedBox(width: 10),
                                Text("Manage\nCustomer",
                                    textAlign: TextAlign.center,
                                    style: AppStyle.txtFieldHeader.copyWith(
                                        fontSize: 12,
                                        color: AppColor.appbackground))
                              ],
                            )),
                        // const SizedBox(height: 10),
                      ])),
            ),
          ),
        )
      ])),
    );
  }
}

formattop(String Name, String Id, String branch, String imgpath) {
  return Container(
    // height: 200,
    decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
        ),
        border: Border(
          top: BorderSide(
            color: AppColor.appbackground,
            width: 1.0,
          ),
        ),
        color: Colors.blue),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            const SizedBox(
              width: 30,
            ),
            ClipOval(
              child: Image.asset(
                imgpath, // Replace with your image URL
                width: 80, // Set desired width
                height: 80, // Set desired height
                fit: BoxFit.cover, // Ensures the image covers the oval shape
              ),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Good Morning",
                    style: AppStyle.textStyleNormal
                        .copyWith(fontSize: 15, color: AppColor.colorWhite)),
                Text(
                  Name,
                  style: AppStyle.textStyleBold
                      .copyWith(fontSize: 16, color: AppColor.colorWhite),
                )
              ],
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(children: [
          const SizedBox(width: 40),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(
              "Branch",
              style: AppStyle.textStyleBold
                  .copyWith(fontSize: 16, color: AppColor.colorWhite),
            ),
            Text(
              "AgentId",
              style: AppStyle.textStyleBold
                  .copyWith(fontSize: 16, color: AppColor.colorWhite),
            )
          ]),
          const SizedBox(
            width: 20,
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              branch,
              style: AppStyle.textStyleBold
                  .copyWith(fontSize: 16, color: AppColor.colorWhite),
            ),
            Text(
              Id,
              style: AppStyle.textStyleBold
                  .copyWith(fontSize: 16, color: AppColor.colorWhite),
            )
          ])
        ]),
        const SizedBox(
          height: 40,
        ),
      ],
    ),
  );
}

buildGridViewLayout(Menu subMenu, double screenWidth) {
  return Container(
      width: (screenWidth) / 2.3,
      height: 70,
      // padding: EdgeInsets.all(5),
      margin: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/home/conback.png'),
        ),
        // border: Border.all(color: Color(0xCC5A244D), width: 0.1)
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.all(5),
                width: (screenWidth) / 2.5,
                child: Row(
                  children: [
                    Image.asset(subMenu.image.toString(), height: 40),
                    const SizedBox(width: 10),
                    Text(subMenu.title,
                        textAlign: TextAlign.center,
                        style: AppStyle.txtFieldHeader.copyWith(
                            fontSize: 12, color: AppColor.appbackground))
                  ],
                )),
            // const SizedBox(height: 10),
          ]));
}
