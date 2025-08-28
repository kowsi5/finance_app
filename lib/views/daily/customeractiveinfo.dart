
// import 'package:finance_app/api/apiconfig.dart';
import 'package:finance_app/core/res/AppColor.dart';
import 'package:finance_app/core/res/AppStyle.dart';
import 'package:finance_app/core/widgets/WidgetButton.dart';
import 'package:finance_app/models/userinfoloan.dart';
import 'package:flutter/material.dart';

class Customeractiveinfo extends StatefulWidget {
  final String collectiontype;

  const Customeractiveinfo({super.key, required this.collectiontype});

  @override
  _CustomeractiveinfoState createState() => _CustomeractiveinfoState();
}

class _CustomeractiveinfoState extends State<Customeractiveinfo> {
  String collectiontype = "";
  String customerid = "";
  String customername = "";
  String imgpath = "";
  String branch = "";
  List<Loan> customerDetails = [];
  List<Loan> customerDetails2 = [];

  bool isloading = false;

  // Future<void> getAccessscustomerloaninfo() async {
  //   setState(() {
  //     isloading = true;
  //   });

  //   final response = await Apiservices().getUserLoanInfo();

  //   print(response.code);

  //   if (response.data != null && response.data.loans != null) {
  //     List<Loan> activeLoans =
  //         response.data.loans.where((loan) => loan.status == "active").toList();

  //     setState(() {
  //       customerDetails = activeLoans;
  //       customername = response.data.name ?? "";
  //       customerid = response.data.loanId ?? "";
  //       collectiontype = widget.collectiontype;
  //       branch = response.data.branch ?? "";
  //       imgpath = response.data.imgPath ?? "";
  //       isloading = false;
  //     });

  //     print(customerDetails);
  //     print(customername);
  //     print(branch);
  //   } else {
  //     // Handle the case where response.data is null
  //     print("No data received from API.");

  //     setState(() {
  //       isloading = false;
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    collectiontype = widget.collectiontype;
    // getAccessscustomerloaninfo();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: AppColor.appbackground,
        appBar: AppBar(
          title: Text(
            'Customer Details',
            style: AppStyle.txtHeader
                .copyWith(color: AppColor.colorBlack, fontSize: 22),
          ),
          backgroundColor: AppColor.appbackground,
          // centerTitle: true,
        ),
        body: isloading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    formattop(
                      context,
                      customername,
                      customerid,
                      branch,
                      imgpath ?? "",
                    ),
                    SizedBox(
                        height: 500,
                        child: ListView.builder(
                            // padding: EdgeInsets.all(10),
                            itemCount: customerDetails.length,
                            itemBuilder: (context, index) {
                              var person = customerDetails[index];
                              return formatcard(
                                  context, person, screenWidth, collectiontype);
                            }))
                    // ...customerDetails.map<Widget>((loan) {
                    //   return formatcard(
                    //       context, loan, screenWidth, collectiontype);
                    // }),
                  ],
                ),
              ));
  }
}

formattop(BuildContext context, String Name, String Id, String branch,
    String imgpath) {
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
        color: AppColor.appprimary),
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
                imgpath == ""
                    ? "assets/images/home/person.png"
                    : imgpath, // Replace with your image URL
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
                        .copyWith(fontSize: 13, color: AppColor.colorWhite)),
                Text(
                  Name,
                  style: AppStyle.textStyleBold
                      .copyWith(fontSize: 16, color: AppColor.colorWhite),
                ),
                Row(children: [
                  // SizedBox(width: 40),
                  Column(children: [
                    Text(
                      "Branch: ",
                      style: AppStyle.textStyleBold
                          .copyWith(fontSize: 16, color: AppColor.colorWhite),
                    ),
                    Text(
                      "AgentId: ",
                      style: AppStyle.textStyleBold
                          .copyWith(fontSize: 16, color: AppColor.colorWhite),
                    )
                  ]),
                  // SizedBox(
                  //   width: 20,
                  // ),
                  Column(children: [
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
              ],
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    ),
  );
}

formatcard(BuildContext context, Loan item, double screenwidth,
    String collectiontype) {
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.menu,
                  color: AppColor.appprimary,
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(item.loanNo,
                    style: AppStyle.textStyleBold
                        .copyWith(fontSize: 16, color: AppColor.colorBlack)),
              ],
            ),
            Container(
                decoration: const BoxDecoration(),
                child: popupactiveButton(
                    context: context,
                    strButtonName: item.status,
                    callback: () {
                      return null;
                    }))
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Issue DueDate",
                  style: AppStyle.textStyleSemiBold
                      .copyWith(fontSize: 12, color: AppColor.colorBlack),
                ),
                Text(
                  item.loanStart.toString(),
                  style: AppStyle.textStyleSemiBold
                      .copyWith(fontSize: 12, color: AppColor.appprimary),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "last DueDate",
                  style: AppStyle.textStyleSemiBold
                      .copyWith(fontSize: 12, color: AppColor.colorBlack),
                ),
                Text(
                  item.loanEnd.toString(),
                  style: AppStyle.textStyleSemiBold
                      .copyWith(fontSize: 12, color: AppColor.appprimary),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            formatrow("Total", item.totalAmount.toString()),
            formatrow("Paid", item.paidAmount.toString()),
            formatrow("Pending", item.paidAmount.toString()),
            formatrow2("Due",
                "${item.paidDue.toString()}/${item.totalDue.toString()}"),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: item.paidAmount / item.totalAmount,
                  backgroundColor: AppColor.colorBlack,
                  color: AppColor.appprimary,
                  minHeight: 13,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Text(
              "${(item.paidAmount / item.totalAmount * 100).toStringAsFixed(1)}%",
              style: AppStyle.textStyleExtraBold.copyWith(
                fontSize: 18,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                // navigatePush(
                    // context, Loansummary(loansummary: item.loanSummary));
              },
              child: formatbutton(context, "Loan summary"),
            ),
            GestureDetector(
              onTap: () {
                // navigatePush(
                //     context,
                //     Paymentpage(
                //       collection: collectiontype,
                //       loanId: 0,
                //     ));
              },
              child: formatbutton(context, "Pay Loans", payment: true),
            )
          ],
        )
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
  return Column(
    children: [
      Text(title,
          style: AppStyle.textStyleSemiBold
              .copyWith(fontSize: 16, color: AppColor.colorGray)),
      Text(value,
          style: AppStyle.textStyleSemiBold
              .copyWith(fontSize: 16, color: AppColor.appprimary)),
    ],
  );
}

formatbutton(BuildContext context, String title, {bool payment = false}) {
  return Container(
      width: 130,
      height: 40,
      decoration: BoxDecoration(
          color: payment ? AppColor.appprimary : AppColor.brownyellow2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
              style: AppStyle.textStyleSemiBold
                  .copyWith(fontSize: 15, color: AppColor.colorwhite)),
          payment
              ? const Icon(
                  Icons.north_east,
                  color: AppColor.colorwhite,
                )
              : const SizedBox()
        ],
      ));
}
