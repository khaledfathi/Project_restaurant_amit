import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project_restaurant/core/core_export.dart';
import 'package:project_restaurant/core/services/auth/auth.dart';
import 'package:project_restaurant/src/models/user_model.dart';
import 'package:project_restaurant/src/views/login/login_screen.dart';
import 'package:project_restaurant/src/views/main/main_screen.dart';

void main() async {
  await AppConfig().apply();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MainTheme.apply,
      debugShowCheckedModeBanner: false,
      initialRoute: _initRoute(),
      onGenerateRoute: RouteHandler.generateRoutes,
    );
  }

  ///init route dpened on last login state
  String _initRoute() {
    if (Globals.sharedPreferences.getBool(IS_LOGIN)!) {
      String user = Globals.sharedPreferences.getString(CURRENT_USER)!;
      Auth.setCurrentUser(UserModel.fromMap(jsonDecode(user)));
      return MainScreen.route;
    }
    return LoginScreen.route;
  }
}
