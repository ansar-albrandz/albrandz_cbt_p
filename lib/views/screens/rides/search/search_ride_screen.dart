import 'package:albrandz_cbt_p/controllers/rides/places_controller.dart';
import 'package:albrandz_cbt_p/controllers/rides/ride_map_controller.dart';
import 'package:albrandz_cbt_p/views/utils/borders/app_border_radius.dart';
import 'package:albrandz_cbt_p/views/utils/colors.dart';
import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:albrandz_cbt_p/views/utils/constants/constants.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/context_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/extensions/int_extensions.dart';
import 'package:albrandz_cbt_p/views/utils/styles/app_text_style.dart';
import 'package:albrandz_cbt_p/views/utils/widgets/app_image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchRideScreen extends StatelessWidget {
  SearchRideScreen({super.key});

  var mapServiceController = Get.put(RideMapController());
  var placesController = Get.put(PlacesController());

  @override
  Widget build(BuildContext context) {
    var height = context.fullHeight;
    return Column(
      children: [
        Card(
          elevation: 10,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.all()),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: verticalPadding),
                child: AppImageView()
                    .assetSVGImageView(startToEndThreeRideIcon, size: 70),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Obx(() => Column(
                      children: [
                        searchFieldView(
                            mapServiceController.searchPickupController.value,
                            hintText: PICKUP,
                            onChanged: (searchText) {
                          placesController.fetchPickupPlaces(searchText);
                        }, prefixIcon: Icons.my_location),
                        10.height,
                        searchFieldView(
                            mapServiceController.searchDestinationController
                                .value, onChanged: (searchText) {
                          placesController.fetchDestinationPlaces(searchText);
                        }, hintText: DESTINATION),
                      ],
                    )),
              ))
            ],
          ),
        ),
        Obx(() {
          if (placesController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return placesController.pickupPlaces.isNotEmpty
              ? pickupListView(height)
              : placesController.destinationPlaces.isNotEmpty
                  ? destinationListView(height)
                  : Container();
        }),
      ],
    );
  }

  Widget pickupListView(double height) {
    return Container(
      height: height / 2.5,
      color: Colors.white,
      child: ListView.builder(
        itemCount: placesController.pickupPlaces.length,
        itemBuilder: (context, index) {
          final place = placesController.pickupPlaces[index];
          return ListTile(
            leading: const Icon(Icons.location_on),
            title: Text(place.name ?? "NA"),
            subtitle: Text(place.formattedAddress ?? "NA"),
            onTap: () {
              placesController.clearPickupPlaces();
              mapServiceController.updatePickupPosition(LatLng(
                  place.geometry?.location?.lat ?? 0.0,
                  place.geometry?.location?.lng ?? 0.0));
              mapServiceController
                  .animatePickupPosition(place.formattedAddress ?? "NA");
            },
          );
        },
      ),
    );
  }

  Widget destinationListView(double height) {
    return Container(
      height: height / 2.5,
      color: Colors.white,
      child: ListView.builder(
        itemCount: placesController.destinationPlaces.length,
        itemBuilder: (context, index) {
          final place = placesController.destinationPlaces[index];
          return ListTile(
            leading: const Icon(Icons.location_on),
            title: Text(place.name ?? "NA"),
            subtitle: Text(place.formattedAddress ?? "NA"),
            onTap: () {
              placesController.clearDestinationPlaces();
              mapServiceController.updateDestinationPosition(LatLng(
                  place.geometry?.location?.lat ?? 0.0,
                  place.geometry?.location?.lng ?? 0.0));
              mapServiceController
                  .animateDestinationPosition(place.formattedAddress ?? "NA");
            },
          );
        },
      ),
    );
  }

  Widget searchFieldView(TextEditingController controller,
      {required String hintText,
      void Function(String)? onChanged,
      IconData prefixIcon = Icons.search}) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        style: AppTextStyle.normalBlack(),
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          hintStyle: AppTextStyle.normalBlack(),
          prefixIcon: Icon(prefixIcon),
          suffixIcon: InkWell(
              onTap: () {
                controller.clear();
              },
              child:  const Icon(Icons.clear,color: semiBoldBlackTextColor,size: appIconSize-5,)),
          border: OutlineInputBorder(
            borderRadius: AppBorderRadius.all(),
            borderSide: const BorderSide(width: .3, color: semiBoldBlackTextColor),
          ),
        ),
      ),
    );
  }
}
