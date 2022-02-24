import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lensme/layout/layout_customer/layout_provider.dart';
import 'package:lensme/shared/components/components.dart';
import 'package:lensme/shared/theme/colors.dart';
import 'package:provider/src/provider.dart';

class HomeCustomerScreen extends StatefulWidget {

  @override
  State<HomeCustomerScreen> createState() => _HomeCustomerScreenState();
}

class _HomeCustomerScreenState extends State<HomeCustomerScreen> {
  var formKey = GlobalKey<FormState>();

  var searchController = TextEditingController();



  @override
  Widget build(BuildContext context) {

    var watch = context.watch<LayoutProvider>();
    var read = context.read<LayoutProvider>();
    final size = MediaQuery.of(context).size;
    var model = watch.photographersDataSortLike;
    var model2 = watch.photographersDataOffer;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 15,left: 17,top: 17,right: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Most Liked',
              style: TextStyle(
                fontSize: responsivizer(context,22,26,30,34),
                  color: mainColor,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 12.0,
            ),
            Container(
              height: responsivizer(context,190,210,230,250),
              child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Container(width: size.width*0.8, child: buildProfileCard(context: context,model: model[index])),
                  separatorBuilder: (context, index) => SizedBox(width: 10,),
                  itemCount: model.length,
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Text(
              'Offers',
              style: TextStyle(
                  color: mainColor,
                  fontSize:responsivizer(context,22,26,30,34),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 12.0,
            ),
            Container(
              height: responsivizer(context,190,210,230,250),
              child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>  Container(width: size.width*0.8,child: buildProfileCard(context: context,model: model2[index])),
                  separatorBuilder: (context, index) => SizedBox(width: 15,),
                  itemCount: model2.length,
              ),
            ),
            SizedBox(
              height: size.height*0.015,
            ),
          ],
        ),
      ),
    );
  }
}
