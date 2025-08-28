import 'package:finance_app/core/utils/AppNavigator.dart';
import 'package:finance_app/core/widgets/WidgetPopup.dart';
import 'package:finance_app/mainhome.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MpinScreen extends StatefulWidget {
  const MpinScreen({super.key});

  @override
  _MpinScreenState createState() => _MpinScreenState();
}

class _MpinScreenState extends State<MpinScreen> {
  String _enteredPin = '';
  String? _savedPin;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _loadSavedPin();
  }

  Future<void> _loadSavedPin() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedPin = prefs.getString('userMPin');
    });
  }

  void _verifyPin() {
    showProgress(context);
    if (_enteredPin == _savedPin) {
      print("correct pin");
      hideProgress(context);
      navigatePushReplacement(context, (  const Mainhome()));
      // Navigator.pushReplacementNamed(context, '/home');
    } else {
      hideProgress(context);
      print("wrong pin");
      setState(() {
        _errorText = 'Incorrect M-PIN';
      });
    }
  }

@override
Widget build(BuildContext context) {
  final defaultPinTheme = PinTheme(
    width: 50,
    height: 50,
    textStyle: const TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.blue),
    ),
  );

  return Scaffold(
    appBar: AppBar(title: const Text('Enter M-PIN')),
    body: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Pinput(
            length: 4,
            obscureText: true,
            controller: TextEditingController(text: _enteredPin),
            onChanged: (value) => _enteredPin = value,
            onCompleted: (value) {
              _enteredPin = value;
              _verifyPin();
            },
            defaultPinTheme: defaultPinTheme,
            focusedPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(
                border: Border.all(color: Colors.blue.shade700, width: 2),
              ),
            ),
            submittedPinTheme: defaultPinTheme,
            keyboardType: TextInputType.number,
          ),
          if (_errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                _errorText!,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          const SizedBox(height: 20),
          InkWell(
            onTap: _verifyPin,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: Colors.blue.shade600,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Enter M-PIN')),
//       body: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Pinput(
//               length: 4,
//               obscureText: true,
//               animationCurve: AnimationType.fade,
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
//               animationDuration: const Duration(milliseconds: 300),
//               backgroundColor: Colors.transparent,
//               enableActiveFill: true,
//               keyboardType: TextInputType.number,
//               onChanged: (value) => _enteredPin = value,
//               appContext: context,
//               onCompleted: (value) {
//                 _enteredPin = value;
//                 _verifyPin();
//               },
//             ),
//             if (_errorText != null)
//               Text(
//                 _errorText!,
//                 style: TextStyle(color: Colors.red),
//               ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _verifyPin,
//               child: Text('Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
