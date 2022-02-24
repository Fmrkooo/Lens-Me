import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:lensme/screens/screens_customer/setting_customer/setting_customer_provider.dart';
import 'package:lensme/shared/components/components.dart';
import 'package:lensme/layout/layout_customer/layout_provider.dart';
import 'package:lensme/screens/screens_customer/search_customer/search_customer_screen.dart';
import 'package:lensme/shared/constants.dart';
import 'package:lensme/shared/theme/colors.dart';
import 'package:provider/provider.dart';

class LayoutScreen extends StatefulWidget {

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<SettingCustomerProvider>(context, listen: false).getCustomerData();
      Provider.of<LayoutProvider>(context, listen: false).getPhotographersData();
      Provider.of<SettingCustomerProvider>(context, listen: false).customerAppointments(customerId: Id!);

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var watch = context.watch<LayoutProvider>();
    var read = context.read<LayoutProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(watch.appBarTitle[watch.currentIndex],style: TextStyle(
            fontSize: responsivizer(context,20,23,25,27),
            fontWeight: FontWeight.bold,
            color: Colors.black54
        ),),
        elevation: 0.0,
        centerTitle: true ,
        leading: IconButton(
          onPressed: (){
            navigateTo(context,SearchCustomerScreen());
          },
          icon: Icon(
            Icons.search,
            size: responsivizer(context,30,33,36,39),
            color: Colors.black54,
          ),
        ),
        backgroundColor: Colors.white,
        toolbarHeight: responsivizer(context,55,60,60,65),
      ),
      body: watch.bottomScreens[watch.currentIndex],
      bottomNavigationBar: ConvexAppBar(
        height: responsivizer(context,55,60,65,70),
        backgroundColor: mainColor,
        activeColor: mainColor,
        color: Colors.white,
        initialActiveIndex:watch.currentIndex ,
        onTap: (index){
          read.changeBottomIndex(index);
        },
        items:[
          TabItem(icon: Icon(Icons.home,color: Colors.white,size:responsivizer(context,30,33,36,39),),),
          TabItem(icon: Icon(Icons.favorite,color: Colors.white,size: responsivizer(context,30,33,36,39),), ),
          TabItem(icon: Icon(Icons.notifications,color: Colors.white,size: responsivizer(context,30,33,36,39),), ) ,
          TabItem(icon: Icon(Icons.settings,color: Colors.white,size: responsivizer(context,30,33,36,39),),)
        ],

      ),
    );
  }
}
