import 'dart:convert';

SearchPlacesModel searchPlacesModelFromJson(String str) => SearchPlacesModel.fromJson(json.decode(str));

String searchPlacesModelToJson(SearchPlacesModel data) => json.encode(data.toJson());

class SearchPlacesModel {
  String? formattedAddress;
  SearchGeometryData? geometry;
  String? icon;
  String? iconBackgroundColor;
  String? iconMaskBaseUri;
  String? name;
  String? placeId;
  String? reference;

  SearchPlacesModel({
    this.formattedAddress,
    this.geometry,
    this.icon,
    this.iconBackgroundColor,
    this.iconMaskBaseUri,
    this.name,
    this.placeId,
    this.reference,
  });

  factory SearchPlacesModel.fromJson(Map<String, dynamic> json) => SearchPlacesModel(
    formattedAddress: json["formatted_address"],
    geometry: json["geometry"] == null ? null : SearchGeometryData.fromJson(json["geometry"]),
    icon: json["icon"],
    iconBackgroundColor: json["icon_background_color"],
    iconMaskBaseUri: json["icon_mask_base_uri"],
    name: json["name"],
    placeId: json["place_id"],
    reference: json["reference"],
  );

  Map<String, dynamic> toJson() => {
    "formatted_address": formattedAddress,
    "geometry": geometry?.toJson(),
    "icon": icon,
    "icon_background_color": iconBackgroundColor,
    "icon_mask_base_uri": iconMaskBaseUri,
    "name": name,
    "place_id": placeId,
    "reference": reference,
  };
}

class SearchGeometryData {
  SearchLocationData? location;

  SearchGeometryData({
    this.location,
  });

  factory SearchGeometryData.fromJson(Map<String, dynamic> json) => SearchGeometryData(
    location: json["location"] == null ? null : SearchLocationData.fromJson(json["location"]),
  );

  Map<String, dynamic> toJson() => {
    "location": location?.toJson(),
  };
}

class SearchLocationData {
  double? lat;
  double? lng;

  SearchLocationData({
    this.lat,
    this.lng,
  });

  factory SearchLocationData.fromJson(Map<String, dynamic> json) => SearchLocationData(
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}
