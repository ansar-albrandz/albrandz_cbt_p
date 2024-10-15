import 'package:albrandz_cbt_p/controllers/services/map_services.dart';
import 'package:albrandz_cbt_p/views/utils/borders/app_border_radius.dart';
import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/app_image_view.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/text_filed_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RideMapWidgets {
  /// current location icon view
  FloatingActionButton currentLocationIconView({required void Function()? onPressed}) {
    var mapService = Get.put(MapServices());
    return FloatingActionButton(
      shape: RoundedRectangleBorder(
        borderRadius: AppBorderRadius.all()
      ),
      backgroundColor: Colors.white,
      onPressed: onPressed,
      child: Obx(()=>mapService.showCurrentLocationLoader.value?const CircularProgressIndicator():AppImageView().assetSVGImageView(goToCurrentLocationIcon)),
    );
  }

  // search location
  Widget searchPickupLocation(TextEditingController controller,{void Function(String)? onChanged,void Function()? onSuffixTap}){
    return TextFiledWidgets().appTextFieldView(controller,
        prefixIcon: goToCurrentLocationIcon,
        onChanged: onChanged,
        hintText: "Where to go...",
        onSuffixTap: onSuffixTap,
        suffixIcon: Icons.arrow_forward);
  }
  Widget searchDestinationLocation(TextEditingController controller,{void Function(String)? onChanged,void Function()? onSuffixTap}){
    return TextFiledWidgets().appTextFieldView(controller,
        prefixIcon: searchIcon,
        onChanged: onChanged,
        hintText: "Search destination...",
        onSuffixTap: onSuffixTap,
        suffixIcon: Icons.arrow_forward);
  }

  Widget searchRideView(TextEditingController pickupController,TextEditingController destinationController,{void Function()? onPickupTap,void Function()? onDestinationTap}){
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: AppBorderRadius.all()
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: AppImageView().assetSVGImageView(startToEndThreeRideIcon,size: 60),
          ),
          Expanded(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              searchPickupLocation(pickupController,onSuffixTap:onPickupTap ),
              10.height,
              searchDestinationLocation(destinationController,onSuffixTap: onDestinationTap)
            ],),
          ))
        ],
      ),
    );
  }
}