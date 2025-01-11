import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  // method to store the user name and user email in shared properties
  static Future<void> storeUserDetails(String userName, String email,
      String password, String confirmPassword, BuildContext context) async {
    try {
      // check the password and cofirm password are the same
      if (password != confirmPassword) {
        //show message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            // ignore: unnecessary_const
            content: const Text("password and confirm password not match"),
          ),
        );

        return;
      }

      // if password and confirm passsword are same store the store the user name and email in shared preference
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("userName", userName);
      await prefs.setString("email", email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("User Details stored successfully"),
        ),
      );
    } catch (err) {
      print(err.toString());
    }
  }

  //Check if the username is stored in shared preferences
  static Future<bool> checkUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString("userName");
    return userName != null;
  }

  //Get the username and email from shared preferences

  static Future<Map<String, String>> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString('userName');
    String? email = prefs.getString('email');
    return {'userName': userName!, 'email': email!};
  }

  //Check if the username is stored in shared preferences
  static Future<bool> checkUsernameIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    return username != null;
  }

  //remove the username and email from shared preferences
  static Future<void> clearUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('email');
  }
}
