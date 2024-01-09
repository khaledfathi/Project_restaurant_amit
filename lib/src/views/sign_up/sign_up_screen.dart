import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_restaurant/core/core_export.dart';
import 'package:project_restaurant/src/controllers/signup/cubit/logic/sign_up/sign_up_cubit.dart';
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
      body: BlocProvider(
          create: (context) => SignUpCubit(),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height -
                  _appBar.preferredSize.height -
                  kToolbarHeight,
              child: Column(
                children: [
                  //header
                  const CustomHeaderText(title: 'Sign Up'),

                  //form
                  BlocConsumer<SignUpCubit, SignUpState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return Form(
                          key: signUpFormKey,
                          child: SignUpScreenForm(
                            emailController: emailController,
                            nameController: nameController,
                            passwordController: passwordController,
                            signUpState: _signUpState(state),
                            onPressSignUp: () {
                              if (signUpFormKey.currentState!.validate()) {
                                SignUpCubit.get(context).signUp(
                                    context : context,
                                    name : nameController.text,
                                    email : emailController.text,
                                    password: passwordController.text);
                              }
                            },
                          ),
                        );
                      }),
                  //social media buttons
                  Expanded(
                      child: Stack(
                    children: [
                      Positioned(
                        bottom: 5,
                        child: CustomSocialMediaBlock(
                          onTapFacebook: () {},
                          onTapGoogle: () {},
                        ),
                      )
                    ],
                  ))
                ],
              ),
            ),
          )),
    );
  }

  Widget? _signUpState(SignUpState state) {
    if (state is Loading) {
      return const CircularProgressIndicator();
    } else if (state is Fail || state is NoInternet) {
      return Text(SignUpCubit.msg , style: const TextStyle(color: Colors.red , fontSize: 15),);
    }
    return null;
  }
}
