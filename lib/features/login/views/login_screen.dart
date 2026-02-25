import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/core/app_images.dart';
import 'package:store_app/features/home/views/home_screen.dart';
import 'package:store_app/features/login/cubit/login_cubit.dart';
import 'package:store_app/features/login/cubit/login_states.dart';
import 'package:store_app/features/login/widgets/custom_button.dart';
import 'package:store_app/features/login/widgets/custom_textformfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginStates>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              usernameController.clear();
              passwordController.clear();
              final String name = state.user.firstName ?? "User";
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen(name: name)),
              );
            } else if (state is LoginFailedState) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Error: ${state.errmsg}")));
            }
          },
          builder: (context, state) {
            return Scaffold(
              resizeToAvoidBottomInset: true,
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Image.asset(
                            AppImages.logoImage,
                            height: 100,
                            width: 100,
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Welcome back.",
                            style: TextStyle(
                              color: Colors.purple,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          CustomTextFormField(
                            passwordController: usernameController,
                            hint: "username",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter you username";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 15),
                          CustomTextFormField(
                            passwordController: passwordController,
                            hint: "Password",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter you Password";
                              } else if (value.length < 6) {
                                return "Enter at least 6 characters";
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [Text("Forget your Password?")],
                          ),
                          SizedBox(height: 15),
                          state is LoginLoadingState
                              ? Center(child: CircularProgressIndicator())
                              : CustomButton(
                                  title: "Login",
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      FocusScope.of(context).unfocus();

                                      context.read<LoginCubit>().login(
                                        username: usernameController.text,
                                        password: passwordController.text,
                                      );
                                    } else {
                                      log("Not Valid");
                                    }
                                  },
                                ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account?"),
                              TextButton(
                                style: ButtonStyle(
                                  padding: WidgetStatePropertyAll(
                                    EdgeInsetsGeometry.all(0),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text("Sign Up"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
