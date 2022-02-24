import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lensme/shared/components/components.dart';
import 'package:lensme/screens/screens_customer/filtering_customer_screen/filtring_customer_provider.dart';
import 'package:lensme/shared/theme/colors.dart';
import 'package:provider/provider.dart';

class FilteringCustomerScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    var watch = context.watch<FilteringCustomerProvider>();
    var read = context.read<FilteringCustomerProvider>();
    var dateController = TextEditingController();
    DateTime dataTime = DateTime.now();
    String date='';

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
          'Filter',
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.bold,
            fontSize: responsivizer(context, 20, 24, 28, 33),
          ),
        ),
        centerTitle: true,
      ),
      body:Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: size.height*0.04,
                  child: Text(
                      'Price Range',
                      style: TextStyle  (
                        fontSize: 24.0,
                        color: mainColor,
                        fontWeight: FontWeight.w700,)),
                ),
                SizedBox(
                  height: size.height*0.01,
                ),
                Container(
                  height: size.height*0.1,
                  child:RangeSlider(
                      values: watch.selectedRange,
                      min: 5.0,
                      max: 155.0,
                      activeColor: mainColor,
                      onChanged: ( RangeValues newRange){
                        read.selectRange(newRange);
                      },
                      divisions:30,
                      labels: RangeLabels('${watch.selectedRange.start.toInt()}','${watch.selectedRange.end.toInt()}'),
                    ),
                  ),
                SizedBox(
                  height: size.height*0.015,
                ),
                Container(
                  height: size.height*0.26,
                  child: filterComponent(
                    label: 'Locations',
                    list: watch.listLocations,
                  ),
                ),
                SizedBox(
                  height: size.height*0.01,
                ),
                Container(
                  height: size.height*0.28,
                  child: filterComponent(
                    label: 'Shooting',
                    list: watch.listShootingTypes,
                  ),
                ),
                SizedBox(
                  height: size.height*0.01,
                ),
                Container(
                  height: size.height*0.26,
                  child: filterComponent(
                    label: 'Practical Experience',
                    list: watch.listPracticalExperience,
                  ),
                ),

                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10,top: 10 ,bottom: 10,left: 10),
                      child: Container(
                        height: responsivizer(context, 48,50,52,54),
                        width:responsivizer(context, 75,80,85,90),
                        decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: TextButton(
                          child: Text('Done',style: TextStyle(color:Colors.white,fontSize: responsivizer(context, 16,18,20,22),),),
                          onPressed: (){},
                        ),
                      ),
                    ),
                  ],
                ),
              ]

            ),
          ),
        ),
      ),
    );
  }
}


