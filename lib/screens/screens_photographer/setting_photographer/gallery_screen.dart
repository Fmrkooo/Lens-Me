import 'package:flutter/material.dart';
import 'package:lensme/screens/screens_photographer/setting_photographer/setting_photographer_provider.dart';
import 'package:lensme/shared/components/components.dart';
import 'package:lensme/shared/theme/colors.dart';
import 'package:provider/src/provider.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var watch = context.watch<SettingPhotographerProvider>();
    var read = context.read<SettingPhotographerProvider>();
    var model = watch.photographerModel;

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
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder:(context, index) =>Stack(
                      alignment: Alignment.topRight,
                   children: [
                     Container(
                       decoration: BoxDecoration(
                           border:Border.all(width: 1)
                       ),
                       child: Image.network(
                         model!.gallery![index],
                         width:double.infinity ,
                         height: 200,
                         fit: BoxFit.cover,
                       ),
                     ),
                     Padding(
                         padding: const EdgeInsetsDirectional.all(6.0),
                         child: GestureDetector(
                           onTap: () async {
                             await watch.removeGallery(index: index);

                           },
                           child: Icon(Icons.remove_circle_outlined, color: mainColor, size: 26,),
                         )

                     ),
                   ]
                  ),
                  separatorBuilder:(context, index) => SizedBox(height: 15,),
                  itemCount:model!.gallery!.length,
                ),
                SizedBox(
                  height: 10,
                ),
                IconButton(
                    onPressed: () async {
                      await read.pickGalleryImage();
                      await read.updateGallery();
                    },
                    icon: Icon(Icons.add,size: 40,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
