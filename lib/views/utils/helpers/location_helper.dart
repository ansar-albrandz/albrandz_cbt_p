import 'dart:async';
import 'package:albrandz_cbt_p/views/utils/colors.dart';
import 'package:albrandz_cbt_p/views/utils/constants/size_constants.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'dart:ui' as ui;
import 'dart:math';

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

  // Future<BitmapDescriptor> createTextMarker(String text) async {
  //   final recorder = ui.PictureRecorder();
  //   final canvas = Canvas(recorder);
  //   final textPainter = TextPainter(
  //     text: TextSpan(
  //       text: text,
  //       style: const TextStyle(
  //         color: Colors.black,
  //         fontSize: 30,
  //         fontWeight: FontWeight.bold,
  //       ),
  //     ),
  //     textDirection: TextDirection.ltr,
  //   );
  //   textPainter.layout();
  //   textPainter.paint(canvas, Offset(0, 0));
  //
  //   final picture = recorder.endRecording();
  //   final img = await picture.toImage(
  //       textPainter.width.toInt(), textPainter.height.toInt());
  //   final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
  //   final uint8List = byteData!.buffer.asUint8List();
  //
  //   return BitmapDescriptor.fromBytes(uint8List);
  // }

  Future<BitmapDescriptor> createCustomMarker(String text) async {
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    const size = Size(70, 30); // Marker size

    final paint = Paint()..color = Colors.white;
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(3),
    );

    canvas.drawRRect(rect.shift(const Offset(3, 3)), shadowPaint); // Shadow
    canvas.drawRRect(rect, paint); // White background

    // Draw the text inside the container
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: primaryColor,
          fontSize: semiBoldTextSize-2,
          fontWeight: FontWeight.bold,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(maxWidth: size.width);
    final offset = Offset(
      (size.width - textPainter.width) / 2,
      (size.height - textPainter.height) / 2,
    );
    textPainter.paint(canvas, offset);

    // Convert the canvas to an image
    final picture = recorder.endRecording();
    final img = await picture.toImage(size.width.toInt(), size.height.toInt());
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    final uint8List = byteData!.buffer.asUint8List();

    return BitmapDescriptor.bytes(uint8List);
  }

  /// get Center position of two position
  LatLng getCenterPosition(LatLng pickup, LatLng destination) {
    double midLat = (pickup.latitude + destination.latitude) / 2;
    double midLon = (pickup.longitude + destination.longitude) / 2;
    return LatLng(midLat, midLon);
  }


  /// distance between two position
  double calculateDistance(LatLng start, LatLng end) {
    const R = 6371000; // Radius of Earth in meters
    double lat1 = start.latitude * pi / 180;
    double lon1 = start.longitude * pi / 180;
    double lat2 = end.latitude * pi / 180;
    double lon2 = end.longitude * pi / 180;

    double dLat = lat2 - lat1;
    double dLon = lon2 - lon1;

    double a = pow(sin(dLat / 2), 2) +
        cos(lat1) * cos(lat2) * pow(sin(dLon / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c; // Distance in meters
  }


}
