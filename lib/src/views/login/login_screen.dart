import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_restaurant/core/custom_widgets/blocks/custom_social_media_block.dart';
import 'package:project_restaurant/core/custom_widgets/headers/custom_header_text.dart';
import 'package:project_restaurant/src/controllers/login/cubit/login/login_cubit.dart';
import 'package:project_restaurant/src/controllers/login/login_args.dart';
import 'package:project_restaurant/src/views/login/components/login_apb_bar.dart';
import 'package:project_restaurant/src/views/login/components/login_form.dart';

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
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
            child: SingleChildScrollView(
              child: SizedBox(
                height: _heightWithOutAppBar(context),
                child: Form(
                  // key: _loginFormKey,
                  child: Column(
                    children: [
                      /***** Header *****/
                      const CustomHeaderText(title: 'Login'),
                      /***** -END- Header *****/

                      /***** Form *****/
                      BlocConsumer<LoginCubit, LoginState>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return Form(
                            key: _loginFormKey,
                            child: LoginForm(
                              emailController: _emailController,
                              passwordController: _passwordController,
                              onPressLogin: () {
                                FocusManager.instance.primaryFocus!.unfocus();
                                if (_loginFormKey.currentState!.validate()) {
                                  LoginCubit.get(context).login(
                                      context: context,
                                      email: _emailController.text,
                                      password: _passwordController.text);
                                }
                              },
                            ),
                          );
                        },
                      ),
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
    } else if (state is LoginFail ||
        state is LoginNoInternet ||
        state is LoginConnectionError) {
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
