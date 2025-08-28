import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10)),
          height: 100,
          width: 100,
          child: const Center(
              child: CircularProgressIndicator(
            color: Color(0xFFE65100),
          ))),
    );
  }
}
