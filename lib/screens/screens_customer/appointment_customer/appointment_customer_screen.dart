import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lensme/layout/layout_customer/layout_provider.dart';
import 'package:lensme/models/photographer_model.dart';
import 'package:lensme/screens/screens_customer/setting_customer/setting_customer_provider.dart';
import 'package:lensme/screens/screens_photographer/setting_photographer/setting_photographer_provider.dart';
import 'package:lensme/shared/components/components.dart';
import 'package:lensme/shared/theme/colors.dart';
import 'package:provider/src/provider.dart';

class AppointmentCustomerScreen extends StatefulWidget {

  PhotographerModel? model;

  AppointmentCustomerScreen(this.model) ;

  @override
  State<AppointmentCustomerScreen> createState() => _AppointmentCustomerScreenState();
}

class _AppointmentCustomerScreenState extends State<AppointmentCustomerScreen> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var locationController = TextEditingController();


  List<String> location=[''];
  List<String> shootingType=[''];
  List<String> appointmentTime=[''];

  @override
  Widget build(BuildContext context) {



    var read = context.read<SettingCustomerProvider>();
    var watch = context.watch<SettingCustomerProvider>();
    var layoutRead = context.read<LayoutProvider>();
    var readPhotographer = context.read<SettingPhotographerProvider>();

    return Scaffold(
      appBar:  AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,color: Colors.black54,size:responsivizer(context, 26, 28, 30, 32),),
        ),
        title: Text(
          'Appointment',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: responsivizer(context, 20, 24, 28, 33),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
        child: BuildCondition(
          condition: true ,
          builder: (context) => Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildAppointment(
                      text: 'Location',
                      hint: 'Choose City',
                      list: widget.model!.locations??[],
                      selected: location,
                      context: context,
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: 55,
                      child: updateFormField(
                        controller: locationController,
                        type: TextInputType.name,
                        validator: (value) {
                          if(value!.isEmpty ) {
                            return ' please enter location';
                          }
                        },
                        prefix: Icons.location_on_outlined,
                        label: 'Details location',
                      ),
                    ),
                    SizedBox(height: 30,),
                    buildAppointment(
                      text: 'Shooting Types',
                      hint: 'Choose Shooting Type',
                      list: widget.model!.shootingTypes??[],
                      selected: shootingType,
                      context: context,
                    ),
                    SizedBox(height: 30,),
                    buildAppointment(
                      text: 'Shooting Times',
                      hint: 'Choose appointment time',
                      list: widget.model!.freeTimes==null || !widget.model!.freeTimes!.contains(appointmentTime[0])&&appointmentTime[0].isNotEmpty ?[]:widget.model!.freeTimes!,
                      selected: appointmentTime,
                      context: context,
                    ),
                    SizedBox(height: 30,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        watch.doneAppointment?
                        Padding(
                          padding: const EdgeInsets.only(right: 37,top: 10 ,bottom: 10,left: 10),
                          child: Center(child: Container(height: 20,width: 20,child: CircularProgressIndicator(color: mainColor,))),
                        )
                        :
                        Padding(
                          padding: const EdgeInsets.only(right: 10,top: 10 ,bottom: 10,left: 10),
                          child: Container(
                            height: responsivizer(context, 48,50,52,54),
                            width:responsivizer(context, 75,80,85,90),
                            decoration: BoxDecoration(
                              color: mainColor,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(0, 5),
                                ),
                              ],
                            ),
                            child: TextButton(
                              child: Text('Done',style: TextStyle(color:Colors.white,fontSize: responsivizer(context, 16,18,20,22),),),
                              onPressed: () async {
                                if (formKey.currentState!.validate() &&
                                    formKey.currentState != null) {
                                   String selected=appointmentTime[0];
                                  final result = await read.appointment(
                                    city:location[0],
                                    location: locationController.text,
                                    shootingType: shootingType[0],
                                    appointmentTime: selected,
                                    price: widget.model!.initialPrice.toString(),
                                    offer: widget.model!.offer!,
                                    photographerId: widget.model!.photographerId!,
                                    photographerName: widget.model!.name!,
                                    photographerPhone: widget.model!.phone!,
                                  );

                                  if(result == 'success') {
                                    await layoutRead.removeAppointment(
                                      appointmentTime: selected,
                                      model: widget.model!,
                                    );
                                    showToast(text: result);
                                    pop(context);
                                  }else {showToast(text: result);
                                  print('f2');}
                                }
                              },
                            )
                          ),
                        ),
                      ],
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

  Widget buildAppointment({
    required String text,
    required String hint,
    required List<String> list,
    required List<String> selected,
    required BuildContext context,
  })
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            text,
            style: TextStyle  (
              fontSize: responsivizer(context, 18, 20, 22, 24),
              color: mainColor,
              fontWeight: FontWeight.w700,)),
        const SizedBox(height: 5,),
        DropdownButtonFormField<String>(
          icon: Icon(Icons.arrow_drop_down,color: mainColor,size: responsivizer(context, 25, 30, 35, 38),),
          decoration: InputDecoration(
              hintStyle:TextStyle(color: Colors.grey,fontSize: responsivizer(context, 13, 14, 16, 18),),
              hintText: hint,
          ),
          items:list.map((label) => DropdownMenuItem(
            child: Text(label.toString()),
            value: label,
          )).toList(),
          onChanged: (value) {
            setState(() {
              selected[0]=value!;
            });
            print(value);
            print(selected);
          },
        ),
      ],
    );
  }
}
// Row(
// children: [
// Row(
// children: [
// Text(
// 'From',
// style: TextStyle(fontSize: responsivizer(context, 14, 16, 18, 20),),
// ),
// SizedBox(
// width: 2,
// ),
// Container(
// decoration: BoxDecoration(
// border: Border(bottom:BorderSide(width: 0.5,color: Colors.black54) ),
// ),
// height: 50,
// width:responsivizer(context,90, 110, 130,140),
// child: TextFormField(
// textAlignVertical: TextAlignVertical.center,
// controller: timeControllerFrom,
// decoration: InputDecoration(
// hintStyle: TextStyle(color: Colors.grey,fontSize: 18),
// hintText: '-:-',
// prefixIcon:Icon(
// Icons.timer,
// color: mainColor,
// size: responsivizer(context,14, 16,18,20),
// ),
// border: InputBorder.none),
// validator: (value) {
// if (value==null || value.isEmpty) {
// return "date must not be empty";
// }
// },
// onTap: (){
// showCustomTimePicker(
// context: context,
// onFailValidation: (context) => print('Unavailable selection'),
// initialTime: TimeOfDay(hour: 12, minute: 0),
// selectableTimePredicate: (time) {
// return time!.hour > 8 && time.hour < 21 &&time.minute % 60 == 0;
// }).then((time) {
// timeControllerFrom.text = time!.format(context);
// timeController.text=time.format(context);
// list.map((e){
//   list[e]=timeControllerFrom.text;
// });
// }
// );
// },
// ),
// ),
// ],
// ),
// SizedBox(
// width: 20,
// ),
// Row(
// children: [
// Text(
// 'To',
// style: TextStyle(fontSize: responsivizer(context, 14, 16, 18, 20),),
// ),
// SizedBox(
// width: 2,
// ),
// Container(
// decoration: BoxDecoration(
// border: Border(bottom:BorderSide(width: 0.5,color: Colors.black54) ),
// ),
// height: 50,
// width: responsivizer(context,90, 110, 130,140),
// child: TextFormField(
// textAlignVertical: TextAlignVertical.center,
// controller: timeControllerTo,
// decoration: InputDecoration(
// hintStyle: TextStyle(color: Colors.grey,fontSize: 18),
// hintText: '-:-',
// prefixIcon:Icon(
// Icons.timer,
// color: mainColor,
// size: responsivizer(context,14, 16,18,20),
// ),
// border: InputBorder.none),
// validator: (value) {
// if (value==null || value.isEmpty) {
// return "date must not be empty";
// }
// },
// onTap: (){
// showCustomTimePicker(
// context: context,
// onFailValidation: (context) => print('Unavailable selection'),
// initialTime: TimeOfDay(hour: 12 , minute: 0),
// selectableTimePredicate: (time) {
// return time!.hour > 8 && time.hour < 21 &&time.minute % 60 == 0;
// }).then((time) {
// timeControllerTo.text = time!.format(context);
// timeController.text+=" "+time.format(context);
// }
// );
// },
// ),
// ),
// ],
// ),
// ],
// ),
// Text('Date',
// style: TextStyle  (
// fontSize: responsivizer(context, 18, 20, 22, 24),
// color: mainColor,
// fontWeight: FontWeight.w700,)),
// SizedBox(height: 10,),
// Container(
// decoration: BoxDecoration(
// border: Border(bottom:BorderSide(width: 0.5,color: Colors.black54) ),
// ),
// height: 50,
// child: TextFormField(
// textAlignVertical: TextAlignVertical.center,
// controller: dateController,
// decoration: InputDecoration(
// hintStyle:TextStyle(color: Colors.grey,fontSize: responsivizer(context, 13, 14, 16, 18),),
// hintText: 'Choose Date',
// prefixIcon:Icon(
// Icons.date_range,
// color: mainColor,
// size: responsivizer(context, 20, 22, 24, 26),
// ),
// border: InputBorder.none),
// validator: (value) {
// if (value==null || value.isEmpty) {
// return "date must not be empty";
// }
// },
// onTap: (){
// showDatePicker(
// context: context,
// initialDate: DateTime.now(),
// firstDate:dataTime,
// lastDate: DateTime(dataTime.year,dataTime.month,dataTime.day+14),
// ).then((value) {
//
// dateController.text = DateFormat('yyyy-MM-dd').format(value!).toString();
//
// // print(DateFormat.yMMMd().format(value));
// timeController.text+=" "+dateController.text;
//
// });
//
// },
// ),
// ),