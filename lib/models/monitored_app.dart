import 'dart:convert';

import 'package:clipboard_privacy/models/entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nameof_annotation/nameof_annotation.dart';

part 'monitored_app.g.dart';
part 'monitored_app.nameof.dart';

@JsonSerializable()
@nameof
class MonitoredApp extends Entity {
  String name;
  String iconName;
  String querySegment;
  bool isEnabled;

  MonitoredApp(
    super.id,
    this.name,
    this.iconName,
    this.querySegment,
    this.isEnabled,
  );

  MonitoredApp.empty() : this(0, "", "", "", true);

  factory MonitoredApp.fromJson(Map<String, dynamic> json) =>
      _$MonitoredAppFromJson(json);

  Map<String, dynamic> toJson() => _$MonitoredAppToJson(this);
  
  @override
  Map<String, dynamic> toJsonMap() => toJson();

  @override
  String toJsonString() => jsonEncode(toJsonMap());
  
  @override
  MonitoredApp fromJsonMap(Map<String, dynamic> json) => _$MonitoredAppFromJson(json);
  
  @override
  String get entityName => NameofMonitoredApp.className;

  @override
  String get columnDefs => "${super.columnDefs}, ${NameofMonitoredApp.fieldName} TEXT, ${NameofMonitoredApp.fieldIconName} TEXT, ${NameofMonitoredApp.fieldQuerySegment} TEXT, ${NameofMonitoredApp.fieldIsEnabled} INTEGER";

  @override
  List<String> get columns => [NameofMonitoredApp.fieldName, NameofMonitoredApp.fieldIconName, NameofMonitoredApp.fieldQuerySegment, NameofMonitoredApp.fieldIsEnabled];
}
