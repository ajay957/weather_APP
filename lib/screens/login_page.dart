import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("OTP login",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold
          ),
          )
        ],
      ),
    );
  }
}