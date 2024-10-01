import 'package:nameof_annotation/nameof_annotation.dart';

part 'entity.nameof.dart';

@nameof
abstract class Entity {
  int id;

  Entity(this.id);

  Map<String, dynamic> toJsonMap();

  String toJsonString();

  Entity fromJsonMap(Map<String, dynamic> json);

  String get entityName;

  String get columnDefs => "${NameofEntity.fieldId} PRIMARY KEY AUTOINCREMENT";

  List<String> get columns;
}