import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/core/app_images.dart';
import 'package:store_app/core/routing/routes.dart';
import 'package:store_app/features/login/widgets/custom_button.dart';
import 'package:store_app/features/login/widgets/custom_textformfield.dart';
import 'package:store_app/features/signup/data/repo/signup_repo.dart';
import 'package:store_app/features/signup/presentation/cubit/signup_cubit.dart';
import 'package:store_app/features/signup/presentation/cubit/signup_states.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocProvider(
        create: (context) => SignupCubit(SignupRepo()),
        child: BlocConsumer<SignupCubit, SignupStates>(
          listener: (context, state) {
            if (state is SignupSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Account created successfully!")),
              );
              Navigator.pushReplacementNamed(context, Routes.loginScreen);
            } else if (state is SignupError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Error: ${state.message}")),
              );
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
                        children: [
                          Image.asset(
                            AppImages.logoImage,
                            height: 100,
                            width: 100,
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Create Account",
                            style: TextStyle(
                              color: Colors.purple,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextFormField(
                                  passwordController: firstNameController,
                                  hint: "First Name",
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Required";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: CustomTextFormField(
                                  passwordController: lastNameController,
                                  hint: "Last Name",
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Required";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          CustomTextFormField(
                            passwordController: usernameController,
                            hint: "Username",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter a username";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15),
                          CustomTextFormField(
                            passwordController: emailController,
                            hint: "Email",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter your email";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 15),
                          CustomTextFormField(
                            passwordController: passwordController,
                            hint: "Password",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter a password";
                              } else if (value.length < 6) {
                                return "Enter at least 6 characters";
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          state is SignupLoading
                              ? Center(child: CircularProgressIndicator())
                              : CustomButton(
                                  title: "Sign Up",
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      FocusScope.of(context).unfocus();
                                      context.read<SignupCubit>().signup(
                                            firstName:
                                                firstNameController.text,
                                            lastName: lastNameController.text,
                                            username:
                                                usernameController.text,
                                            email: emailController.text,
                                            password:
                                                passwordController.text,
                                          );
                                    }
                                  },
                                ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an account?"),
                              TextButton(
                                style: ButtonStyle(
                                  padding: WidgetStatePropertyAll(
                                    EdgeInsetsGeometry.all(0),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Login"),
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
