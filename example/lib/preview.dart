import 'package:flutter/material.dart';
import 'package:insta/capture_player.dart';

class Preview extends StatefulWidget {
  const Preview({Key? key}) : super(key: key);

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {
  late CapturePlayerController _controller;
  bool isStarted = false;

  void _onCapturePlayerCreated(CapturePlayerController controller) {
    _controller = controller;
    controller.onInit();
  }

  void onStart() {
    _controller.play();
    setState(() {
      isStarted = true;
    });
  }

  void onStop() {
    _controller.stop();
    setState(() {
      isStarted = false;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 500,
            child: CapturePlayer(
              onCapturePlayerCreated: _onCapturePlayerCreated,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: ElevatedButton(
              onPressed: isStarted ? onStop : onStart,
              child: Text(isStarted ? "Stop" : "Start"),
            ),
          ),
        ],
      ),
    );
  }
}
