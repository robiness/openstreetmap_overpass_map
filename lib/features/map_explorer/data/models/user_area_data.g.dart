// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_area_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserAreaDataImpl _$$UserAreaDataImplFromJson(Map<String, dynamic> json) =>
    _$UserAreaDataImpl(
      areaId: json['areaId'] as String,
      visitCount: (json['visitCount'] as num?)?.toInt() ?? 0,
      lastVisited: json['lastVisited'] == null
          ? null
          : DateTime.parse(json['lastVisited'] as String),
      totalSpots: (json['totalSpots'] as num).toInt(),
      visitedSpots: (json['visitedSpots'] as num).toInt(),
      firstSpotVisit: json['firstSpotVisit'] == null
          ? null
          : DateTime.parse(json['firstSpotVisit'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$$UserAreaDataImplToJson(_$UserAreaDataImpl instance) =>
    <String, dynamic>{
      'areaId': instance.areaId,
      'visitCount': instance.visitCount,
      'lastVisited': instance.lastVisited?.toIso8601String(),
      'totalSpots': instance.totalSpots,
      'visitedSpots': instance.visitedSpots,
      'firstSpotVisit': instance.firstSpotVisit?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
    };
