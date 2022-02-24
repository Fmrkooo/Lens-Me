import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lensme/screens/screens_photographer/setting_photographer/gallery_screen.dart';
import 'package:lensme/screens/screens_photographer/setting_photographer/setting_photographer_provider.dart';
import 'package:lensme/shared/components/components.dart';
import 'package:lensme/screens/screens_photographer/notification_photographer/notification_photographer_screen.dart';
import 'package:lensme/screens/screens_photographer/setting_photographer/setting_photographer_screen.dart';
import 'package:lensme/shared/constants.dart';
import 'package:lensme/shared/theme/colors.dart';
import 'package:provider/src/provider.dart';

class PhotographerProfileScreenOWNER extends StatefulWidget {
  const PhotographerProfileScreenOWNER({Key? key}) : super(key: key);

  @override
  State<PhotographerProfileScreenOWNER> createState() => _PhotographerProfileScreenOWNERState();
}

class _PhotographerProfileScreenOWNERState extends State<PhotographerProfileScreenOWNER> {

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<SettingPhotographerProvider>(context, listen: false).getPhotographerData();
      if(Id != null)
      Provider.of<SettingPhotographerProvider>(context, listen: false).getAppointment(photographerId: Id!);

    });

    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    var watch = context.watch<SettingPhotographerProvider>();
    var read = context.read<SettingPhotographerProvider>();

    var model=watch.photographerModel;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Stack(
          children: [
            IconButton(
              icon: Icon(
                Icons.notifications,
                size: responsivizer(context, 25, 30, 35, 40),
              ),
              onPressed: () {
                navigateTo(context,NotificationPhotographerScreen(model!));
              },
            ),
          ],
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
            child:  Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(
                  onPressed: (){
                    navigateTo(context,SettingPhotographerScreen());
                  },
                  icon: Icon(
                      Icons.settings, color: mainColor, size: responsivizer(context, 25, 30, 35, 40)),
                ),
                if(watch.not)
                  Padding(
                    padding: const EdgeInsets.all(10.5),
                    child: CircleAvatar(
                      radius: responsivizer(context, 3, 4, 4, 5),
                     // backgroundColor: Colors.redAccent,
                      backgroundColor: Colors.lightGreen,
                    ),
                  ),
              ],
            ),
          ),
        ],
        backgroundColor: Colors.white,
        foregroundColor: mainColor,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh:() async{
          await read.getPhotographerData();
        } ,
        child: BuildCondition(
          condition: model != null ,
          builder: (context) =>  SingleChildScrollView(
            physics: BouncingScrollPhysics() ,
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
                            child: Image.network(model!.profilePicture??'',width: 120,height: 120,fit: BoxFit.cover,),

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
                            Image(
                              image: AssetImage('assets/images/dislike_unfilled.png'),width: responsivizer(context, 30, 35, 40, 45), height: responsivizer(context, 30, 35, 40, 45),
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
                            Image(
                              image: AssetImage('assets/images/like_unfilled.png'),width: responsivizer(context, 30, 35, 40, 45), height: responsivizer(context, 30, 35, 40, 45),
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
                      // height: 350,
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
                                buildProfileTextContent(title: 'Shooting Types:', info: model.shootingTypes!.isNotEmpty?model.shootingTypes!:['??'],context: context),
                                buildProfileTextContent(title: 'Available Locations:',info:  model.locations!.isNotEmpty?model.locations!:['??'],context: context),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildProfileTextContent(title: 'Date&Time:',info:model.freeTimes!.isNotEmpty?['${model.freeTimes![0]}','To','${model.freeTimes![model.freeTimes!.length-1]}']:['??'],context: context),
                                buildProfileTextContent(title: 'Phone Number:',info: [model.phone!],context: context),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildProfileTextContent(title: 'Experience Years:', info: [model.experienceYears!.isNotEmpty?model.experienceYears!:'??'],context: context),
                                buildProfileTextContent(title: 'Price:',info: ['${model.initialPrice} jod/session'],context: context),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      buildPhotoSlider(context,model.gallery),
                      Padding(
                          padding: const EdgeInsetsDirectional.only(end:20.0, bottom: 20),
                          child: GestureDetector(
                            onTap: (){
                              navigateTo(
                                context,
                                  GalleryScreen(),
                              );
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [Icon(Icons.linked_camera, color: mainColor, size: 30,),
                                Icon(Icons.linked_camera, color: secondColor, size: 26,)],),
                          )

                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround, // OR .spaceEvenly
                    children: [
                      GestureDetector(
                        onTap: (){
                          Utils.openPhoneCall(phoneNumber: model.phone!);
                        },
                        child: Image(
                          image: AssetImage('assets/images/call_unfilled.png'),width: responsivizer(context,  40, 50, 60, 70), height: responsivizer(context,  40, 50, 60, 70),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Utils.openLink(url: model.socialLinks![1]);
                        },
                        child: Image(
                          image: AssetImage('assets/images/Instagram.png'),width: responsivizer(context,  40, 50, 60, 70), height: responsivizer(context,  40, 50, 60, 70),
                        ),
                      ),
                      GestureDetector(
                        onTap: ()  {
                          Utils.openLink(url: model.socialLinks![0]);
                        },
                        child: Image(
                          image: AssetImage('assets/images/facebook.png'),width: responsivizer(context, 40, 50, 60, 70), height: responsivizer(context,  40, 50, 60, 70),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 16,)
                ],
              ),
            ),
          ),
          fallback: (context)=>Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
