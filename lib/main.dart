import 'package:flutter/material.dart';
import 'package:store_app/features/login/prefs.dart';
import 'package:store_app/features/login/views/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  runApp(const StoreApp());
}

class StoreApp extends StatelessWidget {
  const StoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Store App", home: LoginScreen());
  }
}
