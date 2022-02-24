import 'package:flutter/material.dart';
import 'package:lensme/screens/screens_customer/setting_customer/setting_customer_provider.dart';
import 'package:lensme/shared/components/components.dart';
import 'package:provider/src/provider.dart';

class NotificationCustomerScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var read = context.read<SettingCustomerProvider>();
    var watch = context.watch<SettingCustomerProvider>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: RefreshIndicator(
          onRefresh:() async{
            await read.customerAppointments(customerId: watch.customerModel!.customerId!);
          },
          child: ListView.separated(
            itemBuilder: (context, index) => GestureDetector(
              onTap: (){
                Utils.openPhoneCall(
                    phoneNumber: watch.CustomerAppointments[index].photographerPhone!);
              },
              child: cardCustomerNotification(
                model: watch.CustomerAppointments[index],
                context: context,
              ),
            ),
            separatorBuilder: (context, index) => SizedBox(
              height: 15,
            ),
            itemCount: watch.CustomerAppointments.length,
          ),
        ),
      ),
    );
  }
}