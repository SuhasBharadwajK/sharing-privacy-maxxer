// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monitored_app.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MonitoredApp _$MonitoredAppFromJson(Map<String, dynamic> json) => MonitoredApp(
      (json['id'] as num).toInt(),
      json['name'] as String,
      json['iconName'] as String,
      json['querySegment'] as String,
      json['isEnabled'] as bool,
    );

Map<String, dynamic> _$MonitoredAppToJson(MonitoredApp instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'iconName': instance.iconName,
      'querySegment': instance.querySegment,
      'isEnabled': instance.isEnabled,
    };
