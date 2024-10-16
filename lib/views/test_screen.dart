// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// class ShowAllMarkersMap extends StatefulWidget {
//   @override
// _ShowAllMarkersMapState createState() =>
//     _ShowAllMarkersMapState(); }
// class _ShowAllMarkersMapState extends State<ShowAllMarkersMap> {
//   GoogleMapController? _mapController;
//   Set<Marker> _markers = {}; // Set of markers to display on the map
//   @override
//   void initState() {
//     super.initState();
// // Example markers, you can dynamically add your marker positions
//     _markers.addAll([ Marker(
//     markerId: MarkerId('marker1'),
//     position: LatLng(28.7041, 77.1025), // Location 1 (New Delhi)
//     ), Marker(
//     markerId: MarkerId('marker2'),
//     position: LatLng(19.0760, 72.8777), // Location 2 (Mumbai)
//     ), Marker(
//     markerId: MarkerId('marker3'),
//     position: LatLng(13.0827, 80.2707), // Location 3
//          ),
//     ]);
// // After markers are initialized, move the camera to show all markers
//     WidgetsBinding.instance.addPostFrameCallback((_) => _showAllMarkersOnMap());
//   }
// // Function to calculate the bounds and animate the camera to show all markers
//   void _showAllMarkersOnMap() {
//     if (_markers.isEmpty || _mapController == null) return;
//     LatLngBounds bounds;
//     if (_markers.length == 1) {
// // If only one marker, center the map on that marker
// var markerPosition = _markers.first.position; bounds = LatLngBounds(
//       southwest: markerPosition,
//     northeast: markerPosition, );
//     } else {
// // If multiple markers, calculate the bounds that cover
//     //all markers
//     LatLngBoundsBuilder boundsBuilder =
//     LatLngBoundsBuilder();
//     _markers.forEach((marker) { boundsBuilder.include(marker.position);
//     });
//     bounds = boundsBuilder.build(); }
// // Animate the map's camera to the bounds of all markers
//     _mapController!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50)); // 50 is padding
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Show All Markers')), body: GoogleMap(
//       initialCameraPosition: CameraPosition(
//         target: LatLng(28.7041, 77.1025), // Default camera
//         zoom: 5,
//       ),
//       markers: _markers,
//       onMapCreated: (GoogleMapController controller) {
//         _mapController = controller;
// // Once map is created, call the function to show all markers
//         _showAllMarkersOnMap(); },
//     ), );
//   } }
// // LatLngBoundsBuilder to build the bounds dynamically class LatLngBoundsBuilder {
// LatLng? _southwest; LatLng? _northeast;
// void include(LatLng point) {
//   if (_southwest == null || _northeast == null) {
//     _southwest = point;
//     _northeast = point; } else {
//     _southwest = LatLng(
//       point.latitude < _southwest!.latitude ? point.latitude :
//       _southwest!.latitude,
//       point.longitude < _southwest!.longitude ?
//       point.longitude : _southwest!.longitude, );
//     _northeast = LatLng(
//         point.latitude > _northeast!.latitude ? point.latitude :
//         _northeast!.latitude,
//         point.longitude > _northeast!.longitude ?
//         point.longitude : _northeast!.longitude, );
//   } }
// LatLngBounds build() {
//   return LatLngBounds(southwest: _southwest!, northeast:
//   _northeast!); }
// }
