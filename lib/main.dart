import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppUpdater',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple)
      ),
      home: const MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  final channel = const MethodChannel('com.example.appupdater/updater');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Update Demo', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () async {
                try {
                  await channel.invokeMethod('requestStoragePermission');
                } on PlatformException catch (e) {
                  debugPrint(e.toString());
                }
            }, 
            child: const Text('Request Storage Permission')),
            ElevatedButton(onPressed: () async {
                try {
                  await channel.invokeMethod('requestInstallPermission');
                } on PlatformException catch (e) {
                  debugPrint(e.toString());
                }
            }, 
            child: const Text('Request Install Permission')),
          ],
        ),
      ),
    );
  }
}
