import 'package:flutter/material.dart';
import 'package:store_app/core/app_images.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset(AppImages.logoImage),
          Text("Login"),
          TextFormField(),
          TextFormField(),
          Text("Forget your Password?"),
          ElevatedButton(onPressed: () {}, child: Text("Login")),
          Row(children: [Text("Don't have an account? "), Text("Sign up")]),
        ],
      ),
    );
  }
}
