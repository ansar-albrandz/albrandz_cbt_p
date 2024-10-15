import 'package:albrandz_cbt_p/controllers/services/map_services.dart';
import 'package:albrandz_cbt_p/views/screens/rides/cab_selection_screen.dart';
import 'package:albrandz_cbt_p/views/screens/rides/widgets/ride_map_widgets.dart';
import 'package:albrandz_cbt_p/views/utils/constants/constants.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/context_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/helpers/app_dialog_helper.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/button_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RideMapScreen extends StatelessWidget {
  RideMapScreen({super.key});

  final mapServiceController = Get.put(MapServices());

  @override
  Widget build(BuildContext context) {
    var width = context.fullWidth;
    var height = context.fullHeight;
    var view = RideMapWidgets();
    return Scaffold(
      body: Stack(
        children: [
          Obx(() => GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: mapServiceController.initialPosition.value,
                  zoom: 12,
                ),
                onMapCreated: (GoogleMapController controller) {
                  mapServiceController.mapController.complete(controller);
                  // showCurrentMarker();
                },
                zoomControlsEnabled: false,
                zoomGesturesEnabled: true,
                markers: mapServiceController.markers.value,
              )),
          Positioned(
              top: horizontalPadding + horizontalPadding,
              right: horizontalPadding,
              left: horizontalPadding,
              child: Obx(() => view.searchRideView(
                      mapServiceController.searchPickupController.value,
                      mapServiceController.searchDestinationController.value,
                      onDestinationTap: () async {
                    await mapServiceController.animateDestinationPosition(
                        mapServiceController
                            .searchDestinationController.value.text);
                  },onPickupTap: ()async{
                await mapServiceController.animatePickupPosition(
                    mapServiceController
                        .searchPickupController.value.text);
              }))),
          Positioned(
              bottom: height / 8,
              right: horizontalPadding,
              child: Obx(() => view.currentLocationIconView(onPressed: () {
                    mapServiceController.showCurrentMarker();
                  }))),
          Positioned(
              bottom: 10,
              left: horizontalPadding,
              right: horizontalPadding,
              child: ButtonWidgets().appButtonFillView(NEXT, onTap: () async {
                AppDialogHelper.showCustomBottomSheet(context,
                    child: const CabSelectionScreen(), height: height / 1.2);
              }, width: width))
        ],
      ),
    );
  }
}
