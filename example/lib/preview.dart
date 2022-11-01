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
    Future.delayed(const Duration(milliseconds: 300), () {
      _controller.onInit();
    });
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

  Future<bool> _onWillPop() {
    int count = 0;
    Navigator.of(context).popUntil((_) => count++ >= 2);
    return Future(() => false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white,
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
      ),
    );
  }
}
