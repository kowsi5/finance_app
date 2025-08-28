import 'dart:convert';

import 'package:finance_app/core/APIConfig.dart';
import 'package:finance_app/core/res/AppColor.dart';
import 'package:finance_app/core/res/AppStyle.dart';
import 'package:finance_app/core/utils/AppNavigator.dart';
import 'package:finance_app/core/utils/Constants.dart';
import 'package:finance_app/core/widgets/WidgetPopup.dart';
import 'package:finance_app/mainhome.dart';
import 'package:finance_app/models/Loanlistmodal.dart';
import 'package:finance_app/views/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Paymentpage extends StatefulWidget {
  final String collection;
  final Loanlistmodal loandeatis;
  final int loanId;

  const Paymentpage(
      {super.key,
      required this.collection,
      required this.loandeatis,
      required this.loanId});

  @override
  _PaymentpageState createState() => _PaymentpageState();
}

class _PaymentpageState extends State<Paymentpage> {
  late final TextEditingController _amountcontroller1 = TextEditingController();
  final TextEditingController _bouncecontroller2 = TextEditingController();
  final TextEditingController _Datecontroller = TextEditingController();
  final TextEditingController _remarkscontroller5 = TextEditingController();
  final TextEditingController _totalController = TextEditingController();

  void _calculateTotal() {
    double num1 = double.tryParse(_amountcontroller1.text) ?? 0.0;
    double num2 = double.tryParse(_bouncecontroller2.text) ?? 0.0;
    double total = num1 + num2;

    setState(() {
      _totalController.text = total.toString(); // Update total field
    });
  }

  final _formKey = GlobalKey<FormState>();
  String? _collection = "";
  String digitalPaymentMode = 'Cash';
  String paymentMadeBy = 'Self';

  Future<void> _addnewemployee() async {
    showProgress(context);
    print('adding employee');

    final loanid = widget.loandeatis.id;
    final customerId = widget.loandeatis.customerId;
    const collectby = 89;
    final amount = _totalController.text;
    final collectedDate = _Datecontroller.text;
    final paymentMode = digitalPaymentMode;
    final reason = _remarkscontroller5.text;

    final uri = Uri.parse(Apiconfig.addloandue);

    print(uri);
    final request = http.MultipartRequest('POST', uri);

    request.fields['loan_id'] = loanid.toString();
    request.fields['customer_id'] = customerId.toString();
    request.fields['collected_by'] = collectby.toString();
    request.fields['amount_collected'] = amount;
    request.fields['collected_date'] = collectedDate;
    request.fields['payment_mode'] = paymentMode;
    request.fields['comments'] = reason;

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
        String strMessage = "User added successfully";
        customAlertPopup(
            context, Constants.lottieSuccess, strTitle, strMessage, "Ok",
            (cont) {
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Homescreen()),
            );
          });
          return null;
        });
      } else {
        String errorMessage = responseData['message'] ?? 'An error occurred';
        // hideProgress(context);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // _showErrorSnackBar(errorMessage);
          String strTitle = "Alert";
          String strMessage = "User already added";
          customAlertPopup(
              context, Constants.lottieAlert, strTitle, strMessage, "Ok",
              (cont) {
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Homescreen()),
              );
            });
            return null;
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
    _collection = widget.collection;
    _amountcontroller1.text = widget.loandeatis.dailyEmi.toString();
    _calculateTotal();
  }

  @override
  void dispose() {
    _amountcontroller1.dispose();
    _bouncecontroller2.dispose();
    // _legalcontroller3.dispose();
    // _penalcontroller4.dispose();
    _totalController.dispose();
    // _remarkscontroller5.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    BuildContext buildContext = context;

    return Scaffold(
      backgroundColor: AppColor.appbackground, // Light background color
      appBar: AppBar(
        title: Text("$_collection Collections"),
        backgroundColor: AppColor.appbackground,
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(children: [
            Container(
              height: 1,
              color: AppColor.appprimary,
            ),
            const SizedBox(
              height: 20,
            ),
            // formatprofile(widget.loan),
            _buildSectionTitle("Payment Mode"),
            _buildPaymentModeSelection(),
            const SizedBox(height: 10),
            _buildPaymentTable(
                widget.loandeatis.loanType!,
                widget.loandeatis.customer!.empid!,
                widget.loandeatis.dailyEmi.toString()),
            Column(
              children: [
                _buildTextField('AMOUNT (Rs)', _amountcontroller1, screenWidth),
                _buildTextField(
                    "Bounce Charges", _bouncecontroller2, screenWidth),
                const Divider(),
                _buildTotalField("Total"),
              ],
            ),
            const SizedBox(height: 20),
            _buildSectionTitle("Payment Via"),

            Container(
              width: screenWidth,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                  color: AppColor.colorwhite,
                  border: Border(
                      bottom: BorderSide(
                    color: AppColor.appprimary,
                    width: 1.0,
                  ))),
              child: Text(
                digitalPaymentMode,
                key: ValueKey(digitalPaymentMode),
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            buildInputField1(
                "Loandate",
                "Enter the Loandate",
                1,
                _Datecontroller,
                (value) => value!.isEmpty ? "Loandate is required" : null,
                isDatePicker: true,
                context: context),
            _buildRemarksField(_remarkscontroller5),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                customDoubleButtonPopup(
                    context: context,
                    strTitle: "cancel Payment",
                    strMessage: "Do you want cancel the payment",
                    yesButtonName: "ok",
                    noButtonName: "cancel",
                    yesCallBack: (conte) {
                      navigatePushReplacement(context, const Mainhome());
                      return null;
                    },
                    noCallBack: (context) {
                      return null;
                    });
              },
              child: Container(
                  width: screenWidth,
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppColor.appprimary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "cancel",
                      style: AppStyle.textStyleSemiBold
                          .copyWith(fontSize: 18, color: AppColor.colorwhite),
                    ),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                customDoubleButtonPopup(
                    context: context,
                    strTitle: "Payment",
                    strMessage: "Do you want add the payment",
                    yesButtonName: "ok",
                    noButtonName: "cancel",
                    yesCallBack: (conte) {
                      _addnewemployee();
                      return null;
                    },
                    noCallBack: (context) {
                      return null;
                    });
              },
              child: Container(
                  width: screenWidth,
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: AppColor.appprimary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Collect",
                      style: AppStyle.textStyleSemiBold
                          .copyWith(fontSize: 18, color: AppColor.colorwhite),
                    ),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
          ]),
        ),
      ),
    );
  }

  _buildSectionTitle(String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(8),
      color: AppColor.colorwhite,
      child: Text(title,
          style: AppStyle.txtHeader
              .copyWith(color: AppColor.colorBlack, fontSize: 12)),
    );
  }

  _buildPaymentModeSelection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          _buildRadioButton("Cash", digitalPaymentMode),
          _buildRadioButton("Gpay", digitalPaymentMode),
          _buildRadioButton("Phonepe", digitalPaymentMode),
          _buildRadioButton("others", digitalPaymentMode),
        ],
      ),
    );
  }

  _buildRadioButton(title, String groupValue) {
    return Row(
      children: [
        Radio(
          value: title,
          groupValue: groupValue,
          onChanged: (
            value,
          ) {
            setState(() {
              if (groupValue == digitalPaymentMode) {
                digitalPaymentMode = value.toString();
              } else {
                paymentMadeBy = value.toString();
              }
            });
          },
        ),
        Text(title),
      ],
    );
  }

  _buildPaymentTable(String producttype, String amount, String accountnum) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: Column(
        children: [
          Row(children: [
            Expanded(child: _buildPaymentTableHeader('PRODUCT\n  CODE', true)),
            Expanded(child: _buildPaymentTableHeader('ACCOUNT', true)),
            Expanded(child: _buildPaymentTableHeader('AMOUNT\nPAYABLE', true)),

            // Expanded(child: _buildPaymentTableHeader('AMOUNT\n   (Rs)')),
          ]),
          const SizedBox(
            height: 10,
          ),
          Row(children: [
            Expanded(child: _buildPaymentTableHeader(producttype, false)),
            Expanded(child: _buildPaymentTableHeader(amount, false)),
            Expanded(
                child: _buildPaymentTableHeader(accountnum.toString(), false)),

            // Expanded(child: _buildPaymentTableHeader('AMOUNT\n   (Rs)')),
          ]),
        ],
      ),
    );
  }

  _buildPaymentTableHeader(String title, bool istitle) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        height: 40,
        decoration: BoxDecoration(
          color: istitle ? AppColor.appprimary : AppColor.colorWhite,
        ),
        child: Center(
            child: Text(
          title,
          style: AppStyle.textStyleSemiBold.copyWith(
              fontSize: 12,
              color: istitle ? AppColor.colorwhite : AppColor.colorBlack),
        )));
  }

  Widget _buildTextField(
      String title, TextEditingController controller, double screenwidth) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(flex: 8, child: Text(title)),
          Flexible(
            flex: 4,
            child: SizedBox(
              height: 40,
              width: screenwidth / 3.3,
              child: TextFormField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  fillColor: AppColor.colorWhite,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.pinkColors),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.appprimary),
                  ),
                  // labelText: "Amount",
                ),
                onChanged: (value) =>
                    _calculateTotal(), // Update total on input change
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalField(
    String title,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 9, vertical: 2),
      // padding: const EdgeInsets.symmetric(vertical: 8.0),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(flex: 8, child: Text(title)),
          Flexible(
            flex: 4,
            child: SizedBox(
              height: 40,
              child: TextFormField(
                controller: _totalController,
                enabled: false,
                style: AppStyle.textStyleBold
                    .copyWith(fontSize: 16, color: AppColor.colorBlack),
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.appprimary),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColor.appprimary),
                    ),
                    filled: true,
                    fillColor: AppColor.colorwhite
                    // Light grey to indicate non-editable
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

_buildRemarksField(TextEditingController controller) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10),
    padding: const EdgeInsets.only(top: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Remarks:"),
        const SizedBox(height: 5),
        SizedBox(
          height: 50,
          child: TextFormField(
            controller: controller,
            // keyboardType: TextInputType.,
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.pinkColors),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColor.appprimary),
              ),
              // labelText: "Amount",
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
    padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
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
            fillColor: AppColor.colorwhite,
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
