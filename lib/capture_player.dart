import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
    const String viewType = 'plugins.meey.insta/capture_player_view';
    // Pass parameters to the platform side.
    const Map<String, dynamic> creationParams = <String, dynamic>{};

    if (defaultTargetPlatform == TargetPlatform.android) {
      return PlatformViewLink(
        viewType: viewType,
        surfaceFactory: (context, controller) {
          return AndroidViewSurface(
            controller: controller as AndroidViewController,
            gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
            hitTestBehavior: PlatformViewHitTestBehavior.opaque,
          );
        },
        onCreatePlatformView: (params) {
          _onPlatformViewCreated(params.id);
          return PlatformViewsService.initExpensiveAndroidView(
            id: params.id,
            viewType: viewType,
            layoutDirection: TextDirection.ltr,
            creationParams: creationParams,
            creationParamsCodec: const StandardMessageCodec(),
            onFocus: () {
              params.onFocusChanged(true);
            },
          )
            ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
            ..create();
        },
      );
      // return AndroidView(
      //   viewType: viewType,
      //   onPlatformViewCreated: _onPlatformViewCreated,
      // );
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
