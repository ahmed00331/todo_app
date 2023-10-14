import 'package:flutter/material.dart';
import 'package:todo/screens/authentication/login_tab.dart';
import 'package:todo/screens/authentication/sign_up_tab.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = "Login";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Login"),
            bottom: const TabBar(tabs: [
              Tab(
                child: Text("Login"),
              ),
              Tab(
                child: Text("SignUp"),
              ),
            ]),
          ),
          body: TabBarView(children: [
            LoginTab(),
            SignUpTab(),
          ]),
        ));
  }
}
