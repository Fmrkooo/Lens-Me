import 'package:flutter/material.dart';
import 'package:lensme/screens/authentication/login/login_screen.dart';
import 'package:lensme/screens/authentication/sign_up/sign_up_provider.dart';
import 'package:lensme/screens/screens_photographer/profile_photographer_owner/profile_photographer_screen_owner.dart';
import 'package:lensme/shared/components/components.dart';
import 'package:lensme/layout/layout_customer/layout_screen.dart';
import 'package:lensme/shared/theme/colors.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var phoneController = TextEditingController();

  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var watch = context.watch<SignUpProvider>();
    var read = context.read<SignUpProvider>();

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
                    Color(0xFF1DB6A7),
                  ],
                )
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 35, 15, 5),
            child:Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: (){
                                navigateTo(
                                  context,
                                  LoginScreen(),
                                );
                              },
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: responsivizer(context,22,25,29,34),
                              ),
                            ),
                            Text(
                              'Sign Up',
                              style: TextStyle(
                                  fontSize: responsivizer(context,20,23,25,27),
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              ),),
                            IconButton(
                              onPressed: (){},
                              icon: Icon(Icons.arrow_back,color: Colors.white.withOpacity(0.0),),
                            ),
                          ],
                        ),
                      const SizedBox(
                        height:25,
                      ),
                      defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        respCTX: context,
                        validator: (value) {
                          String pattern = '(^[A-Za-z]{4,}) [A-Za-z]{2,}\$';
                          RegExp regExp = new RegExp(pattern);
                          if(value!.isEmpty ) {
                            return ' Please enter your name';
                          }
                          else if (value.length < 8) {
                            return ' Please enter at least 8 characters';
                           }
                           else if(!regExp.hasMatch(value))
                          {
                              return ' The name must be as(first last)';
                             }
                          else if(value.length > 20 ) {
                            return 'Please don\'t enter more than 20 characters';
                          }
                        },
                        text: 'Name',
                        label: 'Enter your name',
                        prefix: Icons.person,
                      ),
                      const SizedBox(
                        height:15,
                      ),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        respCTX: context,
                        validator: (value) {
                          if(value!.isEmpty ) {
                            return 'Please enter your email';
                          }
                        },
                        text: 'Email Address' ,
                        label: 'Enter your email',
                        prefix: Icons.email_outlined,
                      ),
                      const SizedBox(
                        height:15,
                      ),
                      defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        respCTX: context,
                        validator: (value) {
                          String pattern = '(^(07)(7|8|9)[0-9]{7})';
                          RegExp regExp = new RegExp(pattern);
                          if(value!.isEmpty ) {
                            return 'Please enter your phone';
                          }
                          else if (!regExp.hasMatch(value)) {
                            return 'Please enter valid mobile number';
                          }
                        },
                        text: 'Phone Number',
                        label: 'Enter your phone',
                        prefix: Icons.phone,
                      ),
                      const SizedBox(
                        height:15,
                      ),
                      defaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        suffix: watch.suffix,
                        respCTX: context,
                        suffixPressed: (){
                          read.changePasswordVisibility();
                        },
                        validator: (value) {
                          if (value!.length <8) {
                            return 'Please enter at least 8 character';}
                          if (value.isEmpty) {
                            return 'Please enter Correct Password';}
                        },
                        //onSubmit: (value) {},
                        isPassword: watch.isPassword,
                        text: 'Password',
                        label: 'Enter your password',
                        prefix: Icons.lock_outline,
                      ),
                      const SizedBox(
                        height:15,
                      ),
                      Row(
                        children: [
                          Checkbox(
                              value: watch.isPhotographer,
                              onChanged:(value){
                                read.changeIsPhotographer(value);
                              },
                            checkColor: mainColor,
                            fillColor: MaterialStateProperty.all(Colors.white),
                            overlayColor:MaterialStateProperty.all(Colors.white.withOpacity(0.6)),
                            //splashRadius: 10.0,

                          ),
                          Text(
                            'Sign up as a Photographer',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: responsivizer(context,13,15,18,22),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height:30,
                      ),
                      Container(
                        width: double.infinity,
                        height:responsivizer(context, 50, 58, 65, 75),
                        child: watch.isSignUpButtonLoading ?
                        Center(child: Container(height: 20,width: 20,child: CircularProgressIndicator(color: Colors.white,)))
                            :
                        defaultButton(
                          function: () async {
                            if (formKey.currentState!.validate() &&
                                formKey.currentState != null) {
                              if(watch.isPhotographer == false)
                                {
                                  final result = await read.customerSignUp(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    password: passwordController.text,
                                  );
                                  if(result == 'success') {
                                    showToast(text: result);
                                    navigateAndFinish(
                                        context, LayoutScreen());
                                  }else {showToast(text: result);}
                                }else
                                  {
                                    final result = await read.photographerSignUp(
                                      name: nameController.text.trim(),
                                      email: emailController.text,
                                      phone: phoneController.text,
                                      password: passwordController.text,
                                    );
                                    if(result == 'success') {
                                      showToast(text: result);
                                      navigateAndFinish(
                                          context, PhotographerProfileScreenOWNER());
                                    }else {showToast(text: result);}
                                  }

                            }

                          },
                          text: 'Sign Up',
                          isUpperCase: true,
                          width: double.infinity,
                          background: Colors.white,
                          colorText: mainColor,
                        ),
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
