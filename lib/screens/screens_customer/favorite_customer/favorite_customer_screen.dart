import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:lensme/layout/layout_customer/layout_provider.dart';
import 'package:lensme/screens/screens_customer/setting_customer/setting_customer_provider.dart';
import 'package:lensme/shared/components/components.dart';
import 'package:provider/src/provider.dart';


class FavoriteCustomerScreen extends StatefulWidget {

  @override
  State<FavoriteCustomerScreen> createState() => _FavoriteCustomerScreenState();
}

class _FavoriteCustomerScreenState extends State<FavoriteCustomerScreen> {

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Provider.of<SettingCustomerProvider>(context, listen: false).getFavorite(
          allPhotographers: Provider.of<LayoutProvider>(context, listen: false).photographersData
      );

    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    var layoutWatch = context.watch<LayoutProvider>();
    var watch = context.watch<SettingCustomerProvider>();

    var favoritesModel = watch.favoritesModel;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 15, 16, 28),
        child: BuildCondition(
          condition: favoritesModel.isNotEmpty,
          builder:(context) => SingleChildScrollView(
            physics: BouncingScrollPhysics() ,
            child: Column(
              children: [
                Container(
                  // height: size.height*0.75,
                  // width: size.width*0.95,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) =>Container(height: responsivizer(context,190,210,230,250),width: size.width*0.9 ,child: buildProfileCard(context: context,model: favoritesModel[index])),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 15,
                    ),
                    itemCount: watch.favorites.length,
                  ),
                ),

              ],
            ),
          ),
          fallback: (context) => Center(child: Icon(Icons.dnd_forwardslash,size: 40,color: Colors.black54,)),
        ),
      ),
    );
  }
}
