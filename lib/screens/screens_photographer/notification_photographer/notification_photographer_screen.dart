import 'package:flutter/material.dart';
import 'package:lensme/models/photographer_model.dart';
import 'package:lensme/screens/screens_photographer/setting_photographer/setting_photographer_provider.dart';
import 'package:lensme/shared/components/components.dart';
import 'package:lensme/shared/theme/colors.dart';
import 'package:provider/src/provider.dart';

class NotificationPhotographerScreen extends StatefulWidget {

  final PhotographerModel model;

  NotificationPhotographerScreen(this.model);

  @override
  State<NotificationPhotographerScreen> createState() => _NotificationPhotographerScreenState();
}


class _NotificationPhotographerScreenState extends State<NotificationPhotographerScreen> {

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<SettingPhotographerProvider>(context, listen: false).getAppointment(photographerId: widget.model.photographerId!);

    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var watch = context.watch<SettingPhotographerProvider>();
    var read = context.read<SettingPhotographerProvider>();
    print(watch.appointments);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black38,
            size: responsivizer(context, 23, 28, 33, 38),
          ),
          onPressed: () {
            pop(context);
          },
        ),
        title: Text(
          'My Appointments',
          style: TextStyle(
              fontSize: responsivizer(context, 20, 24, 29, 34),
              fontWeight: FontWeight.bold,
              color: Colors.black54
          ),),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: mainColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: RefreshIndicator(
          onRefresh:() async{
            await read.getAppointment(photographerId:widget.model.photographerId!);
          },
          child: ListView.separated(
            //shrinkWrap: true,
            //physics: BouncingScrollPhysics() ,
            itemBuilder: (context, index) => GestureDetector(
              onTap: (){
                Utils.openPhoneCall(
                    phoneNumber: watch.appointments[index].customerPhone!);
              },
              child: cardPhotographerNotification(
                model: watch.appointments[index],
                function:(){
                  final result = watch.removeAppointment(
                    photographerId:widget.model.photographerId!,
                    appointmentTime: watch.appointments[index].appointmentTime!,
                  );
                },
                context: context,
              ),
            ),
            separatorBuilder: (context, index) => SizedBox(
              height: 15,
            ),
            itemCount: watch.appointments.length,
          ),
        ),
      ),

    );
  }
}


