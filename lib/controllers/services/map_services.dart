import 'dart:async';

import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:albrandz_cbt_p/views/utils/helpers/location_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapServices extends GetxController{

  /// init position
  var initialPosition =  const LatLng(37.7749, -122.4194).obs;
  /// map controller
  var mapController = Completer<GoogleMapController>();

  /// markers
  final RxSet<Marker> markers = <Marker>{}.obs;

  var showCurrentLocationLoader = false.obs;
  /// get current location and show marker
  showCurrentMarker()async{
    var isEnabled =  await LocationHelper().checkGPSService();
    if(isEnabled){
      showCurrentLocationLoader(true);
      var current = await LocationHelper().getCurrentLocation();
      initialPosition.value = LatLng(current.latitude??0.0, current.longitude??0.0);
      var icon = await LocationHelper().setCustomMarkerIcon(iconPath: currentLocationIconPng,size: 50);
      markers.add(Marker(markerId: const MarkerId(""),
          icon: icon,
          position: initialPosition.value
      ));
      await getCurrentAddress(LatLng(current.latitude??0.0, current.longitude??0.0));
      showCurrentLocationLoader(false);
      animateCameraPosition(LatLng(current.latitude??0.0, current.longitude??0.0));
    }
  }

  /// get address from position
  var currentAddress = "".obs;
  Future<void>getCurrentAddress(LatLng position)async{
    var data = await LocationHelper().getAddressFromLatLang(position);
    currentAddress.value = "${data.street},${data.locality},${data.country}";
    searchPickupController.value = TextEditingController(text: currentAddress.value);
  }
  var searchPickupController = TextEditingController().obs;
  var searchDestinationController = TextEditingController().obs;

  var destinationPosition = const LatLng(0.0, 0.0).obs;

  /// get position by address
  Future<LatLng> getPositionByAddress(String address)async{
    var data = await LocationHelper().positionFromAddress(address: address);
    return LatLng(data.latitude, data.longitude);
  }

  /// animate camera on position
  Future<void> animateCameraPosition(LatLng position,{double zoom = 12})async{
    var map = await mapController.future;
    map.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: position,zoom: zoom)));
  }

  animateDestinationPosition(String address)async{
    var position = await getPositionByAddress(address);
    var icon = await LocationHelper().setCustomMarkerIcon(iconPath: destinationIconPng);
    markers.add(Marker(markerId: MarkerId(position.toString()),position: position,icon: icon));
    await animateCameraPosition(position,zoom: 10);
  }
  animatePickupPosition(String address)async{
    var position = await getPositionByAddress(address);
    var icon = await LocationHelper().setCustomMarkerIcon(iconPath: pickupIconPng);
    markers.add(Marker(markerId: MarkerId(position.toString()),position: position,icon: icon));
    await animateCameraPosition(position,zoom: 10);
  }
}