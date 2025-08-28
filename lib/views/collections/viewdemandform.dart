import 'package:finance_app/core/res/AppColor.dart';
import 'package:finance_app/core/res/AppStyle.dart';
import 'package:finance_app/core/utils/AppNavigator.dart';
import 'package:finance_app/core/widgets/WidgetButton.dart';
import 'package:finance_app/views/collections/viewdemandlist.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Viewdemandform extends StatefulWidget {
  final String collectiontype;

  const Viewdemandform({super.key, required this.collectiontype});

  @override
  State<Viewdemandform> createState() => _ViewdemandformState();
}

class _ViewdemandformState extends State<Viewdemandform> {
  late final TextEditingController _batchcontroller = TextEditingController();
  late final TextEditingController _areacontroller = TextEditingController();
  late final TextEditingController _dateController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
  String? collectiontype;

  @override
  void initState() {
    super.initState();
    collectiontype = widget.collectiontype;
  }

  _handleLoginUser(
      BuildContext buildContext, String batch, String area, String date) async {
    print("$batch \n  $area \n  $date ");
    navigatePushReplacement(context, const Viewdemandlist());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Text("$collectiontype Collections"),
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        Container(
          height: 1,
          color: AppColor.appprimary,
        ),
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
                    color: AppColor.appprimary),
                child: Center(
                  child: Text("View Demand List",
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
                        color: AppColor.appprimary,
                        width: 1,
                      ),
                      color: AppColor.colorwhite),
                  child: Form(
                    key: _loginFormKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        buildInputField(
                          "Batch",
                          "Enter the Batch",
                          _batchcontroller,
                          (value) =>
                              value!.isEmpty ? "Batch is required" : null,
                        ),
                        buildInputField(
                            "Area",
                            "Enter the Area",
                            _areacontroller,
                            (value) => value!.isEmpty
                                ? "Area name is required"
                                : null),
                        buildInputField(
                            "Date",
                            "select the date",
                            _dateController,
                            (value) =>
                                value!.isEmpty ? "Area name is required" : null,
                            isDatePicker: true,
                            context: context),
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
                                _handleLoginUser(
                                    context,
                                    _batchcontroller.text.toString(),
                                    _areacontroller.text.toString(),
                                    _dateController.text.toString());
                                return null;

                                // if (!_loginFormKey.currentState!.validate()) {
                                // } else {
                                //   // _handleLoginUser(
                                //   //     buildContext,
                                // }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        )
      ])),
    );
  }
}

buildInputField(
  String label,
  String hint,
  TextEditingController controller,
  String? Function(String?)? validator, {
  bool isPassword = false,
  bool isDatePicker = false, // New parameter to enable date picker
  BuildContext? context,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          readOnly: isDatePicker, // Prevents manual text input for date picker
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.black38),
            filled: true,
            fillColor: AppColor.appbackground,
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
                        firstDate: DateTime(2000),
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
                  if (context == null || !context.mounted) {
                    return; // Ensure context is valid
                  }
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now(),
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          primaryColor: AppColor.appprimary,
                          scaffoldBackgroundColor: AppColor.appbackground,
                          colorScheme: const ColorScheme.light(
                            primary: AppColor.appprimary,
                            onPrimary: Colors.white,
                            onSurface: Colors.black,
                          ),
                          buttonTheme: const ButtonThemeData(
                              textTheme: ButtonTextTheme.primary),
                        ),
                        child: child!,
                      );
                    },
                  );

                  if (pickedDate != null && context.mounted) {
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
