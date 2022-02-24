import 'dart:io';
import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:lensme/screens/screens_photographer/calendar/calendar_screen.dart';
import 'package:lensme/shared/components/components.dart';
import 'package:lensme/screens/screens_photographer/setting_photographer/setting_photographer_provider.dart';
import 'package:lensme/shared/constants.dart';
import 'package:lensme/shared/theme/colors.dart';
import 'package:provider/provider.dart';

class SettingPhotographerScreen extends StatefulWidget {

  @override
  State<SettingPhotographerScreen> createState() => _SettingPhotographerScreenState();
}

class _SettingPhotographerScreenState extends State<SettingPhotographerScreen> {
  var formKey = GlobalKey<FormState>();


  var nameController = TextEditingController();


  var phoneController = TextEditingController();

  var priceController = TextEditingController();

  var experienceController = TextEditingController();

  var offerController = TextEditingController();

  var facebookController = TextEditingController();

  var instagramController = TextEditingController();



  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      var provider=Provider.of<SettingPhotographerProvider>(context, listen: false);
      provider.getPhotographerData();
      nameController.text=provider.photographerModel!.name!;
      phoneController.text=provider.photographerModel!.phone!;
      priceController.text=provider.photographerModel!.initialPrice.toString();
      experienceController.text=provider.photographerModel!.experienceYears!;
      offerController.text=provider.photographerModel!.offer!;
      facebookController.text=provider.photographerModel!.socialLinks![0];
      instagramController.text=provider.photographerModel!.socialLinks![1];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var watch = context.watch<SettingPhotographerProvider>();
    var read = context.read<SettingPhotographerProvider>();
    final size = MediaQuery.of(context).size;

    var model = watch.photographerModel;
    var image =watch.profileImage;


    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,color: Colors.black54,size:responsivizer(context, 26, 28, 30, 32),),
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: responsivizer(context, 20, 24, 28, 33),
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only( end: 16.0),
            child:  Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(
                  color: mainColor,
                  onPressed: (){
                    navigateTo(
                      context,
                      CalendarScreen(model!),
                    );
                   // read.changeNotFalse();
                  },
                  icon: Icon(Icons.calendar_today,),
                ),
                if(watch.not)
                  Padding(
                    padding: const EdgeInsets.all(10.5),
                    child: CircleAvatar(
                      radius: responsivizer(context, 3, 4, 4, 5),
                      //backgroundColor: Colors.redAccent,
                      backgroundColor: Colors.lightGreen,
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
        body: RefreshIndicator(
          onRefresh:() async{
            await read.getPhotographerData();
          } ,
          child: BuildCondition(
            condition:  model != null,
            builder: (context) => Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: SingleChildScrollView(
                child: Form(
                  key:formKey ,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                radius: responsivizer(context, 49, 54, 59, 64),
                                backgroundColor: Colors.grey,
                              ),
                              CircleAvatar(
                                  radius: responsivizer(context, 47, 52, 57, 62),
                                  child: ClipOval(
                                    child: watch.profileImage.isEmpty ?
                                    Image.network(model!.profilePicture??'',
                                      width: 120,height: 120,fit: BoxFit.cover,)
                                        :
                                    Image.file(File(image),width: 120,height: 120,fit: BoxFit.cover,),
                                    // Image(
                                    //   image: AssetImage('assets/images/pp.jpeg'),
                                    // ),
                                  )),
                              //Icon(Icons.linked_camera_outlined, color: mainColor,)
                            ],
                          ),
                          GestureDetector(
                            onTap: read.pickProfileImage,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                //Icon(Icons.linked_camera, color: mainColor, size: 23,),
                                CircleAvatar(
                                  radius: responsivizer(context, 11, 14, 16, 18),
                                  backgroundColor: mainColor,
                                ),
                                Icon(Icons.linked_camera, color: Colors.white, size: responsivizer(context, 15, 20, 23, 28),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height:15,
                      ),
                      Container(
                        height: 55,
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
                          // onChange: (value){
                          //   name=value;
                          // },
                        ),
                      ),
                      SizedBox(
                        height:10,
                      ),
                      Container(
                        height: 55,
                        child: updateFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validator: (value) {
                            String pattern = '(^(07)(7|8|9)[0-9]{7})';
                            RegExp regExp = new RegExp(pattern);
                            if(value!.isEmpty ) {
                              // showToastChecker += 'Please enter your phone\n';
                              return ' Please enter your phone';
                            }
                            else if (!regExp.hasMatch(value)) {
                              // showToastChecker += 'Please enter valid mobile number\n';
                              return ' Please enter valid mobile number';
                            }
                          },
                          prefix: Icons.phone,
                        ),
                      ),
                      SizedBox(
                        height:10,
                      ),
                      Container(
                        height: 55,
                        child: updateFormField(
                          controller: priceController,
                          type: TextInputType.number,
                          validator: (value) {
                            String pattern = '(^[0-9])';
                            RegExp regExp = new RegExp(pattern);
                            if (value!.isEmpty) {
                              return ' please enter your price';
                            }
                            if (!regExp.hasMatch(value)) {
                              return ' please enter integer value';
                            }
                          },
                          prefix:Icons.attach_money,
                        ),
                      ),
                      SizedBox(
                        height:10,
                      ),
                      Container(
                        height: 55,
                        child: updateFormField(
                          controller: offerController,
                          type: TextInputType.text,
                          validator: (value) {
                            // if (value!.isEmpty) {
                            //   return ' please enter your experience years';
                            // }
                          },
                          prefix:Icons.work_outline_outlined,
                        ),
                      ),
                      SizedBox(
                        height:10,
                      ),
                      Container(
                        height: 55,
                        child: updateFormField(
                          controller: experienceController,
                          type: TextInputType.text,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ' please enter your experience years';
                            }
                          },
                          prefix:Icons.work_outline_outlined,
                        ),
                      ),
                      SizedBox(
                        height:10,
                      ),
                      Container(
                        child: defaultFormChoice(
                          label: 'Choose Available Locations',
                          allList: watch.listLocations,
                          selectedList:model!.locations!,
                        ),
                      ),
                      SizedBox(
                        height:10,
                      ),
                      Container(
                        child: defaultFormChoice(
                          label: 'Choose Shooting Types',
                          allList: watch.listShootingTypes,
                          selectedList:model.shootingTypes!,
                        ),
                      ),
                      SizedBox(
                        height:10,
                      ),
                      Container(
                        height: 55,
                        child: updateFormField(
                          controller: facebookController,
                          type: TextInputType.emailAddress,
                          validator: (value) {
                            // if (value!.isEmpty) {
                            //   return ' please enter your price';
                            // }
                          },
                          prefix:Icons.facebook,
                        ),
                      ),
                      SizedBox(
                        height:10,
                      ),
                      Container(
                        height: 55,
                        child: updateFormField(
                          controller: instagramController,
                          type: TextInputType.emailAddress,
                          validator: (value) {
                            // if (value!.isEmpty) {
                            //   return ' please enter your price';
                            // }
                          },
                          prefix:Icons.account_circle_outlined,
                        ),
                      ),
                      SizedBox(
                        height:10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: watch.isPageLoading? Center(child: CircularProgressIndicator())
                            :
                        defaultButton(
                          function: () async {
                            if (formKey.currentState != null &&
                                formKey.currentState!.validate()) {
                              model.socialLinks![0]=facebookController.text;
                              model.socialLinks![1]=instagramController.text;
                              final result = await read.updatePhotographer(
                                name: nameController.text,
                                phone: phoneController.text,
                                initialPrice: int.parse(priceController.text),
                                locations:model.locations!,
                                freeTimes: model.freeTimes,
                                shootingTypes: model.shootingTypes!,
                                socialLinks:model.socialLinks!,
                                pExperience:experienceController.text,
                                offer: offerController.text,
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
                        height:10,
                      ),
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: defaultButton(
                          function: () {
                            defaultShowDialog(
                                context: context,
                                text: 'Are you sure',
                                function: (){
                                  read.changeNotTrue();
                                  signOut(context);
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
        ),
      );
  }

  Widget defaultFormChoice({
    required String label,
    required List<String> allList,
    required List<String> selectedList,
  })
  {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey,width: 0.7,),
        borderRadius: BorderRadius.circular(2),
      ),
      child: ExpansionTile(
        collapsedIconColor: Colors.grey,
        iconColor:Colors.white,
        title: Text(
          label,
          style:
          TextStyle(color: Colors.black54,fontSize: 14.5,fontWeight: FontWeight.bold),
        ),
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 17,bottom: 10,right: 10),
              child: Container(
                height: 150,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemBuilder:(context, index) =>  CheckboxListTile(
                    title: Text(allList[index]),
                    onChanged:(isSelected){
                      setState(() {
                        if(isSelected!) {
                          selectedList.add(allList[index]);
                        } else {
                          selectedList.remove(allList[index]);
                        }
                      });

                    },
                    value:selectedList.contains(allList[index]),
                  ),
                  itemCount: allList.length,
                ),
              )
          ),
        ],
      ),
    );
  }
}


