import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_restaurant/core/core_export.dart';
import 'package:project_restaurant/src/controllers/signup/cubit/logic/sign_up/sign_up_cubit.dart';
import 'package:project_restaurant/src/views/sign_up/components/sign_up_screen_app_bar.dart';
import 'package:project_restaurant/src/views/sign_up/components/sign_up_screen_form.dart';

class SignUpScreen extends StatefulWidget {
  //route name
  static const String route = 'signup';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //inputs controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //widgets
  final SignUpScreenAppBar _appBar = const SignUpScreenAppBar();
  //keys
  GlobalKey<FormState> _signUpFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: BlocProvider(
          create: (context) => SignUpCubit(),
          child: GestureDetector(
            onTap: ()=> FocusManager.instance.primaryFocus!.unfocus(), //dismiss keyboard 
            child: SingleChildScrollView(
              child: SizedBox(
                height: _heightWithOutAppBar(context),
                child: Column(
                  children: [
                    /****** Header ******/
                    const CustomHeaderText(title: 'Sign Up'),
                    /****** -END- Header ******/
                    
                    /****** Form ******/
                    BlocConsumer<SignUpCubit, SignUpState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return Form(
                            key: _signUpFormKey,
                            child: SignUpScreenForm(
                              emailController: _emailController,
                              nameController: _nameController,
                              passwordController: _passwordController,
                              signUpState: _signUpState(state),
                              onPressSignUp: () {
                                if (_signUpFormKey.currentState!.validate()) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  SignUpCubit.get(context).signUp(
                                      context: context,
                                      name: _nameController.text,
                                      email: _emailController.text,
                                      password: _passwordController.text);
                                }
                              },
                            ),
                          );
                        }),
                    /****** -END- Form ******/
                    
                    /****** Social Media Buttons Block ******/
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
                    )),
                    /****** End Social Media Buttons Block ******/

                  ],
                ),
              ),
            ),
          )),
    );
  }

  ///get screen height exclude appbar heigh and kToolbar hight
  double _heightWithOutAppBar(BuildContext context) {
    return MediaQuery.of(context).size.height -
        _appBar.preferredSize.height -
        kToolbarHeight;
  }

  /// indecator widget  to show status of sign up 
  Widget? _signUpState(SignUpState state) {
    if (state is SignUpLoading) {
      return const CircularProgressIndicator();
    } else if (state is SignUpFail || state is SignUpNoInternet) {
      return FittedBox(
        child: Text(
          SignUpCubit.msg,
          style: const TextStyle(color: Colors.red, fontSize: 15),
        ),
      );
    }
    return null;
  }
}
