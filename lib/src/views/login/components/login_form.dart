// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_restaurant/core/core_export.dart';
import 'package:project_restaurant/src/controllers/login/cubit/UI/login_email_validation/login_email_validation_cubit.dart';
import 'package:project_restaurant/src/controllers/login/cubit/UI/login_password_visibility/login_password_visibility_cubit.dart';
import 'package:project_restaurant/src/views/sign_up/sign_up_screen.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  final void Function()? onPressLogin;

  const LoginForm({
    super.key,
    this.emailController,
    this.passwordController,
    this.onPressLogin
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LoginEmailValidationCubit(),
          ),
          BlocProvider(
            create: (context) => LoginPasswordVisibilityCubit(),
          ),
        ],
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              /***** Email Input *****/
              BlocConsumer<LoginEmailValidationCubit,
                  LoginEmailValidationState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return CustomTextFormField(
                    validator: (email)=>_emailValidation(email!),
                    labelText: 'Email',
                    controller: emailController,
                    suffixIcon: state is LoginValidEmail ? const Icon(Icons.check) : null ,
                    suffixIconColor: Colors.green,
                    onChanged: (email) => LoginEmailValidationCubit.get(context).validateEmail(email) ,
                  );
                },
              ),
              /***** -END- Email Input *****/

              /***** Password Input *****/
              BlocConsumer<LoginPasswordVisibilityCubit,
                  LoginPasswordVisibilityState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return CustomTextFormField(
                    validator: (password)=>_passwordValidation(password!),
                    labelText: 'Password',
                    controller: passwordController,
                    obscureText: state is LoginShowPassword ? false : true,
                    suffixButtonIconData: state is LoginShowPassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    onTapSuffixButton: () {
                      LoginPasswordVisibilityCubit.get(context)
                          .toggleVisibility();
                    },
                  );
                },
              ),
              /***** -END- Password Input *****/

              /***** Back to signup button *****/
              CustomLineButton(
                label: 'Don\'t have account?',
                onPressed: () => Navigator.of(context)
                    .pushReplacementNamed(SignUpScreen.route),
              ),
              /***** -END- Back to signup button *****/

              /***** Login Button *****/
              CustomStanderButton(
                text: 'Login',
                onPressed: onPressLogin,
              )
              /***** -END- Login Button *****/
            ],
          ),
        ));
  }

  /***** input validation methods  *****/
  String? _emailValidation(String email) {
    Validation emailvalidate =
        Validation(email, fieldName: 'Email').required().email().validate();
    if (emailvalidate.isValid) {
      return null;
    } else {
      return emailvalidate.errors.first;
    }
  }

  String? _passwordValidation(String password) {
    Validation passwordValidate = Validation(password, fieldName: 'Password')
        .required()
        .validate();
    if (passwordValidate.isValid) {
      return null;
    } else {
      return passwordValidate.errors.first;
    }
  }
  /***** -END- input validation methods  *****/
}
