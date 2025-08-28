
import 'package:finance_app/core/res/AppColor.dart';
import 'package:finance_app/core/res/AppImage.dart';
import 'package:finance_app/core/res/AppStyle.dart';
import 'package:finance_app/core/utils/Constants.dart';
import 'package:finance_app/core/widgets/WidgetText.dart';
import 'package:finance_app/views/loancategory.dart';
import 'package:finance_app/views/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finance_app/Providers/BaseProvider.dart';
import 'package:provider/provider.dart';

class Mainhome extends StatefulWidget {
  const Mainhome({super.key});

  @override
  _MainhomeState createState() => _MainhomeState();
}

class _MainhomeState extends State<Mainhome> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    BuildContext mainContext = context;
    final provider = Provider.of<BaseProvider>(context);

    return Scaffold(
      body: Consumer<BaseProvider>(
          builder: (context, providerValue, child) => Stack(
                children: [
                  Column(
                    children: [
                      // Container(
                      //   height: MediaQuery.of(context).viewPadding.top,
                      //   color: AppColor.appprimary,
                      // ),
                      getSelectedScreen(
                          provider: provider, screen: provider.selectedMenu),
                    ],
                  ),
                  if (Constants.showSplash) ...[]
                ],
              )),
      bottomNavigationBar: Consumer<BaseProvider>(
          builder: (context, providerValue, child) => Container(
                height: 70,
                decoration:
                    const BoxDecoration(color: AppColor.colorWhite, boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      offset: Offset(0, 2),
                      blurRadius: 5),
                ]),
                child: Row(
                  children: [
                    Expanded(
                      child: formatBottomTabs(
                          title: "Home",
                          icon: AppImage.imgBottomMenuHome,
                          onClick: () {
                            Scaffold.of(context).closeDrawer();
                            provider.updateScreen("Home");
                            return null;
                          }),
                    ),
                    Expanded(
                      child: formatBottomTabs(
                          title: "New loans",
                          icon: AppImage.imgBottomwallet,
                          onClick: () {
                            Scaffold.of(context).closeDrawer();
                            provider.updateScreen("New loans");
                            return null;
                          }),
                    ),
                    // Expanded(
                    //   child: formatBottomCenterTabs(
                    //       title: "",
                    //       icon: AppImage.calendar,
                    //       onClick: () {
                    //         Scaffold.of(context).closeDrawer();
                    //         showBottomSheetMenu(mainContext: mainContext);
                    //         return null;
                    //       }),
                    // ),
                    // Expanded(
                    //   child: formatBottomTabs(
                    //       title: "தகவல்",
                    //       icon: AppImage.imgBottomMenuDays,
                    //       onClick: () {
                    //         Scaffold.of(context).closeDrawer();
                    //         provider.updateScreen("தகவல்");
                    //         return null;
                    //       }),
                    // ),
                    Expanded(
                      child: formatBottomTabs(
                          title: "Collections",
                          icon: AppImage.imgBottomloans,
                          onClick: () {
                            Scaffold.of(context).closeDrawer();
                            provider.updateScreen("Collections");
                            return null;
                          }),
                    ),
                    Expanded(
                      child: formatBottomTabs(
                          title: "Profile",
                          icon: AppImage.imgBottomprofile,
                          onClick: () {
                            Scaffold.of(context).closeDrawer();
                            provider.updateScreen("Profile");
                            return null;
                          }),
                    ),
                  ],
                ),
              )),
    );
  }
}

Widget formatBottomTabs(
    {required String title,
    required String icon,
    required VoidCallback? Function() onClick}) {
  return Consumer<BaseProvider>(
      builder: (context, providerValue, child) => InkWell(
            onTap: () {
              onClick();
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (providerValue.selectedMenu == title) ...[
                  SvgPicture.asset(icon,
                      height: 40,
                      width: 40,
                      colorFilter: const ColorFilter.mode(
                          AppColor.appprimary, BlendMode.srcATop)),
                  appText(
                      text: title,
                      style: AppStyle.textStyleNormal
                          .copyWith(fontSize: 12, color: AppColor.appprimary)),
                  Container(
                    height: 3,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
                if (providerValue.selectedMenu != title) ...[
                  SvgPicture.asset(icon,
                      height: 60,
                      width: 60,
                      colorFilter: const ColorFilter.mode(
                          AppColor.colorTextDark, BlendMode.srcIn)),
                  // appText(
                  //     text: title,
                  //     style: AppStyle.textStyleNormal
                  //         .copyWith(fontSize: 11, color: AppColor.colorBlack))
                ]
              ],
            ),
          ));
}

Widget getSelectedScreen(
    {required BaseProvider provider, required String screen}) {
  if (screen == "Home") {
    return Expanded(child: Container(child: const Homescreen()));
  } else if (screen == "New loans") {
    return Expanded(child: Container(child: const Loancategory()));
  } else if (screen == "collections") {
    return Expanded(child: Container(child: const Homescreen()));
  } else if (screen == "Profile") {
    return Expanded(child: Container(child: const Homescreen()));
  } else {
    return Expanded(child: Container(child: const Homescreen()));
  }
}
