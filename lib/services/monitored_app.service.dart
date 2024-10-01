import 'dart:async';
import 'dart:developer';

import 'package:clipboard_privacy/models/monitored_app.dart';
import 'package:clipboard_privacy/services/data.service.dart';
import 'package:get_it/get_it.dart';

class MonitoredAppService extends Disposable {
  DataService? _dataService;

  Future<List<MonitoredApp>> getAllMonitoredApps(String? filter) async {
    final entity = MonitoredApp.empty();
    _dataService = DataService(entity.entityName, entity.columnDefs);
    final entityMaps = await _dataService?.getAll() ?? List.empty();
    final entities =
        entityMaps.map((map) => MonitoredApp.fromJson(map)).toList();
    return entities;
  }

  Future<MonitoredApp> getMonitoredApp(int id) async {
    final entity = MonitoredApp.empty();
    _dataService = DataService(entity.entityName, entity.columnDefs);
    final map = await _dataService?.getEntity(id, entity.columns) ?? {};
    return MonitoredApp.fromJson(map);
  }

  Future<bool> updateMonitoredApp(MonitoredApp app) async {
    try {
      _dataService = DataService(app.entityName, app.columnDefs);
      await _dataService?.update(app);
    } catch (e) {
      return false;
    }

    return true;
  }

  Future<MonitoredApp> createMonitoredApp(
      String name, String iconName, List<String> querySegments) async {
    final app = MonitoredApp(0, name, iconName, querySegments, true);
    _dataService = DataService(app.entityName, app.columnDefs);

    // Save app to storage.
    app.id = await _dataService?.insert(app) ?? 0;

    return app;
  }

  Future<bool> deleteMonitoredApp(int id) async {
    try {
      final entity = MonitoredApp.empty();
      _dataService = DataService(entity.entityName, entity.columnDefs);
      var res = await _dataService?.delete(id) ?? 0;
      return res > 0;
    } catch (e) {
      return false;
    }
  }

  @override
  FutureOr onDispose() async {
    log("Disposing MonitoredAppService");
    if (_dataService != null) {
      await _dataService?.onDispose();
    }
  }
}
