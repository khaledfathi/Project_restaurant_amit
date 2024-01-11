import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_restaurant/core/custom_widgets/blocks/custom_social_media_block.dart';
import 'package:project_restaurant/core/custom_widgets/buttons/custom_line_button.dart';
import 'package:project_restaurant/core/custom_widgets/buttons/custom_standard_button.dart';
import 'package:project_restaurant/core/custom_widgets/headers/custom_header_text.dart';
import 'package:project_restaurant/core/custom_widgets/inputs/custom_text_form_field.dart';
import 'package:project_restaurant/src/controllers/login/cubit/logic/login/login_cubit.dart';
import 'package:project_restaurant/src/controllers/login/login_args.dart';

class LoginScreen extends StatefulWidget {
  static const String route = 'login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //input controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  //keys
  GlobalKey<FormState> loginFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    //set credential if exists
    _setEmailAndPasswordFromArgs(context);
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
          create: (context) => LoginCubit(),
          child: Column(
            children: [
              //header
              CustomHeaderText(title: 'Login'),

              //form
              CustomTextFormField(
                  labelText: 'Email', controller: emailController),
              CustomTextFormField(
                labelText: 'Password',
                controller: passwordController,
              ),
              CustomLineButton(
                label: 'Don\'t have account?',
                onPressed: () => Navigator.of(context).pop(),
              ),

              BlocConsumer<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return CustomStanderButton(
                      text: 'Login',
                      onPressed: () {
                        LoginCubit.get(context).login(
                            context: context,
                            email: emailController.text,
                            password: passwordController.text);
                      },
                    );
                  },
                  listener: (context, state) {}),

              BlocConsumer<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return Text(LoginCubit.msg);
                  },
                  listener: (context, state) {}),

              //social media block
              CustomSocialMediaBlock(),
            ],
          )),
    );
  }

  void _setEmailAndPasswordFromArgs(BuildContext context) {
    LoginArgs? args = ModalRoute.of(context)!.settings.arguments as LoginArgs?;
    if (args != null) {
      emailController.text = args.email!;
      passwordController.text = args.password!;
    }
  }
}
