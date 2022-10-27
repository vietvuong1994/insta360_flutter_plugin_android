import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:insta/insta.dart';
import 'package:insta/insta_listener_model.dart';
import 'package:insta/text_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isCameraConnected = false;
  final _instaPlugin = Insta();

  @override
  void initState() {
    super.initState();
    initListener();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initListener() async {
    InstaListenerModel callbacks = InstaListenerModel(
      onCameraConnectError: onCameraConnectError,
      onCameraStatusChanged: onCameraStatusChanged,
    );
    _instaPlugin.listener(callbacks);
  }

  onCameraConnectError(int errorCode) {
    EasyLoading.dismiss();
    EasyLoading.showToast("Camera connect failed $errorCode");
  }

  onCameraStatusChanged(bool enabled) {
    EasyLoading.dismiss();
    setState(() {
      isCameraConnected = enabled;
    });
  }

  Future<void> getFullDemo() async {
    await _instaPlugin.getFullDemo();
  }

  Future<void> connectByWifi() async {
    try {
      EasyLoading.show();
      await _instaPlugin.connectByWifi();
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showToast("Internet connect failed");
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

  void _onTextViewCreated(TextViewController controller) {
    controller.setText('Hello from Android!');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: EasyLoading.init(),
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
            ElevatedButton(onPressed: isCameraConnected ? capture : null, child: const Text("Capture")),
            ElevatedButton(onPressed: isCameraConnected ? getPreview : null, child: const Text("Preview")),
            ElevatedButton(onPressed: isCameraConnected ? getPreview2 : null, child: const Text("Preview 2")),
            ElevatedButton(onPressed: isCameraConnected ? getPreview3 : null, child: const Text("Preview 3")),
            ElevatedButton(onPressed: isCameraConnected ? getLive : null, child: const Text("Live")),
            ElevatedButton(onPressed: isCameraConnected ? getOsc : null, child: const Text("OSC")),
            ElevatedButton(onPressed: isCameraConnected ? getSetting : null, child: const Text("Settings")),
            const Text("Other"),
            ElevatedButton(onPressed: () {}, child: const Text("Camera file list")),
            ElevatedButton(onPressed: () {}, child: const Text("Play & Export")),
            ElevatedButton(onPressed: () {}, child: const Text("HDR stitching")),
            ElevatedButton(onPressed: () {}, child: const Text("Firmware upgrade")),
            SizedBox(
              height: 100,
              width: double.infinity,
              child: TextView(
                onTextViewCreated: _onTextViewCreated,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
