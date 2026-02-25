import 'package:flutter/material.dart';
import 'package:store_app/core/routing/app_route.dart';
import 'package:store_app/core/routing/routes.dart';
import 'package:store_app/features/login/prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  runApp(const StoreApp());
}

class StoreApp extends StatelessWidget {
  const StoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Store App",
      initialRoute: CacheHelper.getData("AccessToken") != null
          ? Routes.homeScreen
          : Routes.loginScreen,
      onGenerateRoute: AppRouter().generateRoute,
    );
  }
}
