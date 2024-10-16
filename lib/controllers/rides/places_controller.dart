import 'dart:convert';
import 'package:albrandz_cbt_p/models/rides/search_places_model.dart';
import 'package:albrandz_cbt_p/views/utils/constants/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PlacesController extends GetxController {
  final RxList<SearchPlacesModel> pickupPlaces = <SearchPlacesModel>[].obs;
  final RxBool isLoading = false.obs;

  Future<void> fetchPickupPlaces(String query) async {
    if (query.isEmpty) {
      pickupPlaces.clear();
      return;
    }
    isLoading.value = true;

    final url =
        'https://maps.googleapis.com/maps/api/place/textsearch/json?query=$query&key=$mapKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        List results = data['results'];
        pickupPlaces.value= results.map((item)=>SearchPlacesModel.fromJson(item)).toList();
      } else {
        pickupPlaces.clear();
      }
    } else {
      pickupPlaces.clear();
    }
    isLoading.value = false;
  }
  clearPickupPlaces(){
    pickupPlaces.clear();
  }

  final RxList<SearchPlacesModel> destinationPlaces = <SearchPlacesModel>[].obs;

  Future<void> fetchDestinationPlaces(String query) async {
    if (query.isEmpty) {
      destinationPlaces.clear();
      return;
    }
    isLoading.value = true;

    final url =
        'https://maps.googleapis.com/maps/api/place/textsearch/json?query=$query&key=$mapKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        List results = data['results'];
        destinationPlaces.value= results.map((item)=>SearchPlacesModel.fromJson(item)).toList();
      } else {
        destinationPlaces.clear();
      }
    } else {
      destinationPlaces.clear();
    }
    isLoading.value = false;
  }

  clearDestinationPlaces(){
    destinationPlaces.clear();
  }
}
