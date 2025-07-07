import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:latlong2/latlong.dart';

part 'spot.freezed.dart';
part 'spot.g.dart';

// Custom converter for LatLng
class LatLngConverter implements JsonConverter<LatLng, Map<String, dynamic>> {
  const LatLngConverter();

  @override
  LatLng fromJson(Map<String, dynamic> json) {
    return LatLng(json['lat'] as double, json['lon'] as double);
  }

  @override
  Map<String, dynamic> toJson(LatLng object) {
    return {
      'lat': object.latitude,
      'lon': object.longitude,
    };
  }
}

@freezed
class Spot with _$Spot {
  const factory Spot({
    required String id,
    required String name,
    required String category,
    @LatLngConverter() required LatLng location,
    String? description,
    @Default([]) List<String> tags,
    required DateTime createdAt,
    String? createdBy,
    @Default({}) Map<String, dynamic> properties,
    String? parentAreaId,
  }) = _Spot;

  factory Spot.fromJson(Map<String, dynamic> json) => _$SpotFromJson(json);
}

// User interaction data for spots
@freezed
class UserSpotData with _$UserSpotData {
  const factory UserSpotData({
    required String spotId,
    @Default(0) int visitCount,
    @Default(false) bool isFavorite,
    @Default(false) bool isCheckedIn,
    DateTime? lastVisited,
    double? userRating, // 1-5 stars
    String? userNotes,
  }) = _UserSpotData;

  factory UserSpotData.fromJson(Map<String, dynamic> json) => _$UserSpotDataFromJson(json);
}

// Displayable spot combining spot data with user data
class DisplayableSpot {
  final Spot spot;
  final UserSpotData userData;

  DisplayableSpot({required this.spot, required this.userData});

  // Convenience getters
  String get id => spot.id;
  String get name => spot.name;
  String get category => spot.category;
  LatLng get location => spot.location;
  int get visitCount => userData.visitCount;
  bool get isFavorite => userData.isFavorite;
  bool get isVisited => userData.visitCount > 0;
  bool get isCheckedIn => userData.isCheckedIn;
}
