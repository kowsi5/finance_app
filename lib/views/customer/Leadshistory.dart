import 'dart:convert';
import 'package:finance_app/core/APIConfig.dart';
import 'package:finance_app/core/res/AppColor.dart';
import 'package:finance_app/core/res/AppStyle.dart';
import 'package:finance_app/core/utils/AppNavigator.dart';
import 'package:finance_app/core/widgets/WidgetPopup.dart';
import 'package:finance_app/models/Loanlistmodal.dart';
import 'package:finance_app/views/customer/loansummary.dart';
import 'package:finance_app/views/daily/paymentpage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Leaverequest extends StatefulWidget {
  final int userId;
  final String acttype;
  const Leaverequest({super.key, required this.userId, required this.acttype});

  @override
  _LeaverequestState createState() => _LeaverequestState();
}

class _LeaverequestState extends State<Leaverequest> {
  int userid = 0;
  String acttype = "";
  DateTime? _selectedDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime today = DateTime.now();
    setState(() {
      _selectedDate = today;
    });
    totalfuction();
  }

  totalfuction() async {
    setState(() {
      userid = widget.userId;
      acttype = widget.acttype;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchactivities();
    });
  }

  List<Loanlistmodal> loanData = [];

  Future<void> fetchactivities() async {
    const baseUrl = Apiconfig.listloans;
    showProgress(context);
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['data'] != null &&
            responseData['data']['loanList'] != null) {
          final List<dynamic> useractivityInfo =
              responseData['data']['loanList'];

          List<dynamic> reversedActivityInfo =
              useractivityInfo.reversed.toList();

          final List<Loanlistmodal> activitylist =
              reversedActivityInfo.map((userJson) {
            return Loanlistmodal.fromJson(userJson);
          }).toList();

          // final List<Activitytypemodal> activitylist2 =
          //     getFilteredData(activitylist, _selectedDate!);

          setState(() {
            loanData = activitylist;
          });
          print(loanData.length);
          hideProgress(context);
          // Process data
        }
      } else {
        print("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      hideProgress(context);
    }
  }

  // List<Activitytypemodal> getFilteredData(
  //     List<Activitytypemodal> employeeData, DateTime selectedDate) {
  //   final selectedDateString = DateFormat("yyyy-MM-dd").format(selectedDate);

  //   return employeeData
  //       .where((activity) => activity.fromDate == selectedDateString)
  //       .toList();
  // }

  // Future<String?> getEmployeeFcmTokenByUserId(
  //     String userId, String status) async {
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;

  //   try {
  //     DocumentSnapshot<Map<String, dynamic>> doc =
  //         await firestore.collection('Employee').doc(userId).get();

  //     if (doc.exists && doc.data() != null) {
  //       final data = doc.data()!;
  //       if (data.containsKey('fcmToken') && data['fcmToken'] != null) {
  //         sendNotificationToEmployee(data['fcmToken'], status);
  //         // return data['fcmToken'];
  //       }
  //     }
  //     print("No FCM token found for userId: $userId");
  //   } catch (e) {
  //     print("Error fetching FCM token: $e");
  //   }
  //   return null;
  // }

  // Future<void> sendNotificationToEmployee(String token, String status) async {
  //   final String projectId = 'mpeopleslm';
  //   final String fcmEndpoint =
  //       'https://fcm.googleapis.com/v1/projects/$projectId/messages:send';

  //   try {
  //     final serviceAccount = json.decode(await rootBundle.loadString(
  //         'assets/json/mpeopleslm-firebase-adminsdk-vaqch-616e9c084e.json'));

  //     final authClient = await clientViaServiceAccount(
  //       ServiceAccountCredentials.fromJson(serviceAccount),
  //       ['https://www.googleapis.com/auth/firebase.messaging'],
  //     );

  //     final Map<String, dynamic> message = {
  //       "message": {
  //         "token": token,
  //         "notification": {
  //           "title": "MPeoples",
  //           "body": "your $acttype has been $status",
  //         },
  //         // You can optionally add data fields here
  //         // "data": {"screen": "leave_details", "leaveId": "xyz123"}
  //       }
  //     };

  //     final response = await authClient.post(
  //       Uri.parse(fcmEndpoint),
  //       headers: {'Content-Type': 'application/json'},
  //       body: json.encode(message),
  //     );

  //     if (response.statusCode == 200) {
  //       print('✅ Notification sent successfully to token: $token');
  //     } else {
  //       print(
  //           '❌ Error sending notification: ${response.statusCode}, ${response.body}');
  //     }

  //     authClient.close();
  //   } catch (e) {
  //     print('Exception while sending notification: $e');
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> updateactivity(int id, String status, int userIdact) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showProgress(context);
    });

    final uri = Uri.parse(Apiconfig.listactivityupdate);
    print(uri);
    final request = http.MultipartRequest('POST', uri);
    request.fields['activity_id'] = id.toString();
    request.fields['status'] = status;

    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      print('Response status: ${response.statusCode}');
      final responseData = json.decode(responseBody);

      if (!mounted) return;

      if (response.statusCode == 200) {
        // getEmployeeFcmTokenByUserId(userIdact.toString(), status);
        hideProgress(context);
        fetchactivities();
        _showSuccessSnackBar('Activity status updated');
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
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(202),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue,
            colorScheme: const ColorScheme.light(primary: Colors.blue),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        print(_selectedDate);
      });
      await fetchactivities();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          // backgroundColor: AppColors.apptitle,
          title: const Row(
            children: [
              Text(
                'MPeoples ',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.amber,
                ),
              ),
              Text(
                'Business ',
                style: TextStyle(fontSize: 14, color: Colors.purple),
              ),
              Text(
                'Solutions',
                style: TextStyle(fontSize: 14, color: Colors.blue),
              ),
            ],
          ),
          // actions: [
          //   Container(
          //     height: 70,
          //     width: 70,
          //     // margin: EdgeInsets.all(5),
          //     child: Image.asset(
          //       'assets/images/mainlogo2.png',
          //       height: 50,
          //       width: 50,
          //     ),
          //   )
          // ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: screenWidth,
                height: 50,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(color: AppColor.appprimary),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$acttype Request",
                      style: const TextStyle(
                          color: AppColor.colorWhite,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                    ),
                    GestureDetector(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Container(
                        height: 40,
                        width: 110,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: const Color(0xFF19283E),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                            ),
                            Text(
                              'Date',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Icon(
                              Icons.arrow_downward,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        // abel: Text("Date"),,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: screenheight - 200,
                child: ListView.builder(
                    itemCount: loanData.length,
                    itemBuilder: ((context, index) {
                      var data = loanData[index];
                      return formatcard(context, data, screenWidth, "");
                    })),
              )
            ],
          ),
        ));
  }
}

formatcard(BuildContext context, Loanlistmodal item, double screenwidth,
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
        Text(item.customer!.name!,
            style: AppStyle.textStyleBold
                .copyWith(fontSize: 16, color: AppColor.colorBlack)),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Row(
        //       children: [
        //         Icon(
        //           Icons.menu,
        //           color: AppColor.appprimary,
        //           size: 18,
        //         ),
        //         SizedBox(width: 8),

        //       ],
        //     ),
        //     Container(
        //         decoration: BoxDecoration(),
        //         child: popupactiveButton(
        //             context: context, strButtonName: "", callback: () {}))
        //   ],
        // ),
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
                  DateFormat('dd-MM-yyyy').format(item.loanGivenDate!),
                  style: AppStyle.textStyleSemiBold
                      .copyWith(fontSize: 12, color: AppColor.appprimary),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Loan amount",
                  style: AppStyle.textStyleSemiBold
                      .copyWith(fontSize: 12, color: AppColor.colorBlack),
                ),
                Text(
                  item.loanAmount.toString(),
                  style: AppStyle.textStyleSemiBold
                      .copyWith(fontSize: 12, color: AppColor.appprimary),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // formatrow("Total", item.totalAmount.toString()),
            // formatrow("Paid", item.paidAmount.toString()),
            // formatrow("Pending", item.paidAmount.toString()),
            // formatrow2("Due",
            //     "${item.paidDue.toString()}/${item.totalDue.toString()}"),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              "Loan Tenure",
              style: AppStyle.textStyleExtraBold.copyWith(
                fontSize: 12,
              ),
            ),
            const SizedBox(width: 15),
            Text(
              "${item.loanTenure}${item.tenureType}",
              style: AppStyle.textStyleExtraBold.copyWith(
                fontSize: 12,
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
                navigatePush(context, Loansummary(loansummary: item.loandues!));
              },
              child: formatbutton(context, "Loan summary"),
            ),
            GestureDetector(
              onTap: () {
                navigatePush(
                    context,
                    Paymentpage(
                      collection: collectiontype,
                      loanId: item.id!,
                      loandeatis: item,
                    ));
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
