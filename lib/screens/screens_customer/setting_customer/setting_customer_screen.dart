import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:lensme/layout/layout_customer/layout_provider.dart';
import 'package:lensme/shared/components/components.dart';
import 'package:lensme/screens/screens_customer/setting_customer/setting_customer_provider.dart';
import 'package:lensme/shared/constants.dart';
import 'package:lensme/shared/theme/colors.dart';
import 'package:provider/provider.dart';

class SettingCustomerScreen extends StatefulWidget {

  @override
  State<SettingCustomerScreen> createState() => _SettingCustomerScreenState();
}

class _SettingCustomerScreenState extends State<SettingCustomerScreen> {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController();

  var phoneController = TextEditingController();


  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      var provider=Provider.of<SettingCustomerProvider>(context, listen: false);
      provider.getCustomerData();
      nameController.text=provider.customerModel!.name!;
      phoneController.text=provider.customerModel!.phone!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var watch = context.watch<SettingCustomerProvider>();
    var read = context.read<SettingCustomerProvider>();
    var watchLayout = context.watch<LayoutProvider>();

     var model = watch.customerModel;
     nameController.text=model!.name!;
     phoneController.text=model.phone!;

    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: BuildCondition(
          condition: model != null ,
          builder:  (context)=> Padding(
            padding: const EdgeInsets.fromLTRB(16, 17, 16, 28),
            child: Form(
              key:formKey ,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: size.height*0.09,
                      child: updateFormField(
                        controller: nameController,
                        type: TextInputType.name,
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
                        prefix: Icons.person,
                      ),
                    ),
                    SizedBox(
                      height:size.height*0.02,
                    ),
                    Container(
                      height: size.height*0.09,
                      child: updateFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
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
                        prefix: Icons.phone,
                      ),
                    ),
                    SizedBox(
                      height:size.height*0.02,
                    ),
                    Container(
                      width: double.infinity,
                      height:size.height*0.08,
                      child: watch.isPageLoading? Center(child: CircularProgressIndicator())
                      :
                      defaultButton(
                        function: () async {
                          if (formKey.currentState != null &&
                              formKey.currentState!.validate()) {
                            final result = await read.updateCustomer(
                                name: nameController.text,
                                phone: phoneController.text,
                            );
                            if (result == 'error') {
                              showToast(text: 'an error occurred');
                            } else {
                              showToast(text:'success');
                            }
                          }
                          //get();
                        },
                        text: 'UPDATE',
                        isUpperCase: true,
                        width: double.infinity,
                        background: mainColor,
                        colorText: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height:size.height*0.02,
                    ),
                    Container(
                      width: double.infinity,
                      height:size.height*0.08,
                      child: defaultButton(
                        function: () {
                          defaultShowDialog(
                            context: context,
                            text: 'Are you sure',
                            function: (){
                              signOut(context);
                              watchLayout.currentIndex=0;
                            }
                          );
                        },
                        text: 'LOGOUT',
                        isUpperCase: true,
                        width: double.infinity,
                        background: mainColor,
                        colorText: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        ),
      );
  }
}
