
import 'package:lensme/screens/authentication/login/login_screen.dart';
import 'package:lensme/shared/cashe_helper.dart';
import 'package:lensme/shared/components/components.dart';

void signOut(context) {
  //uId = '';
  CacheHelper.removeData(
    key: 'isPhotographer'
  );
  CacheHelper.removeData(
    key: 'Id',
  ).then((value) {
    if (value) {
      navigateAndFinish(
        context,
        LoginScreen(),
      );
    }
  });
}

String? Id = '';
bool isPhotographer=false;