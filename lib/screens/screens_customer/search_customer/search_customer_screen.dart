import 'package:flutter/material.dart';
import 'package:lensme/layout/layout_customer/layout_provider.dart';
import 'package:lensme/models/photographer_model.dart';
import 'package:lensme/screens/screens_photographer/profile_photographer_visitor/profile_photographer_screen_visitor.dart';
import 'package:lensme/shared/components/components.dart';
import 'package:lensme/layout/layout_customer/layout_screen.dart';
import 'package:lensme/screens/screens_customer/filtering_customer_screen/filtering_customer_screen.dart';
import 'package:provider/src/provider.dart';

class SearchCustomerScreen extends StatefulWidget {
  @override
  State<SearchCustomerScreen> createState() => _SearchCustomerScreenState();
}

class _SearchCustomerScreenState extends State<SearchCustomerScreen> {
  var formKey = GlobalKey<FormState>();

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var watch = context.watch<LayoutProvider>();
    var read = context.read<LayoutProvider>();

    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 30, 15, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5,),
            IconButton(
              onPressed: (){
                navigateTo(
                  context,
                  LayoutScreen(),
                );
              },
              icon: Icon(Icons.arrow_back,color: Colors.black,),
            ),
            SizedBox(height: 1,),
            Row(
              children: [
                Container(
                  width: size.width*0.8,
                  height: size.height*0.08,
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: Color(0xFFDDDDDD),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            size: 30,
                            color: Colors.black54,
                          ),
                          hintText: 'Search',
                         ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'please enter Name';
                        } else
                          return null;
                      },
                      onChanged: (String? text) {
                        setState(() {
                          read.getSearch(text!);
                        });
                      }),
                ),
                SizedBox(
                  width: size.width*0.02,
                ),
                Container(
                  width: size.width*0.1,
                  height: size.height*0.08,
                  child: IconButton(
                      onPressed: (){
                        navigateTo(context,FilteringCustomerScreen());
                      },
                      icon: Icon(Icons.filter_list_sharp,size: 30,),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5,),
           if(watch.search.isNotEmpty)
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) => buildSearch(context: context,model: watch.search[index]),
                  separatorBuilder:(context, index) => SizedBox(height: 5,),
                  itemCount: watch.search.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

buildSearch({
  required BuildContext context,
  required PhotographerModel model,
}){
  return GestureDetector(
    onTap:(){
      navigateTo(context,PhotographerProfileScreenVISITOR(model));
    } ,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: double.infinity,
        height: 70,
        decoration: BoxDecoration(border: Border.all(width: 0.1,color: Colors.grey)),
        child: Row(
          children: [
            CircleAvatar(
                radius: responsivizer(context, 22, 30, 28, 32),
                child: ClipOval(
                  child:
                  Image.network('${model.profilePicture}',width: 120,height: 120,fit: BoxFit.cover,)
                )),
            SizedBox(width: 30,),
            Text(
              '${model.name}',
              style: TextStyle(
                fontSize: responsivizer(context, 16, 18, 20, 22),
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}