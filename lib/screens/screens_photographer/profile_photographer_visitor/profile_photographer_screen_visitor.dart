import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lensme/layout/layout_customer/layout_provider.dart';
import 'package:lensme/models/photographer_model.dart';
import 'package:lensme/screens/screens_customer/setting_customer/setting_customer_provider.dart';
import 'package:lensme/shared/components/components.dart';
import 'package:lensme/screens/screens_customer/appointment_customer/appointment_customer_screen.dart';
import 'package:lensme/shared/theme/colors.dart';
import 'package:provider/src/provider.dart';

class PhotographerProfileScreenVISITOR extends StatelessWidget {
  PhotographerModel model;

  PhotographerProfileScreenVISITOR(this.model);
  @override
  Widget build(BuildContext context) {

    var layoutWatch = context.watch<LayoutProvider>();
    var layoutRead = context.read<LayoutProvider>();

    var watch = context.watch<SettingCustomerProvider>();
    var read = context.read<SettingCustomerProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: responsivizer(context, 23, 28, 33, 38),
          ),
          onPressed: () {
            pop(context);
          },
        ),
        title: Text(
          'Profile',
          style: TextStyle(fontSize: responsivizer(context, 20, 24, 29, 34),
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only( end: 16.0),
            child: IconButton(
              icon: Icon(
                  watch.favorites.contains(model.photographerId)?Icons.favorite:Icons.favorite_border,
                  color: mainColor,
                  size: responsivizer(context, 25, 30, 35, 40)),
              onPressed: () {
               read.addFavorite(id: model.photographerId!,allPhotographers:layoutWatch.photographersData );
                },),
          )
        ],
        backgroundColor: Colors.white,
        foregroundColor: mainColor,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        navigateTo(
          context,
          AppointmentCustomerScreen(model),
        );
      },
        backgroundColor: mainColor,
        foregroundColor: Colors.white,
      child: Icon(Icons.date_range),),
      body: BuildCondition(
          condition: model != null ,
          builder: (context) => SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 16,),
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
                              child:
                              Image.network(model.profilePicture??'',width: 120,height: 120,fit: BoxFit.cover,),

                          )),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    '${model.name}',
                    style: TextStyle(fontSize: responsivizer(context, 15, 20, 25, 30),
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 10.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              child: watch.customerModel!.rate!.containsKey(model.photographerId) && watch.customerModel!.rate![model.photographerId]==false?
                              Image(
                                image: AssetImage('assets/images/dislike.png'),width: responsivizer(context, 30, 35, 40, 45), height: responsivizer(context, 30, 35, 40, 45),
                              ):
                              Image(
                                image: AssetImage('assets/images/dislike_unfilled.png'),width: responsivizer(context, 30, 35, 40, 45), height: responsivizer(context, 30, 35, 40, 45),
                              ),
                              onTap:() async {
                                final result=await read.addRate(id: model.photographerId!, rate: false);
                                print(result);
                                int like = model.like!;
                                int dislike = model.dislike!;

                                if(result == 'add'){
                                  dislike++;
                                } else if(result == 'remove'){
                                  dislike--;
                                } else if(result == 'add+remove'){
                                  like--;
                                  dislike++;
                                }
                                model.like=like;
                                model.dislike=dislike;
                                await layoutRead.updatePhotographers(
                                  modelPhotographer: model,
                                );
                              } ,
                            ),
                            // Icon(Icons.tag_faces, color: Colors.green, size: 35,),
                            SizedBox(height: 5,),
                            Text(
                              '${model.dislike}',
                              style: TextStyle(fontSize: responsivizer(context, 12, 17, 22, 27),fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width:35),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 10.0),
                        child: Column(
                          children: [
                           GestureDetector(
                             child: watch.customerModel!.rate!.containsKey(model.photographerId) && watch.customerModel!.rate![model.photographerId]==true?
                             Image(
                               image: AssetImage('assets/images/like.png'),width: responsivizer(context, 30, 35, 40, 45), height: responsivizer(context, 30, 35, 40, 45),
                             ):
                             Image(
                               image: AssetImage('assets/images/like_unfilled.png'),width: responsivizer(context, 30, 35, 40, 45), height: responsivizer(context, 30, 35, 40, 45),
                             ),
                             onTap: () async {
                               final result= await read.addRate(id: model.photographerId!, rate: true);

                               print(result);

                               int like = model.like!;
                               int dislike = model.dislike!;

                               if(result == 'add'){
                                 like++;
                               } else if(result == 'remove'){
                                 like--;
                               } else if(result == 'add+remove'){
                                 dislike--;
                                 like++;
                               }
                               model.like=like;
                               model.dislike=dislike;
                               layoutRead.updatePhotographers(
                                 modelPhotographer: model,
                               );
                             },
                           ),
                            // Icon(Icons.tag_faces, color: Colors.red, size: 35,),
                            SizedBox(height: 5,),

                            Text(
                              '${model.like}',
                              style: TextStyle(fontSize: responsivizer(context, 12, 17, 22, 27),fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 6, color: mainColor),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 1,
                            offset: Offset(2, 2), // changes position of shadow
                          ),
                        ],

                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildProfileTextContent(title: 'Shooting Types:',info: model.shootingTypes!.isNotEmpty?model.shootingTypes!:['??'],context: context),
                                buildProfileTextContent(title: 'Available Locations:',info: model.locations!.isNotEmpty?model.locations!:['??'],context: context),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildProfileTextContent(title: 'Date&Time:',info:model.freeTimes!.isNotEmpty?['${model.freeTimes![0]}','To','${model.freeTimes![model.freeTimes!.length-1]}']:['??'],context: context),
                                buildProfileTextContent(title: 'Phone Number:',info:  ['${model.phone}'],context: context),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildProfileTextContent(title: 'Experience Years:',info: [model.experienceYears!.isNotEmpty?model.experienceYears!:'??'],context: context),
                                buildProfileTextContent(title: 'Price:',info:  ['${model.initialPrice} jod/session'],context: context),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  buildPhotoSlider(context,model.gallery),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround, // OR .spaceEvenly
                    children: [
                      GestureDetector(
                        onTap: (){
                          Utils.openPhoneCall(phoneNumber: model.phone!);
                        },
                        child: Image(
                          image: AssetImage('assets/images/call_unfilled.png'),width: responsivizer(context,  40, 50, 60, 70), height: responsivizer(context, 40, 50, 60, 70),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Utils.openLink(url: model.socialLinks![1]);
                        },
                        child: Image(
                          image: AssetImage('assets/images/Instagram.png'),width: responsivizer(context, 40, 50, 60, 70), height: responsivizer(context, 40, 50, 60, 70),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await Utils.openLink(url: model.socialLinks![0]);
                        },
                        child: Image(
                          image: AssetImage('assets/images/facebook.png'),width: responsivizer(context,  40, 50, 60, 70), height: responsivizer(context, 40, 50, 60, 70),
                        ),
                      ),
                      SizedBox(),
                    ],
                  ),
                  SizedBox(height: 16,)
                ],
              ),
            ),
          ),
        fallback: (context)=>Center(child: CircularProgressIndicator()),

      ),
    );
  }
}
