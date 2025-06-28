// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserSpotDataImpl _$$UserSpotDataImplFromJson(Map<String, dynamic> json) =>
    _$UserSpotDataImpl(
      spotId: (json['spotId'] as num).toInt(),
      visitCount: (json['visitCount'] as num?)?.toInt() ?? 0,
      isFavorite: json['isFavorite'] as bool? ?? false,
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
      'lastVisited': instance.lastVisited?.toIso8601String(),
      'userRating': instance.userRating,
      'userNotes': instance.userNotes,
    };
