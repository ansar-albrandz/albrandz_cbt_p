import 'package:albrandz_cbt_p/controllers/services/ride_map_controller.dart';
import 'package:albrandz_cbt_p/views/utils/borders/app_border_radius.dart';
import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/app_image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RideMapWidgets {
  /// current location icon view
  FloatingActionButton currentLocationIconView({required void Function()? onPressed}) {
    var mapService = Get.put(RideMapController());
    return FloatingActionButton(
      shape: RoundedRectangleBorder(
        borderRadius: AppBorderRadius.all()
      ),
      backgroundColor: Colors.white,
      onPressed: onPressed,
      child: Obx(()=>mapService.showCurrentLocationLoader.value?const CircularProgressIndicator():AppImageView().assetSVGImageView(goToCurrentLocationIcon)),
    );
  }
}