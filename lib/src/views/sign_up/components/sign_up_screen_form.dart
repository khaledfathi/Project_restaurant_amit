// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_restaurant/core/core_export.dart';
import 'package:project_restaurant/src/controllers/signup/cubit/UI/email_validation/email_validation_cubit.dart';
import 'package:project_restaurant/src/controllers/signup/cubit/UI/name_validation/name_validation_cubit.dart';
import 'package:project_restaurant/src/controllers/signup/cubit/UI/password_visibility/password_visibility_cubit.dart';
import 'package:project_restaurant/src/views/login/login_screen.dart';

class SignUpScreenForm extends StatelessWidget {
  final TextEditingController? nameController;
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  final void Function()? onPressSignUp;
  final Widget? signUpState ; 
  const SignUpScreenForm(
      {super.key,
      this.nameController,
      this.emailController,
      this.passwordController,
      this.onPressSignUp, 
      this.signUpState});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => NameValidationCubit(),
          ),
          BlocProvider(
            create: (context) => EmailValidationCubit(),
          ),
          BlocProvider(
            create: (context) => PasswordVisibilityCubit(),
          ),
        ],
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              
              //Name
              /***** Name Input *****/
              BlocConsumer<NameValidationCubit, NameValidationState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return CustomTextFormField(
                    validator: (name)=>_nameValidation(name!),
                    controller: nameController,
                    labelText: 'Name',
                    suffixIcon:
                        state is ValidName ? const Icon(Icons.check) : null,
                    suffixIconColor: Colors.green,
                    onChanged: (val) =>
                        NameValidationCubit.get(context).validateName(val),
                  );
                },
              ),
              /***** -END- Name Input *****/

              /***** Email Input *****/ 
              BlocConsumer<EmailValidationCubit, EmailValidationState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return CustomTextFormField(
                    validator: (email)=>_emailValidation(email!),
                    controller: emailController,
                    labelText: 'Email',
                    suffixIcon: state is ValidEmail ? const Icon(Icons.check) : null,
                    suffixIconColor: Colors.green,
                    onChanged: (val)=> EmailValidationCubit.get(context).validateEmail(val),
                  );
                },
              ),
              /***** -END- Email Input *****/ 
              
              /***** Password *****/ 
              BlocConsumer<PasswordVisibilityCubit, PasswordVisibilityState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return CustomTextFormField(
                    validator: (password)=>_passwordValidation(password!),
                    controller: passwordController,
                    labelText: 'Password',
                    obscureText: state is ShowPassword ? false : true ,
                    suffixButtonIconData: state is ShowPassword ?  Icons.visibility_off : Icons.visibility,
                    onTapSuffixButton: () {
                      PasswordVisibilityCubit.get(context).toggleVisibility(); 
                    },
                  );
                },
              ),
              /***** -END- Password Input *****/ 

              /***** Forget Password Button *****/ 
              CustomLineButton(
                label: 'Already have an account?',
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, LoginScreen.route),
              ),
              /***** -END- Forget Button *****/ 


              /***** SignUp Button*****/ 
              CustomStanderButton(
                text: 'Sign Up',
                margin: const EdgeInsets.only(top: 10),
                onPressed: onPressSignUp,
              ),
              /***** -END- SignUp Button*****/ 

              /***** SignUp Status *****/ 
              Container(
                padding: const EdgeInsets.all(15),
                child: signUpState
              )
              /***** -END- SignUp Status *****/ 
            ],
          ),
        ));

  }
  /***** input validation methods  *****/
  String? _nameValidation (String name){
    Validation nameValidate = Validation(name , fieldName: 'Name').required().length(minLength: 3).validate();
    if (nameValidate.isValid){
      return null ; 
    }else {
      return nameValidate.errors.first; 
    }
  }
  String?  _emailValidation (String email){
    Validation emailvalidate  = Validation(email , fieldName: 'Email').required().email().validate();
    if (emailvalidate.isValid){
      return null ; 
    }else {
      return emailvalidate.errors.first; 
    }
  }
  String?  _passwordValidation (String password){
    Validation passwordValidate = Validation(password , fieldName: 'Password').required().length(minLength: 8).validate();
    if (passwordValidate.isValid){
      return null ; 
    }else {
      return passwordValidate.errors.first; 
    }
  }
  /***** -END- input validation methods  *****/
}
