import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:finance_app/core/APIConfig.dart';
import 'package:finance_app/core/res/AppColor.dart';
import 'package:finance_app/core/res/AppStyle.dart';
import 'package:finance_app/core/utils/Constants.dart';
import 'package:finance_app/core/widgets/WidgetButton.dart';
import 'package:finance_app/core/widgets/WidgetPopup.dart';
import 'package:finance_app/mainhome.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';

class Addcustomer extends StatefulWidget {
  const Addcustomer({super.key});

  @override
  _AddcustomerState createState() => _AddcustomerState();
}

class _AddcustomerState extends State<Addcustomer> {
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _mobilecontroller = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController empCodeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =TextEditingController();
  final TextEditingController aadhaaarController = TextEditingController();
  final TextEditingController _imgController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();

  List<Map<String, dynamic>> listCategories = [];
  List<Map<String, dynamic>> listsubCategories = [];
  List<Map<String, dynamic>> listroles = [];

  bool isLoading = false;

  String? selectedAddress; // Stores the selected address
  int? category;
  String? selectsubcategory;
  int? subcategory;
  int? role;
  String? selectrole;

  final ImagePicker _picker = ImagePicker();

  XFile? _image;

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await _picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
        _imgController.text = _image!.path;
      });
    }
  }

  Future<void> fetchmaincategoyry() async {
    showProgress(context);
    print("FUNCTION TRIGGERED");

    try {
      final uri = Uri.parse(Apiconfig.getmainbranch);
      print("Fetching from: $uri");

      final response = await http.get(uri);
      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData["data"] != null) {
        hideProgress(context);

        // Safely extract and map data
        final List<Map<String, dynamic>> companies =
            (responseData["data"] as List).map<Map<String, dynamic>>((item) {
          return {
            "id": item["id"],
            "address": item["company_address"],
          };
        }).toList();

        // Update state
        setState(() {
          listCategories = companies;
        });

        print("Fetched Categories: $listCategories");
      } else {
        hideProgress(context);
        print("Unexpected response: ${response.body}");
      }
    } catch (e) {
      hideProgress(context);
      print("Error fetching categories: $e");
    }
  }

  Future<void> fetchsubcategoyry(category) async {
    final prefs = await SharedPreferences.getInstance();
    // setState(() {
    //   isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    //   usertoken = prefs.getString('token') ?? '';
    // });
    showProgress(context);
    try {
      final uri = ('${Apiconfig.getsubbranch}$category');
      print(uri); // Log the URI
      final response = await http.get(Uri.parse(uri)); // Make the GET request
      final responseData = jsonDecode(response.body); // Decode the response

      if (response.statusCode == 200) {
        print(responseData);
        hideProgress(context);
        // Extract the categories data
        final List<dynamic> categoriesData =
            responseData["data"] ?? []; // Adjust key if needed
        print(categoriesData);

        // Clear the existing categories list
        listsubCategories.clear();

        // Populate the categories list
        final List<Map<String, dynamic>> companies = categoriesData.map((item) {
          return {
            "id": item["id"],
            "address": item["branch_name"],
          };
        }).toList();

        setState(() {
          listsubCategories = companies;
        });
        print(listsubCategories);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchroles() async {
    try {
      const uri = (Apiconfig.getuserbyrole);
      print(uri); // Log the URI
      final response = await http.get(Uri.parse(uri)); // Make the GET request
      final responseData = jsonDecode(response.body); // Decode the response

      if (response.statusCode == 200) {
        print(responseData);

        listroles.clear();
        if (responseData['success'] == true) {
          final List<dynamic> rolesData = responseData['data']['roles'] ?? [];

          setState(() {
            listroles = rolesData
                .map((role) => {"id": role["id"], "name": role["name"]})
                .toList();
          });
        }

        print(listroles);
      }
    } catch (e) {
      print(e);
    }
  }

 
  List<String> customertypes = ["Customer", "Agent", "Admin"];

  Future<void> _addnewemployee() async {
    showProgress(context);
    print('adding employee');

    if (passwordController.text != confirmPasswordController.text) {
      print("Passwords do not match");
      _showErrorSnackBar("Passwords do not match");

      hideProgress(context);
    }

    final name = _namecontroller.text;
    final empno = empCodeController.text;
    final maincategory = category.toString();
    final email = emailController.text;
    final password = passwordController.text;
    final confirmpass = confirmPasswordController.text;
    final phone = _mobilecontroller.text;
    final branchId = subcategory.toString();
    const address = "salem";
    final roleslist = selectrole;
    final aadhaar = aadhaaarController.text;
    final media = _imgController.text;

    print(
        "$name\n$phone\n$address\n $maincategory\n$branchId\n$empno\n$email\n$password\n$confirmpass\n$aadhaar \n $address\n$media");

    final uri = Uri.parse(Apiconfig.addemployee);

    print(uri);
    final request = http.MultipartRequest('POST', uri);

    request.fields['name'] = name;
    request.fields['empid'] = empno;
    request.fields['email'] = email;
    request.fields['mobile'] = phone;
    request.fields['password'] = password;
    request.fields['c_password'] = confirmpass;
    request.fields['company_id'] = maincategory.toString();
    request.fields['branch_id'] = branchId.toString();
    request.fields['address'] = address;
    request.fields['adharnumber'] = aadhaar;
    request.fields['roles'] = roleslist.toString();

    if (media.isNotEmpty) {
      final file = File(media);
      if (await file.exists()) {
        final mimeType =
            lookupMimeType(file.path) ?? 'application/octet-stream';
        final stream = http.ByteStream(file.openRead());
        final length = await file.length();

        final multipartFile = http.MultipartFile(
          'profileimg',
          stream,
          length,
          filename: path.basename(file.path),
          contentType: MediaType.parse(mimeType),
        );
        request.files.add(multipartFile);
      } else {
        print('Media file not found at path: $media');
      }
    }

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
              MaterialPageRoute(builder: (context) => const Mainhome()),
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
                MaterialPageRoute(builder: (context) => const Mainhome()),
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchmaincategoyry();
      fetchroles();
    });
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
  Widget build(BuildContext context) {
    BuildContext mainContext = context;

    return Scaffold(
      backgroundColor: AppColor.appbackground,
      appBar: AppBar(
        title: Text(
          'Add Customers',
          style: AppStyle.txtHeader
              .copyWith(color: AppColor.colorBlack, fontSize: 22),
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
                  child: Text("Customer Details",
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
                        buildInputField1(
                            "Name",
                            "Enter the Name",
                            1,
                            _namecontroller,
                            (value) =>
                                value!.isEmpty ? "Name is required" : null),
                        buildInputField1(
                            "Email",
                            "Enter a Email",
                            1,
                            emailController,
                            (value) =>
                                value!.isEmpty ? "Email is required" : null),
                        buildInputField1(
                            "Mobile",
                            "Enter a Mobile number",
                            1,
                            _mobilecontroller,
                            (value) => value!.isEmpty
                                ? "Mobile number is required"
                                : null),
                        buildInputField1(
                            "EMP Code",
                            "Enter a emp Id",
                            1,
                            empCodeController,
                            (value) =>
                                value!.isEmpty ? "EMP id is required" : null),
                        buildDropdownFormFieldsample(
                          title: 'Select District',
                          hint: 'Select Address',
                          controller: addressController,
                          items: listCategories,
                          valueKey: 'address',
                          displayKey: 'address',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select an address';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              var selected = listCategories.firstWhere(
                                  (item) => item['address'] == value);
                              category = selected['id'];
                              fetchsubcategoyry(category);
                            });
                          },
                        ),
                        buildDropdownFormFieldbranch(
                          title: 'Select the district',
                          hint: 'Select branch',
                          controller: districtController,
                          items: listsubCategories,
                          valueKey: 'address',
                          displayKey: 'address',
                          validator: (value) => value == null || value.isEmpty
                              ? 'Please select a district'
                              : null,
                          onChanged: (value) {
                            setState(() {
                              selectsubcategory = value;
                              subcategory = listsubCategories.firstWhere(
                                (item) => item["address"] == value,
                              )["id"];
                            });
                          },
                        ),
                        buildDropdownFormFieldrole(
                          title: 'Select your role',
                          hint: 'Choose role',
                          controller: roleController,
                          items: listroles,
                          valueKey: 'name',
                          displayKey: 'name',
                          validator: (value) => value == null || value.isEmpty
                              ? 'Please select a role'
                              : null,
                          onChanged: (value) {
                            setState(() {
                              selectrole = value;
                              role = listroles.firstWhere(
                                  (item) => item["name"] == value)["id"];
                            });
                          },
                        ),
                        buildInputField1(
                          "Aadhaar (optional)",
                          "Enter a Aadhaar number",
                          1,
                          aadhaaarController,
                          (value) => null,
                          // (value) =>
                          //     value!.isEmpty ? "Name is required" : null),
                        ),
                        buildInputField1(
                          "Login Password",
                          "Login Password",
                          1,
                          passwordController,
                          (value) => value!.length < 6
                              ? "Password must be at least 6 characters"
                              : null,
                          isPassword: true,
                        ),
                        buildInputField1(
                          "Confirm Password",
                          "Enter the Confirm Password",
                          1,
                          confirmPasswordController,
                          (value) => value!.isEmpty
                              ? "Confirm Password is required"
                              : null,
                          isPassword: true,
                        ),
                        SizedBox(
                          height: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Profile Picture
                              _image != null
                                  ? Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFEFF6FF),
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: FileImage(File(_image!.path)),
                                          fit: BoxFit.cover,
                                        ),
                                        border:
                                            Border.all(color: Colors.black38),
                                      ),
                                    )
                                  : const CircleAvatar(
                                      radius: 50,
                                      backgroundColor: Colors.grey,
                                      child: Icon(Icons.person,
                                          size: 60, color: Colors.white),
                                    ),

                              const SizedBox(width: 20),

                              // Buttons Column
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () =>
                                        _pickImage(ImageSource.gallery),
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/home/gallery.png"),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  GestureDetector(
                                    onTap: () => _pickImage(ImageSource.camera),
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/home/camera.png"),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
                                  if (_image != null) {
                                    _addnewemployee();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Please select an image')));

                                    // ("Please upload image");
                                    // vibrate();
                                  }
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

  Widget buildDropdownField({
    required String title,
    required String hintText,
    required String? selectedValue,
    required List<Map<String, dynamic>> items,
    required Function(String?) onChanged,
    required String? Function(String?)? validator,
  }) {
    return SizedBox(
      height: 85,
      width: 286,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: AppStyle.textStyleBold,
            ),
          ),
          Container(
            color: const Color(0xFFEFF6FF).withOpacity(0.5),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                fillColor: const Color(0xFFEFF6FF),
                hintText: hintText,
                hintStyle: AppStyle.textStyleLight,
                border: const OutlineInputBorder(borderSide: BorderSide.none),
              ),
              value: selectedValue,
              items: items.map<DropdownMenuItem<String>>((item) {
                return DropdownMenuItem<String>(
                  value: item['address'],
                  child: Text(item['address']),
                );
              }).toList(),
              onChanged: onChanged,
              validator: validator,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDropdownmain({
    required String title,
    required String hint,
    required String? value,
    required List<Map<String, dynamic>> items,
    required Function(String?) onChanged,
    String? Function(String?)? validator,
  }) {
    return Container(
      width: 286,
      // Remove fixed height here or use padding instead
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyle.textAppStyle,
          ),
          const SizedBox(height: 5),
          Container(
            color: const Color(0xFFEFF6FF),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                fillColor: const Color(0xFFEFF6FF),
                hintText: hint,
                hintStyle: AppStyle.textAppStyle,
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              isExpanded: true, // Important for dropdown to open fully
              value: value,
              items: items.map<DropdownMenuItem<String>>((item) {
                return DropdownMenuItem<String>(
                  value: item["address"],
                  child: Text(item["address"]),
                );
              }).toList(),
              onChanged: onChanged,
              validator: validator,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDropdownField2(
    String label,
    String hint,
    TextEditingController controller,
    List<String> items,
    String? Function(String?)? validator, {
    void Function(String)? onChanged,
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
          DropdownButtonFormField2<String>(
            isExpanded: true,
            value: controller.text.isNotEmpty ? controller.text : null,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.black38),
              filled: true,
              fillColor: const Color(0xFFEFF6FF),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            ),
            items: items.map((item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item, overflow: TextOverflow.ellipsis),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                controller.text = value;
                if (onChanged != null) onChanged(value);
              }
            },
            validator: validator,
            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.symmetric(horizontal: 12),
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              iconEnabledColor: Colors.black54,
            ),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color(0xFFEFF6FF),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDropdownField3({
    required String title,
    required String hint,
    required String? value,
    required List<Map<String, dynamic>> items,
    required void Function(String?) onChanged,
    String? Function(String?)? validator,
  }) {
    return SizedBox(
      height: 85,
      width: 286,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyle.textAppStyle,
          ),
          const SizedBox(height: 5),
          DropdownButtonFormField2<String>(
            isExpanded: true,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              fillColor: const Color(0xFFEFF6FF),
              filled: true,
              hintText: hint,
              hintStyle: AppStyle.textStyleLight,
            ),
            value: value,
            items: items.map<DropdownMenuItem<String>>((item) {
              return DropdownMenuItem<String>(
                value: item["address"],
                child: Text(item["address"]),
              );
            }).toList(),
            onChanged: onChanged,
            validator: validator,
          ),
        ],
      ),
    );
  }
}

Widget buildDropdownFormFieldsample({
  required String title,
  required String hint,
  required TextEditingController controller,
  required List<Map<String, dynamic>> items,
  required String valueKey,
  required String displayKey,
  required String? Function(String?)? validator,
  void Function(String)? onChanged,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyle.textStyleBold.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5),
        DropdownButtonFormField2<String>(
          isExpanded: true,
          value: controller.text.isNotEmpty ? controller.text : null,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.black38),
            filled: true,
            fillColor: const Color(0xFFEFF6FF),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          ),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item[valueKey].toString(),
              child: Text(
                item[displayKey].toString(),
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              controller.text = value;
              if (onChanged != null) onChanged(value);
            }
          },
          validator: validator,
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.symmetric(horizontal: 12),
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            iconEnabledColor: Colors.black54,
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color(0xFFEFF6FF),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildDropdownFormFieldrole({
  required String title,
  required String hint,
  required TextEditingController controller,
  required List<Map<String, dynamic>> items,
  required String valueKey,
  required String displayKey,
  String? Function(String?)? validator,
  void Function(String)? onChanged,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppStyle.textStyleBold.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField2<String>(
          isExpanded: true,
          value: controller.text.isNotEmpty ? controller.text : null,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.black38),
            filled: true,
            fillColor: const Color(0xFFEFF6FF),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          ),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item[valueKey]?.toString(),
              child: Text(
                item[displayKey]?.toString() ?? '',
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              controller.text = value;
              onChanged?.call(value);
            }
          },
          validator: validator,
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.symmetric(horizontal: 12),
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            iconEnabledColor: Colors.black54,
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color(0xFFEFF6FF),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildDropdownFormFieldbranch({
  required String title,
  required String hint,
  required TextEditingController controller,
  required List<Map<String, dynamic>> items,
  required String valueKey,
  required String displayKey,
  String? Function(String?)? validator,
  void Function(String)? onChanged,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            // Replace with your AppStyle.textStyleBold if you want
          ),
        ),
        const SizedBox(height: 5),
        DropdownButtonFormField<String>(
          isExpanded: true,
          value: controller.text.isNotEmpty ? controller.text : null,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.black38),
            filled: true,
            fillColor: const Color(0xFFEFF6FF),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          ),
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item[valueKey].toString(),
              child: Text(
                item[displayKey].toString(),
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              controller.text = value;
              if (onChanged != null) onChanged(value);
            }
          },
          
          validator: validator,
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 24,
          iconEnabledColor: Colors.black54,
        ),
      ],
    ),
  );
}
