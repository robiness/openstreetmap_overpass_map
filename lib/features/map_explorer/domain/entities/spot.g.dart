// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SpotImpl _$$SpotImplFromJson(Map<String, dynamic> json) => _$SpotImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  category: json['category'] as String,
  location: const LatLngConverter().fromJson(
    json['location'] as Map<String, dynamic>,
  ),
  description: json['description'] as String?,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  createdAt: DateTime.parse(json['createdAt'] as String),
  createdBy: json['createdBy'] as String?,
  properties: json['properties'] as Map<String, dynamic>? ?? const {},
  parentAreaId: json['parentAreaId'] as String?,
);

Map<String, dynamic> _$$SpotImplToJson(_$SpotImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'location': const LatLngConverter().toJson(instance.location),
      'description': instance.description,
      'tags': instance.tags,
      'createdAt': instance.createdAt.toIso8601String(),
      'createdBy': instance.createdBy,
      'properties': instance.properties,
      'parentAreaId': instance.parentAreaId,
    };

_$UserSpotDataImpl _$$UserSpotDataImplFromJson(Map<String, dynamic> json) =>
    _$UserSpotDataImpl(
      spotId: json['spotId'] as String,
      visitCount: (json['visitCount'] as num?)?.toInt() ?? 0,
      isFavorite: json['isFavorite'] as bool? ?? false,
      isCheckedIn: json['isCheckedIn'] as bool? ?? false,
      lastVisited: json['lastVisited'] == null
          ? null
          : DateTime.parse(json['lastVisited'] as String),
      userRating: (json['userRating'] as num?)?.toDouble(),
      userNotes: json['userNotes'] as String?,
    );

Map<String, dynamic> _$$UserSpotDataImplToJson(_$UserSpotDataImpl instance) =>
    <String, dynamic>{
      'spotId': instance.spotId,
      'visitCount': instance.visitCount,
      'isFavorite': instance.isFavorite,
      'isCheckedIn': instance.isCheckedIn,
      'lastVisited': instance.lastVisited?.toIso8601String(),
      'userRating': instance.userRating,
      'userNotes': instance.userNotes,
    };
