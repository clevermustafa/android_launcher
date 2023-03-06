import 'dart:developer';
import 'dart:io';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Android Launcher',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        home: const LauncherPage());
  }
}

class LauncherPage extends StatefulWidget {
  const LauncherPage({super.key});

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  final AppsProvider appsProvider = AppsProvider();
  List<Application> apps = [];

  @override
  void initState() {
    super.initState();
    appsProvider.getAllApps().then((value) => {
      log(value.toString()),
      setState(() => apps = value)});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: apps.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
        itemBuilder: (context, index) {
          Application app = apps[index];
          return Column(
            children: [
              app is ApplicationWithIcon ? 
              CircleAvatar(
                backgroundImage: MemoryImage(app.icon,)
              ) : Container()
            ],
          );  
        },
      ),
    );
  }
}

class AppsProvider {
  Future getAllApps() async {
    List<Application> apps = await DeviceApps.getInstalledApplications(includeAppIcons: true, includeSystemApps: true, onlyAppsWithLaunchIntent: true);
    return apps;
  }
}
