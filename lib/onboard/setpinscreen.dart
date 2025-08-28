// import 'package:finance/core/res/AppColor.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Setpinscreen extends StatefulWidget {
//   const Setpinscreen({ Key? key }) : super(key: key);

//   @override
//   _SetpinscreenState createState() => _SetpinscreenState();
// }

// class _SetpinscreenState extends State<Setpinscreen> {
//     final TextEditingController _pinController = TextEditingController();
//   final TextEditingController _confirmPinController = TextEditingController();
//   final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
//   String? _error;

//   Future<void> _savePin() async {
//     final pin = _pinController.text;
//     final confirmPin = _confirmPinController.text;

//     if (pin.length != 4 || confirmPin.length != 4) {
//       setState(() => _error = "PIN must be 4 digits");
//       return;
//     }

//     if (pin != confirmPin) {
//       setState(() => _error = "PINs do not match");
//       return;
//     }

//     // Save PIN securely
//     await _secureStorage.write(key: 'user_pin', value: pin);

//     // Also mark pin as set
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isPinSet', true);

//     // Navigate to Home (or wherever you want)
//     Navigator.pushReplacementNamed(context, '/home');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//        backgroundColor: AppColor.appbackground, // Light background color
//       // appBar: AppBar(
//       //   title: Text("${_collection} Collections"),
//       //   backgroundColor: AppColor.appbackground,
//       //   elevation: 0,
//       //   titleTextStyle: const TextStyle(
//       //     color: Colors.black,
//       //     fontSize: 18,
//       //     fontWeight: FontWeight.bold,
//       //   ),
//       //   iconTheme: const IconThemeData(color: Colors.black),
//       // ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Set Pin",
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: AppColor.appprimary, // Dark text color
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               "Please set a pin to secure your account.",
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.black, // Dark text color
//               ),
//             ),
//             const SizedBox(height: 20),
//             // Add your pin input fields here
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:finance_app/mainhome.dart'; // Adjust import based on your structure
// Custom navigator if you're using it
import 'package:pinput/pinput.dart';

class SetPinScreen extends StatefulWidget {
  const SetPinScreen({super.key});

  @override
  _SetPinScreenState createState() => _SetPinScreenState();
}

class _SetPinScreenState extends State<SetPinScreen> {
  final _formKey = GlobalKey<FormState>();
  final _pinController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _pinController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            spreadRadius: 1,
            offset: Offset(2, 4),
          ),
        ],
        border: Border.all(color: Colors.blueAccent),
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FA),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue.shade600,
        title: const Text('Enter PIN'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
        centerTitle: true,
        elevation: 4,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25),
                Pinput(
                  focusNode: _focusNode,
                  controller: _pinController,
                  length: 4,
                  keyboardType: TextInputType.number,
                  autofocus: true,
                  defaultPinTheme: defaultPinTheme,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'PIN cannot be empty';
                    }
                    if (value!.length != 4) {
                      return 'PIN must be 4 digits';
                    }
                    return null; 
                  },
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                      // padding: EdgeInsets.all(30 ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final prefs = await SharedPreferences.getInstance();
                        await prefs.setString('userMPin', _pinController.text);

                        print('PIN saved: ${_pinController.text}');
                        _pinController.clear();

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Mainhome(),
                          ),
                        );
                      }
                    },

                    // onPressed: () {
                    //   if (_formKey.currentState!.validate()) {
                    //     print('PIN is valid: ${_pinController.text}');
                    //     _pinController.clear();
                    //     Navigator.pushReplacement(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => const Mainhome(),
                    //       ),
                    //     );
                    //   }
                    // },
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }
}
//   String _enteredPin = '';
//   String _confirmedPin = '';
//   bool _showError = false;

//   Future<void> _savePin() async {
//     if (_enteredPin.length != 4 || _confirmedPin.length != 4) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Please enter a 4-digit PIN in both fields')),
//       );
//       return;
//     }

//     if (_enteredPin != _confirmedPin) {
//       setState(() => _showError = true);
//       return;
//     }

//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('userMPin', _enteredPin);
//     await prefs.setBool('hasMPin', true);

//     navigatePushReplacement(context, Mainhome());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Set Your M-PIN')),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             Text(
//               'Enter a 4-digit M-PIN',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),

//             // Enter PIN
//             PinCodeTextField(
//               length: 4,
//               obscureText: true,
//               animationType: AnimationType.fade,
//               pinTheme: PinTheme(
//                 shape: PinCodeFieldShape.box,
//                 borderRadius: BorderRadius.circular(10),
//                 fieldHeight: 50,
//                 fieldWidth: 50,
//                 activeFillColor: Colors.white,
//                 selectedFillColor: Colors.white,
//                 inactiveFillColor: Colors.grey.shade200,
//                 activeColor: Colors.blue,
//                 selectedColor: Colors.blue,
//                 inactiveColor: Colors.grey,
//               ),
//               animationDuration: Duration(milliseconds: 300),
//               backgroundColor: Colors.transparent,
//               enableActiveFill: true,
//               keyboardType: TextInputType.number,
//               appContext: context,
//               onChanged: (value) => _enteredPin = value,
//               onCompleted: (value) => _enteredPin = value,
//             ),

//             const SizedBox(height: 20),

//             // Confirm PIN
//             PinCodeTextField(
//               length: 4,
//               obscureText: true,
//               animationType: AnimationType.fade,
//               pinTheme: PinTheme(
//                 shape: PinCodeFieldShape.box,
//                 borderRadius: BorderRadius.circular(10),
//                 fieldHeight: 50,
//                 fieldWidth: 50,
//                 activeFillColor: Colors.white,
//                 selectedFillColor: Colors.white,
//                 inactiveFillColor: Colors.grey.shade200,
//                 activeColor: Colors.blue,
//                 selectedColor: Colors.blue,
//                 inactiveColor: Colors.grey,
//               ),
//               animationDuration: Duration(milliseconds: 300),
//               backgroundColor: Colors.transparent,
//               enableActiveFill: true,
//               keyboardType: TextInputType.number,
//               appContext: context,
//               onChanged: (value) => _confirmedPin = value,
//               onCompleted: (value) => _confirmedPin = value,
//             ),

//             const SizedBox(height: 20),

//             if (_showError)
//               Text(
//                 '❌ PINs do not match',
//                 style: TextStyle(color: Colors.red),
//               ),

//             ElevatedButton(
//               onPressed: _savePin,
//               child: Text('Save PIN'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
