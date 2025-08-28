import 'dart:convert';
import 'package:finance_app/core/APIConfig.dart';
import 'package:finance_app/core/res/AppColor.dart';
import 'package:finance_app/core/res/AppStyle.dart';
import 'package:finance_app/core/utils/AppNavigator.dart';
import 'package:finance_app/core/utils/Constants.dart';
import 'package:finance_app/core/widgets/WidgetButton.dart';
import 'package:finance_app/core/widgets/WidgetPopup.dart';
import 'package:finance_app/views/customer/Leadshistory.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Newleads extends StatefulWidget {
  const Newleads({super.key});

  @override
  _NewleadsState createState() => _NewleadsState();
}

class _NewleadsState extends State<Newleads> {
  late final TextEditingController _loanamountcontroller = TextEditingController();
  late final TextEditingController _commentscontroller = TextEditingController();
  late final TextEditingController _loantenurecontroller = TextEditingController();
  late final TextEditingController _Datecontroller = TextEditingController();
  final TextEditingController _loanTypeController = TextEditingController();
  final TextEditingController _loanagentcontroller = TextEditingController();
  final TextEditingController _loanemicontroller = TextEditingController();
  final TextEditingController _loandaycontroller = TextEditingController();
  final TextEditingController _customerController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
  String mobile = '';
  int? category;
  bool existingUser = true;
  String? selectedName;
  int? selectedId;
  String? selectedLeaveType;
  String? selectedagenttype;

  List<Map<String, dynamic>> customerList = [];
  // List<String> loantype = ["daily",
  //  "weekly", "monthly"
  //  ];
  List<String> loantype = ["Daily"];
  List<String> loantype3 = ["days"];
  List<String> loanagenttype = ["Admin", "Agent"];

  _handleLoginUser(
    BuildContext buildContext,
  ) async {
    navigatePushReplacement(
        context,
        const Leaverequest(
          userId: 0,
          acttype: "loan",
        ));
  }

  Future<void> fetchmaincategoyry() async {
    showProgress(context);
    print("FUNCTION TRIGGERED");

    try {
      final uri = Uri.parse(Apiconfig.listuserdropdown);
      print("Fetching from: $uri");

      final response = await http.get(uri);
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData["data"] != null) {
        hideProgress(context);

        List<dynamic> rawList = responseData["data"]["customerList"];

        customerList = rawList.map((item) {
          return {"id": item["id"], "name": item["name"]};
        }).toList();

        print("Fetched Categories: $customerList");
      } else {
        hideProgress(context);
        print("Unexpected response: ${response.body}");
      }
    } catch (e) {
      hideProgress(context);
      print("Error fetching categories: $e");
    }
  }
 Future<void> _addnewemployee() async {
    String dailyEmi = "";
    String weeklyEmi = "";
    String monthlyEmi = "";
 
    if (_loanTypeController.text == "Daily") {
      dailyEmi = _loanemicontroller.text;
      weeklyEmi = 0.toString();
      monthlyEmi = 0.toString();
    } else if (_loanTypeController.text == "Weekly") {
      weeklyEmi = _loanemicontroller.text;
      dailyEmi = 0.toString();
      monthlyEmi = 0.toString();
    } else if (_loanTypeController.text == "Monthly") {
      monthlyEmi = _loanemicontroller.text;
      dailyEmi = 0.toString();
      weeklyEmi = 0.toString();
    }
 
    showProgress(context);
    print('adding new loan');
    final loan_type = _loanTypeController.text;
    final customer_id = selectedId;
    final created_by = 89.toString();
    final loan_amount = _loanamountcontroller.text;
    final loan_tenure = _loantenurecontroller.text;
    final tenure_type = _loandaycontroller.text;
    final daily_emi = dailyEmi;
    final weekly_emi = weeklyEmi;
    final monthly_emi = monthlyEmi;
    final loan_given_date = _Datecontroller.text;
    final comments = _commentscontroller.text;
 
    // Print nicely formatted payload
    print('''
====== Loan Payload ======
Loan Type       : $loan_type
Customer ID     : $customer_id
Created By      : $created_by
Loan Amount     : $loan_amount
Loan Tenure     : $loan_tenure
Daily EMI       : $daily_emi
Weekly EMI      : $weekly_emi
Monthly EMI     : $monthly_emi
Loan Given Date : $loan_given_date
Comments        : $comments
tenure_type     : $tenure_type
===========================
''');
    final uri = Uri.parse(Apiconfig.addnewloan);
 
    print(uri);
    final request = http.MultipartRequest('POST', uri);
 
    request.fields['loan_type'] = loan_type;
    request.fields['customer_id'] = customer_id.toString();
    request.fields['created_by'] = created_by!;
    request.fields['loan_amount'] = loan_amount;
    request.fields['loan_tenure'] = loan_tenure;
    request.fields['tenure_type'] = tenure_type;
    request.fields['daily_emi'] = daily_emi;
    request.fields['weekly_emi'] = weekly_emi;
    request.fields['monthly_emi'] = monthly_emi;
    request.fields['loan_given_date'] = loan_given_date.toString();
    request.fields['comments'] = comments;
 
    try {
      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
 
      print('Response status: ${response.statusCode}');
 
      final responseData = json.decode(responseBody);
 
      if (!mounted) return;
      if (response.statusCode == 200) {
        hideProgress(context);
        print(responseData);
        String strTitle = "Success";
        String strMessage = "Loan added successfully";
        customAlertPopup(
            context, Constants.lottieSuccess, strTitle, strMessage, "Ok",
            (cont) {
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Newleads()),
            );
          });
        });
      } else {
        String errorMessage = responseData['message'] ?? 'An error occurred';
        // hideProgress(context);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // _showErrorSnackBar(errorMessage);
          String strTitle = "Alert";
          String strMessage = "loan already added";
          customAlertPopup(
              context, Constants.lottieAlert, strTitle, strMessage, "Ok",
              (cont) {
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Newleads()),
              );
            });
          });
        });
      }
    } catch (e) {
      print(e);
 
      _showErrorSnackBar('An error occurred: $e');
    } finally {
      hideProgress(context);
      // setState(() {
      //   isloading = false;
      // });
      // }
    }
  }
//   Future<void> _addnewemployee() async {
//     String dailyEmi = "";
//     String weeklyEmi = "";
//     String monthlyEmi = "";

//     if (_loanTypeController.text == "Daily") {
//       dailyEmi = _loanemicontroller.text;
//       weeklyEmi = 0.toString();
//       monthlyEmi = 0.toString();
//     } else if (_loanTypeController.text == "Weekly") {
//       weeklyEmi = _loanemicontroller.text;
//       dailyEmi = 0.toString();
//       monthlyEmi = 0.toString();
//     } else if (_loanTypeController.text == "Monthly") {
//       monthlyEmi = _loanemicontroller.text;
//       dailyEmi = 0.toString();
//       weeklyEmi = 0.toString();
//     }

//     showProgress(context);
//     print('adding new loan');
//     final loanType = _loanTypeController.text;
//     final customerId = selectedId;
//     final createdBy = 89.toString();
//     final loanAmount = _loanamountcontroller.text;
//     final loanTenure = _loantenurecontroller.text;
//     final tenureType = _loandaycontroller.text;
//     final dailyEmi = dailyEmi;
//     final weeklyEmi = weeklyEmi;
//     final monthlyEmi = monthlyEmi;
//     final loanGivenDate = _Datecontroller.text;
//     final comments = _commentscontroller.text;

//     // Print nicely formatted payload
//     print('''
// ====== Loan Payload ======
// Loan Type       : $loanType
// Customer ID     : $customerId
// Created By      : $createdBy
// Loan Amount     : $loanAmount
// Loan Tenure     : $loanTenure
// Daily EMI       : $dailyEmi
// Weekly EMI      : $weeklyEmi
// Monthly EMI     : $monthlyEmi
// Loan Given Date : $loanGivenDate
// Comments        : $comments
// tenure_type     : $tenureType
// ===========================
// ''');
//     final uri = Uri.parse(Apiconfig.addnewloan);

//     print(uri);
//     final request = http.MultipartRequest('POST', uri);
  

//     request.fields['loan_type'] = loanType;
//     request.fields['customer_id'] = customerId.toString();
//     request.fields['created_by'] = createdBy;
//     request.fields['loan_amount'] = loanAmount;
//     request.fields['loan_tenure'] = loanTenure;
//     request.fields['tenure_type'] = tenureType;
//     request.fields['daily_emi'] = dailyEmi;
//     request.fields['weekly_emi'] = weeklyEmi;
//     request.fields['monthly_emi'] = monthlyEmi;
//     request.fields['loan_given_date'] = loanGivenDate.toString();
//     request.fields['comments'] = comments;

//     try {
//       final response = await request.send();
//       final responseBody = await response.stream.bytesToString();

//       print('Response status: ${response.statusCode}');

//       final responseData = json.decode(responseBody);
//         print('Response body: ${responseData.body}');

//       if (!mounted) return;
//       if (response.statusCode == 200) {
//         hideProgress(context);
//         print(responseData);
//         String strTitle = "Success";
//         String strMessage = "Loan added successfully";
//         customAlertPopup(
//             context, Constants.lottieSuccess, strTitle, strMessage, "Ok",
//             (cont) {
//           Future.delayed(const Duration(seconds: 1), () {
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(builder: (context) => const Newleads()),
//             );
//           });
//           return null;
//         });
//       } else {
//         String errorMessage = responseData['message'] ?? 'An error occurred';
//         // hideProgress(context);
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           // _showErrorSnackBar(errorMessage);
//           String strTitle = "Alert";
//           String strMessage = "loan already added";
//           customAlertPopup(
//               context, Constants.lottieAlert, strTitle, strMessage, "Ok",
//               (cont) {
//             Future.delayed(const Duration(seconds: 1), () {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const Newleads()),
//               );
//             });
//             return null;
//           });
//         });
//       }
//     } catch (e) {
//       print(e);

//       _showErrorSnackBar('An error occurred: $e');
//     } finally {
//       hideProgress(context);
//       // setState(() {
//       //   isloading = false;
//       // });
//       // }
//     }
//   }

//   Future<void> _addnewemployee() async {
//     String dailyEmi = "";
//     String weeklyEmi = "";
//     String monthlyEmi = "";

//     if (_loanTypeController.text == "Daily") {
//       dailyEmi = _loanemicontroller.text;
//       weeklyEmi = "0";
//       monthlyEmi = "0";
//     } else if (_loanTypeController.text == "Weekly") {
//       weeklyEmi = _loanemicontroller.text;
//       dailyEmi = "0";
//       monthlyEmi = "0";
//     } else if (_loanTypeController.text == "Monthly") {
//       monthlyEmi = _loanemicontroller.text;
//       dailyEmi = "0";
//       weeklyEmi = "0";
//     }

//     showProgress(context);

//     final loan_type = _loanTypeController.text;
//     final customer_id = selectedId;
//     final created_by = "89"; // Hardcoded, consider fetching from session/user
//     final loan_amount = _loanamountcontroller.text;
//     final loan_tenure = _loantenurecontroller.text;
//     final tenure_type = _loandaycontroller.text;
//     final loan_given_date = _Datecontroller.text;
//     final comments = _commentscontroller.text;

//     print('''
// ====== Loan Payload ======
// Loan Type       : $loan_type
// Customer ID     : $customer_id
// Created By      : $created_by
// Loan Amount     : $loan_amount
// Loan Tenure     : $loan_tenure
// Daily EMI       : $dailyEmi
// Weekly EMI      : $weeklyEmi
// Monthly EMI     : $monthlyEmi
// Loan Given Date : $loan_given_date
// Comments        : $comments
// Tenure Type     : $tenure_type
// ===========================
// ''');

//     final uri = Uri.parse(Apiconfig.addnewloan);
//     print("POSTing to: $uri");

//     try {
//       final response = await http.post(
//         uri,
//         headers: {
//           "Content-Type": "application/json",
//         },
//         body: jsonEncode({
//           "loan_type": loan_type,
//           "customer_id": customer_id.toString(),
//           "created_by": created_by,
//           "loan_amount": loan_amount,
//           "loan_tenure": loan_tenure,
//           "tenure_type": tenure_type,
//           "daily_emi": dailyEmi,
//           "weekly_emi": weeklyEmi,
//           "monthly_emi": monthlyEmi,
//           "loan_given_date": loan_given_date,
//           "comments": comments,
//         }),
//       );

//       print("Response Status: ${response.statusCode}");
//       print("Raw Response: ${response.body}");

//       if (!mounted) return;

//       try {
//         final responseData = json.decode(response.body);

//         if (response.statusCode == 200) {
//           hideProgress(context);
//           String strTitle = "Success";
//           String strMessage = "Loan added successfully";
//           customAlertPopup(
//               context, Constants.lottieSuccess, strTitle, strMessage, "Ok",
//               (cont) {
//             Future.delayed(const Duration(seconds: 1), () {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const Newleads()),
//               );
//             });
//           });
//         } else {
//           String errorMessage = responseData['message'] ?? 'An error occurred';
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             customAlertPopup(
//                 context, Constants.lottieAlert, "Alert", errorMessage, "Ok",
//                 (cont) {
//               Future.delayed(const Duration(seconds: 1), () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => const Newleads()),
//                 );
//               });
//             });
//           });
//         }
//       } catch (e) {
//         print("JSON decode error: $e");
//         _showErrorSnackBar("Invalid server response format.");
//       }
//     } catch (e) {
//       print("Request error: $e");
//       _showErrorSnackBar("An error occurred: $e");
//     } finally {
//       hideProgress(context);
//     }
//   }

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchmaincategoyry();
      // fetchmaincategoyry();
      // fetchroles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appbackground,
      appBar: AppBar(
        title: Text(
          'Add Customers',
          style: AppStyle.txtHeader
              .copyWith(color:  Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColor.appbackground,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey, // Line color
            height: 1.0,
          ),
        ),
        // centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                // padding: const EdgeInsets.all(10.0),
                height: 50,
                width: double.infinity,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    color: Colors.blue),
                child: Center(
                  child: Text("Apply new loan",
                      style: AppStyle.txtHeader
                          .copyWith(color: AppColor.colorwhite, fontSize: 22)),
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      border: Border.all(
                        color: Colors.blue,
                        width: 1.5,
                      ),
                      color: AppColor.colorwhite),
                  child: Form(
                    key: _loginFormKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        buildDropdownFieldnormal(
                          'loan Type',
                          'Select loan Type',
                          _loanTypeController,
                          loantype,
                          (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select loan Type';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              selectedLeaveType = value;
                            });
                          },
                        ),
                        buildDropdownFieldnormal(
                          'activity Type',
                          'Select activity Type',
                          _loanagentcontroller,
                          loanagenttype,
                          (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select Leave Type';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              selectedagenttype = value;
                            }); // 🔁 Rebuild to show/hide 'To Date'
                          },
                        ),
                        buildDropdownField(
                          label: 'Customer Name',
                          hint: 'Select customer',
                          controller: _customerController,
                          items: customerList,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a customer';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              final selected = customerList.firstWhere(
                                (e) => e["name"] == value,
                                orElse: () => {},
                              );
                              selectedId = selected["id"];
                            });

                            print("Selected Name: $value");
                            print("Selected ID: $selectedId");
                          },
                        ),
                        buildInputField1(
                            "Loan Amount",
                            "Enter loanAmount",
                            1,
                            _loanamountcontroller,
                            (value) => value!.isEmpty
                                ? "loanAmount is required"
                                : null),
                        buildInputField1(
                            "EMI",
                            "Enter EMI",
                            1,
                            _loanemicontroller,
                            (value) =>
                                value!.isEmpty ? "EMI is required" : null),
                        buildInputField1(
                            "Loandate",
                            "Enter the Loandate",
                            1,
                            _Datecontroller,
                            (value) =>
                                value!.isEmpty ? "Loandate is required" : null,
                            isDatePicker: true,
                            context: context),
                        Row(
                          children: [
                            Flexible(
                              flex: 4,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                child: buildInputField1(
                                  "tenure",
                                  "Enter a tenure",
                                  1,
                                  _loantenurecontroller,
                                  (value) => null,
                                  // (value) =>
                                  //     value!.isEmpty ? "Name is required" : null),
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 4,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                child: buildDropdownFieldnormal(
                                  'tenure type',
                                  'tenuretype',
                                  _loandaycontroller,
                                  loantype3,
                                  (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please tenure type';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      selectedagenttype = value;
                                    }); // 🔁 Rebuild to show/hide 'To Date'
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        buildInputField1(
                          "comments",
                          "Enter a comments",
                          2,
                          _commentscontroller,
                          (value) => null,
                          // (value) =>
                          //     value!.isEmpty ? "Name is required" : null),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 25),
                          // width: screenwidth / 1.5,
                          child: Center(
                            child: primaryButton(
                              context: context,
                              strButtonName: 'Process',
                              callback: () {
                                if (!_loginFormKey.currentState!.validate()) {
                                } else {
                                  _addnewemployee(
                                      // context,
                                      // _namecontroller.text.toString(),
                                      // _mobilecontroller.text.toString(),
                                      // _batchcontroler.text.toString(),
                                      // _areacontroller.text.toString(),
                                      // _dateController.text.toString(),
                                      );
                                  // _handleLoginUser(
                                  //     buildContext,
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ])),
    );
  }

  Widget buildDropdownField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required List<Map<String, dynamic>> items,
    required String? Function(String?)? validator,
    required void Function(String?) onChanged,
    String Function(Map<String, dynamic>)? getValue,
    String Function(Map<String, dynamic>)? getLabel,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppStyle.textAppStyle.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          DropdownButtonFormField<String>(
            isExpanded: true,
            hint: Text(hint),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFEFF6FF),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(3),
              ),
            ),
            items: items.map((item) {
              final value = getValue != null ? getValue(item) : item["name"];
              final label = getLabel != null ? getLabel(item) : item["name"];
              return DropdownMenuItem<String>(
                value: value,
                child: Text(label),
              );
            }).toList(),
            value: controller.text.isNotEmpty ? controller.text : null,
            validator: validator,
            onChanged: (value) {
              controller.text = value ?? '';
              onChanged(value);
            },
          ),
        ],
      ),
    );
  }

  Widget buildDropdownFieldnormal(
    String label,
    String hint,
    TextEditingController controller,
    List<String> items,
    String? Function(String?)? validator, {
    void Function(String)? onChanged, // ✅ optional callback
  }) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 10),s
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppStyle.textAppStyle.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 5),
          DropdownButtonFormField<String>(
            value: controller.text.isNotEmpty ? controller.text : null,
            items: items
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    ))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                controller.text = value;
                if (onChanged != null) onChanged(value);
              }
            },
            validator: validator,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.black38),
              filled: true,
              fillColor: const Color(0xFFEFF6FF),
              focusedBorder: const OutlineInputBorder(
                 
                      // BorderSide(color: Colors.deepOrange)
                  ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                // borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInputField1(
    String label,
    String hint,
    int max,
    TextEditingController controller,
    String? Function(String?)? validator, {
    bool isPassword = false,
    bool isDatePicker = false, // New parameter to enable date picker
    BuildContext? context,
  }) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppStyle.textAppStyle.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          // const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            readOnly: isDatePicker,
            maxLines: max, // Prevents manual text input for date picker
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.black38),
              filled: true,
              fillColor: const Color(0xFFEFF6FF),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none,
              ),
              suffixIcon: isDatePicker
                  ? IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        if (context == null) return;
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          controller.text =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                        }
                      },
                    )
                  : null,
            ),
            obscureText: isPassword,
            validator: validator,
            onTap: isDatePicker
                ? () async {
                    if (context == null) return;
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      controller.text =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                    }
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
