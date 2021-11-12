import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';

class CustomCamera extends StatefulWidget {
  final ImageAddres;

  const CustomCamera({Key? key, this.ImageAddres}) : super(key: key);

  @override
  _CustomCameraState createState() => _CustomCameraState();
}

class _CustomCameraState extends State<CustomCamera> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    controller =
        CameraController(cameras[1] as CameraDescription, ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [
            CameraPreview(controller),
            Container(
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                width: size.width,
                height: size.height,
                child: Image.network(widget.ImageAddres))
          ],
        ));
  }
}
