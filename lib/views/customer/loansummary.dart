import 'package:finance_app/core/res/AppColor.dart';
import 'package:finance_app/core/res/AppStyle.dart';
import 'package:finance_app/models/Loanlistmodal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Loansummary extends StatelessWidget {
  List<LoanDue> loansummary;

  Loansummary({super.key, required this.loansummary});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.appbackground,
        appBar: AppBar(
          title: const Text("Loan Summary"),
          backgroundColor: AppColor.appbackground,
          elevation: 0,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Column(children: [
          Container(
            height: 1,
            color: AppColor.appprimary,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: loansummary.length,
                  itemBuilder: (context, index) {
                    var summary = loansummary[index];
                    return Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColor.colorwhite,
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: AppColor.appprimary, width: 1)),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text('Loan no:'),
                                Text(summary.loanId.toString(),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        color: AppColor.appprimary)),
                              ],
                            ),
                            Container(
                              height: 30,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColor.appprimary),
                              child: Center(
                                child: Text(summary.paymentMode.toString(),
                                    style: AppStyle.textStyleBold.copyWith(
                                        fontSize: 18,
                                        color: AppColor.colorwhite)),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text('Amount:'),
                                Text(
                                  summary.amountCollected.toString(),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Text('date:'),
                                Text(
                                  DateFormat('dd-MM-yyyy')
                                      .format(summary.collectedDate!),
                                )
                              ],
                            )
                          ],
                        )
                      ]),
                    );
                  }))
        ]));
  }
}
