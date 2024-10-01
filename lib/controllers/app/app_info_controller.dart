import 'package:albrandz_cbt_p/views/utils/helpers/app_info_helper.dart';
import 'package:get/get.dart';

class AppInfoController extends GetxController{

  var appVersion = ''.obs;
  var appVersionCode = ''.obs;
  @override
  void onInit() {
    initApp();
    super.onInit();
  }

  initApp()async{
    appVersion.value = await AppInfoHelper.getAppVersion();
    appVersionCode.value =await AppInfoHelper.getAppVersionCode();
  }

}