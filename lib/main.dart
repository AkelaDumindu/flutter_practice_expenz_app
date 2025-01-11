import 'package:flutter/material.dart';
import 'package:flutter_expenz_app/services/user_data_service.dart';
import 'package:flutter_expenz_app/widgets/wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //when user log user redirect to the main screen of the app else move to the onboard screen
    return FutureBuilder(
        future: UserService.checkUsername(),
        builder: (context, snapshot) {
          //if the snapshot still waiting
          if (snapshot.connectionState == ConnectionState.waiting) {
            // ignore: prefer_const_constructors
            return CircularProgressIndicator();
          } else {
            // here has the user name that will be true pther wise false
            bool hasUsername = snapshot.data ?? false;
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                fontFamily: "Inter",
              ),

              //pass the wrapper widget according to the hasUsername value
              home: Wrapper(showMainScreen: hasUsername),
            );
          }
        });
  }
}
