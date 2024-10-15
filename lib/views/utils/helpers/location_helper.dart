import 'dart:async';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationHelper {
  Location location = Location();

  /// check GPS service enabled
  Future<bool> checkGPSService() async {
    bool serviceEnabled;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }
    return serviceEnabled;
  }

  /// current location continues
  StreamSubscription<LocationData> getContinuouslyCurrentLocation() {
    return location.onLocationChanged.listen((LocationData currentLocation) async {});
  }

  /// current location
 Future<LocationData> getCurrentLocation()async{
    return await location.getLocation();
  }

  /// set custom marker
  Future<BitmapDescriptor> setCustomMarkerIcon({required String iconPath, double size = appIconSize}) async {
    return await BitmapDescriptor.asset(
       ImageConfiguration(size: Size(size, size)), // Set size if needed
      iconPath,
    );
  }

  /// get address from position
  Future<geocoding.Placemark>getAddressFromLatLang(LatLng position)async{
    var data = await geocoding.placemarkFromCoordinates(position.latitude, position.longitude);
    return data.first;
  }

  /// get position from address
  Future<geocoding.Location>positionFromAddress({required String address})async{
    var data =  await geocoding.locationFromAddress(address);
    return data.first;
  }
}
