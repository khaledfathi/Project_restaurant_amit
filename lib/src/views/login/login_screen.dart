import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_restaurant/core/custom_widgets/blocks/custom_social_media_block.dart';
import 'package:project_restaurant/core/custom_widgets/buttons/custom_line_button.dart';
import 'package:project_restaurant/core/custom_widgets/buttons/custom_standard_button.dart';
import 'package:project_restaurant/core/custom_widgets/headers/custom_header_text.dart';
import 'package:project_restaurant/core/custom_widgets/inputs/custom_text_form_field.dart';
import 'package:project_restaurant/src/controllers/login/cubit/logic/login/login_cubit.dart';
import 'package:project_restaurant/src/controllers/login/login_args.dart';
import 'package:project_restaurant/src/views/login/components/login_apb_bar.dart';
import 'package:project_restaurant/src/views/sign_up/sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String route = 'login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //input controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //widgets
  final LoginAppBar _appBar = const LoginAppBar();
  //keys
  GlobalKey<FormState> _loginFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    //set credential if exists
    _setEmailAndPasswordFromArgs(context);
    return Scaffold(
      appBar: _appBar,
      body: BlocProvider(
          create: (context) => LoginCubit(),
          child: SingleChildScrollView(
            child: SizedBox(
              height: _heightWithOutAppBar(context),
              child: Column(
                children: [
                  /***** Header *****/
                  CustomHeaderText(title: 'Login'),
                  /***** -END- Header *****/

                  /***** Form *****/
                  //email 
                  CustomTextFormField(
                      labelText: 'Email', controller: _emailController),
                  //password
                  CustomTextFormField(
                    labelText: 'Password',
                    controller: _passwordController,
                    obscureText: true,
                  ),
                  // back to signup button
                  CustomLineButton(
                    label: 'Don\'t have account?',
                    onPressed: () => Navigator.of(context).pushReplacementNamed(SignUpScreen.route),
                  ),
                  //login button 
                  BlocConsumer<LoginCubit, LoginState>(
                      builder: (context, state) {
                        return CustomStanderButton(
                          text: 'Login',
                          onPressed: () {
                            LoginCubit.get(context).login(
                                context: context,
                                email: _emailController.text,
                                password: _passwordController.text);
                          },
                        );
                      },
                      listener: (context, state) {}),
                  /***** -END- Form *****/

                  /***** Login Status Indicator *****/
                  BlocConsumer<LoginCubit, LoginState>(
                      builder: (context, state) {
                        return Container(
                            padding: const EdgeInsets.all(15),
                            child: _loginStatus(state));
                      },
                      listener: (context, state) {}),
                  /***** -EnD- Login Status Indicator *****/

                  /***** Social Media Block *****/
                  Expanded(
                      child: Stack(
                    children: [
                      Positioned(
                          bottom: 10,
                          child: CustomSocialMediaBlock(
                            text: 'Or login with social media account',
                            onTapFacebook: () {},
                            onTapGoogle: () {},
                          ))
                    ],
                  )),
                  /***** -END- Social Media Block *****/
                ],
              ),
            ),
          )),
    );
  }

  ///read credential from route args
  void _setEmailAndPasswordFromArgs(BuildContext context) {
    LoginArgs? args = ModalRoute.of(context)!.settings.arguments as LoginArgs?;
    if (args != null) {
      _emailController.text = args.email!;
      _passwordController.text = args.password!;
    }
  }

  ///get screen height exclude appbar heigh and kToolbar hight
  double _heightWithOutAppBar(BuildContext context) {
    return MediaQuery.of(context).size.height -
        _appBar.preferredSize.height -
        kToolbarHeight;
  }

  /// indecator widget  to show status of sign up
  Widget? _loginStatus(LoginState state) {
    if (state is LoginLoading) {
      return const CircularProgressIndicator();
    } else if (state is LoginFail || state is LoginNoInternet) {
      return FittedBox(
        child: Text(
          LoginCubit.msg,
          style: const TextStyle(color: Colors.red, fontSize: 15),
        ),
      );
    }
    return null;
  }
}
