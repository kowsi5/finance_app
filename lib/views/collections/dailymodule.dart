import 'package:finance_app/core/res/AppColor.dart';
import 'package:finance_app/core/res/AppStyle.dart';
import 'package:finance_app/core/utils/AppNavigator.dart';
import 'package:finance_app/views/collections/unplanned.dart';
import 'package:finance_app/views/collections/viewdemandform.dart';
import 'package:finance_app/views/daily/usergetinfo.dart';
import 'package:flutter/material.dart';

class Dailymodule extends StatefulWidget {
  final String collectiontype;

  const Dailymodule({super.key, required this.collectiontype});

  @override
  State<Dailymodule> createState() => _DailymoduleState();
}

class _DailymoduleState extends State<Dailymodule> {
  String collectiontype = "";

  @override
  void initState() {
    super.initState();

    collectiontype = widget.collectiontype;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appbackground, // Light background color
      appBar: AppBar(
        title: Text("$collectiontype Collections"),
        backgroundColor: AppColor.appbackground,
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          Container(
            height: 1,
            color: AppColor.appprimary,
          ),
          const SizedBox(
            height: 20,
          ),
          buildListTile(
            icon: Icons.groups,
            title: "Batch Individual",
            onTap: () {
              navigatePushReplacement(
                  context,
                  Usergetinfo(
                    collectiontype: collectiontype,
                  ));
            },
          ),
          ExpansionTile(
            leading: const Icon(Icons.insert_drive_file, color: Colors.blue),
            backgroundColor: AppColor.colorWhite,
            title: Text(
              "$collectiontype Demand List",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            children: [
              buildMenuOption("View Demand List"),
              buildMenuOption("Planned"),
              buildMenuOption("Unplanned"),
              buildMenuOption("Download Demand List"),
            ],
          ),
        ],
      ),
    );
  }

  // Function to create a simple list tile
  Widget buildListTile(
      {required IconData icon, required String title, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title, style: const TextStyle(fontSize: 16)),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.blue),
      onTap: onTap,
    );
  }

  // Function to create menu items inside ExpansionTile
  Widget buildMenuOption(String title) {
    return GestureDetector(
        onTap: () {
          if (title == "View Demand List") {
            navigatePush(
                context,
                (Viewdemandform(
                  collectiontype: collectiontype,
                )));
          } else if (title == "Planned") {
            navigatePush(context, (()));
          } else if (title == "Unplanned") {
            navigatePush(
                context,
                (Unplanned(
                  collectiontype: collectiontype,
                )));
          } else if (title == "Download Demand List") {
            navigatePush(context, (()));
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey, width: 1),
          ),
          child: Center(
            child: Text(
              title,
              style: AppStyle.textStyleSemiBold.copyWith(
                fontSize: 14,
              ),
            ),
          ),
        ));
  }
}
