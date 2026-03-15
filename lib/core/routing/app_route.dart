import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/core/routing/routes.dart';
import 'package:store_app/features/home/presentation/screens/home_screen.dart';
import 'package:store_app/features/login/views/login_screen.dart';
import 'package:store_app/features/my_cart/data/repo/cart_repo.dart';
import 'package:store_app/features/my_cart/presentation/cubit/cart_cubit.dart';
import 'package:store_app/features/my_cart/presentation/screens/my_cart_screen.dart';
import 'package:store_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:store_app/features/signup/presentation/screens/signup_screen.dart';

class AppRouter {
  final CartCubit _cartCubit = CartCubit(CartRepo());

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _cartCubit,
            child: HomeScreen(),
          ),
        );
      case Routes.loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Routes.profileScreen:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case Routes.signupScreen:
        return MaterialPageRoute(builder: (_) => SignupScreen());
      case Routes.myCartScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _cartCubit,
            child: MyCartScreen(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text("No route defined for ${settings.name}")),
          ),
        );
    }
  }
}
