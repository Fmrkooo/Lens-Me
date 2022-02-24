import 'package:flutter/material.dart';
import 'package:lensme/layout/layout_customer/layout_provider.dart';
import 'package:lensme/layout/layout_customer/layout_screen.dart';
import 'package:lensme/screens/authentication/login/login_provider.dart';
import 'package:lensme/screens/authentication/login/login_screen.dart';
import 'package:lensme/screens/authentication/sign_up/sign_up_provider.dart';
import 'package:lensme/screens/screens_customer/appointment_customer/appointment_customer_provider.dart';
import 'package:lensme/screens/screens_customer/filtering_customer_screen/filtring_customer_provider.dart';
import 'package:lensme/screens/screens_customer/setting_customer/setting_customer_provider.dart';
import 'package:lensme/screens/screens_photographer/notification_photographer/notification_photographer_provider.dart';
import 'package:lensme/screens/screens_photographer/profile_photographer_owner/profile_photographer_screen_owner.dart';
import 'package:lensme/screens/screens_photographer/profile_photographer_visitor/profile_photographer_visitor_provider.dart';
import 'package:lensme/screens/screens_photographer/setting_photographer/setting_photographer_provider.dart';
import 'package:lensme/shared/cashe_helper.dart';
import 'package:lensme/shared/components/components.dart';
import 'package:lensme/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async
{
  print('on massage back ground');
  showToast(text:'on massage back ground');
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  print('888888888888888888888888');
  print(token);
  print('888888888888888888888888');

  FirebaseMessaging.onMessage.listen((event) {
    print('on massage');
    print(event.notification!.body);
    showToast(text:'on massage');
   // navigateTo(context,LayoutScreen());
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('on massage open app');
    print(event.notification!.body);
    showToast(text:'on massage open app');
  });
  var massage=FirebaseMessaging.instance.getInitialMessage();
  if(massage != null){
    print('massage 3');
  }

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await CacheHelper.init();
  Widget? widget;

  Id =CacheHelper.getData(key: 'Id');
  if (Id != null) {
    isPhotographer= CacheHelper.getData(key: 'isPhotographer');
    if(isPhotographer)
      {
        widget = PhotographerProfileScreenOWNER();
      }
      else
        {
          widget = LayoutScreen();
        }
  } else
    widget = LoginScreen();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<LayoutProvider>(
        create: (_) => LayoutProvider()),
    ChangeNotifierProvider<SignUpProvider>(
        create: (_) => SignUpProvider()),
    ChangeNotifierProvider<LoginProvider>(
        create: (_) => LoginProvider()),
    ChangeNotifierProvider<SettingPhotographerProvider>(
        create: (_) => SettingPhotographerProvider()),
    ChangeNotifierProvider<SettingCustomerProvider>(
        create: (_) => SettingCustomerProvider()),
    ChangeNotifierProvider<FilteringCustomerProvider>(
        create: (_) => FilteringCustomerProvider()),
    ChangeNotifierProvider<AppointmentCustomerProvider>(
        create: (_) => AppointmentCustomerProvider()),
    ChangeNotifierProvider<NotificationPhotographerProvider>(
        create: (_) => NotificationPhotographerProvider()),
    ChangeNotifierProvider<ProfilePhotographerVisitorProvider>(
        create: (_) => ProfilePhotographerVisitorProvider()),
  ], child: MyApp(
    startWidget: widget,
  )));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp({
    required this.startWidget,
  });
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
        ClampingScrollWrapper.builder(context, widget!),
        breakpoints: const [
          ResponsiveBreakpoint.autoScale(320, name: 'MOBILE-S'),
          ResponsiveBreakpoint.autoScale(375, name: 'MOBILE-M'),
          ResponsiveBreakpoint.autoScale(425, name: 'MOBILE-L'),
          ResponsiveBreakpoint.autoScale(450, name: 'MOBILE-XL'),
        ],
      ),
      title: 'Lens Me',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Comfortaa',
      ),
      home: startWidget,
    );
  }
}
