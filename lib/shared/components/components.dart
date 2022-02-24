import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lensme/models/appointment_model.dart';
import 'package:lensme/models/photographer_model.dart';
import 'package:lensme/screens/screens_photographer/profile_photographer_visitor/profile_photographer_screen_visitor.dart';
import 'package:lensme/shared/theme/colors.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

Widget defaultButton({
  double width = 130,
  double? height,
  Color? background,
  Color? colorText,
  required String text,
  required Function function,
  bool isUpperCase = true,
  double radius = 20.0,
}) =>
    Container(
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 5)),
          ],
        ),
        child: MaterialButton(
            child: Text(
              isUpperCase ? text.toUpperCase() : text,
              style: TextStyle(
                  color: colorText ,fontSize: 15, fontWeight: FontWeight.bold),
              maxLines: 1,
            ),
            onPressed: () {
              function();
            }),
    );

//////////////////////////////////////////////////////////////////////////////

Widget defaultTextButton({
  required Function function,
  required String text,
}) =>
    LayoutBuilder(
      builder: (context, constraints) => TextButton(
        onPressed: () {
          function();
        },
        child: FittedBox(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
          ),
        ),
      ),
    );


//////////////////////////////////////////////////////////////////////////////////////////
Widget defaultFormField({
  required TextEditingController controller,
  required String text,
  required String label,
  required IconData prefix,
  required TextInputType type,
  required BuildContext respCTX,
  Function? onSubmit,
  Function? onChange,
  VoidCallback? onTap,
  Function? validate,
  String? Function(String?)? validator,
  IconData? suffix,
  bool isPassword = false,
  VoidCallback? suffixPressed,
  double? height,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: responsivizer(respCTX, 14, 18, 22, 26),
          ),
        ),
        SizedBox(
          height: responsivizer(respCTX, 10, 10, 10, 10),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 5.0,left: 8.0),
          height: responsivizer(respCTX, 50, 58, 65, 75),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(responsivizer(respCTX, 15, 20, 25, 30)!),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 4),
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              controller: controller,
              decoration: InputDecoration(
                suffixStyle: TextStyle(color: mainColor),
                  errorStyle: TextStyle(color: mainColor,),
                  // hintStyle: TextStyle(color: Colors.grey,fontSize: 13),
                  //   hintText: label,
                  prefixIcon:Icon(
                    prefix,
                    color: mainColor,
                    size: responsivizer(respCTX, 20, 23, 28, 33),
                  ),
                  suffixIcon: suffix != null
                      ? IconButton(
                    onPressed: suffixPressed,
                    icon: Icon(suffix),
                  )
                      : null,
                  border: InputBorder.none),
              keyboardType: type,
              onFieldSubmitted: (s) {
                if (onSubmit != null) onSubmit(s);
              },
              onChanged: (s) {
                if (onChange != null) onChange(s);
              },
              validator: validator ??
                      (input) {
                    if (input?.isEmpty ?? true) {
                      return 'input must not be empty';
                    }
                    return null;
                  },
              obscureText: isPassword,
              onTap: onTap,
            ),
          ),
        ),
      ],
    );


//////////////////////////////////////////////////////////////////////////////

Widget updateFormField({
  required TextEditingController controller,
  String? label,
  required IconData prefix,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  VoidCallback? onTap,
  Function? validate,
  String? Function(String?)? validator,
  IconData? suffix,
  bool isPassword = false,
  VoidCallback? suffixPressed,
  double? height,
}) =>
    LayoutBuilder(
      builder: (context, constraints) =>
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey,width: 1,),
              borderRadius: BorderRadius.circular(2),
            ),
            child: TextFormField(
              //enabled: false,
              textAlignVertical: TextAlignVertical.center,
              controller: controller,
              decoration: InputDecoration(
                  errorStyle: const TextStyle(color: mainColor,),
                  hintStyle: const TextStyle(color: Colors.grey,),
                  hintText: label,
                  prefixIcon:Icon(
                    prefix,
                    color: mainColor,
                    size: constraints.maxHeight*0.35,
                  ),
                  suffixIcon: suffix != null
                      ? IconButton(
                    onPressed: suffixPressed,
                    icon: Icon(suffix),
                  )
                      : null,
                  border: InputBorder.none
              ),
              keyboardType: type,
              onFieldSubmitted: (s) {
                if (onSubmit != null) onSubmit(s);
              },
              onChanged: (s) {
                if (onChange != null) onChange(s);
              },
              validator: validator ??
                      (input) {
                    if (input?.isEmpty ?? true) {
                      return 'input must not be empty';
                    }
                    return null;
                  },
              obscureText: isPassword,
              onTap: onTap,
            ),
          ),
    );
/////////////////////////////////////////////////////////////////


Widget filterComponent({
  required String label,
  required List<String>list,
})
{
  return LayoutBuilder(
    builder: (context, constraints) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: constraints.maxHeight*0.15,
          child: Text(
              label,
              style: TextStyle  (
                fontSize: 24.0,
                color: mainColor,
                fontWeight: FontWeight.w700,)),
        ),
        Container(
          //color: Colors.red,
          height: constraints.maxHeight*0.85,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10,10,10,15),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemBuilder:(context, index) => Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(list[index],style: TextStyle(fontSize: 16),),
                  Container(
                    child: Checkbox(
                        materialTapTargetSize:MaterialTapTargetSize.shrinkWrap,
                        value: false,
                        onChanged: (value){}
                    ),
                  ),
                ],

              ),
              itemCount:list.length,
            ),
          ) ,
        ),
      ],
    ),
  );
}

///////////////////////////////////////////////////////////////////

Widget cardPhotographerNotification({
  required AppointmentModel model,
  required BuildContext context,
  required Function function,
})
{
  return
    // Dismissible(
    // key:Key(model.appointmentTime!),
    // onDismissed:(direction){
    //   function();
    // },
    // child:
    Container(
      // height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 1.5,color: mainColor),
        boxShadow: const [
          BoxShadow(
              color: Colors.black26, blurRadius: 6, offset: Offset(0, 5)),
        ],
      ),
      child:  Padding(
        padding: const EdgeInsets.fromLTRB(3,3,3,10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    defaultShowDialog(
                        context: context,
                        function: function,
                        text: 'Are you sure about that ?',
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text('CANCEL',style: TextStyle(
                      fontSize: responsivizer(context,14,15,16,17),
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),),
                  ),
                ),
              ],
            ),
            Text('Great News!',style: TextStyle(
              fontSize: responsivizer(context,14,15,16,17),
              fontWeight: FontWeight.bold,
              color:  Colors.black54,
            ),),
            Text('You Just Got A new Reservation',
              style: TextStyle(
                fontSize: responsivizer(context,14,15,16,17),
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      model.customerName!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize:responsivizer(context,11,12,14,16), color: mainColor,
                      ),

                    ),
                    SizedBox(height: 5,),
                    Text(
                      model.shootingType!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize:responsivizer(context,11,12,14,16), color: mainColor),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      model.customerPhone!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize:responsivizer(context,11,12,14,16), color: mainColor),
                    ),
                    SizedBox(height: 5,),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '${model.city!} / ${model.location}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize:responsivizer(context,11,12,14,16), color: mainColor,
                      ),
                      // maxLines: 1,
                      // overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5,),
                    Text(
                      model.offer!.isEmpty?
                      '${model.price}'
                      :
                      '${model.price} * ${model.offer}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize:responsivizer(context,11,12,14,16), color:mainColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5,),
                    Text(
                      model.appointmentTime!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize:responsivizer(context,11,12,14,16), color: mainColor),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  //);
}

Widget cardCustomerNotification({
  required AppointmentModel model,
  required BuildContext context,
 // required Function function,
})
{
  return Container(
      // height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 1.5,color: mainColor),
        boxShadow: const [
          BoxShadow(
              color: Colors.black26, blurRadius: 6, offset: Offset(0, 5)),
        ],
      ),
      child:  Padding(
        padding: const EdgeInsets.fromLTRB(3,15,3,10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('You have a Appointment',
              style: TextStyle(
                fontSize: responsivizer(context,14,15,16,17),
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      model.photographerName!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize:responsivizer(context,11,12,14,16), color: mainColor,
                      ),

                    ),
                    SizedBox(height: 5,),
                    Text(
                      model.shootingType!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize:responsivizer(context,11,12,14,16), color: mainColor),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      model.photographerPhone!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize:responsivizer(context,11,12,14,16), color: mainColor),
                    ),
                    SizedBox(height: 5,),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '${model.city!} / ${model.location}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize:responsivizer(context,11,12,14,16), color: mainColor,
                      ),
                      // maxLines: 1,
                      // overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5,),
                    Text(
                      model.offer!.isEmpty?
                      '${model.price}'
                          :
                      '${model.price} * ${model.offer}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize:responsivizer(context,11,12,14,16), color:mainColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5,),
                    Text(
                      model.appointmentTime!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize:responsivizer(context,11,12,14,16), color: mainColor),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  //);
}

void defaultShowDialog({
  required BuildContext context,
  Function? function,
  required String text,
}) {
  showDialog(
   // barrierColor:mainColor.withOpacity(0.25) ,
    barrierDismissible: false,
    context: context,
    builder:(context) =>  AlertDialog(
      title: Text(
        text,
        style: TextStyle(color:mainColor,fontWeight: FontWeight.bold),
      ),
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        height: 50,
        width: 100,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              defaultButton(
                text: 'Yes',
                width: 50,
                height: 30,
                background: mainColor,
                colorText: Colors.white,
                function:(){
                  if(function != null) {
                    function();
                  }
                  pop(context);
                },
              ),
              defaultButton(
                text: 'No',
                width: 50,
                height: 30,
                background: mainColor,
                colorText: Colors.white,
                function: (){
                  pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

///////////////////////////////////////////////////////////////////
void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) =>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => widget),
            (route)
        {
          return false;
        }
    );

void pop(context)=>Navigator.pop(context);

//////////////////////////////////////////////////////////////////

Widget buildProfileCard({
  BuildContext? context,
  required PhotographerModel model,
}){
  return  GestureDetector(

    onTap: (){
      navigateTo(context, PhotographerProfileScreenVISITOR(model));
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(width:0.8,color: Colors.grey),
        boxShadow: [const BoxShadow(
          color: Colors.black26,
          blurRadius: 6, offset: Offset(0,1),
        ),
        ],),
      child:  Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Stack(
          //alignment: Alignment.bottomLeft,
          children: [
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF00abbb),
                        //    Color(0xFF2ABAC7),
                        Color(0xFF22B7C5),
                        Color(0xFF65CDD7)
                      ],
                    ),
                  ),
                  height:  responsivizer(context!,140,150,160,170),
                  width: double.infinity,
                ),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius:BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0)),
                    color: Colors.white,
                  ),
                  // color:secondColor,
                  height:  responsivizer(context,48,58,68,78),
                  width: double.infinity,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: responsivizer(context,22,25,27,30),
                ),
                CircleAvatar(
                  radius:  responsivizer(context,60,65,70,75),
                  backgroundImage: NetworkImage('${model.profilePicture}'),
                ),
                SizedBox(
                  height:  responsivizer(context,7,8,9,10),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  height:  responsivizer(context,20,25,25,27),
                 // color: Colors.red,
                  width: double.infinity,
                  child: LayoutBuilder(
                    builder: (context, constraints) =>  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                            width: constraints.maxWidth*0.75,
                            child: Text(
                              '${model.name}',
                              style: TextStyle(
                                  fontSize: responsivizer(context,15,18,20,22),
                                  fontWeight: FontWeight.bold
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,

                            )),
                        Container(
                          width: constraints.maxWidth*0.25,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '${model.like}',
                                style: TextStyle(fontSize: responsivizer(context,13,15,17,19),fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Icon(
                                Icons.thumb_up_alt,
                                color: mainColor,
                                size: responsivizer(context,20,22,24,26),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height:  responsivizer(context,10,11,12,13),
                ),
              ],
            ),
            if(model.offer!.isNotEmpty)
              Container(
                color: Colors.red[400],
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Text(
                    '${model.offer}',
                    style: TextStyle(color: Colors.white,fontSize: responsivizer(context,12,14,16,18),),
                  ),
                ),
              ),
          ],
        ),
      ),
    ),
  );
}

////////////////////////////////////////////////////////////////////

Widget buildProfileTextContent({
  required String title,
  required List<String> info,
  required BuildContext context,
})
{
  return Column(
    children: [
      Container(
        width: responsivizer(context, 130, 150, 170, 190),
        decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(width: 3, color: mainColor)),
        child: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize:responsivizer(context,11,12,14,16), color: Colors.white),
        ),
      ),
      SizedBox(height: 5,),
      Container(
        padding: const EdgeInsetsDirectional.only(start: 10),
        width: responsivizer(context, 130, 150, 170, 190),
        child: Wrap(
          children: [
            for(int i=0;i<info.length;i++)...[
              Text(
                info[i]+(i==info.length-1? '':', '),
                style: TextStyle(fontSize: responsivizer(context,10,11,12,14), color: mainColor),
              ),]

          ],
        ),
      ),
      SizedBox(height: 5,),

    ],
  );
}


/////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Widget buildPhotoSlider(
    @required BuildContext context, List<String>? examples,
    )
{
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Container(
      // padding: const EdgeInsetsDirectional.all(8),
      decoration: BoxDecoration(
        color: secondColor,
        // borderRadius: BorderRadius.circular(20),
        // border: Border.all(width: 3, color: mainColor)
      ),
      child: CarouselSlider(
        items: examples!.map((e) => Image.network(
          '${e}',
          width: double.infinity,
          fit: BoxFit.cover,
        )).toList(),
        options: CarouselOptions(
          height: responsivizer(context, 190, 220, 250, 280),
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 7),
          autoPlayAnimationDuration: Duration(seconds: 1),
          autoPlayCurve: Curves.fastOutSlowIn,
          scrollDirection: Axis.horizontal,
          viewportFraction: 1,
        ),
      ),
    ),
  );
}


////////////////////////////////////////////////////////////////

double? responsivizer(
    @required BuildContext context,
    @required double S,
    @required double M,
    @required double L,
    @required double XL,
    )
=> ResponsiveValue(context,
  defaultValue: M,
  valueWhen: [
// THIS LINE ENTERS THE SCOPE OF [MOBILE-S]
    Condition.smallerThan(
      name: 'MOBILE-M',
      value: S,
    ),
// THIS LINE ENTERS THE SCOPE OF [MOBILE-L]
    Condition.largerThan(
      name: 'MOBILE-M',
      value: L,
    ),
// THIS LINE ENTERS THE SCOPE OF [MOBILE-XL]
    Condition.largerThan(
      name: 'MOBILE-L',
      value: XL,
    ),
  ],
).value;
///////////////////////////////////////////////////////////////////////////////

void showToast({
  required String text,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: mainColor,
        textColor: Colors.white,
        fontSize: 16.0);

////////////////////////////////////////////////////////////////////////////////


class Utils {
  static Future openLink({
    required String url,
  }) =>
      _launchUrl(url);

  static Future openEmail({required String toEmail}) async {
    final url = 'mailto:$toEmail';
    await _launchUrl(url);
  }

  static Future openPhoneCall({required String phoneNumber}) async {
    final url = 'tel:$phoneNumber';
    await _launchUrl(url);
  }

  static Future openSMS({required String phoneNumber}) async {
    final url = 'sms:$phoneNumber';
    await _launchUrl(url);
  }

  static Future _launchUrl(String url) async {
      await launch(url);
  }
}


