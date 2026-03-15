import 'package:flutter/material.dart';
import 'package:store_app/core/routing/app_route.dart';
import 'package:store_app/core/routing/routes.dart';
import 'package:store_app/features/login/prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();

  runApp(StoreApp());
}

class StoreApp extends StatelessWidget {
  StoreApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Store App",
      debugShowCheckedModeBanner: false,
      initialRoute: CacheHelper.getData("AccessToken") != null
          ? Routes.homeScreen
          : Routes.loginScreen,
      onGenerateRoute: _appRouter.generateRoute,
    );
  }
}
