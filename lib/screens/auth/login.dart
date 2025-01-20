import 'package:flutter/material.dart';
import 'package:frontend/utils/color.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: primaryColor,
      ),
      body: Center(
        child: Text('Login Page', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
