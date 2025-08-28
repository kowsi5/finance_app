import 'package:finance_app/core/res/AppColor.dart';
import 'package:flutter/material.dart';

class Enquirysection extends StatelessWidget {
  Enquirysection({super.key});

  final List<String> options = [
    "Balance Enquiry",
    "Mini Statement",
    "Collected Balance",
    "Financial Transaction",
    "Cash Withdrawal",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appbackground,
      appBar: AppBar(
        title: const Text("Enquiry"),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 1,
              color: AppColor.appprimary,
            ),
            const SizedBox(height: 20),
            Container(
              width: 320,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColor.colorwhite,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColor.appprimary,
                  width: 1,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Column(
                children: options
                    .asMap()
                    .entries
                    .map((entry) => buildMenuItem(
                        entry.value, entry.key == options.length - 1))
                    .toList(),
              ),
            ),
          ]),
    );
  }
}

Widget buildMenuItem(String title, bool isLast) {
  return InkWell(
    onTap: () {
      print("$title tapped");
    },
    splashColor: Colors.blue.shade100,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(bottom: BorderSide(width: 1, color: AppColor.appprimary)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.blue),
        ],
      ),
    ),
  );
}
