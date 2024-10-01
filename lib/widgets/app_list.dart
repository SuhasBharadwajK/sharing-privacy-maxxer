import 'package:clipboard_privacy/models/monitored_app.dart';
import 'package:flutter/material.dart';

class AppList extends StatelessWidget {
  final List<MonitoredApp> appList = [
    MonitoredApp(1, "Twitter", "twitter", ["t", "s"], true),
    MonitoredApp(2, "Instagram", "instagram", ["igsh"], true)
  ];

  AppList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: appList
          .map((l) => GestureDetector(
                child: Row(
                  children: [
                    Text(l.name),
                    Divider(),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
