import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef CapturePlayerCreatedCallback = void Function(CapturePlayerController controller);

class CapturePlayer extends StatefulWidget {
  const CapturePlayer({
    Key? key,
    this.onCapturePlayerCreated,
  }) : super(key: key);

  final CapturePlayerCreatedCallback? onCapturePlayerCreated;

  @override
  State<StatefulWidget> createState() => _CapturePlayerState();
}

class _CapturePlayerState extends State<CapturePlayer> {
  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: 'plugins.meey.insta/capture_player_view',
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    }
    return Text('$defaultTargetPlatform is not yet supported by the capture_player_view plugin');
  }

  void _onPlatformViewCreated(int id) {
    if (widget.onCapturePlayerCreated == null) {
      return;
    }
    widget.onCapturePlayerCreated!(CapturePlayerController._(id));
  }
}

class CapturePlayerController {
  CapturePlayerController._(int id) : _channel = MethodChannel('plugins.meey.insta/capture_player_view_$id');

  final MethodChannel _channel;

  Future<void> onInit() async {
    return _channel.invokeMethod('onInit');
  }

  Future<void> play() async {
    return _channel.invokeMethod('play');
  }

  Future<void> stop() async {
    return _channel.invokeMethod('stop');
  }

  Future<void> dispose() async {
    return _channel.invokeMethod('dispose');
  }
}
