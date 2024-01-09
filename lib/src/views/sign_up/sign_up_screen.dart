import 'package:flutter/material.dart';
import 'package:project_restaurant/core/core_export.dart';
import 'package:project_restaurant/src/views/sign_up/components/sign_up_screen_app_bar.dart';
import 'package:project_restaurant/src/views/sign_up/components/sign_up_screen_form.dart';

class SignUpScreen extends StatefulWidget {
  static const String route = 'signup';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //inputs controllers 
  final TextEditingController nameController = TextEditingController(); 
  final TextEditingController emailController = TextEditingController(); 
  final TextEditingController passwordController = TextEditingController(); 
  final SignUpScreenAppBar _appBar = const SignUpScreenAppBar(); 
  //keys 
  GlobalKey<FormState> signUpFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                _appBar.preferredSize.height -
                kToolbarHeight,
            child: Column(
              children: [
                //header
                const CustomHeaderText(title: 'Sign Up'),
                //form
                Form(
                  key: signUpFormKey ,
                  child: SignUpScreenForm(
                    emailController: emailController,
                    nameController: nameController,
                    passwordController: passwordController,
                    onPressSignUp: (){
                      if(signUpFormKey.currentState!.validate()){
                        print ('go'); 
                        //check internet
                        //loading 
                        // ok or fail
                        //ok => main page
                      }
                    },
                  ),
                ), 
                //social media buttons 
                Expanded(
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 5,
                        child: CustomSocialMediaBlock(
                          onTapFacebook: (){},
                          onTapGoogle: (){},
                        ),
                      )
                    ],
                  ))
              ],
            ),
          ),
        ));
  }
}
