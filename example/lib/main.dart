import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:insta/insta.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  bool isCameraConnected = false;
  final _instaPlugin = Insta();

  @override
  void initState() {
    super.initState();
    // initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _instaPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> getFullDemo() async {
    await _instaPlugin.getFullDemo();
  }

  Future<void> connectByWifi() async {
    try {
      await _instaPlugin.connectByWifi();
      Fluttertoast.showToast(msg: "Camera connect success");
      setState(() {
        isCameraConnected = true;
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Camera connect failed");
      setState(() {
        isCameraConnected = false;
      });
    }
  }

  Future<void> connectByUsb() async {
    await _instaPlugin.connectByUsb();
  }

  Future<void> connectByBle() async {
    await _instaPlugin.connectByBle();
  }

  Future<void> closeCamera() async {
    await _instaPlugin.closeCamera();
    setState(() {
      isCameraConnected = false;
    });
  }

  Future<void> capture() async {
    await _instaPlugin.capture();
  }

  Future<void> getPreview() async {
    await _instaPlugin.getPreview();
  }

  Future<void> getPreview2() async {
    await _instaPlugin.getPreview2();
  }

  Future<void> getPreview3() async {
    await _instaPlugin.getPreview3();
  }

  Future<void> getLive() async {
    await _instaPlugin.getLive();
  }

  Future<void> getOsc() async {
    await _instaPlugin.getOsc();
  }

  Future<void> getSetting() async {
    await _instaPlugin.getSetting();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ElevatedButton(onPressed: getFullDemo, child: const Text("Full Demo")),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: connectByWifi,
                    child: const Text("Connect by Wifi"),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: connectByUsb,
                    child: const Text("Connect by USB"),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: connectByBle,
                    child: const Text("Connect by BLE"),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: closeCamera,
                    child: const Text("Disconnect"),
                  ),
                ),
              ],
            ),
            const Text("Camera Function -- Need to connect camere first"),
            ElevatedButton(onPressed: isCameraConnected ? () {} : null, child: const Text("Capture")),
            ElevatedButton(onPressed: isCameraConnected ? () {} : null, child: const Text("Preview")),
            ElevatedButton(onPressed: isCameraConnected ? () {} : null, child: const Text("Preview 2")),
            ElevatedButton(onPressed: isCameraConnected ? () {} : null, child: const Text("Preview 3")),
            ElevatedButton(onPressed: isCameraConnected ? () {} : null, child: const Text("Live")),
            ElevatedButton(onPressed: isCameraConnected ? () {} : null, child: const Text("OSC")),
            ElevatedButton(onPressed: isCameraConnected ? () {} : null, child: const Text("Settings")),
            const Text("Other"),
            ElevatedButton(onPressed: () {}, child: const Text("Camera file list")),
            ElevatedButton(onPressed: () {}, child: const Text("Play & Export")),
            ElevatedButton(onPressed: () {}, child: const Text("HDR stitching")),
            ElevatedButton(onPressed: () {}, child: const Text("Firmware upgrade")),
          ],
        ),
      ),
    );
  }
}
