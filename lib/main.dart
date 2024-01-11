import 'package:flutter/material.dart';
import 'package:project_restaurant/core/core_export.dart';
import 'package:project_restaurant/src/views/main/main_screen.dart';
import 'package:project_restaurant/src/views/sign_up/sign_up_screen.dart';

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
  String _initRoute (){
    if (Globals.sharedPreferences.getBool(IS_LOGIN)!){
      return MainScreen.route; 
    }
    return SignUpScreen.route; 
  }
}
