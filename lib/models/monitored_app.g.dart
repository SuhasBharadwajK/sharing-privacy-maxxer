// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monitored_app.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MonitoredApp _$MonitoredAppFromJson(Map<String, dynamic> json) => MonitoredApp(
      (json['id'] as num).toInt(),
      json['name'] as String,
      json['iconName'] as String,
      (json['querySegments'] as List<dynamic>).map((e) => e as String).toList(),
      json['isEnabled'] as bool,
    );

Map<String, dynamic> _$MonitoredAppToJson(MonitoredApp instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'iconName': instance.iconName,
      'querySegments': instance.querySegments,
      'isEnabled': instance.isEnabled,
    };
