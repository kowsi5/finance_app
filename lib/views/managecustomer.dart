import 'package:finance_app/core/res/AppColor.dart';
import 'package:finance_app/core/res/AppStyle.dart';
import 'package:finance_app/core/utils/AppNavigator.dart';
import 'package:finance_app/models/MenuList.dart';
import 'package:finance_app/views/customer/Leadshistory.dart';
import 'package:finance_app/views/customer/addcustomer.dart';
import 'package:finance_app/views/customer/existingcustomer.dart';
import 'package:finance_app/views/customer/newleads.dart';
import 'package:flutter/material.dart';

class Managecustomer extends StatefulWidget {
  const Managecustomer({super.key});

  @override
  State<Managecustomer> createState() => _ManagecustomerState();
}

class _ManagecustomerState extends State<Managecustomer> {
  List<Menu> listMenus = [];

  @override
  void initState() {
    super.initState();
    MenuListloader();
  }

  Future<void> MenuListloader() async {
    // Load the JSON file from assets
    formatMenuList();
  }

  formatMenuList() {
    listMenus.add(Menu(
        title: "Add\nCustomer",
        image: "assets/images/home/newuser.png",
        object: "AddCustomer"));
    listMenus.add(Menu(
        title: "Manage\nCustomer",
        image: "assets/images/home/mnguser.png",
        object: "ManageCustomer"));
    listMenus.add(Menu(
        title: "New loan",
        image: "assets/images/home/loan.png",
        object: "newLeads"));
    listMenus.add(Menu(
        title: "Manage Loans",
        image: "assets/images/home/manageloan.png",
        object: "manageloans"));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColor.appbackground,
      appBar: AppBar(
        title: Text(
          'Manage Customers',
          style: AppStyle.txtHeader
              .copyWith(color: AppColor.colorWhite, fontSize: 22),
        ),
        iconTheme: const IconThemeData(color: AppColor.colorwhite),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: Center(
            child: Container(
              padding: const EdgeInsets.only(top: 10),
              child: Wrap(
                  children: List.generate(listMenus.length, (index) {
                return InkWell(
                    onTap: () {
                      if (listMenus[index].object == "AddCustomer") {
                        navigatePush(context, (const Addcustomer()));
                      } else if (listMenus[index].object == "ManageCustomer") {
                        navigatePush(context, (const Existingcustomer()));
                      } else if (listMenus[index].object == "newLeads") {
                        navigatePush(context, (const Newleads()));
                      } else if (listMenus[index].object == "manageloans") {
                        navigatePush(
                            context,
                            (const Leaverequest(
                              userId: 0,
                              acttype: "loan",
                            )));
                      }
                    },
                    child: buildGridViewLayout(listMenus[index], screenWidth));
              })),
            ),
          )),
        ],
      ),
    );
  }
}

buildGridViewLayout(Menu subMenu, double screenWidth) {
  return Container(
      width: (screenWidth) / 2.7,
      height: 120,
      // padding: EdgeInsets.all(5),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColor.colorWhite,
          boxShadow: const [
            BoxShadow(
              color: AppColor.appprimary,
              offset: Offset(
                1.0,
                1.0,
              ),
              blurRadius: 2.5,
              spreadRadius: 2.0,
            )
          ],
          borderRadius: BorderRadius.circular(10)),
      // border: Border.all(color: Color(0xCC5A244D), width: 0.1)),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.all(5),
                width: (screenWidth) / 2.5,
                child: Column(
                  children: [
                    Image.asset(
                      subMenu.image.toString(),
                      height: 50,
                      width: 60,
                    ),
                    const SizedBox(height: 10),
                    Text(subMenu.title,
                        textAlign: TextAlign.center,
                        style: AppStyle.txtFieldHeader
                            .copyWith(fontSize: 12, color: AppColor.colorBlack))
                  ],
                )),
            // const SizedBox(height: 10),
          ]));
}
