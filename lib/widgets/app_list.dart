import 'dart:async';

import 'package:clipboard_privacy/models/monitored_app.dart';
import 'package:flutter/material.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

class AppList extends StatefulWidget {
  const AppList({super.key});

  @override
  State<AppList> createState() => _AppListState();
}

class _AppListState extends State<AppList> {
  late StreamSubscription _intentSub;

  final List<MonitoredApp> appList = [
    MonitoredApp(1, "Twitter", "twitter", ["t", "s"], true),
    MonitoredApp(2, "Instagram", "instagram", ["igsh"], true)
  ];

  @override
  void initState() {
    super.initState();
    // For sharing images coming from outside the app
    // while the app is in the memory
    _intentSub = ReceiveSharingIntent.instance.getMediaStream().listen(
        (List<SharedMediaFile> media) {
      debugPrint("Inside callback");
      print(media.toList());
    }, onError: (err) {
      debugPrint("$err");
    });
  }

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

  @override
  void dispose() {
    _intentSub.cancel();
    super.dispose();
  }
}
