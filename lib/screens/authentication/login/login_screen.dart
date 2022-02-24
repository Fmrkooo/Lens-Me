import 'package:flutter/material.dart';
import 'package:lensme/layout/layout_customer/layout_provider.dart';
import 'package:lensme/screens/authentication/login/login_provider.dart';
import 'package:lensme/screens/authentication/sign_up/sign_up_screen.dart';
import 'package:lensme/screens/screens_photographer/profile_photographer_owner/profile_photographer_screen_owner.dart';
import 'package:lensme/shared/cashe_helper.dart';
import 'package:lensme/shared/components/components.dart';
import 'package:lensme/layout/layout_customer/layout_screen.dart';
import 'package:lensme/shared/constants.dart';

import 'package:lensme/shared/theme/colors.dart';
import 'package:provider/src/provider.dart';

class LoginScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  String showToastChecker = '';

  @override
  Widget build(BuildContext context) {

    var watch = context.watch<LoginProvider>();
    var read = context.read<LoginProvider>();

    return Scaffold(
      body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xB300ABBB),
                      Color(0xFF00ABBB),
                      Color(0xD91DB6A7),
                      Color(0xFF1DB6A7)
                    ],
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0,35.0,15.0,15.0),
              child: Center(
                child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Lens Me',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: responsivizer(context,30, 34, 38, 42),
                            ),
                          ),
                          const SizedBox(
                            height:75,
                          ),
                          defaultFormField(
                            controller: emailController,
                            text: 'Email' ,
                            label: 'Enter your email',
                            type: TextInputType.emailAddress,
                            respCTX: context,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Your Email Address';
                              }
                            },
                            onSubmit: (value) {},
                            prefix: Icons.email,
                          ),
                          const SizedBox(
                            height:15,
                          ),
                          defaultFormField(
                            controller: passwordController,
                            text: 'Password',
                            label: 'Enter your password',
                            type: TextInputType.visiblePassword,
                            suffix: watch.suffix,
                            respCTX: context,
                            suffixPressed: (){
                              read.changePasswordVisibility();
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Password';
                              }
                            },
                            onSubmit: (value) {},
                            prefix: Icons.lock_outline,
                            isPassword: watch.isPassword,
                          ),
                          const SizedBox(
                              height:30,
                          ),
                          Container(
                            width: double.infinity,
                            height:responsivizer(context, 50, 58, 65, 75),
                            child: watch.isLoginButtonLoading ?
                            Center(child: Container(height: 20,width: 20,child: CircularProgressIndicator(color: Colors.white,)))
                                :
                            defaultButton(
                              function: () async {
                                if (formKey.currentState!.validate() &&
                                    formKey.currentState != null) {
                                  final result = await  read.loginWithEmailAndPassword(
                                      email: emailController.text,
                                      password: passwordController.text,
                                  );
                                  if(result == 'success') {
                                    isPhotographer= CacheHelper.getData(key: 'isPhotographer');
                                    if(isPhotographer)
                                    {
                                      navigateAndFinish(
                                          context, PhotographerProfileScreenOWNER());
                                    }
                                    else
                                    {
                                      navigateAndFinish(
                                          context, LayoutScreen());
                                    }
                                  }
                                  else {showToast(text: result);
                                  print(result);
                                  }
                                }
                              },
                              text: 'Login',
                              isUpperCase: true,
                              background: Colors.white,
                              colorText: mainColor,
                              width: double.infinity,
                            ),
                          ),
                          const SizedBox(
                            height:32,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account?',
                                style: TextStyle(
                                  fontSize: responsivizer(context, 12, 14, 16, 18),
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                child: Text(
                                  ' Sign Up',
                                  style: TextStyle(
                                    fontSize: responsivizer(context, 11, 17, 15, 17),
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                onTap: (){
                                  navigateTo(
                                    context,
                                    SignUpScreen(),
                                  );
                                },
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              ),
              ),
          ],
        ),
    );
  }
}
