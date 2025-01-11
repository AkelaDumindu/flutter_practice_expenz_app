import 'package:flutter/material.dart';
import 'package:flutter_expenz_app/screens/main_screen.dart';
import 'package:flutter_expenz_app/services/user_data_service.dart';
import 'package:flutter_expenz_app/utilz/color.dart';
import 'package:flutter_expenz_app/utilz/constant.dart';
import 'package:flutter_expenz_app/widgets/custom_button.dart';

class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key});

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends State<UserDataScreen> {
  bool rememberMe = false;

  // form key for the form validation
  final _formKey = GlobalKey<FormState>();

  // controller for the text form field
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userPasswordController = TextEditingController();
  final TextEditingController _userConfirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _userEmailController.dispose();
    _userPasswordController.dispose();
    _userConfirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(kDefalutPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Enter your \nPersonal Details",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //form field for user name
                      TextFormField(
                        controller: _userNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter your name";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            contentPadding: const EdgeInsets.all(20)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      //form field for user email
                      TextFormField(
                        controller: _userEmailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter your email";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            contentPadding: const EdgeInsets.all(20)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      //form field for user password

                      TextFormField(
                        controller: _userPasswordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter your password";
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            contentPadding: const EdgeInsets.all(20)),
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      //form field for user confirm password

                      TextFormField(
                        controller: _userConfirmPasswordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter your confirm password";
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "confirm password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            contentPadding: const EdgeInsets.all(20)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      Row(
                        children: [
                          const Text(
                            "Remember Me for the next time",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: kGrey),
                          ),
                          Expanded(
                            child: CheckboxListTile(
                              activeColor: kMainColor,
                              value: rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  rememberMe = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            // valid form data
                            String userName = _userNameController.text;
                            String email = _userEmailController.text;
                            String password = _userPasswordController.text;
                            String confirmPassword =
                                _userConfirmPasswordController.text;

                            // save the user name, email in device storage
                            await UserService.storeUserDetails(userName, email,
                                password, confirmPassword, context);

                            // navigate to the main screen
                            if (context.mounted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MainScreen(),
                                ),
                              );
                            }
                          }
                        },
                        child: const CustomButton(
                            buttonName: "Next", color: kMainColor),
                      ),
                    ],
                  ))
            ],
          ),
        )),
      ),
    );
  }
}
