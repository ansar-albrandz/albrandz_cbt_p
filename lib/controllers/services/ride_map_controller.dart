import 'dart:async';

import 'package:albrandz_cbt_p/views/utils/colors.dart';
import 'package:albrandz_cbt_p/views/utils/constants/assets_path.dart';
import 'package:albrandz_cbt_p/views/utils/constants/constants.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:albrandz_cbt_p/views/utils/helpers/location_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RideMapController extends GetxController {
  final _pickupMarkerId = const MarkerId("pickupMarkerId");
  final _destinationMarkerId = const MarkerId("destinationMarkerId");
  final _currentLocationMarkerId = const MarkerId("currentMarkerId");
  final _centerLocationMarkerId = const MarkerId("centerLocationMarkerId");

  /// init position
  var initialPosition = const LatLng(37.7749, -122.4194).obs;

  /// map controller
  var mapController = Completer<GoogleMapController>();

  /// markers
  final RxSet<Marker> markers = <Marker>{}.obs;

  var showCurrentLocationLoader = false.obs;

  /// get current location and show marker
  showCurrentMarker() async {
    var isEnabled = await LocationHelper().checkGPSService();
    if (isEnabled) {
      showCurrentLocationLoader(true);
      var current = await LocationHelper().getCurrentLocation();
      initialPosition.value =
          LatLng(current.latitude ?? 0.0, current.longitude ?? 0.0);
      var icon = await LocationHelper()
          .setCustomMarkerIcon(iconPath: currentLocationIconPng, size: 50);
      markers.add(Marker(
          markerId: _currentLocationMarkerId,
          icon: icon,
          position: initialPosition.value));
      updatePickupPosition(initialPosition.value);
      await getCurrentAddress(
          LatLng(current.latitude ?? 0.0, current.longitude ?? 0.0));
      showCurrentLocationLoader(false);
      animatePickupPosition(currentAddress.value);
      animateCameraPosition(
          LatLng(current.latitude ?? 0.0, current.longitude ?? 0.0));
    }
  }

  /// get address from position
  var currentAddress = "".obs;
  Future<void> getCurrentAddress(LatLng position) async {
    var data = await LocationHelper().getAddressFromLatLang(position);
    currentAddress.value = "${data.street},${data.locality},${data.country}";
    searchPickupController.value =
        TextEditingController(text: currentAddress.value);
  }

  var searchPickupController = TextEditingController().obs;
  var searchDestinationController = TextEditingController().obs;

  /// get position by address
  Future<LatLng> getPositionByAddress(String address) async {
    var data = await LocationHelper().positionFromAddress(address: address);
    return LatLng(data.latitude, data.longitude);
  }

  /// animate camera on position
  Future<void> animateCameraPosition(LatLng position,
      {double zoom = 12}) async {
    var map = await mapController.future;
    markers.forEach((markers){
      map.showMarkerInfoWindow(markers.markerId);
    });
    // map.showMarkerInfoWindow(_destinationMarkerId);
    map.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: zoom)));
  }

  /// animate to the destination location
  animateDestinationPosition(String address) async {
    var position = await getPositionByAddress(address);
    searchDestinationController.value.clear();
    searchDestinationController.value = TextEditingController(text: address);
    await _addDestinationMarker(position);
    await animateCameraPosition(position, zoom: 11);
  }

  /// animate pickup location
  animatePickupPosition(String address) async {
    var position = await getPositionByAddress(address);
    searchPickupController.value.clear();
    searchPickupController.value = TextEditingController(text: address);
    await _addPickupMarker(position);
    await animateCameraPosition(position, zoom: 11);
  }

  /// add pickup marker
  Future<void> _addPickupMarker(LatLng position) async {
    if (markers.any((marker) => marker.markerId == _pickupMarkerId)) {
      markers.removeWhere((marker) => marker.markerId == _pickupMarkerId);
    }
    getRoutes();
    var icon =
        await LocationHelper().setCustomMarkerIcon(iconPath: pickupIconPng);
    markers
        .add(Marker(markerId: _pickupMarkerId, position: position, icon: icon,infoWindow:  InfoWindow(title: "Pick up",onTap: (){})));
  }

  /// add destination marker
  Future<void> _addDestinationMarker(LatLng position) async {
    if (markers.any((marker) => marker.markerId == _destinationMarkerId)) {
      markers.removeWhere((marker) => marker.markerId == _destinationMarkerId);
    }
    getRoutes();
    var icon = await LocationHelper()
        .setCustomMarkerIcon(iconPath: destinationIconPng);
    // var icon = await LocationHelper().createCustomMarker("Destination");
    markers.add(
        Marker(markerId: _destinationMarkerId, position: position, icon: icon,infoWindow: InfoWindow(title: "Destination",onTap: (){})));
  }

  /// add distance marker
  Future<void> _addCenterMarker() async {
    if (markers.any((marker) => marker.markerId == _centerLocationMarkerId)) {
      markers.removeWhere((marker) => marker.markerId == _centerLocationMarkerId);
    }
    getRoutes();
    var distance = LocationHelper().calculateDistance(pickupPosition.value, destinationPosition.value);
    var km = distance/1000;
    var removedDistance = double.parse(km.toStringAsFixed(2));
    var centerPosition = LocationHelper().getCenterPosition(pickupPosition.value, destinationPosition.value);
    var icon = await LocationHelper().createCustomMarker("$removedDistance Kms");
    markers.add(
        Marker(markerId: _centerLocationMarkerId, position: centerPosition, icon: icon,infoWindow: InfoWindow(title: "Destination",onTap: (){})));
  }

  /// update destination position
  var destinationPosition = const LatLng(0.0, 0.0).obs;
  updateDestinationPosition(LatLng position) {
    destinationPosition.value = position;
  }

  /// update pickup position
  var pickupPosition = const LatLng(0.0, 0.0).obs;
  updatePickupPosition(LatLng position) {
    pickupPosition.value = position;
  }

  /// check and get routes
  getRoutes() async{
    if (pickupPosition.value.latitude != 0.0 &&
        destinationPosition.value.longitude != 0.0) {
      await _getRouteBetweenCoordinates();
     // _addCenterMarker();
      _fitMarkers();
    }
  }

  /// get routes between two position
  RxList<LatLng> polylineCoordinates = <LatLng>[].obs;
  RxSet<Polyline> polylines = <Polyline>{}.obs;
  Future<void> _getRouteBetweenCoordinates() async {
    final String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${pickupPosition.value.latitude},${pickupPosition.value.longitude}&destination=${destinationPosition.value.latitude},${destinationPosition.value.longitude}&key=$mapKey';

    try {
      final response = await Dio().get(url);
      if (response.statusCode == 200) {
        final data = response.data;
        if (data['routes'].isNotEmpty) {
          _decodePolyline(data['routes'][0]['overview_polyline']['points']);
        }
      }
    } catch (e) {
      print('Error fetching route: $e');
    }
  }

  /// calculate polyline
  void _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1E5, lng / 1E5));
    }

    polylineCoordinates.value = points;
    _updatePolyline();
  }

  /// update polyline
  void _updatePolyline() {
    polylines.value = {
      Polyline(
        polylineId: const PolylineId('route'),
        points: polylineCoordinates,
        color: primaryColor,
        width: polylineWidth,
      ),
    };
  }

  void _fitMarkers() async{
    LatLngBounds bounds;
    LatLng southwest = pickupPosition.value;
    LatLng northeast = destinationPosition.value;
    var locations = [
      pickupPosition.value,
      destinationPosition.value
    ];
    for (LatLng location in locations) {
      southwest = LatLng(
        southwest.latitude < location.latitude ? southwest.latitude : location.latitude,
        southwest.longitude < location.longitude ? southwest.longitude : location.longitude,
      );
      northeast = LatLng(
        northeast.latitude > location.latitude ? northeast.latitude : location.latitude,
        northeast.longitude > location.longitude ? northeast.longitude : location.longitude,
      );
    }

    bounds = LatLngBounds(southwest: southwest, northeast: northeast);
    var map = await mapController.future;
    map.animateCamera(CameraUpdate.newLatLngBounds(bounds, horizontalPadding*5));
  }

}
