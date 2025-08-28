import 'package:finance_app/core/res/AppColor.dart';
import 'package:finance_app/core/res/AppStyle.dart';
import 'package:finance_app/core/widgets/WidgetButton.dart';
import 'package:flutter/material.dart';

class Viewdemandlist extends StatefulWidget {
  const Viewdemandlist({super.key});

  @override
  _ViewdemandlistState createState() => _ViewdemandlistState();
}

class _ViewdemandlistState extends State<Viewdemandlist> {
  final List<Map<String, dynamic>> demandData = [
    {
      "name": "Amutha",
      "location": "Tiruchengode",
      "week": "W-03",
      "date": "15-03-2025",
      "total": 10000,
      "paid": 3000,
      "pending": 7000,
      "emi": 1000,
      "balance": 0
    },
    {
      "name": "atithi",
      "location": "Cbe",
      "week": "W-04",
      "date": "22-03-2025",
      "total": 12000,
      "paid": 5000,
      "pending": 7000,
      "emi": 2000,
      "balance": 500
    },
    {
      "name": "atithi",
      "location": "Cbe",
      "week": "W-04",
      "date": "22-03-2025",
      "total": 12000,
      "paid": 5000,
      "pending": 7000,
      "emi": 2000,
      "balance": 500
    },
    {
      "name": "atithi",
      "location": "Cbe",
      "week": "W-04",
      "date": "22-03-2025",
      "total": 12000,
      "paid": 5000,
      "pending": 7000,
      "emi": 2000,
      "balance": 500
    },
    {
      "name": "atithi",
      "location": "Cbe",
      "week": "W-04",
      "date": "22-03-2025",
      "total": 12000,
      "paid": 5000,
      "pending": 7000,
      "emi": 2000,
      "balance": 500
    },
    {
      "name": "atithi",
      "location": "Cbe",
      "week": "W-04",
      "date": "22-03-2025",
      "total": 12000,
      "paid": 5000,
      "pending": 7000,
      "emi": 2000,
      "balance": 500
    },
    {
      "name": "atithi",
      "location": "Cbe",
      "week": "W-04",
      "date": "22-03-2025",
      "total": 12000,
      "paid": 5000,
      "pending": 7000,
      "emi": 2000,
      "balance": 500
    },
    {
      "name": "atithi",
      "location": "Cbe",
      "week": "W-04",
      "date": "22-03-2025",
      "total": 12000,
      "paid": 5000,
      "pending": 7000,
      "emi": 2000,
      "balance": 500
    },
    {
      "name": "atithi",
      "location": "Cbe",
      "week": "W-04",
      "date": "22-03-2025",
      "total": 12000,
      "paid": 5000,
      "pending": 7000,
      "emi": 2000,
      "balance": 500
    },
    {
      "name": "atithi",
      "location": "Cbe",
      "week": "W-04",
      "date": "22-03-2025",
      "total": 12000,
      "paid": 5000,
      "pending": 7000,
      "emi": 2000,
      "balance": 500
    },
    {
      "name": "atithi",
      "location": "Cbe",
      "week": "W-04",
      "date": "22-03-2025",
      "total": 12000,
      "paid": 5000,
      "pending": 7000,
      "emi": 2000,
      "balance": 500
    },
    {
      "name": "atithi",
      "location": "Cbe",
      "week": "W-04",
      "date": "22-03-2025",
      "total": 12000,
      "paid": 5000,
      "pending": 7000,
      "emi": 2000,
      "balance": 500
    },
    {
      "name": "atithi",
      "location": "Cbe",
      "week": "W-04",
      "date": "22-03-2025",
      "total": 12000,
      "paid": 5000,
      "pending": 7000,
      "emi": 2000,
      "balance": 500
    },
    {
      "name": "atithi",
      "location": "Cbe",
      "week": "W-04",
      "date": "22-03-2025",
      "total": 12000,
      "paid": 5000,
      "pending": 7000,
      "emi": 2000,
      "balance": 500
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.appbackground,
      appBar: AppBar(
        title: const Text("Weekly Collections"),
        backgroundColor: AppColor.appbackground,
      ),
      body: Column(
        children: [
          // Header
          Container(
            decoration: const BoxDecoration(
              color: Colors.blue,
              // borderRadius: BorderRadius.circular(10),
            ),
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            // margin: EdgeInsets.all(15),
            child: const Text(
              "Demand Lists",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Demand List
          Expanded(
            child: ListView.builder(
              itemCount: demandData.length,
              itemBuilder: (context, index) {
                final item = demandData[index];
                return formatcard(context, item, screenWidth);
              },
            ),
          ),
        ],
      ),
    );
  }
}

formatcard(
    BuildContext context, Map<String, dynamic> item, double screenwidth) {
  return Container(
    margin: const EdgeInsets.all(8),
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: AppColor.colorwhite,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Name with Contact Icon + Week on Right Side
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.person,
                  color: AppColor.appprimary,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(item["name"],
                    style: AppStyle.textStyleBold
                        .copyWith(fontSize: 16, color: AppColor.colorBlack)),
              ],
            ),
            Text(item["week"],
                style: AppStyle.textStyleBold
                    .copyWith(fontSize: 14, color: AppColor.colorBlack)),
          ],
        ),
        const SizedBox(height: 5),

        // Location with Icon

        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              item["date"],
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Container(
                decoration: const BoxDecoration(),
                child: popupSuccessButton(
                    context: context,
                    strButtonName: "EMI 1000",
                    callback: () {
                      return null;
                    }))
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            formatrow("Total", item["total"].toString()),
            formatrow("Paid", item["paid"].toString()),
            formatrow("Pending", item["pending"].toString()),
            formatrow("Balance", item["balance"].toString()),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: item["paid"] / item["total"],
                  backgroundColor: AppColor.colorBlack,
                  color: AppColor.appprimary,
                  minHeight: 13,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Text(
              "${(item["paid"] / item["total"] * 100).toStringAsFixed(1)}%",
              style: AppStyle.textStyleExtraBold.copyWith(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

formatrow(String title, String value) {
  return Column(
    children: [
      Text(title,
          style: AppStyle.textStyleSemiBold
              .copyWith(fontSize: 16, color: AppColor.colorGray)),
      Text("₹$value",
          style: AppStyle.textStyleSemiBold
              .copyWith(fontSize: 16, color: AppColor.appprimary)),
    ],
  );
}

formatrow2(String title, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          const Icon(
            Icons.person,
            color: AppColor.appprimary,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(title,
              style: AppStyle.textStyleBold
                  .copyWith(fontSize: 16, color: AppColor.colorBlack)),
        ],
      ),
      Text(value,
          style: AppStyle.textStyleBold
              .copyWith(fontSize: 14, color: AppColor.colorBlack)),
    ],
  );
}
